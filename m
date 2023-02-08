Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9599C68E500
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 01:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBHAej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 19:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHAei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 19:34:38 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6B6B53B3C8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 16:34:36 -0800 (PST)
Received: (qmail 717489 invoked by uid 1000); 7 Feb 2023 19:34:35 -0500
Date:   Tue, 7 Feb 2023 19:34:35 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y+LuG+mNwY46obat@rowland.harvard.edu>
References: <Y96HiYcreb8jZIHi@rowland.harvard.edu>
 <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
 <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
 <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
 <827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp>
 <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
 <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
 <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
 <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:17:20AM +0900, Tetsuo Handa wrote:
> On 2023/02/08 2:46, Alan Stern wrote:
> > The real question is what will happen in your syzbot test scenarios.  
> > Lockdep certainly ought to be able to detect a real deadlock when one 
> > occurs.  It will be more interesting to find out if it can warn about 
> > potential deadlocks _without_ them occurring.
> 
> For example, https://syzkaller.appspot.com/x/repro.c?x=15556074480000 generates
> below warning, but I don't have syzbot environment. Please propose an updated
> patch (which won't hit WARN_ON_ONCE()) for allowing people to try it in syzbot
> environment.

Here is a patch.  I haven't tried to compile it.

Alan Stern



Index: usb-devel/drivers/base/core.c
===================================================================
--- usb-devel.orig/drivers/base/core.c
+++ usb-devel/drivers/base/core.c
@@ -2322,6 +2322,9 @@ static void device_release(struct kobjec
 	devres_release_all(dev);
 
 	kfree(dev->dma_range_map);
+	mutex_destroy(&dev->mutex);
+	if (!lockdep_static_obj(dev))
+		lockdep_unregister_key(&dev->mutex_key);
 
 	if (dev->release)
 		dev->release(dev);
@@ -2941,7 +2944,10 @@ void device_initialize(struct device *de
 	kobject_init(&dev->kobj, &device_ktype);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	mutex_init(&dev->mutex);
-	lockdep_set_novalidate_class(&dev->mutex);
+	if (!lockdep_static_obj(dev)) {
+		lockdep_register_key(&dev->mutex_key);
+		lockdep_set_class(&dev->mutex, &dev->mutex_key);
+	}
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
Index: usb-devel/include/linux/device.h
===================================================================
--- usb-devel.orig/include/linux/device.h
+++ usb-devel/include/linux/device.h
@@ -570,6 +570,7 @@ struct device {
 	struct mutex		mutex;	/* mutex to synchronize calls to
 					 * its driver.
 					 */
+	struct lock_class_key	mutex_key;	/* Unique key for each device */
 
 	struct dev_links_info	links;
 	struct dev_pm_info	power;
Index: usb-devel/include/linux/lockdep.h
===================================================================
--- usb-devel.orig/include/linux/lockdep.h
+++ usb-devel/include/linux/lockdep.h
@@ -172,6 +172,7 @@ do {							\
 	current->lockdep_recursion -= LOCKDEP_OFF;	\
 } while (0)
 
+extern int lockdep_static_obj(const void *obj);
 extern void lockdep_register_key(struct lock_class_key *key);
 extern void lockdep_unregister_key(struct lock_class_key *key);
 
Index: usb-devel/kernel/locking/lockdep.c
===================================================================
--- usb-devel.orig/kernel/locking/lockdep.c
+++ usb-devel/kernel/locking/lockdep.c
@@ -831,7 +831,7 @@ static int arch_is_kernel_initmem_freed(
 }
 #endif
 
-static int static_obj(const void *obj)
+int lockdep_static_obj(const void *obj)
 {
 	unsigned long start = (unsigned long) &_stext,
 		      end   = (unsigned long) &_end,
@@ -857,6 +857,7 @@ static int static_obj(const void *obj)
 	 */
 	return is_module_address(addr) || is_module_percpu_address(addr);
 }
+EXPORT_SYMBOL_GPL(lockdep_static_obj);
 #endif
 
 /*
@@ -969,7 +970,7 @@ static bool assign_lock_key(struct lockd
 		lock->key = (void *)can_addr;
 	else if (__is_module_percpu_address(addr, &can_addr))
 		lock->key = (void *)can_addr;
-	else if (static_obj(lock))
+	else if (lockdep_static_obj(lock))
 		lock->key = (void *)lock;
 	else {
 		/* Debug-check: all keys must be persistent! */
@@ -1220,7 +1221,7 @@ void lockdep_register_key(struct lock_cl
 	struct lock_class_key *k;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(static_obj(key)))
+	if (WARN_ON_ONCE(lockdep_static_obj(key)))
 		return;
 	hash_head = keyhashentry(key);
 
@@ -1246,7 +1247,7 @@ static bool is_dynamic_key(const struct
 	struct lock_class_key *k;
 	bool found = false;
 
-	if (WARN_ON_ONCE(static_obj(key)))
+	if (WARN_ON_ONCE(lockdep_static_obj(key)))
 		return false;
 
 	/*
@@ -1293,7 +1294,7 @@ register_lock_class(struct lockdep_map *
 	if (!lock->key) {
 		if (!assign_lock_key(lock))
 			return NULL;
-	} else if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
+	} else if (!lockdep_static_obj(lock->key) && !is_dynamic_key(lock->key)) {
 		return NULL;
 	}
 
@@ -4836,7 +4837,7 @@ void lockdep_init_map_type(struct lockde
 	 * Sanity check, the lock-class key must either have been allocated
 	 * statically or must have been registered as a dynamic key.
 	 */
-	if (!static_obj(key) && !is_dynamic_key(key)) {
+	if (!lockdep_static_obj(key) && !is_dynamic_key(key)) {
 		if (debug_locks)
 			printk(KERN_ERR "BUG: key %px has not been registered!\n", key);
 		DEBUG_LOCKS_WARN_ON(1);
@@ -6335,7 +6336,7 @@ void lockdep_unregister_key(struct lock_
 
 	might_sleep();
 
-	if (WARN_ON_ONCE(static_obj(key)))
+	if (WARN_ON_ONCE(lockdep_static_obj(key)))
 		return;
 
 	raw_local_irq_save(flags);

