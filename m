Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B566007F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJQHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJQHnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD2F5AA1B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665992614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YGorBMUyq2qicOpifjibu1km97gdoW7yGmf9uIs85s0=;
        b=cQNjvO5OZK0XGspIXBvJ5jvamVwenK+389cJEfmW5Cgmewipm4/W5t9R5XT4eCzPUPqfXH
        LBtorru67Mvg49Frn5kkz7um/5riBOEkVZZvGQz1CRLJSNO+M6tDWL1OK4tz+Xi2h2+oLa
        Z7cNN9ATYKuiz+cVzcTXXlr2++2f8fM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-VF_Sp23TN_aev1BcyPFJIw-1; Mon, 17 Oct 2022 03:43:32 -0400
X-MC-Unique: VF_Sp23TN_aev1BcyPFJIw-1
Received: by mail-wm1-f69.google.com with SMTP id c3-20020a7bc843000000b003b486fc6a40so5179096wml.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGorBMUyq2qicOpifjibu1km97gdoW7yGmf9uIs85s0=;
        b=iOR2JVQQGg/omkZ7TcKzIiw1US+ngLBkuIajMhoRFuMtrQepQaAMwIV1WBegdkr3Dg
         tihtUpgjLh+rTol+95mCqM18Npcv3l7Ygz3t/kNyN6l1BkQ+MQftIbwyDLQoNNXS0xFR
         yt9pt1nIrhuMNJnQemSIz35PiULPoOoV1htsXYQwP2jrJ9MhK2SAJf0aT2332bu9Vcit
         2DZStGS2hDThPIF1+g+QIPlfMCypZeYZBOXRlIiu0hvbyc+0wmaAapoQwK1yxxam3QKK
         v18lmHJ0d6gPeXT108lsU+TNxu8JAHPaLGoHPwaZRIxvy0n6OmB1ZRFEbwjz9wluFqPz
         Q44w==
X-Gm-Message-State: ACrzQf1BvHAdJP+TpFARV6NWojfHSRD4P8DJF3LIoEmu8c9FCk0TaevS
        6rI+ujqgYUVSJjzLFXEKD/LDBOHjZmh7DKZ5Qtsqv7iL0d3w514SKK8kxgRSW5xdOEp6csL+wvM
        KO39VpTg1g37J7O6HioaXhh0V
X-Received: by 2002:a05:600c:3542:b0:3c6:e509:b051 with SMTP id i2-20020a05600c354200b003c6e509b051mr10388958wmq.142.1665992610330;
        Mon, 17 Oct 2022 00:43:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM40MKMa6mE2IwoQYCqfPUwe5h5uKLHmv0VyTWyS1wUmbCh4Ft/L6gY4maf7rXiXacP/RZ8Zfg==
X-Received: by 2002:a05:600c:3542:b0:3c6:e509:b051 with SMTP id i2-20020a05600c354200b003c6e509b051mr10388938wmq.142.1665992609939;
        Mon, 17 Oct 2022 00:43:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2300:e5ce:21ba:1d93:4323? (p200300cbc7072300e5ce21ba1d934323.dip0.t-ipconnect.de. [2003:cb:c707:2300:e5ce:21ba:1d93:4323])
        by smtp.gmail.com with ESMTPSA id v1-20020adfedc1000000b00228daaa84aesm7767576wro.25.2022.10.17.00.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 00:43:29 -0700 (PDT)
Message-ID: <d6e6abc4-84ae-0ddf-eb02-9f0537d4bed1@redhat.com>
Date:   Mon, 17 Oct 2022 09:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Petr Pavlu <petr.pavlu@suse.com>, mcgrof@kernel.org
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-4-petr.pavlu@suse.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 3/4] module: Merge same-name module load requests
In-Reply-To: <20221016123031.3963-4-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.22 14:30, Petr Pavlu wrote:
> During a system boot, it can happen that the kernel receives a burst of
> requests to insert the same module but loading it eventually fails
> during its init call. For instance, udev can make a request to insert
> a frequency module for each individual CPU when another frequency module
> is already loaded which causes the init function of the new module to
> return an error.
> 
> The module loader currently serializes all such requests, with the
> barrier in add_unformed_module(). This creates a lot of unnecessary work
> and delays the boot. It can prevent udev from loading drivers for other
> devices and might cause timeouts of services waiting on them and
> subsequently a failed boot.
> 
> The mentioned serialization was introduced as a side-effect of commit
> 6e6de3dee51a. The kernel before that merged some of same load requests
> although it was more by accident and relied on specific timing. The
> patch brings this behavior back in a more explicit form.
> 
> The logic is improved as follows:
> * A check whether a module load matches an already loaded module is
>    moved right after a module name is determined. -EEXIST continues to be
>    returned if the module exists and is live, -EBUSY is returned if
>    a same-name module is going.

Can you clarify why the EBUSY change is needed? Why not simply return 
EEXIST?

If you have thread 0 loading the module and thread 1 unloading the 
module concurrently, then it's pretty much unpredictable what the 
outcome will be either way, no?

Add a random sleep to thread 1 (such that the module is *not* going yet) 
and the result will be EEXIST.

I suggest avoiding a EBUSY change unless there is real reason to do so.

User space that concurrently loads and unloads the same module is shaky 
already, no?

> * A new reference-counted shared_load_info structure is introduced to
>    keep track of duplicate load requests. Two loads are considered
>    equivalent if their module name matches. In case a load duplicates
>    another running insert, the code waits for its completion and then
>    returns -EEXIST or -EBUSY depending on whether it succeeded.
> 
> Moving the check for same-name module loads earlier has also a positive
> effect on reducing memory pressure. For instance, David Hildenbrand and
> Lin Liu reported [1] that when KASAN_INLINE is enabled (resulting in
> large module size), with plenty of devices that udev wants to probe and
> with plenty of CPUs that can carry out that probing concurrently, the
> system can actually run out of module vmap space and trigger vmap
> allocation errors. This is fixed by the patch too as it avoids duplicate
> layout_and_allocate() work.

It might we reasonable to add the kernel messages here. Can you also add 
the Reported-by?

> 
> [1] https://lore.kernel.org/all/20221013180518.217405-1-david@redhat.com/
> 
> Fixes: 6e6de3dee51a ("kernel/module.c: Only return -EEXIST for modules that have finished loading")
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>   kernel/module/main.c | 217 ++++++++++++++++++++++++++++++-------------
>   1 file changed, 155 insertions(+), 62 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 5288843ca40f..2228c0f725e7 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -66,11 +66,28 @@
>    *    uses RCU list operations).
>    * 2) module_use links,
>    * 3) mod_tree.addr_min/mod_tree.addr_max,
> - * 4) list of unloaded_tainted_modules.
> + * 4) list of unloaded_tainted_modules,
> + * 5) list of running_loads.
>    */
>   DEFINE_MUTEX(module_mutex);
>   LIST_HEAD(modules);
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
> +/*
> + * Waiting for a module load when the exact module name is not known, for
> + * example, when resolving symbols from another modules.
> + */
> +static DECLARE_WAIT_QUEUE_HEAD(module_wq);
> +
>   /* Work queue for freeing init sections in success case */
>   static void do_free_init(struct work_struct *w);
>   static DECLARE_WORK(init_free_wq, do_free_init);
> @@ -124,9 +141,6 @@ static void mod_update_bounds(struct module *mod)
>   int modules_disabled;
>   core_param(nomodule, modules_disabled, bint, 0);
>   
> -/* Waiting for a module to finish initializing? */
> -static DECLARE_WAIT_QUEUE_HEAD(module_wq);
> -
>   static BLOCKING_NOTIFIER_HEAD(module_notify_list);
>   
>   int register_module_notifier(struct notifier_block *nb)
> @@ -764,8 +778,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>   	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false), sizeof(last_unloaded_module.taints));
>   
>   	free_module(mod);
> -	/* someone could wait for the module in add_unformed_module() */
> -	wake_up_interruptible(&module_wq);
>   	return 0;
>   out:
>   	mutex_unlock(&module_mutex);
> @@ -2373,26 +2385,6 @@ static int post_relocation(struct module *mod, const struct load_info *info)
>   	return module_finalize(info->hdr, info->sechdrs, mod);
>   }
>   
> -/* Is this module of this name done loading?  No locks held. */
> -static bool finished_loading(const char *name)
> -{
> -	struct module *mod;
> -	bool ret;
> -
> -	/*
> -	 * The module_mutex should not be a heavily contended lock;
> -	 * if we get the occasional sleep here, we'll go an extra iteration
> -	 * in the wait_event_interruptible(), which is harmless.
> -	 */
> -	sched_annotate_sleep();
> -	mutex_lock(&module_mutex);
> -	mod = find_module_all(name, strlen(name), true);
> -	ret = !mod || mod->state == MODULE_STATE_LIVE;
> -	mutex_unlock(&module_mutex);
> -
> -	return ret;
> -}
> -
>   /* Call module constructors. */
>   static void do_mod_ctors(struct module *mod)
>   {
> @@ -2523,7 +2515,6 @@ static noinline int do_init_module(struct module *mod)
>   		schedule_work(&init_free_wq);
>   
>   	mutex_unlock(&module_mutex);
> -	wake_up_interruptible(&module_wq);
>   
>   	return 0;
>   
> @@ -2539,7 +2530,6 @@ static noinline int do_init_module(struct module *mod)
>   	klp_module_going(mod);
>   	ftrace_release_mod(mod);
>   	free_module(mod);
> -	wake_up_interruptible(&module_wq);
>   	return ret;
>   }
>   
> @@ -2551,43 +2541,138 @@ static int may_init_module(void)
>   	return 0;
>   }
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
>   /*
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
>    * memory exhaustion.
> + *
> + * Merging same load requests then primarily helps during the boot process. It
> + * can happen that the kernel receives a burst of requests to load the same
> + * module (for example, a same module for each individual CPU) and loading it
> + * eventually fails during its init call. Merging the requests allows that only
> + * one full attempt to load the module is made.
> + *
> + * On a non-error return, it is guaranteed that this load is unique.
>    */
> -static int add_unformed_module(struct module *mod)
> +static struct shared_load_info *add_running_load(const struct load_info *info)
>   {
> -	int err;
>   	struct module *old;
> +	struct shared_load_info *shared_info;
>   
> -	mod->state = MODULE_STATE_UNFORMED;
> -
> -again:
>   	mutex_lock(&module_mutex);
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
>   			mutex_unlock(&module_mutex);
> -			err = wait_event_interruptible(module_wq,
> -					       finished_loading(mod->name));
> -			if (err)
> -				goto out_unlocked;
> -			goto again;
> +
> +			err = wait_for_completion_interruptible(
> +				&shared_info->done);
> +			/*
> +			 * Return -EBUSY when the parallel load failed for any
> +			 * reason. This load might end up another way but we are
> +			 * not going to try.

Why not? Usually "-EAGAIN" signals that user space should retry. But I 
hope that we can avoid EBUSY altogether and simply retry here.

I'd suggest shared_load_info_put()+retry.

No need to optimize for corner cases (concurrent load failing so we 
don't retry ourselves).

> +			 */
> +			if (!err)
> +				err = shared_info->err ? -EBUSY : -EEXIST;
> +			shared_load_info_put(shared_info);
> +			shared_info = ERR_PTR(err);
> +			goto out_unlocked;
> +		}
> +
> +	/* Search if there is a live module with the given name already. */
> +	old = find_module_all(info->name, strlen(info->name), true);
> +	if (old != NULL) {
> +		if (old->state == MODULE_STATE_LIVE) {
> +			shared_info = ERR_PTR(-EEXIST);
> +			goto out;
>   		}
> -		err = -EEXIST;
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

As raised above, why not EEXIST? Concurrent loading+unloading is racy 
either way.

>   		goto out;
>   	}
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
>   out:
>   	mutex_unlock(&module_mutex);
>   out_unlocked:
> -	return err;
> +	return shared_info;
> +}
> +
> +static void finalize_running_load(struct shared_load_info *shared_info, int err)

s/finalize/release? It would be nice if the name could correspond to an 
opposite action of "add_running_load".

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


[...]

>    sysfs_cleanup:
>   	mod_sysfs_teardown(mod);
> @@ -2880,15 +2973,15 @@ static int load_module(struct load_info *info, const char __user *uargs,
>   	/* Unlink carefully: kallsyms could be walking list. */
>   	list_del_rcu(&mod->list);
>   	mod_tree_remove(mod);
> -	wake_up_interruptible(&module_wq);
>   	/* Wait for RCU-sched synchronizing before releasing mod->list. */
>   	synchronize_rcu();
>   	mutex_unlock(&module_mutex);
> - free_module:
>   	/* Free lock-classes; relies on the preceding sync_rcu() */
>   	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
>   
>   	module_deallocate(mod, info);
> + free_shared:

Ideally, the label matches what's actually being done. So maybe 
"release_shared" if you go with "release_..."

> +	finalize_running_load(shared_info, err);
>    free_copy:
>   	free_copy(info, flags);
>   	return err;

-- 
Thanks,

David / dhildenb

