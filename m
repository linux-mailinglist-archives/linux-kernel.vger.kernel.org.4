Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98F468675C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjBANqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjBANqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:46:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A864956897
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:46:33 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5F53F21F56;
        Wed,  1 Feb 2023 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675259192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWffW842zx0Ic0ZTpiaeuqRiYLXVWbY9mBJbQ30f2sA=;
        b=lt4vtI5K6Nh1r3/Cr0c4RcCHHJjA6Cp6RZbYAFDzB+CvR7IwIvMhF8Ju4vcIMslLAIu8N/
        ZO9iv/J7NZO+X6b9zwahh/p86djrr5E7dXq9g9tDHpB5EaQsgSJxoI/1M2M84vnjWhuBL/
        nePhzU/3i3aVakXBFDaTSVfVXJbM7+4=
Received: from alley.suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        by relay2.suse.de (Postfix) with ESMTP id 21CD62C141;
        Wed,  1 Feb 2023 13:46:32 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [RFC 4/5] workqueue: Warn when a rescuer could not be created
Date:   Wed,  1 Feb 2023 14:45:42 +0100
Message-Id: <20230201134543.13687-5-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230201134543.13687-1-pmladek@suse.com>
References: <20230201134543.13687-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rescuers are created when a workqueue with WQ_MEM_RECLAIM is allocated.
It typically happens during the system boot.

systemd switches the root filesystem from initrd to the booted system
during boot. It kills processes that block the switch for too long.
One of the process might be modprobe that tries to create a workqueue.

These problems are hard to reproduce. Also alloc_workqueue() does not
pass the error code. Make the debugging easier by printing a warning,
similar to create_worker().

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/workqueue.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5f3327e119b4..58b835420435 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1914,9 +1914,11 @@ static void worker_detach_from_pool(struct worker *worker)
 static int create_worker_failed;
 static DEFINE_SPINLOCK(create_worker_failed_lock);
 
-static __printf(2, 3) __cold
-void __print_create_worker_failure(long err, const char *fmt, ...)
+static __printf(3, 4) __cold
+void __print_create_worker_failure(bool is_rescuer, long err, const char *fmt, ...)
 {
+	bool one_off_failure;
+
 	spin_lock_irq(&create_worker_failed_lock);
 
 	/*
@@ -1925,7 +1927,8 @@ void __print_create_worker_failure(long err, const char *fmt, ...)
 	 * touch watchdogs so that more frequent messages would prevent
 	 * reaching the watchdog thresh.
 	 */
-	if (!create_worker_failed || err == -EINTR) {
+	one_off_failure = (err == -EINTR || is_rescuer);
+	if (!create_worker_failed || one_off_failure) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -1933,7 +1936,7 @@ void __print_create_worker_failure(long err, const char *fmt, ...)
 		va_end(args);
 	}
 
-	if (err != -EINTR)
+	if (!one_off_failure)
 		create_worker_failed++;
 
 	spin_unlock_irq(&create_worker_failed_lock);
@@ -1943,7 +1946,9 @@ void __print_create_worker_failure(long err, const char *fmt, ...)
 	do {					\
 		long _err = err;		\
 						\
-		__print_create_worker_failure(_err, KERN_WARNING msg ":%pe\n", (void *)_err); \
+		__print_create_worker_failure(false, _err,			\
+					      KERN_WARNING msg ":%pe\n",	\
+					      (void *)_err);			\
 	} while (0)
 
 static void print_create_worker_success(void)
@@ -4323,6 +4328,15 @@ static int wq_clamp_max_active(int max_active, unsigned int flags,
 	return clamp_val(max_active, 1, lim);
 }
 
+#define print_create_rescuer_failure(msg, name, err)			\
+	do {								\
+		long _err = err;					\
+									\
+		__print_create_worker_failure(true, _err,		\
+					      KERN_WARNING msg ": %s :%pe\n",	\
+					      name, (void *)_err);	\
+	} while (0)
+
 /*
  * Workqueues which may be used during memory reclaim should have a rescuer
  * to guarantee forward progress.
@@ -4336,13 +4350,18 @@ static int init_rescuer(struct workqueue_struct *wq)
 		return 0;
 
 	rescuer = alloc_worker(NUMA_NO_NODE);
-	if (!rescuer)
+	if (!rescuer) {
+		print_create_rescuer_failure("workqueue: Failed to allocate a rescuer",
+					     wq->name, -ENOMEM);
 		return -ENOMEM;
+	}
 
 	rescuer->rescue_wq = wq;
 	rescuer->task = kthread_create(rescuer_thread, rescuer, "%s", wq->name);
 	if (IS_ERR(rescuer->task)) {
 		ret = PTR_ERR(rescuer->task);
+		print_create_rescuer_failure("workqueue: Failed to create a rescuer thread",
+					     wq->name, ret);
 		kfree(rescuer);
 		return ret;
 	}
-- 
2.35.3

