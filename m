Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE70B686B33
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjBAQLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjBAQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:11:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE66B74A66;
        Wed,  1 Feb 2023 08:11:02 -0800 (PST)
Date:   Wed, 01 Feb 2023 16:10:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675267860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oqqWe7eBCUvOpimW7kiVzqgFNPGnEMVUiB85b6iAhEE=;
        b=dzIM3MzN8hiBdW0RAnP3A3rCc4btN2KARiSJgOpfcUNm35KnAIY2fFBojs06sZC6pp/xsO
        KjEOOaB9Qbokb2IJgX0w7U1nNrbWze889bAZMdILcdZ/XQdd4bEaO56qhE3lkzwrzZigfD
        Py8enfeUB438rTZqEmH4qPMi7XExvzkbdfaXw86HCsoFjsn87/mXVAosd+ou5Q3c9bD7f5
        WAwtECKpgyaQ9xeSKA954WJcjFCfXKOw+h8cS69EEt7V/HukFuVfLVY+rsJlUdhiJ7etkk
        TRcnLAMjy2S9bIo+4KLTGzfi3fb+MIremXMbyQCzbHSShH/Izy8O8IcUmsJbuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675267860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oqqWe7eBCUvOpimW7kiVzqgFNPGnEMVUiB85b6iAhEE=;
        b=faTU7XV8eUaUm7+nFIRiZTiAnZvfVZnGOcqUxPfCuQ5zDpf8IDA5rOKum1ZhDOQwCkLvU+
        B4tLW57MQ/+GCIAg==
From:   "tip-bot2 for James Clark" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix perf_event_pmu_context serialization
Cc:     syzbot+697196bc0265049822bd@syzkaller.appspotmail.com,
        James Clark <james.clark@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230127143141.1782804-2-james.clark@arm.com>
References: <20230127143141.1782804-2-james.clark@arm.com>
MIME-Version: 1.0
Message-ID: <167526785958.4906.6025271558329131555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4f64a6c9f6f11e8b7314f8e27e2c4568706009e6
Gitweb:        https://git.kernel.org/tip/4f64a6c9f6f11e8b7314f8e27e2c4568706009e6
Author:        James Clark <james.clark@arm.com>
AuthorDate:    Fri, 27 Jan 2023 14:31:41 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 31 Jan 2023 20:37:18 +01:00

perf: Fix perf_event_pmu_context serialization

Syzkaller triggered a WARN in put_pmu_ctx().

  WARNING: CPU: 1 PID: 2245 at kernel/events/core.c:4925 put_pmu_ctx+0x1f0/0x278

This is because there is no locking around the access of "if
(!epc->ctx)" in find_get_pmu_context() and when it is set to NULL in
put_pmu_ctx().

The decrement of the reference count in put_pmu_ctx() also happens
outside of the spinlock, leading to the possibility of this order of
events, and the context being cleared in put_pmu_ctx(), after its
refcount is non zero:

 CPU0                                   CPU1
 find_get_pmu_context()
   if (!epc->ctx) == false
                                        put_pmu_ctx()
                                        atomic_dec_and_test(&epc->refcount) == true
                                        epc->refcount == 0
     atomic_inc(&epc->refcount);
     epc->refcount == 1
                                        list_del_init(&epc->pmu_ctx_entry);
	                                      epc->ctx = NULL;

Another issue is that WARN_ON for no active PMU events in put_pmu_ctx()
is outside of the lock. If the perf_event_pmu_context is an embedded
one, even after clearing it, it won't be deleted and can be re-used. So
the warning can trigger. For this reason it also needs to be moved
inside the lock.

The above warning is very quick to trigger on Arm by running these two
commands at the same time:

  while true; do perf record -- ls; done
  while true; do perf record -- ls; done

[peterz: atomic_dec_and_raw_lock*()]
Fixes: bd2756811766 ("perf: Rewrite core context handling")
Reported-by: syzbot+697196bc0265049822bd@syzkaller.appspotmail.com
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20230127143141.1782804-2-james.clark@arm.com
---
 include/linux/spinlock.h |  9 +++++++++-
 kernel/events/core.c     | 39 +++++++++++++++++----------------------
 lib/dec_and_lock.c       | 31 +++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 1341f7d..be48f1c 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -476,6 +476,15 @@ extern int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
 #define atomic_dec_and_lock_irqsave(atomic, lock, flags) \
 		__cond_lock(lock, _atomic_dec_and_lock_irqsave(atomic, lock, &(flags)))
 
+extern int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock);
+#define atomic_dec_and_raw_lock(atomic, lock) \
+		__cond_lock(lock, _atomic_dec_and_raw_lock(atomic, lock))
+
+extern int _atomic_dec_and_raw_lock_irqsave(atomic_t *atomic, raw_spinlock_t *lock,
+					unsigned long *flags);
+#define atomic_dec_and_raw_lock_irqsave(atomic, lock, flags) \
+		__cond_lock(lock, _atomic_dec_and_raw_lock_irqsave(atomic, lock, &(flags)))
+
 int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 			     size_t max_size, unsigned int cpu_mult,
 			     gfp_t gfp, const char *name,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d56328e..c4be13e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4813,19 +4813,17 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 
 		cpc = per_cpu_ptr(pmu->cpu_pmu_context, event->cpu);
 		epc = &cpc->epc;
-
+		raw_spin_lock_irq(&ctx->lock);
 		if (!epc->ctx) {
 			atomic_set(&epc->refcount, 1);
 			epc->embedded = 1;
-			raw_spin_lock_irq(&ctx->lock);
 			list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
 			epc->ctx = ctx;
-			raw_spin_unlock_irq(&ctx->lock);
 		} else {
 			WARN_ON_ONCE(epc->ctx != ctx);
 			atomic_inc(&epc->refcount);
 		}
-
+		raw_spin_unlock_irq(&ctx->lock);
 		return epc;
 	}
 
@@ -4896,33 +4894,30 @@ static void free_epc_rcu(struct rcu_head *head)
 
 static void put_pmu_ctx(struct perf_event_pmu_context *epc)
 {
+	struct perf_event_context *ctx = epc->ctx;
 	unsigned long flags;
 
-	if (!atomic_dec_and_test(&epc->refcount))
+	/*
+	 * XXX
+	 *
+	 * lockdep_assert_held(&ctx->mutex);
+	 *
+	 * can't because of the call-site in _free_event()/put_event()
+	 * which isn't always called under ctx->mutex.
+	 */
+	if (!atomic_dec_and_raw_lock_irqsave(&epc->refcount, &ctx->lock, flags))
 		return;
 
-	if (epc->ctx) {
-		struct perf_event_context *ctx = epc->ctx;
+	WARN_ON_ONCE(list_empty(&epc->pmu_ctx_entry));
 
-		/*
-		 * XXX
-		 *
-		 * lockdep_assert_held(&ctx->mutex);
-		 *
-		 * can't because of the call-site in _free_event()/put_event()
-		 * which isn't always called under ctx->mutex.
-		 */
-
-		WARN_ON_ONCE(list_empty(&epc->pmu_ctx_entry));
-		raw_spin_lock_irqsave(&ctx->lock, flags);
-		list_del_init(&epc->pmu_ctx_entry);
-		epc->ctx = NULL;
-		raw_spin_unlock_irqrestore(&ctx->lock, flags);
-	}
+	list_del_init(&epc->pmu_ctx_entry);
+	epc->ctx = NULL;
 
 	WARN_ON_ONCE(!list_empty(&epc->pinned_active));
 	WARN_ON_ONCE(!list_empty(&epc->flexible_active));
 
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+
 	if (epc->embedded)
 		return;
 
diff --git a/lib/dec_and_lock.c b/lib/dec_and_lock.c
index 9555b68..1dcca8f 100644
--- a/lib/dec_and_lock.c
+++ b/lib/dec_and_lock.c
@@ -49,3 +49,34 @@ int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
 	return 0;
 }
 EXPORT_SYMBOL(_atomic_dec_and_lock_irqsave);
+
+int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock)
+{
+	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
+	if (atomic_add_unless(atomic, -1, 1))
+		return 0;
+
+	/* Otherwise do it the slow way */
+	raw_spin_lock(lock);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	raw_spin_unlock(lock);
+	return 0;
+}
+EXPORT_SYMBOL(_atomic_dec_and_raw_lock);
+
+int _atomic_dec_and_raw_lock_irqsave(atomic_t *atomic, raw_spinlock_t *lock,
+				     unsigned long *flags)
+{
+	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
+	if (atomic_add_unless(atomic, -1, 1))
+		return 0;
+
+	/* Otherwise do it the slow way */
+	raw_spin_lock_irqsave(lock, *flags);
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	raw_spin_unlock_irqrestore(lock, *flags);
+	return 0;
+}
+EXPORT_SYMBOL(_atomic_dec_and_raw_lock_irqsave);
