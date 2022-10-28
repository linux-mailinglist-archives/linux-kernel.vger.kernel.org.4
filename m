Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A824D610A99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJ1GoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJ1Gm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DAB1BA1D0;
        Thu, 27 Oct 2022 23:42:22 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fdtyswIlXhZDxIDmJgt5i7Zm70bgRwTXWdCBkV57Us=;
        b=C10mRIHR2YCLtTmPFNj7cxuBXOUzHZCmlSCFDDkzlnCXTf4rZCVRIVfDKcpnIDW66ehqOw
        n82nJYIX2rRan3e5PCbo6pKmY1UBV2khFnq8Gw2JBGfzSlvpwZqNN7S9luC0NwtKLIeZXw
        L8PWlnFWEy8zTZI8n+pr4ciwbV+whuvF87LMbiaq0pwJQ6lYHzBRIxQ1+fAd6YrV9T+L55
        vnXYLDKf0oxo8L70zyGseUwRYFnAxxKmLdpJTFbxX+pupUz3yPq711/JZMHjk/DFyWDc5z
        oD3R3HzLPGA4J0r8Ff3PbfMB5tk96kvf1JKM9lo5XVPvSKumJ03CxhUER/dvpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fdtyswIlXhZDxIDmJgt5i7Zm70bgRwTXWdCBkV57Us=;
        b=xN1Ik5I78wLn6a06wI8WTjZw5bayeuUxqOWyByS/jXuPwkLjcabpM+ig9dUNXQEKg3Bk0y
        WyaaentDBRpNMJBw==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Make cpu_overutilized() use util_fits_cpu()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220804143609.515789-7-qais.yousef@arm.com>
References: <20220804143609.515789-7-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <166693933995.29415.10483608660072529451.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c56ab1b3506ba0e7a872509964b100912bde165d
Gitweb:        https://git.kernel.org/tip/c56ab1b3506ba0e7a872509964b100912bde165d
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 04 Aug 2022 15:36:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:19 +02:00

sched/uclamp: Make cpu_overutilized() use util_fits_cpu()

So that it is now uclamp aware.

This fixes a major problem of busy tasks capped with UCLAMP_MAX keeping
the system in overutilized state which disables EAS and leads to wasting
energy in the long run.

Without this patch running a busy background activity like JIT
compilation on Pixel 6 causes the system to be in overutilized state
74.5% of the time.

With this patch this goes down to  9.79%.

It also fixes another problem when long running tasks that have their
UCLAMP_MIN changed while running such that they need to upmigrate to
honour the new UCLAMP_MIN value. The upmigration doesn't get triggered
because overutilized state never gets set in this state, hence misfit
migration never happens at tick in this case until the task wakes up
again.

Fixes: af24bde8df202 ("sched/uclamp: Add uclamp support to energy_compute()")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220804143609.515789-7-qais.yousef@arm.com
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cabbdac..a0ee319 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5987,7 +5987,10 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
+	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
+	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+
+	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }
 
 static inline void update_overutilized_status(struct rq *rq)
