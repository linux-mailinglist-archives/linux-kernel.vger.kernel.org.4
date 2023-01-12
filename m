Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE60666722D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjALM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjALM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:27:30 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8C49150
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:27:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so14899878wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCcNIf1UDvpuNFf5vf6I9RJFpFoRfVbI97Z02S7w11Y=;
        b=gqlZx5nKqp7gWtHj2VtzvWabHx3d0lzbz8cWeB4kIBorh/UGScyAAfbJbYPXhsaJoU
         fhP7yJANvZo9WuUChqGizHV6E2xdG1lpAq8umJKDZZSOxFnmjRwPGBpNhVPmxGDtvu/9
         ooTxgzzTa4EnGJk3i9ZeIZtu2oE4IhI5ZkvixnakGQGOlREeGuq8BHaW6uARCuoMzeTD
         SB2nbteXj3n+waH9as/eKVO/X4jy6HGO5KfmDcwlpeuMAMELpyeNeVivZsx8mQvlRdvl
         QD1mK0AHxYU3u3Xj3LjBueXI7WD5JCHVMU6wL0wKIPUB5su+8D097VCFf2hpiQgMkf5e
         POzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCcNIf1UDvpuNFf5vf6I9RJFpFoRfVbI97Z02S7w11Y=;
        b=72cKIGgpzbeDsaTfAAPCukmL8Mww+sXkybGwMf2ib4QSzf+meOKOSQz40f2Q+hdEom
         KIWbJ0N/hqbmAUqiZwkaW+LYVfBU/Rn4JKHjubIlAA4kI6m8FkzRXJKI6XV8rq7ArjmL
         NVyZctX0nWFilfdy2f6ynK9os7oeTH/9deHV00IImKv8kN472j38v/3lCYnMxXH4hek2
         EpYLK8YLSKCcMiQE1E22wx4zmUUUbmFewXZezMe0WnEMOA7iWARlTJfRpOCTaMZ/s29U
         ILKQthTInXnsAwpW9t+oYp8WyQRYj0oBoQPSg5VKoMc7n1Kd5ghFDwOrsWgIpsoBIDUa
         XqFg==
X-Gm-Message-State: AFqh2kpOoiOhE5qlesQNSLmlTyEaIw5nzfEBCakKIftwSTLhs/MdvOs8
        y4otOPyslZW6h1x5mOv28Q9TAw==
X-Google-Smtp-Source: AMrXdXtdEBRvBQgd/6uz8LieQd8BHljlCl9RDt73lsyy4hhbaUWrV5WImaqKCcpXlCMpsh+4LAGRIA==
X-Received: by 2002:a1c:4c12:0:b0:3c6:e63e:89a6 with SMTP id z18-20020a1c4c12000000b003c6e63e89a6mr55130984wmf.2.1673526447908;
        Thu, 12 Jan 2023 04:27:27 -0800 (PST)
Received: from airbuntu.lon.corp.google.com ([104.132.45.104])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003d04e4ed873sm30132354wmq.22.2023.01.12.04.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:27:27 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v3 1/2] sched/uclamp: Fix a uninitialized variable warnings
Date:   Thu, 12 Jan 2023 12:27:07 +0000
Message-Id: <20230112122708.330667-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112122708.330667-1-qyousef@layalina.io>
References: <20230112122708.330667-1-qyousef@layalina.io>
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
 kernel/sched/fair.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e9d906a9bba9..5a8e75d4a17b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7353,10 +7353,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -7375,6 +7375,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		eenv.pd_cap = 0;
 
 		for_each_cpu(cpu, cpus) {
+			struct rq *rq = cpu_rq(cpu);
+
 			eenv.pd_cap += cpu_thermal_cap;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
@@ -7393,24 +7395,19 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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

