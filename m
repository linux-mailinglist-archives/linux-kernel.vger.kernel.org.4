Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968D8743BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjF3M3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjF3M3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:29:04 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793BC19B5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:29:01 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 35UCSsGv067611;
        Fri, 30 Jun 2023 21:28:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Fri, 30 Jun 2023 21:28:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 35UCSrjL067608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Jun 2023 21:28:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <42f1067f-3232-0a64-4c19-6165dabf46d0@I-love.SAKURA.ne.jp>
Date:   Fri, 30 Jun 2023 21:28:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH for 6.5] workqueue: Warn attempt to flush system-wide
 workqueues.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using
a macro"), all in-tree users stopped flushing system-wide workqueues.
Therefore, start emitting runtime message so that all out-of-tree users
will understand that they need to update their code.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
After this patch, flush_workqueue(wq) where wq cannot be determined at build
time will not get runtime warning. Should we now start checking wq at run time
so that we get runtime warning when wq is system-wide?

 include/linux/workqueue.h | 44 +++------------------------------------
 kernel/workqueue.c        | 11 +++++-----
 2 files changed, 8 insertions(+), 47 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 683efe29fa69..1a4223cbdb5f 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -569,6 +569,7 @@ static inline bool schedule_work(struct work_struct *work)
 
 /*
  * Detect attempt to flush system-wide workqueues at compile time when possible.
+ * Warn attempt to flush system-wide workqueues at runtime.
  *
  * See https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
  * for reasons and steps for converting system-wide workqueues into local workqueues.
@@ -576,52 +577,13 @@ static inline bool schedule_work(struct work_struct *work)
 extern void __warn_flushing_systemwide_wq(void)
 	__compiletime_warning("Please avoid flushing system-wide workqueues.");
 
-/**
- * flush_scheduled_work - ensure that any scheduled work has run to completion.
- *
- * Forces execution of the kernel-global workqueue and blocks until its
- * completion.
- *
- * It's very easy to get into trouble if you don't take great care.
- * Either of the following situations will lead to deadlock:
- *
- *	One of the work items currently on the workqueue needs to acquire
- *	a lock held by your code or its caller.
- *
- *	Your code is running in the context of a work routine.
- *
- * They will be detected by lockdep when they occur, but the first might not
- * occur very often.  It depends on what work items are on the workqueue and
- * what locks they need, which you have no control over.
- *
- * In most situations flushing the entire workqueue is overkill; you merely
- * need to know that a particular work item isn't queued and isn't running.
- * In such cases you should use cancel_delayed_work_sync() or
- * cancel_work_sync() instead.
- *
- * Please stop calling this function! A conversion to stop flushing system-wide
- * workqueues is in progress. This function will be removed after all in-tree
- * users stopped calling this function.
- */
-/*
- * The background of commit 771c035372a036f8 ("deprecate the
- * '__deprecated' attribute warnings entirely and for good") is that,
- * since Linus builds all modules between every single pull he does,
- * the standard kernel build needs to be _clean_ in order to be able to
- * notice when new problems happen. Therefore, don't emit warning while
- * there are in-tree users.
- */
+/* Please stop using this function, for this function will be removed in near future. */
 #define flush_scheduled_work()						\
 ({									\
-	if (0)								\
-		__warn_flushing_systemwide_wq();			\
+	__warn_flushing_systemwide_wq();				\
 	__flush_workqueue(system_wq);					\
 })
 
-/*
- * Although there is no longer in-tree caller, for now just emit warning
- * in order to give out-of-tree callers time to update.
- */
 #define flush_workqueue(wq)						\
 ({									\
 	struct workqueue_struct *_wq = (wq);				\
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 02a8f402eeb5..f8891552fdd6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6571,10 +6571,9 @@ void __init workqueue_init(void)
 	wq_watchdog_init();
 }
 
-/*
- * Despite the naming, this is a no-op function which is here only for avoiding
- * link error. Since compile-time warning may fail to catch, we will need to
- * emit run-time warning from __flush_workqueue().
- */
-void __warn_flushing_systemwide_wq(void) { }
+void __warn_flushing_systemwide_wq(void)
+{
+	pr_warn("WARNING: Flushing system-wide workqueues will be prohibited in near future.\n");
+	dump_stack();
+}
 EXPORT_SYMBOL(__warn_flushing_systemwide_wq);
-- 
2.18.4

