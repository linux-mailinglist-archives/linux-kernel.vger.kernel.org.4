Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB86CB97E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjC1IfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC1Iew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:34:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B2C49E9;
        Tue, 28 Mar 2023 01:34:51 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:34:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679992487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uj3Gz9DQvbGioAeN5LafCO6bBWg9r/sA+4PyB9L7G3s=;
        b=Djw0WY+jpTx+2J8yMwnbzJlCJneo0RSRFMz1JNNaowlqLuEXrg+VRKw04wEnrrr13aVrn4
        Pcc2AgyTNILa5YUK/2NeZhavr9v7WWkopCrTGV7qEmsd9h9JpYbFHiwkO1fNfQ7WZJZeFb
        97ha2r5NP3smMnJSHLExe99QvnzCO5Oe2B8FlEyAv5Hn91nHig+pXNJmzss7YTSl/aTrCW
        8sx/AYQ2qV3H+iq9bnlQ7/1QmWgfR3ixI9/+3hXclh486Bk520x+z8WfJaj+lbFnPdfB2d
        oReSOcZ8sRE/tu88FXvooUe2zVXIAtSC8PGTPlc6hNpvTWI6tcbDWeZFaAYEow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679992487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uj3Gz9DQvbGioAeN5LafCO6bBWg9r/sA+4PyB9L7G3s=;
        b=pV9eOMJvFElNoRSHdm5rWChGY+RONdT/wA3ERMCL5QN/n0ft23mIBnAInDU8mJegW/60gy
        nenAaCnsf2rLRpDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] locking/csd_lock: Remove per-CPU data indirection
 from CSD lock debugging
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230321005516.50558-3-paulmck@kernel.org>
References: <20230321005516.50558-3-paulmck@kernel.org>
MIME-Version: 1.0
Message-ID: <167999248708.5837.15614730966447536861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     6366d062e7f97499409979f23f4107a6c45edb04
Gitweb:        https://git.kernel.org/tip/6366d062e7f97499409979f23f4107a6c45edb04
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 20 Mar 2023 17:55:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Mar 2023 11:01:26 +01:00

locking/csd_lock: Remove per-CPU data indirection from CSD lock debugging

The diagnostics added by this commit were extremely useful in one instance:

a5aabace5fb8 ("locking/csd_lock: Add more data to CSD lock debugging")

However, they have not seen much action since, and there have been some
concerns expressed that the complexity is not worth the benefit.

Therefore, manually revert the following commit preparatory commit:

de7b09ef658d ("locking/csd_lock: Prepare more CSD lock debugging")

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20230321005516.50558-3-paulmck@kernel.org
---
 kernel/smp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 038d666..7a85bcd 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -31,12 +31,8 @@
 
 #define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
 
-struct cfd_percpu {
-	call_single_data_t	csd;
-};
-
 struct call_function_data {
-	struct cfd_percpu	__percpu *pcpu;
+	call_single_data_t	__percpu *csd;
 	cpumask_var_t		cpumask;
 	cpumask_var_t		cpumask_ipi;
 };
@@ -59,8 +55,8 @@ int smpcfd_prepare_cpu(unsigned int cpu)
 		free_cpumask_var(cfd->cpumask);
 		return -ENOMEM;
 	}
-	cfd->pcpu = alloc_percpu(struct cfd_percpu);
-	if (!cfd->pcpu) {
+	cfd->csd = alloc_percpu(call_single_data_t);
+	if (!cfd->csd) {
 		free_cpumask_var(cfd->cpumask);
 		free_cpumask_var(cfd->cpumask_ipi);
 		return -ENOMEM;
@@ -75,7 +71,7 @@ int smpcfd_dead_cpu(unsigned int cpu)
 
 	free_cpumask_var(cfd->cpumask);
 	free_cpumask_var(cfd->cpumask_ipi);
-	free_percpu(cfd->pcpu);
+	free_percpu(cfd->csd);
 	return 0;
 }
 
@@ -730,7 +726,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 		cpumask_clear(cfd->cpumask_ipi);
 		for_each_cpu(cpu, cfd->cpumask) {
-			call_single_data_t *csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
+			call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
 
 			if (cond_func && !cond_func(cpu, info))
 				continue;
@@ -774,7 +770,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
 
-			csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
+			csd = per_cpu_ptr(cfd->csd, cpu);
 			csd_lock_wait(csd);
 		}
 	}
