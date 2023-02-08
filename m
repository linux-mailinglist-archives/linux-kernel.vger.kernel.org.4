Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117BF68F19B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjBHPHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjBHPHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:07:37 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3650938002
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:07:35 -0800 (PST)
Received: (qmail 735684 invoked by uid 1000); 8 Feb 2023 10:07:34 -0500
Date:   Wed, 8 Feb 2023 10:07:34 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+O6toMmAKBSILMf@rowland.harvard.edu>
References: <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
 <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
 <827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp>
 <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
 <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
 <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
 <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:30:25PM +0900, Tetsuo Handa wrote:
> Commit 1704f47b50b5 ("lockdep: Add novalidate class for dev->mutex
> conversion") made it impossible to find real deadlocks unless timing
> dependent testings manage to trigger hung task like [1] and [2]. And
> lockdep_set_novalidate_class() remained for more than one decade due to
> a fear of false positives [3]. But not sharing mutex_init() could make
> it possible to find real deadlocks without triggering hung task [4].
> Thus, let's assign a unique class key on each "struct device"->mutex.
> 
> Link: https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101 [1]
> Link: https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb [2]
> Link: https://lkml.kernel.org/r/Y98FLlr7jkiFlV0k@rowland.harvard.edu [3]
> Link: https://lkml.kernel.org/r/827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp [4]
> Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

You must never do this!

I did not put my Signed-off-by: on the patch I sent to you.  I do not 
want it added to that patch or to this one.  You should never put 
somebody else's Signed-off-by: on a patch unless they tell you it's okay 
to do so.

I'm happy to have people test this patch, but I do not want anybody 
think that it is ready to be merged into the kernel.

> Co-developed-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Hello, syzkaller users.
> 
> We made a patch that keeps lockdep validation enabled on "struct dev->mutex".
> Will you try this patch and see if this patch causes boot failures and/or
> too frequent crashes to continue testing.
> 
>  drivers/base/core.c      | 7 ++++++-
>  include/linux/device.h   | 1 +
>  include/linux/lockdep.h  | 6 ++++++
>  kernel/locking/lockdep.c | 7 +++++++
>  4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a3e14143ec0c..c30ecbc4d60e 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2322,6 +2322,9 @@ static void device_release(struct kobject *kobj)
>  	devres_release_all(dev);
>  
>  	kfree(dev->dma_range_map);
> +	mutex_destroy(&dev->mutex);
> +	if (!lockdep_static_obj(dev))
> +		lockdep_unregister_key(&dev->mutex_key);
>  
>  	if (dev->release)
>  		dev->release(dev);
> @@ -2941,7 +2944,9 @@ void device_initialize(struct device *dev)
>  	kobject_init(&dev->kobj, &device_ktype);
>  	INIT_LIST_HEAD(&dev->dma_pools);
>  	mutex_init(&dev->mutex);
> -	lockdep_set_novalidate_class(&dev->mutex);
> +	if (!lockdep_static_obj(dev))
> +		lockdep_register_key(&dev->mutex_key);
> +	lockdep_set_class(&dev->mutex, &dev->mutex_key);
>  	spin_lock_init(&dev->devres_lock);
>  	INIT_LIST_HEAD(&dev->devres_head);
>  	device_pm_init(dev);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 44e3acae7b36..bdaca9f54dc2 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -570,6 +570,7 @@ struct device {
>  	struct mutex		mutex;	/* mutex to synchronize calls to
>  					 * its driver.
>  					 */
> +	struct lock_class_key	mutex_key;	/* Unique key for each device */
>  
>  	struct dev_links_info	links;
>  	struct dev_pm_info	power;
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 1f1099dac3f0..5afc999a7e56 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -172,6 +172,7 @@ do {							\
>  	current->lockdep_recursion -= LOCKDEP_OFF;	\
>  } while (0)
>  
> +extern int lockdep_static_obj(const void *obj);
>  extern void lockdep_register_key(struct lock_class_key *key);
>  extern void lockdep_unregister_key(struct lock_class_key *key);
>  
> @@ -391,6 +392,11 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
>  # define lockdep_free_key_range(start, size)	do { } while (0)
>  # define lockdep_sys_exit() 			do { } while (0)
>  
> +static inline int lockdep_static_obj(const void *obj)
> +{
> +	return 0;
> +}
> +
>  static inline void lockdep_register_key(struct lock_class_key *key)
>  {
>  }
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e3375bc40dad..74c0113646f1 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -857,6 +857,13 @@ static int static_obj(const void *obj)
>  	 */
>  	return is_module_address(addr) || is_module_percpu_address(addr);
>  }
> +
> +int lockdep_static_obj(const void *obj)
> +{
> +	return static_obj(obj);
> +}
> +EXPORT_SYMBOL_GPL(lockdep_static_obj);

What's the point of adding a new function that just calls the old 
function?  Why not simply rename the old function?

Alan Stern

> +
>  #endif
>  
>  /*
> -- 
> 2.34.1
> 
