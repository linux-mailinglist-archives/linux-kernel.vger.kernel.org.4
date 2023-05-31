Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800AB717F80
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjEaME6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjEaMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:04:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD1310B;
        Wed, 31 May 2023 05:04:49 -0700 (PDT)
Date:   Wed, 31 May 2023 12:04:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685534688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuqkZobSgHIHglDkY+euou/mzGOOirg20B5cXN0jJ+4=;
        b=LTxEda//z9UXe3+WCw7hUrMJ5zbPoX+UCmgkO3USRcPf34TYUJBPSEsLur9CA41z4LIXZw
        1aGNrR6ea8fSHZn1q5gQoAoc3zj9TSa7Dz2CW7yTDtstXwZVVk5kpz7FhxezrfvMbYbxow
        KiNXmoEICbli0AGkXEPonV8co6UnhxnofeRevXsaKfensDLSLDJWp1a9bnThAl3D2bMjYj
        Ba3bWFGXcjYMghuy5U5G55CcNm4TbEGyE+ny/WxS2vp0V345yfQ2CcEGPKyhunmxITa1F/
        DANeB0Ps+S7pKo01C/EvA/DcfQYUL4CYigjkSBPT3XAI6EKYvBCMZgbzDV1pzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685534688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuqkZobSgHIHglDkY+euou/mzGOOirg20B5cXN0jJ+4=;
        b=UZN+Xir1hVSjhTswmo1wqX3tcGlQxViQmAUnQY9T4ndZWOknPrpqF5kkn3FcYkoos/xT94
        suS73PBity6vbFCA==
From:   "tip-bot2 for Miaohe Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: remove unused dl_bandwidth
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230524102514.407486-1-linmiaohe@huawei.com>
References: <20230524102514.407486-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Message-ID: <168553468812.404.16437578033424915162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3f4bf7aa315bf55b2a569bf77f61ff81c7e11fc1
Gitweb:        https://git.kernel.org/tip/3f4bf7aa315bf55b2a569bf77f61ff81c7e11fc1
Author:        Miaohe Lin <linmiaohe@huawei.com>
AuthorDate:    Wed, 24 May 2023 18:25:14 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 May 2023 22:46:26 +02:00

sched/deadline: remove unused dl_bandwidth

The default deadline bandwidth control structure has been removed since
commit eb77cf1c151c ("sched/deadline: Remove unused def_dl_bandwidth")
leading to unused init_dl_bandwidth() and struct dl_bandwidth. Remove
them to clean up the code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20230524102514.407486-1-linmiaohe@huawei.com
---
 kernel/sched/deadline.c | 7 -------
 kernel/sched/sched.h    | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5a9a4b8..f827067 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -489,13 +489,6 @@ static inline int is_leftmost(struct task_struct *p, struct dl_rq *dl_rq)
 
 static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
 
-void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime)
-{
-	raw_spin_lock_init(&dl_b->dl_runtime_lock);
-	dl_b->dl_period = period;
-	dl_b->dl_runtime = runtime;
-}
-
 void init_dl_bw(struct dl_bw *dl_b)
 {
 	raw_spin_lock_init(&dl_b->lock);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6784462..d8ba81c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -286,12 +286,6 @@ struct rt_bandwidth {
 
 void __dl_clear_params(struct task_struct *p);
 
-struct dl_bandwidth {
-	raw_spinlock_t		dl_runtime_lock;
-	u64			dl_runtime;
-	u64			dl_period;
-};
-
 static inline int dl_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
@@ -2394,7 +2388,6 @@ extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
 extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
-extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
 extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
 extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
 
