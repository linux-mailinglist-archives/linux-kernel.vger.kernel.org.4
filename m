Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D3647235
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiLHOxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiLHOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:52:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2BC4C271
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:52:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg10so1229719wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 06:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EQRHK9ZlDWtgRsVXiI0JZkXJchjbzgSFU+bI1duxL4=;
        b=pcESBS62/zG7V+GsJWrKU7/PXisfwFgAymJ/MUMxWu15xwo3i4GDWcQX9v6VF15qe2
         D5EwLMHkbvtc9csuGVfJBFiRVWQ2a1NMbJQpgmuG8ujbi2Q7bEsnDCSrmmy8bnlXYpcf
         ENb5qESpp7R5LgDTYr4Zp8cuQghWlo1KI+z1C4OIxXnILkxM3A5TcTzLN4sLhOkzh0Kw
         Rno6hezMZki5uOXCT5vLotDr+tE+LL0ewYH+K/MmgRaHbavncKZQSfpIoF1VRKWf015X
         jR+i0mIyq9ycIRR+onCBLzC4CLPA+n973t7v/PgfWIf+v4UuilplNhNjKpK7O2pJa3I/
         jXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EQRHK9ZlDWtgRsVXiI0JZkXJchjbzgSFU+bI1duxL4=;
        b=r+tMr99B0Fu0WZfqM9s8KL+NzI/9Uc9s6vbmDEYyg4RSPfFb7k9yMtN59kqx8oOj4p
         fjhwxdN8BNGpkvphtpRHg1QsUPr2OaMVAjzZcLBFVvybCCTU9gaZAVZEfM0VVi/7lNbg
         t49oXA73nyuxsF/Gr1VuWJZtBQT5VlGSucJjazGS3YopLci649Hr2ZgokxS6GqYVzJnX
         EpP3ufVFzVtsceFneS0jsT+JyXk36q2s0pE7cPpm03wLMnVGK1IA/9eUxIx3N/qrWW5G
         dLTY6C1xo/S+W4IX8rXOq5Hz52f0dPQtIdIE7ibIROElctZ6qcByJJUUcQZaMSUGaC5L
         PYPg==
X-Gm-Message-State: ANoB5pnN0/vuGMyzpEl+1WXTyX8X8rRgpskpruNN64gugLpUXXIDnbd5
        3FS3epo1omDnL02X7LAiYJ4Kug==
X-Google-Smtp-Source: AA0mqf6NnqFP55HRb79YXq9Xi7imG/OjrWKxmg2AHykMJvlL7/gHosi71god0CG5G865JNWhc7OHtw==
X-Received: by 2002:a05:600c:6888:b0:3d1:d746:7bca with SMTP id fn8-20020a05600c688800b003d1d7467bcamr2106872wmb.4.1670511172700;
        Thu, 08 Dec 2022 06:52:52 -0800 (PST)
Received: from localhost.localdomain ([2a00:79e1:abc:9:c7d:8d2a:a83c:450a])
        by smtp.gmail.com with ESMTPSA id f13-20020a7bcd0d000000b003b47ff307e1sm4973469wmj.31.2022.12.08.06.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 06:52:52 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2] sched/uclamp: Fix a uninitialized variable warnings
Date:   Thu,  8 Dec 2022 14:51:08 +0000
Message-Id: <20221208145108.452032-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <927e4ffc-8400-b615-2d58-9e88ee4bdc3c@arm.com>
References: <927e4ffc-8400-b615-2d58-9e88ee4bdc3c@arm.com>
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

Addresses the following warnings:

> config: riscv-randconfig-m031-20221111
> compiler: riscv64-linux-gcc (GCC) 12.1.0
>
> smatch warnings:
> kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_min'.
> kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_max'.

Fixes: 244226035a1f ("sched/uclamp: Fix fits_capacity() check in feec()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---

Changes in v2:

	* Improve indentation as suggested by Dietmar

 kernel/sched/fair.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4cc56c91e06e..6a2fc2ca5078 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7217,10 +7217,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	eenv_task_busy_time(&eenv, p, prev_cpu);
 
 	for (; pd; pd = pd->next) {
+		unsigned long util_min = p_util_min, util_max = p_util_max;
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		unsigned long cur_delta, max_spare_cap = 0;
 		unsigned long rq_util_min, rq_util_max;
-		unsigned long util_min, util_max;
 		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
@@ -7239,6 +7239,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		eenv.pd_cap = 0;
 
 		for_each_cpu(cpu, cpus) {
+			struct rq *rq = cpu_rq(cpu);
+
 			eenv.pd_cap += cpu_thermal_cap;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
@@ -7257,24 +7259,19 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * much capacity we can get out of the CPU; this is
 			 * aligned with sched_cpu_util().
 			 */
-			if (uclamp_is_used()) {
-				if (uclamp_rq_is_idle(cpu_rq(cpu))) {
-					util_min = p_util_min;
-					util_max = p_util_max;
-				} else {
-					/*
-					 * Open code uclamp_rq_util_with() except for
-					 * the clamp() part. Ie: apply max aggregation
-					 * only. util_fits_cpu() logic requires to
-					 * operate on non clamped util but must use the
-					 * max-aggregated uclamp_{min, max}.
-					 */
-					rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
-					rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
-
-					util_min = max(rq_util_min, p_util_min);
-					util_max = max(rq_util_max, p_util_max);
-				}
+			if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
+				/*
+				 * Open code uclamp_rq_util_with() except for
+				 * the clamp() part. Ie: apply max aggregation
+				 * only. util_fits_cpu() logic requires to
+				 * operate on non clamped util but must use the
+				 * max-aggregated uclamp_{min, max}.
+				 */
+				rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
+				rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
+
+				util_min = max(rq_util_min, p_util_min);
+				util_max = max(rq_util_max, p_util_max);
 			}
 			if (!util_fits_cpu(util, util_min, util_max, cpu))
 				continue;
-- 
2.25.1

