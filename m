Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40AA680029
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjA2QPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjA2QO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:14:59 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E71E2B6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:14:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k16so6524954wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kxYlHG5oFypkr3pUxTSgVEs+bHMQxU7f8JXM84b6kU=;
        b=xWPLpgWGnvTZ6YPIRhflVxRly7YPZXXxsbkCDMr1V9tgl3OcDFvX1jB8BCsQvhfWAE
         AKWiXP2zsYbejjJQZSCvgb76nD6oXvrJdJUNFD1+zhtpUEx6jncBjHvxh94Vvh/1IA7y
         tOLpgLsOGJPNcEus+SGg9Q7unk+lS1UGdD07UX3+KaQWUa8rZUUHc72tF0OGK29SUu0d
         qOgfc/TkSl0VJcRH2qdxfdQqZ+hNNaFVz4lVXlgpi6/yvBNf+6dnxnRHGmB5XP5KUQKm
         hG56PLnLpDBtTY102dJAN8jg5h+dER0yigjHVjxr2nrBey9AlwVGpTlTDBuo2ogYp1/0
         1Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kxYlHG5oFypkr3pUxTSgVEs+bHMQxU7f8JXM84b6kU=;
        b=HUTaJZwPxAWTfjvWfHEwqPG8SZxygP8l9kuR4K0N/g1Tz5UgAHq3bhqQqPFhrjgnST
         Tq2RslgZY7/7tWSFE8AmF0ufJt5Gwv1ML4iJMINbf70tczqZYx0yDFyfquPIYdccGKZO
         gdmt2GBX1uMX4Ez4dsMO1cBkNxahhGFrzu7S67mdlNDm/to7NAKJxeb7SPbf6Fbg/Y+w
         T1oTvPLdEivDV2iLpBhF+atB0thlOQn84xNliHFv+4CoZuCyrkJyFr1mTRhO3LFYTlMh
         OOLx8nyO3AIEJxkDwXTMZoVzdHddHXlI2D2LlPPmKDhdfPAiw8erd1aN4T8ffzh6SZix
         lD9g==
X-Gm-Message-State: AFqh2krv74zcNXMWhw+4jUQp6mkakzHRTS3rUdhSU5QOxBF+PzhrunpS
        3ZCi/HZjdpbGeOPjCWvrvLWyz9Z/A1WP3ZSe
X-Google-Smtp-Source: AMrXdXu6gjqIK7PgH1RoeqMCjhcCfC4GKacovTsXQpu5Zak3yTsS9PVrxSkOwNGhA2trKhYX110wHA==
X-Received: by 2002:a05:600c:3d16:b0:3cf:8b22:76b3 with SMTP id bh22-20020a05600c3d1600b003cf8b2276b3mr44438418wmb.0.1675008896912;
        Sun, 29 Jan 2023 08:14:56 -0800 (PST)
Received: from localhost.localdomain (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c254500b003dc47fb33dasm5324783wma.18.2023.01.29.08.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 08:14:56 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 1/3] sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
Date:   Sun, 29 Jan 2023 16:14:42 +0000
Message-Id: <20230129161444.1674958-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230129161444.1674958-1-qyousef@layalina.io>
References: <20230129161444.1674958-1-qyousef@layalina.io>
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

When uclamp_max is being used, the util of the task could be higher than
the spare capacity of the CPU, but due to uclamp_max value we force fit
it there.

The way the condition for checking for max_spare_cap in
find_energy_efficient_cpu() was constructed; it ignored any CPU that has
its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
hence ending up never performing compute_energy() for this cluster and
missing an opportunity for a better energy efficient placement to honour
uclamp_max setting.

	max_spare_cap = 0;
	cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high

	...

	util_fits_cpu(...);		// will return true if uclamp_max forces it to fit

	...

	// this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
	if (cpu_cap > max_spare_cap) {
		max_spare_cap = cpu_cap;
		max_spare_cap_cpu = cpu;
	}

prev_spare_cap suffers from a similar problem.

Fix the logic by treating -1UL value as 'not populated' instead of
0 which is a viable and correct spare capacity value.

Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e29e9ea4cde8..ca2c389d3180 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7390,9 +7390,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
 		unsigned long cpu_cap, cpu_thermal_cap, util;
-		unsigned long cur_delta, max_spare_cap = 0;
+		unsigned long cur_delta, max_spare_cap = -1UL;
 		unsigned long rq_util_min, rq_util_max;
-		unsigned long prev_spare_cap = 0;
+		unsigned long prev_spare_cap = -1UL;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
 		int fits, max_fits = -1;
@@ -7457,7 +7457,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 				prev_spare_cap = cpu_cap;
 				prev_fits = fits;
 			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
+				   ((fits == max_fits) &&
+				   (cpu_cap > max_spare_cap || max_spare_cap == -1UL) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * among the remaining CPUs in the performance
@@ -7469,7 +7470,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap == -1UL)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -7477,7 +7478,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > 0) {
+		if (prev_spare_cap != -1UL) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
@@ -7489,7 +7490,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		}
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
-		if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
+		if (max_spare_cap_cpu >= 0 &&
+		    (max_spare_cap > prev_spare_cap || prev_spare_cap == -1UL)) {
 			/* Current best energy cpu fits better */
 			if (max_fits < best_fits)
 				continue;
-- 
2.25.1

