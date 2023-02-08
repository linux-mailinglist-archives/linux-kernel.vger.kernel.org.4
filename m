Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71668ECE3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjBHKbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjBHKbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:31:09 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B095747EFC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:30:31 -0800 (PST)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 318AUTgR072761;
        Wed, 8 Feb 2023 19:30:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Wed, 08 Feb 2023 19:30:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 318AUTJM072758
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 8 Feb 2023 19:30:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
Date:   Wed, 8 Feb 2023 19:30:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH] drivers/core: Replace lockdep_set_novalidate_class() with
 unique class keys
Content-Language: en-US
To:     syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hillf Danton <hdanton@sina.com>
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
 <20230208080739.1649-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230208080739.1649-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1704f47b50b5 ("lockdep: Add novalidate class for dev->mutex
conversion") made it impossible to find real deadlocks unless timing
dependent testings manage to trigger hung task like [1] and [2]. And
lockdep_set_novalidate_class() remained for more than one decade due to
a fear of false positives [3]. But not sharing mutex_init() could make
it possible to find real deadlocks without triggering hung task [4].
Thus, let's assign a unique class key on each "struct device"->mutex.

Link: https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101 [1]
Link: https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb [2]
Link: https://lkml.kernel.org/r/Y98FLlr7jkiFlV0k@rowland.harvard.edu [3]
Link: https://lkml.kernel.org/r/827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp [4]
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Co-developed-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Hello, syzkaller users.

We made a patch that keeps lockdep validation enabled on "struct dev->mutex".
Will you try this patch and see if this patch causes boot failures and/or
too frequent crashes to continue testing.

 drivers/base/core.c      | 7 ++++++-
 include/linux/device.h   | 1 +
 include/linux/lockdep.h  | 6 ++++++
 kernel/locking/lockdep.c | 7 +++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..c30ecbc4d60e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2322,6 +2322,9 @@ static void device_release(struct kobject *kobj)
 	devres_release_all(dev);
 
 	kfree(dev->dma_range_map);
+	mutex_destroy(&dev->mutex);
+	if (!lockdep_static_obj(dev))
+		lockdep_unregister_key(&dev->mutex_key);
 
 	if (dev->release)
 		dev->release(dev);
@@ -2941,7 +2944,9 @@ void device_initialize(struct device *dev)
 	kobject_init(&dev->kobj, &device_ktype);
 	INIT_LIST_HEAD(&dev->dma_pools);
 	mutex_init(&dev->mutex);
-	lockdep_set_novalidate_class(&dev->mutex);
+	if (!lockdep_static_obj(dev))
+		lockdep_register_key(&dev->mutex_key);
+	lockdep_set_class(&dev->mutex, &dev->mutex_key);
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index 44e3acae7b36..bdaca9f54dc2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -570,6 +570,7 @@ struct device {
 	struct mutex		mutex;	/* mutex to synchronize calls to
 					 * its driver.
 					 */
+	struct lock_class_key	mutex_key;	/* Unique key for each device */
 
 	struct dev_links_info	links;
 	struct dev_pm_info	power;
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1f1099dac3f0..5afc999a7e56 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -172,6 +172,7 @@ do {							\
 	current->lockdep_recursion -= LOCKDEP_OFF;	\
 } while (0)
 
+extern int lockdep_static_obj(const void *obj);
 extern void lockdep_register_key(struct lock_class_key *key);
 extern void lockdep_unregister_key(struct lock_class_key *key);
 
@@ -391,6 +392,11 @@ static inline void lockdep_set_selftest_task(struct task_struct *task)
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
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e3375bc40dad..74c0113646f1 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -857,6 +857,13 @@ static int static_obj(const void *obj)
 	 */
 	return is_module_address(addr) || is_module_percpu_address(addr);
 }
+
+int lockdep_static_obj(const void *obj)
+{
+	return static_obj(obj);
+}
+EXPORT_SYMBOL_GPL(lockdep_static_obj);
+
 #endif
 
 /*
-- 
2.34.1

