Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5785FEF1D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJNNx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiJNNxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:53:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6939C1CFC6B;
        Fri, 14 Oct 2022 06:52:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EBFFD1F383;
        Fri, 14 Oct 2022 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665755554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6MZoBwQQqx9KCfq4b3on/BghZjmn8c0p31HxKoi/v8=;
        b=azZUzGdvRTqiI3P7iTT5i8M+gWXMYTIMsRGpKZvEYQGkNjt4+4WOC6yZopO1d074IP9agz
        rpeGZQgOw0mRXCXHsXifxRlc8ErRjrLsAVaNIlQQi+n0F1Yr6TBa8Tka6X/FqozD0cWgAs
        8pcq0nbRwQF9hHc2blLvmnbDT0Pcj3U=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C7A602C141;
        Fri, 14 Oct 2022 13:52:34 +0000 (UTC)
Date:   Fri, 14 Oct 2022 15:52:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y0lpn/TJOamfvBaZ@alley>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919123233.8538-3-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-09-19 14:32:33, Petr Pavlu wrote:
> During a system boot, it can happen that the kernel receives a burst of
> requests to insert the same module but loading it eventually fails
> during its init call. For instance, udev can make a request to insert
> a frequency module for each individual CPU when another frequency module
> is already loaded which causes the init function of the new module to
> return an error.
> 
> The module loader currently serializes all such requests, with the
> barrier in add_unformed_module(). This creates a lot of unnecessary work
> and delays the boot.
> 
> This patch improves the behavior as follows:
> * A check whether a module load matches an already loaded module is
>   moved right after a module name is determined. -EEXIST continues to be
>   returned if the module exists and is live, -EBUSY is returned if
>   a same-name module is going.
> * A new reference-counted shared_load_info structure is introduced to
>   keep track of duplicate load requests. Two loads are considered
>   equivalent if their module name matches. In case a load duplicates
>   another running insert, the code waits for its completion and then
>   returns -EEXIST or -EBUSY depending on whether it succeeded.
> 
> Note that prior to 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
> for modules that have finished loading"), the kernel already did merge
> some of same load requests but it was more by accident and relied on
> specific timing. The patch brings this behavior back in a more explicit
> form.

> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -61,14 +61,29 @@
>  
>  /*
>   * Mutex protects:
> - * 1) List of modules (also safely readable with preempt_disable),
> + * 1) list of modules (also safely readable with preempt_disable, delete and add
> + *    uses RCU list operations).
>   * 2) module_use links,
> - * 3) mod_tree.addr_min/mod_tree.addr_max.
> - * (delete and add uses RCU list operations).
> + * 3) mod_tree.addr_min/mod_tree.addr_max,
> + * 4) list of unloaded_tainted_modules.

This is unrelated and should be done in separate patch. It minimizes
the size of the patch and simplifies review. More importantly, these
unrelated changes will not get lost when the patch gets reverted for
some reason.

> + * 5) list of running_loads.
>   */
>  DEFINE_MUTEX(module_mutex);
>  LIST_HEAD(modules);
>  
> +/* Shared information to track duplicate module loads. */
> +struct shared_load_info {
> +	char name[MODULE_NAME_LEN];
> +	refcount_t refcnt;
> +	struct list_head list;
> +	struct completion done;
> +	int err;
> +};
> +static LIST_HEAD(running_loads);
> +
> +/* Waiting for a module to finish loading? */
> +static DECLARE_WAIT_QUEUE_HEAD(module_wq);

It is not obvious why this is actually needed. One would expect
that using the completion in struct shared_load_info would
be enough.

It is need because the user, resolve_symbol_wait(), does
not know the exact name of the module that it is waiting for.

It would deserve a comment and maybe even renaming, for example:

/*
 * Waiting for a module load when the exact module name is not known,
 * for example, when resolving symbols from another modules.
 */
static DECLARE_WAIT_QUEUE_HEAD(any_module_load_wq);


> +
>  /* Work queue for freeing init sections in success case */
>  static void do_free_init(struct work_struct *w);
>  static DECLARE_WORK(init_free_wq, do_free_init);
> @@ -762,8 +774,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>  	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false), sizeof(last_unloaded_module.taints));
>  
>  	free_module(mod);
> -	/* someone could wait for the module in add_unformed_module() */
> -	wake_up_interruptible(&module_wq);

The new code does not longer wakes module_wq when the module is
removed. I wondered if it is correct. It is a bit tricky.
module_wq used to have two purposes. It was used to wake up:

   1. parallel loads of the same module.

   2. resolving symbols in a module using symbols from
      another module.


Ad 1. The new code handles the parallel load using struct shared_load_info.
      Also the new code does not wait when the same module
      is being removed. So the wake up is not needed here.


Ad 2. The module_wq is typically used when the other module is
      loaded automatically because of module dependencies.
      In this case, only the wake up in load_module() is important.

      But what about module removal? IMHO, the is small race window:


The problem is the module operations are asynchronous. And A takes
the reference on B only after it resolves a symbol, see ref_module()
called in resolve_symbol().

Let's have two modules A and B when the module A uses a symbol
from module B.


CPU 0:			CPU 1			CPU 3

modprobe A
  // see dependency on B
  // and call modprobe B
  // in separate thread

			modprobe B
			  return -EEXIST

						rmmod B
						  // finished


      resolve_symbol_wait(sym_from_B)

It has to wait until the timeout 30s because module B is gone
and it is not beeing loaded.

IMHO, the new code makes the race window slightly bigger because
modprobe B retuns immediately even when rmmod B is already in
progress.

IMHO, this is acceptable because the race was there anyway. And
it is not much realistic scenario.


>  	return 0;
>  out:
>  	mutex_unlock(&module_mutex);
> @@ -2552,43 +2540,133 @@ static int may_init_module(void)
>  	return 0;
>  }
>  
> +static struct shared_load_info *
> +shared_load_info_alloc(const struct load_info *info)
> +{
> +	struct shared_load_info *shared_info =
> +		kzalloc(sizeof(*shared_info), GFP_KERNEL);
> +	if (shared_info == NULL)
> +		return ERR_PTR(-ENOMEM);
> +
> +	strscpy(shared_info->name, info->name, sizeof(shared_info->name));
> +	refcount_set(&shared_info->refcnt, 1);
> +	INIT_LIST_HEAD(&shared_info->list);
> +	init_completion(&shared_info->done);
> +	return shared_info;
> +}
> +
> +static void shared_load_info_get(struct shared_load_info *shared_info)
> +{
> +	refcount_inc(&shared_info->refcnt);
> +}
> +
> +static void shared_load_info_put(struct shared_load_info *shared_info)
> +{
> +	if (refcount_dec_and_test(&shared_info->refcnt))
> +		kfree(shared_info);
> +}
> +
>  /*
> - * We try to place it in the list now to make sure it's unique before
> - * we dedicate too many resources.  In particular, temporary percpu
> + * Check that a module load is unique and make it visible to others. The code
> + * looks for parallel running inserts and already loaded modules. Two inserts
> + * are considered equivalent if their module name matches. In case this load
> + * duplicates another running insert, the code waits for its completion and
> + * then returns -EEXIST or -EBUSY depending on whether it succeeded.
> + *
> + * Detecting early that a load is unique avoids dedicating too many cycles and
> + * resources to bring up the module. In particular, it prevents temporary percpu
>   * memory exhaustion.
> + *
> + * Merging same load requests then primarily helps during the boot process. It
> + * can happen that the kernel receives a burst of requests to load the same
> + * module (for example, a same module for each individual CPU) and loading it
> + * eventually fails during its init call. Merging the requests allows that only
> + * one full attempt to load the module is made.
> + *
> + * On a non-error return, it is guaranteed that this load is unique.
>   */
> -static int add_unformed_module(struct module *mod)
> +static struct shared_load_info *add_running_load(const struct load_info *info)
>  {
> -	int err;
>  	struct module *old;
> +	struct shared_load_info *shared_info;
>  
> -	mod->state = MODULE_STATE_UNFORMED;
> -
> -again:
>  	mutex_lock(&module_mutex);
> -	old = find_module_all(mod->name, strlen(mod->name), true);
> -	if (old != NULL) {
> -		if (old->state != MODULE_STATE_LIVE) {
> -			/* Wait in case it fails to load. */
> +
> +	/* Search if there is a running load of a module with the same name. */
> +	list_for_each_entry(shared_info, &running_loads, list)
> +		if (strcmp(shared_info->name, info->name) == 0) {
> +			int err;
> +
> +			shared_load_info_get(shared_info);
>  			mutex_unlock(&module_mutex);
> -			err = wait_event_interruptible(module_wq,
> -					       finished_loading(mod->name));
> -			if (err)
> -				goto out_unlocked;
> -			goto again;
> +
> +			err = wait_for_completion_interruptible(
> +				&shared_info->done);

This would deserve a comment, for examle:

			/*
			 * Return -EBUSY when the parallel load failed
			 * from any reason. This load might end up
			 * another way but we are not going to try.
			 */

> +			if (!err)
> +				err = shared_info->err ? -EBUSY : -EEXIST;
> +			shared_load_info_put(shared_info);
> +			shared_info = ERR_PTR(err);
> +			goto out_unlocked;
>  		}
> -		err = -EEXIST;
> +
> +	/* Search if there is a live module with the given name already. */
> +	old = find_module_all(info->name, strlen(info->name), true);
> +	if (old != NULL) {
> +		if (old->state == MODULE_STATE_LIVE) {
> +			shared_info = ERR_PTR(-EEXIST);
> +			goto out;
> +		}
> +
> +		/*
> +		 * Any active load always has its record in running_loads and so
> +		 * would be found above. This applies independent whether such
> +		 * a module is currently in MODULE_STATE_UNFORMED,
> +		 * MODULE_STATE_COMING, or even in MODULE_STATE_GOING if its
> +		 * initialization failed. It therefore means this must be an
> +		 * older going module and the caller should try later once it is
> +		 * gone.
> +		 */
> +		WARN_ON(old->state != MODULE_STATE_GOING);
> +		shared_info = ERR_PTR(-EBUSY);
>  		goto out;
>  	}
> -	mod_update_bounds(mod);
> -	list_add_rcu(&mod->list, &modules);
> -	mod_tree_insert(mod);
> -	err = 0;
> +
> +	/* The load is unique, make it visible to others. */
> +	shared_info = shared_load_info_alloc(info);
> +	if (IS_ERR(shared_info))
> +		goto out;
> +	list_add(&shared_info->list, &running_loads);
>  
>  out:
>  	mutex_unlock(&module_mutex);
>  out_unlocked:
> -	return err;
> +	return shared_info;
> +}
> +
> +static void finalize_running_load(struct shared_load_info *shared_info, int err)
> +{
> +	/* Inform other duplicate inserts that the load finished. */
> +	mutex_lock(&module_mutex);
> +	list_del(&shared_info->list);
> +	shared_info->err = err;
> +	mutex_unlock(&module_mutex);
> +
> +	complete_all(&shared_info->done);
> +	shared_load_info_put(shared_info);
> +
> +	/* Tell other modules waiting on this one that it completed loading. */
> +	wake_up_interruptible(&module_wq);
> +}
> +
> +static void add_unformed_module(struct module *mod)
> +{
> +	mod->state = MODULE_STATE_UNFORMED;
> +
> +	mutex_lock(&module_mutex);
> +	mod_update_bounds(mod);
> +	list_add_rcu(&mod->list, &modules);
> +	mod_tree_insert(mod);
> +	mutex_unlock(&module_mutex);
>  }
>  
>  static int complete_formation(struct module *mod, struct load_info *info)

The comments are more or less about cosmetic problems. I do not see
any real functional problem. I am sorry that I did not mention
them when reviewing v1.

Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
