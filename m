Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7F656AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiL0MPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiL0MOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0EBC0E;
        Tue, 27 Dec 2022 04:13:50 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOddLRVxfeU+1QhsA0x4c7NKPt/49V8pu9vYzKx84IY=;
        b=Rs3ydQasKXu+Lg90oMYMt1YtqW//jLFXIBQMoT93NQAWgtkSTepo9O7GEvgj3soDe+9k03
        YPSgN2ewiC4JpcRJjBiRnnUN3DQaGTOcku+bYT0l/YYMISnUiuEAZEuqMIMzR5PgmILl2n
        NM/Q5EV5NYm0RS5Aa2dFlGMtEslthhXybFNLlRFsxziUpw/TNHnb4aOKstMn3PGsC/YYQV
        lyTy0fwOH2qTiz7A75fQP043Zq26+zKKIFP2RyeH4XX8LJkdsb0FBC5N6C+/u4odaCMPbk
        dxgvcqpWmxmhs2YnM0CJWpf15aMAp2cOepZwmPpaD/c4UuJzEm5BZsuo0l3y0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143229;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOddLRVxfeU+1QhsA0x4c7NKPt/49V8pu9vYzKx84IY=;
        b=7EjQzzLKyQ2TRap8jKpuV/JgbCPl83oxuyEhzWJITLJjKWz3yzOqM1fp6m03nh6d7eqoyY
        4jJe7FY9yG3u3UAA==
From:   "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Stop an exhastive search if an idle
 core is found
Cc:     Hao Jia <jiahao.os@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221216062406.7812-2-jiahao.os@bytedance.com>
References: <20221216062406.7812-2-jiahao.os@bytedance.com>
MIME-Version: 1.0
Message-ID: <167214322868.4906.12856544569923049158.tip-bot2@tip-bot2>
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

Commit-ID:     feaed76376fd612b9450ad1251aec20a63ccfe92
Gitweb:        https://git.kernel.org/tip/feaed76376fd612b9450ad1251aec20a63ccfe92
Author:        Hao Jia <jiahao.os@bytedance.com>
AuthorDate:    Fri, 16 Dec 2022 14:24:05 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:16 +01:00

sched/numa: Stop an exhastive search if an idle core is found

In update_numa_stats() we try to find an idle cpu on the NUMA node,
preferably an idle core. we can stop looking for the next idle core
or idle cpu after finding an idle core. But we can't stop the
whole loop of scanning the CPU, because we need to calculate
approximate NUMA stats at a point in time. For example,
the src and dst nr_running is needed by task_numa_find_cpu().

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20221216062406.7812-2-jiahao.os@bytedance.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d0e2a48..aaff209 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1804,7 +1804,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
 
-		if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
+		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
 			if (READ_ONCE(rq->numa_migrate_on) ||
 			    !cpumask_test_cpu(cpu, env->p->cpus_ptr))
 				continue;
