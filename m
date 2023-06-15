Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C34731729
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbjFOLkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbjFOLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:38:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9430F2;
        Thu, 15 Jun 2023 04:38:15 -0700 (PDT)
Date:   Thu, 15 Jun 2023 11:38:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686829093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QTaI/jPZ+a/Pf15JySdI0RMrIx//5I7shAXr7QX8aj0=;
        b=vb5gO97yB+2BrODwrlonZV1VQGqdebUak+lUPZS5VR7Eg0SN81CvL+1/Ac7QWSeNBXgm6h
        9JSqn+Wv83o75u1yb4sHPmzu+m7KwPkHehPljqBQ4yxAITUZetV5Vyt68MJwccwXP8eMJt
        zKHrU0b0wyOZivu9DkIlGZm+Q8e7tICX6SECIQ/bDtrd/c1NMpx5zzsLb8Ls9rRB741vN8
        aRHluWGq+6jFmLcGcK8eFwaZB+IXwpLFoN+Kkwx/rsxZYFpqgA8CDxzDfBrwhhH4nBNNt4
        uL5gg1NYqIItfvBQptqkSu4VlvclyzmvsuamDQIUIbfs45AL1d5FyBUYzPIUrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686829093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QTaI/jPZ+a/Pf15JySdI0RMrIx//5I7shAXr7QX8aj0=;
        b=2wzcfvFrVMIHLshOe9k55rNwzjoVW1MnzpMbZGblJ1vcKRo/dBGGk2Z6ttR5HLMkKYj80a
        KP4aVcQali0mQ9Dw==
From:   tip-bot2 for Arve =?utf-8?q?Hj=C3=B8nnev=C3=A5g?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/wait: Fix a kthread_park race with wait_woken()
Cc:     arve@android.com, John Stultz <jstultz@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230602212350.535358-1-jstultz@google.com>
References: <20230602212350.535358-1-jstultz@google.com>
MIME-Version: 1.0
Message-ID: <168682909289.404.8831438391422157920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4b85308dac750b16bd273b0f4e9c9b478fbb886b
Gitweb:        https://git.kernel.org/tip/4b85308dac750b16bd273b0f4e9c9b478fb=
b886b
Author:        Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
AuthorDate:    Fri, 02 Jun 2023 21:23:46=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jun 2023 13:28:21 +02:00

sched/wait: Fix a kthread_park race with wait_woken()

kthread_park and wait_woken have a similar race that
kthread_stop and wait_woken used to have before it was fixed in
commit cb6538e740d7 ("sched/wait: Fix a kthread race with
wait_woken()"). Extend that fix to also cover kthread_park.

[jstultz: Made changes suggested by Peter to optimize
 memory loads]

Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230602212350.535358-1-jstultz@google.com
---
 include/linux/kthread.h |  1 +
 kernel/kthread.c        | 10 ++++++++++
 kernel/sched/wait.c     |  7 +------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 30e5bec..f1f95a7 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -89,6 +89,7 @@ int kthread_stop(struct task_struct *k);
 bool kthread_should_stop(void);
 bool kthread_should_park(void);
 bool __kthread_should_park(struct task_struct *k);
+bool kthread_should_stop_or_park(void);
 bool kthread_freezable_should_stop(bool *was_frozen);
 void *kthread_func(struct task_struct *k);
 void *kthread_data(struct task_struct *k);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 490792b..07a0570 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -182,6 +182,16 @@ bool kthread_should_park(void)
 }
 EXPORT_SYMBOL_GPL(kthread_should_park);
=20
+bool kthread_should_stop_or_park(void)
+{
+	struct kthread *kthread =3D __to_kthread(current);
+
+	if (!kthread)
+		return false;
+
+	return kthread->flags & (BIT(KTHREAD_SHOULD_STOP) | BIT(KTHREAD_SHOULD_PARK=
));
+}
+
 /**
  * kthread_freezable_should_stop - should this freezable kthread return now?
  * @was_frozen: optional out parameter, indicates whether %current was frozen
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 133b747..48c53e4 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -425,11 +425,6 @@ int autoremove_wake_function(struct wait_queue_entry *wq=
_entry, unsigned mode, i
 }
 EXPORT_SYMBOL(autoremove_wake_function);
=20
-static inline bool is_kthread_should_stop(void)
-{
-	return (current->flags & PF_KTHREAD) && kthread_should_stop();
-}
-
 /*
  * DEFINE_WAIT_FUNC(wait, woken_wake_func);
  *
@@ -459,7 +454,7 @@ long wait_woken(struct wait_queue_entry *wq_entry, unsign=
ed mode, long timeout)
 	 * or woken_wake_function() sees our store to current->state.
 	 */
 	set_current_state(mode); /* A */
-	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
+	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !kthread_should_stop_or_park())
 		timeout =3D schedule_timeout(timeout);
 	__set_current_state(TASK_RUNNING);
=20
