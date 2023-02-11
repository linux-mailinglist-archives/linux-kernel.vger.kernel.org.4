Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5635569340F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 22:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBKVlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 16:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBKVlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 16:41:13 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E9E0C11674
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 13:41:11 -0800 (PST)
Received: (qmail 858280 invoked by uid 1000); 11 Feb 2023 16:41:11 -0500
Date:   Sat, 11 Feb 2023 16:41:11 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Subject: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+gLd78vChQERZ6A@rowland.harvard.edu>
References: <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
 <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
 <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
 <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
 <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep is blind to the dev->mutex field of struct device, owing to
the fact that these mutexes are assigned to lockdep's "novalidate"
class.  Commit 1704f47b50b5 ("lockdep: Add novalidate class for
dev->mutex conversion") did this because the hierarchical nature of
the device tree makes it impossible in practice to determine whether
acquiring one of these mutexes is safe or might lead to a deadlock.

Unfortunately, this means that lockdep is unable to help diagnose real
deadlocks involving these mutexes when they occur in testing [1] [2]
or in actual use, or to detect bad locking patterns that might lead to
a deadlock.  We would like to obtain as much of lockdep's benefits as
possible without generating a flood of false positives -- which is
what happens if one naively removes these mutexes from the
"novalidate" class.

Accordingly, as a middle ground the mutex in each non-static struct
device will be placed in its own unique locking class.  This approach
gives up some of lockdep's advantages (for example, all devices having
a particular bus_type or device_type might reasonably be put into the
same locking class), but it should at least allow us to gain the
benefit of some of lockdep's capabilities.

Link: https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101 [1]
Link: https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb [2]
Link: https://lore.kernel.org/all/28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp/
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Boqun Feng <boqun.feng@gmail.com>

---

I decided to take your suggestion about introducing a new
lockdep_static_obj() function, to reduce the size of the patch.  It
can always be combined with the original static_obj() function later
on, if that's what the lockdep developers want.

If Hillf Danton contributed any of the code for this patch, I haven't
seen it in any messages sent to me or in the mailing list archives.
That's why I didn't include a Co-developed-by: tag for him.

 drivers/base/core.c      |    8 +++++++-
 include/linux/device.h   |    1 +
 include/linux/lockdep.h  |    6 ++++++
 kernel/locking/lockdep.c |    5 +++++
 4 files changed, 19 insertions(+), 1 deletion(-)

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
 
@@ -391,6 +392,11 @@ static inline void lockdep_set_selftest_
 # define lockdep_free_key_range(start, size)	do { } while (0)
 # define lockdep_sys_exit() 			do { } while (0)
 
+static inline int lockdep_static_obj(const void *obj)
+{
+	return 0;
+}
+
 static inline void lockdep_register_key(struct lock_class_key *key)
 {
 }
Index: usb-devel/kernel/locking/lockdep.c
===================================================================
--- usb-devel.orig/kernel/locking/lockdep.c
+++ usb-devel/kernel/locking/lockdep.c
@@ -857,6 +857,11 @@ static int static_obj(const void *obj)
 	 */
 	return is_module_address(addr) || is_module_percpu_address(addr);
 }
+
+int lockdep_static_obj(const void *obj)
+{
+	return static_obj(obj);
+}
 #endif
 
 /*
