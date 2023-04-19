Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CABA6E73C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjDSHPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDSHPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A464C1A;
        Wed, 19 Apr 2023 00:15:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1005F61B39;
        Wed, 19 Apr 2023 07:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE10BC433D2;
        Wed, 19 Apr 2023 07:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681888514;
        bh=raTzdIyYvUwuNJ9Dt1Cuom2hZfleXfVay1boETzqlsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ssAsuQK+EEa0ROEjk/687q6fRihZPoK9sha9JuRE/nv9sIBz1kbdxQZec5cZyqa+Q
         Tt4H6f+0CmvE/Jh/XoVYiqmgGl7BzYPrAtzH3/tqhxYNZvpg8VD+QPaHBSNUZOA6Tm
         Y9L5LQgIZDU/nThd5zYWwUxZiNTZa4HC9Hm+4lx4=
Date:   Wed, 19 Apr 2023 09:15:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH] module: add debugging auto-load duplicate module support
Message-ID: <2023041951-evolution-unwitting-1791@gregkh>
References: <20230418204636.791699-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418204636.791699-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 01:46:36PM -0700, Luis Chamberlain wrote:
> This adds debugging support to the kernel module auto-loader to
> easily detect and deal with duplicate module requests. To aid
> with possible bootup failure issues it will supress the waste
> in virtual memory when races happen before userspace loads a
> module and the kernel is still issuing requests for the same
> module.
> 
> Folks debugging virtual memory abuse on bootup can and should
> enable this to see what WARN()s come on, to see if module
> auto-loading is to blame for their woes.

You get 72 columns for changelog text, so you can use it :)

> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Changes on this patch since the last RFC:
> 
>   o dropped the kernel_read*() patch from this series moving to
>     punt the issues as a udev issue now that we have proof auto-loading
>     is not the issue
>   o some spell checks
> 
>  kernel/module/Kconfig    |  40 +++++++
>  kernel/module/Makefile   |   1 +
>  kernel/module/dups.c     | 234 +++++++++++++++++++++++++++++++++++++++
>  kernel/module/internal.h |  15 +++
>  kernel/module/kmod.c     |  23 +++-
>  5 files changed, 309 insertions(+), 4 deletions(-)
>  create mode 100644 kernel/module/dups.c
> 
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index e6df183e2c80..cc146ef4a6ac 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -59,6 +59,46 @@ config MODULE_STATS
>  
>  	  If unsure, say N.
>  
> +config MODULE_AUTOLOAD_SUPRESS_DUPS

MODULE_DEBUG_DUPLICATE perhaps?  It has nothing to do with autoloading
(other than that is what userspace is doing) and you aren't suppressing
anything except throwing up warnings, right?

> +	bool "Debug duplicate modules with auto-loading"
> +	help
> +	  Module autoloading allows in-kernel code to request modules through
> +	  the *request_module*() API calls. This in turn just calls userspace
> +	  modprobe. Although modprobe checks to see if a module is already
> +	  loaded before trying to load a module there is a small time window in
> +	  which multiple duplicate requests can end up in userspace and multiple
> +	  modprobe calls race calling finit_module() around the same time for
> +	  duplicate modules. The finit_module() system call can consume in the
> +	  worst case more than twice the respective module size in virtual
> +	  memory for each duplicate module requests. Although duplicate module
> +	  requests are non-fatal virtual memory is a limited resource and each
> +	  duplicate module request ends up just wasting virtual memory.

It's not "wasted", as it is returned when the module is determined to be
a duplicate.  Otherwise everyone will want this enabled as they think it
will actually save memory.

> +	  This debugging facility will create WARN() splats for duplicate module
> +	  requests to help identify if module auto-loading is the culprit to your
> +	  woes. Since virtual memory abuse caused by duplicate module requests
> +	  could render a system unusable this functionality will also suppresses
> +	  the waste in virtual memory caused by duplicate requests by sharing
> +	  races in requests for the same module to a single unified request.
> +	  Once a non-wait request_module() call completes a module should be
> +	  loaded and modprobe should simply not allow new finit_module() calls.
> +
> +	  Enable this functionality to try to debug virtual memory abuse during
> +	  boot on systems and identify if the abuse was due to module
> +	  auto-loading.
> +
> +	  If the first module request used request_module_nowait() we cannot
> +	  use that as the anchor to wait for duplicate module requests, since
> +	  users of request_module() do want a proper return value. If a call
> +	  for the same module happened earlier with request_module() though,
> +	  then a duplicate request_module_nowait() would be detected.
> +
> +	  You want to enable this if you want to debug and see if duplicate
> +	  module auto-loading might be causing virtual memory abuse during
> +	  bootup. A kernel trace will be provided for each duplicate request.
> +
> +	  Disable this if you are on production.

"on production"?  That does not translate well, how about:
	Only enable this for debugging system functionality, never have
	it enabled on real systems.
or something like that?


> +
>  endif # MODULE_DEBUG
>  
>  config MODULE_FORCE_LOAD
> diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> index 52340bce497e..e8b121ac39cf 100644
> --- a/kernel/module/Makefile
> +++ b/kernel/module/Makefile
> @@ -10,6 +10,7 @@ KCOV_INSTRUMENT_module.o := n
>  obj-y += main.o
>  obj-y += strict_rwx.o
>  obj-y += kmod.o
> +obj-$(CONFIG_MODULE_AUTOLOAD_SUPRESS_DUPS) += dups.o
>  obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
>  obj-$(CONFIG_MODULE_SIG) += signing.o
>  obj-$(CONFIG_LIVEPATCH) += livepatch.o
> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> new file mode 100644
> index 000000000000..903ab7c7e8f4
> --- /dev/null
> +++ b/kernel/module/dups.c
> @@ -0,0 +1,234 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * kmod dups - the kernel module autoloader duplicate suppressor
> + *
> + * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task.h>
> +#include <linux/binfmts.h>
> +#include <linux/syscalls.h>
> +#include <linux/unistd.h>
> +#include <linux/kmod.h>
> +#include <linux/slab.h>
> +#include <linux/completion.h>
> +#include <linux/cred.h>
> +#include <linux/file.h>
> +#include <linux/fdtable.h>
> +#include <linux/workqueue.h>
> +#include <linux/security.h>
> +#include <linux/mount.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/resource.h>
> +#include <linux/notifier.h>
> +#include <linux/suspend.h>
> +#include <linux/rwsem.h>
> +#include <linux/ptrace.h>
> +#include <linux/async.h>
> +#include <linux/uaccess.h>
> +
> +DEFINE_MUTEX(kmod_dup_mutex);

static?

> +static LIST_HEAD(dup_kmod_reqs);
> +
> +struct kmod_dup_req {
> +	struct list_head list;
> +	char name[MODULE_NAME_LEN];
> +	struct completion first_req_done;
> +	struct work_struct complete_work;
> +	struct delayed_work delete_work;
> +	int dup_ret;
> +};
> +
> +static struct kmod_dup_req *kmod_dup_request_lookup(char *module_name)

Lock requirements?  You should document that here.

> +{
> +	struct kmod_dup_req *kmod_req;
> +
> +	list_for_each_entry_rcu(kmod_req, &dup_kmod_reqs, list,
> +				lockdep_is_held(&kmod_dup_mutex)) {
> +		if (strlen(kmod_req->name) == strlen(module_name) &&
> +		    !memcmp(kmod_req->name, module_name, strlen(module_name))) {
> +			return kmod_req;
> +                }
> +        }
> +
> +	return NULL;
> +}
> +
> +static void kmod_dup_request_delete(struct work_struct *work)
> +{
> +	struct kmod_dup_req *kmod_req;
> +	kmod_req = container_of(to_delayed_work(work), struct kmod_dup_req, delete_work);
> +
> +	/*
> +	 * The typical situation is a module successully loaded. In that
> +	 * situation the module will be present already in userspace. If
> +	 * new requests come in after that, userspace will already know the
> +	 * module is loaded so will just return 0 right away. There is still
> +	 * a small chance right after we delete this entry new request_module()
> +	 * calls may happen after that, they can happen. These heuristics
> +	 * are to protect finit_module() abuse for auto-loading, if modules
> +	 * are still tryign to auto-load even if a module is already loaded,
> +	 * that's on them, and those inneficiencies should not be fixed by
> +	 * kmod. The inneficies there are a call to modprobe and modprobe
> +	 * just returning 0.
> +	 */
> +	mutex_lock(&kmod_dup_mutex);
> +	list_del_rcu(&kmod_req->list);
> +	synchronize_rcu();
> +	mutex_unlock(&kmod_dup_mutex);
> +	kfree(kmod_req);
> +}
> +
> +static void kmod_dup_request_complete(struct work_struct *work)
> +{
> +	struct kmod_dup_req *kmod_req;
> +
> +	kmod_req = container_of(work, struct kmod_dup_req, complete_work);
> +
> +	/*
> +	 * This will ensure that the kernel will let all the waiters get
> +	 * informed its time to check the return value. It's time to
> +	 * go home.
> +	 */
> +	complete_all(&kmod_req->first_req_done);
> +
> +	/*
> +	 * Now that we have allowed prior request_module() calls to go on
> +	 * with life, let's schedule deleting this entry. We don't have
> +	 * to do it right away, but we *eventually* want to do it so to not
> +	 * let this linger forever as this is just a boot optimization for
> +	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
> +	 */
> +	queue_delayed_work(system_wq, &kmod_req->delete_work, 60 * HZ);
> +}
> +
> +bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
> +{
> +	struct kmod_dup_req *kmod_req, *new_kmod_req;
> +	int ret;
> +
> +	/*
> +	 * Pre-allocate the entry in case we have to use it later
> +	 * to avoid contention with the mutex.
> +	 */
> +	new_kmod_req = kzalloc(sizeof(*new_kmod_req), GFP_KERNEL);
> +	if (!new_kmod_req)
> +		return false;
> +
> +	memcpy(new_kmod_req->name, module_name, strlen(module_name));
> +	INIT_WORK(&new_kmod_req->complete_work, kmod_dup_request_complete);
> +	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
> +	init_completion(&new_kmod_req->first_req_done);
> +
> +	mutex_lock(&kmod_dup_mutex);
> +
> +	kmod_req = kmod_dup_request_lookup(module_name);
> +	if (!kmod_req) {
> +		/*
> +		 * If the first request that came through for a module
> +		 * was with request_module_nowait() we cannot wait for it
> +		 * and share its return value with other users which may
> +		 * have used request_module() and need a proper return value
> +		 * so just skip using them as an anchor.
> +		 *
> +		 * If a prior request to this one came through with
> +		 * request_module() though, then a request_module_nowait()
> +		 * would benefit from duplicate detection.
> +		 */
> +		if (!wait) {
> +			kfree(new_kmod_req);
> +			pr_warn("New request_module_nowait() for %s -- cannot track duplicates for this request\n", module_name);

pr_dbg() as this is debugging?

And did you set your pr_fmt value to make it obvious where these
messages are coming from?

> +			mutex_unlock(&kmod_dup_mutex);
> +			return false;
> +		}
> +
> +		/*
> +		 * There was no duplicate, just add the request so we can
> +		 * keep tab on duplicates later.
> +		 */
> +		pr_info("New request_module() for %s\n", module_name);

Why not pr_dbg()?

> +		list_add_rcu(&new_kmod_req->list, &dup_kmod_reqs);
> +		mutex_unlock(&kmod_dup_mutex);
> +		return false;
> +	}
> +	mutex_unlock(&kmod_dup_mutex);
> +
> +	/* We are dealing with a duplicate request now */
> +

No blank line needed.

> +	kfree(new_kmod_req);
> +
> +	/*
> +	 * To fix these try to use try_then_request_module() instead as that
> +	 * will check if the component you are looking for is present or not.
> +	 * You could also just queue a single request to load the module once,
> +	 * instead of having each and everything you need try to request for
> +	 * the module.
> +	 *
> +	 * Duplicate request_module() calls  can cause quite a bit of wasted
> +	 * vmalloc() space when racing with userspace.
> +	 */
> +	WARN(1, "module-autoload: duplicate request for module %s\n", module_name);

Remember, this will trigger syzbot and any system that has
panic-on-warn, so be prepared for that mess.  Especially the syzbot
reports, that's going to cause lots of issues for you if you don't tell
them to always disable this option.

thanks,

greg k-h
