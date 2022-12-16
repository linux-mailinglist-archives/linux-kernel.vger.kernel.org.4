Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6364E74B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLPGYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiLPGYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:24:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0608E6BCA2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:24:38 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so1430206pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JvWppdepGKuCmZdK+T4x0HrLho3kQxHEXyInOIABdw=;
        b=ZLRQsDIaEc7I4ixWaVvP1F3HTLEthQeeNLtaMh7Ktn1wlWDLMyCqsbcbnCBaXmjW62
         KsFFGwGUzPVpOUI8uJFu1YHQUogRl16vxmktW0lI+MyWw18yfVz9GVAH13MDatVGmCQm
         btMgceRIrcHIdzEE1DdJmDxVH59tQqFSKPh1Exm7snRZtSB0Rzf+7noxtFVnduY3kMLg
         JpJvZ5p++xvAjCnXqrf30gkis6G0/CwPr4meDvGfXTs4lWrpcAh6ZxnI1dvyxCyAM0/O
         Kx8aOfHP6gHdl2lCtS4gC21O7GA2m7wnc/hjHLb461KwWPEscD8VX/uyPY9B8bAdnDOx
         mL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JvWppdepGKuCmZdK+T4x0HrLho3kQxHEXyInOIABdw=;
        b=M5BsupKS1nau7T4U1GP3Ev1dCD9+vt2+4Fr4iiwk3GFGP5orkKQxNRZCaywjQtbs/t
         jskIbujt5qN0lXSAxdDLoZrCUi7FmOkZVlfg4f42CuxuJA3a58kR53d0TG6IvuG29+bZ
         zXIFx5FdST1LPQyV8TX39I9TTIBV/FpiiInb8U36Fs44txNGh+h3T/u5Nhkc/IZKD6KP
         FVhKS6Jt015hoHyXPm1Eef3kyqoahev1JaLrObuOg3iypp18GsezGMcxRXGFqjQW+le3
         sXvHQ9qQJHHDoPxIXLln1xsOH9+cfaxHln4HaO+kUgeutaMpb8aLoIMRZciwcuSiMiC8
         qLvA==
X-Gm-Message-State: ANoB5pmreluGRyWLiicu3GCtfPR3gBvyY4HMv5r920/IJ9XgGIZAOpQR
        M6pPTSx5DUzQeWv/dWOjXRXV5g==
X-Google-Smtp-Source: AA0mqf6fsWOiyIh7ajhDx3xcGGZ2etvic2nJr13nHLjljWd9tw/qya3r5tdXYSsmUAr/gWgZ1iW77g==
X-Received: by 2002:a05:6a21:394b:b0:ac:3f3f:9fbd with SMTP id ac11-20020a056a21394b00b000ac3f3f9fbdmr36790086pzc.48.1671171877541;
        Thu, 15 Dec 2022 22:24:37 -0800 (PST)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id s5-20020a656445000000b0046feca0883fsm681819pgv.64.2022.12.15.22.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 22:24:36 -0800 (PST)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 2/2] sched/core: Adjusting the order of scanning CPU
Date:   Fri, 16 Dec 2022 14:24:06 +0800
Message-Id: <20221216062406.7812-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221216062406.7812-1-jiahao.os@bytedance.com>
References: <20221216062406.7812-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When select_idle_capacity() starts scanning for an idle CPU, it starts
with target CPU that has already been checked in select_idle_sibling().
So we start checking from the next CPU and try the target CPU at the end.
Similarly for task_numa_assign(), we have just checked numa_migrate_on
of dst_cpu, so start from the next CPU. This also works for
steal_cookie_task(), the first scan must fail and start directly
from the next one.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 2 +-
 kernel/sched/fair.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 25b582b6ee5f..40149ff68f14 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6206,7 +6206,7 @@ static bool steal_cookie_task(int cpu, struct sched_domain *sd)
 {
 	int i;
 
-	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
+	for_each_cpu_wrap(i, sched_domain_span(sd), cpu + 1) {
 		if (i == cpu)
 			continue;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 643cbcb61b49..e910df06b779 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1836,7 +1836,7 @@ static void task_numa_assign(struct task_numa_env *env,
 		int start = env->dst_cpu;
 
 		/* Find alternative idle CPU. */
-		for_each_cpu_wrap(cpu, cpumask_of_node(env->dst_nid), start) {
+		for_each_cpu_wrap(cpu, cpumask_of_node(env->dst_nid), start + 1) {
 			if (cpu == env->best_cpu || !idle_cpu(cpu) ||
 			    !cpumask_test_cpu(cpu, env->p->cpus_ptr)) {
 				continue;
@@ -6811,7 +6811,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	util_min = uclamp_eff_value(p, UCLAMP_MIN);
 	util_max = uclamp_eff_value(p, UCLAMP_MAX);
 
-	for_each_cpu_wrap(cpu, cpus, target) {
+	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
-- 
2.37.0

