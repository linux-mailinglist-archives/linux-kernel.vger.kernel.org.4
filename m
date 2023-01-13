Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85FC6696BC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241362AbjAMMPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbjAMMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:14:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D731C39F85;
        Fri, 13 Jan 2023 04:08:51 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:08:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673611729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/Ic1iHz7HOZXaYuCXWJmrVkuygPLmdoT5X74IVs4F4=;
        b=tHfH//SC2gwMwc/gpDl6kaUeJ0/a9ii4zzJ6iAkjsoy8gFyxV0K6GqmOVmWjc7kbk98kqD
        Syuem4R9u4HONmYTsxbm0DblE3X/AyhlFOWU8lQ5PgU/BEK165etO/1gGEaFCvJJ41AY6b
        l8jngw5nWxDSroyq6RLBmdD2DpfoMkHaSLFjVDlAPv9PBdVlSFmHhtI8x0JPgi2M2j7F/N
        F58/a9M/EZ70X9b9lLyO++/SuUO1TJenftGTuLrFT44lugwhR6hejSnQkUgj5/D6W8s5UH
        eyvf1sYYVRQaKbzzUdjnv2MulPYI8WBgnALLarfmDcM586GMIQbFsGvjKWxFjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673611729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/Ic1iHz7HOZXaYuCXWJmrVkuygPLmdoT5X74IVs4F4=;
        b=xu7T3dWh3XoitD0n4zxH4ygrNwkPfXafMdSuUsX3gqx6FqwE5m2+GaSfTOztcZHdTd200x
        aS+gMpJEc+KQcNCA==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fixes for capacity inversion detection
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Qais Yousef (Google)" <qyousef@layalina.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112122708.330667-3-qyousef@layalina.io>
References: <20230112122708.330667-3-qyousef@layalina.io>
MIME-Version: 1.0
Message-ID: <167361172839.4906.18334832591447660001.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     da07d2f9c153e457e845d4dcfdd13568d71d18a4
Gitweb:        https://git.kernel.org/tip/da07d2f9c153e457e845d4dcfdd13568d71d18a4
Author:        Qais Yousef <qyousef@layalina.io>
AuthorDate:    Thu, 12 Jan 2023 12:27:08 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 13 Jan 2023 11:40:21 +01:00

sched/fair: Fixes for capacity inversion detection

Traversing the Perf Domains requires rcu_read_lock() to be held and is
conditional on sched_energy_enabled(). Ensure right protections applied.

Also skip capacity inversion detection for our own pd; which was an
error.

Fixes: 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230112122708.330667-3-qyousef@layalina.io
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index be43731..0f87369 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8868,16 +8868,23 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	 *   * Thermal pressure will impact all cpus in this perf domain
 	 *     equally.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (sched_energy_enabled()) {
 		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
-		struct perf_domain *pd = rcu_dereference(rq->rd->pd);
+		struct perf_domain *pd;
+
+		rcu_read_lock();
 
+		pd = rcu_dereference(rq->rd->pd);
 		rq->cpu_capacity_inverted = 0;
 
 		for (; pd; pd = pd->next) {
 			struct cpumask *pd_span = perf_domain_span(pd);
 			unsigned long pd_cap_orig, pd_cap;
 
+			/* We can't be inverted against our own pd */
+			if (cpumask_test_cpu(cpu_of(rq), pd_span))
+				continue;
+
 			cpu = cpumask_any(pd_span);
 			pd_cap_orig = arch_scale_cpu_capacity(cpu);
 
@@ -8902,6 +8909,8 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 				break;
 			}
 		}
+
+		rcu_read_unlock();
 	}
 
 	trace_sched_cpu_capacity_tp(rq);
