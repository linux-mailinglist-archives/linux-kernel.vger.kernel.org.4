Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E214686867
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjBAOgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjBAOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:36:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6029F46D6B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:36:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so1544338wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+blrN7WtKKrcrfUwE6iTjyvPLjyIFloAnSM6+cYP9Uk=;
        b=VoIZNY1ahARaxgQK+WsGmW+yafJimH556eH2h3BQf6MxR48n3HvHMamvnzY+f31LIZ
         Z6By6S502dma8DVrDBpercD15jqm/Qrur6fh4vxnu5hZLf86o3KWsGn8OkuxIUy0iYw1
         mxxcLo39RlC9eOuhCz4muhe8bgRyhq0x1RU3eeLhlUn++ERMZ3t8sq2R8e16kFYs+0kv
         5FfMHJGgjGHksOVTOA+nq6vVE+0r68LOVVtjcOEX0GXU+Pk/W8/MqYtkyKN1jSZmhng3
         M7b1hCvxkiSwo6/HayWcEs8chxCT5nscIoJFLziTWuZ782cxtsN/bsqPFcH1XracuGQi
         QDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+blrN7WtKKrcrfUwE6iTjyvPLjyIFloAnSM6+cYP9Uk=;
        b=NQnVv/cUNRoiGHIwuggBEN4yxsdKCCzwk4FlSuKc+xyF9NfbDWbHMFwVba1dCm2vHt
         A35h054kz2U6K8dl3tzTOcYRkoYnDPky7f50nUFFMDAW5h5q3cP/pRIsLK9YIuRk995K
         gBv/yYh6K27YaD2LlFyiUBd8tGM75oEKpty0XvIte6YvM0aUAWEAvd+Brc0zZ0KJKdu4
         Yc4v1DrcfsJlY5sXqKMJZHpMLRZX47JTGkpAKBXMwP9whgu1elMuAGvwGjeU1cKs6U5i
         sQO4D0zHWEgSo64VkbjuN8gLcnUqZCN/pFuW/YCNP53e9Uups5KXH/RcMlCnP3xeyJUj
         wCNg==
X-Gm-Message-State: AO0yUKW9smEJpBXDrZxMJCrgJ7obwfqiaB35fDCClYhQ9W8ePikSMsvY
        N7TuLLerDow1OfcFtbf8xwh84g==
X-Google-Smtp-Source: AK7set9IcoFs4V/b8WPpL6myJXdeG5YOgLy780D6LlPFU1r/NLnYTmQ0h/WQfmaGm4dCYciBecEj6Q==
X-Received: by 2002:a05:600c:4f42:b0:3dc:5984:a16c with SMTP id m2-20020a05600c4f4200b003dc5984a16cmr2312966wmq.31.1675262194788;
        Wed, 01 Feb 2023 06:36:34 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:3db4:bf23:5fd8:a5])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003cf71b1f66csm1846756wmc.0.2023.02.01.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:36:34 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kajetan.puchalski@arm.com
Cc:     lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2 v5] sched/fair: Remove capacity inversion detection
Date:   Wed,  1 Feb 2023 15:36:28 +0100
Message-Id: <20230201143628.270912-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201143628.270912-1-vincent.guittot@linaro.org>
References: <20230201143628.270912-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the capacity inversion detection which is now handled by
util_fits_cpu() returning -1 when we need to continue to look for a
potential CPU with better performance.

This ends up almost reverting patches below except for some comments:
commit da07d2f9c153 ("sched/fair: Fixes for capacity inversion detection")
commit aa69c36f31aa ("sched/fair: Consider capacity inversion in util_fits_cpu()")
commit 44c7b80bffc3 ("sched/fair: Detect capacity inversion")

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 84 +++-----------------------------------------
 kernel/sched/sched.h | 19 ----------
 2 files changed, 5 insertions(+), 98 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 074742f107c0..c6c8e7f52935 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4476,17 +4476,9 @@ static inline int util_fits_cpu(unsigned long util,
 	 *
 	 * For uclamp_max, we can tolerate a drop in performance level as the
 	 * goal is to cap the task. So it's okay if it's getting less.
-	 *
-	 * In case of capacity inversion we should honour the inverted capacity
-	 * for both uclamp_min and uclamp_max all the time.
 	 */
-	capacity_orig = cpu_in_capacity_inversion(cpu);
-	if (capacity_orig) {
-		capacity_orig_thermal = capacity_orig;
-	} else {
-		capacity_orig = capacity_orig_of(cpu);
-		capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
-	}
+	capacity_orig = capacity_orig_of(cpu);
+	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -9027,82 +9019,16 @@ static unsigned long scale_rt_capacity(int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
-	struct rq *rq = cpu_rq(cpu);
 
-	rq->cpu_capacity_orig = capacity_orig;
+	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
 
 	if (!capacity)
 		capacity = 1;
 
-	rq->cpu_capacity = capacity;
-
-	/*
-	 * Detect if the performance domain is in capacity inversion state.
-	 *
-	 * Capacity inversion happens when another perf domain with equal or
-	 * lower capacity_orig_of() ends up having higher capacity than this
-	 * domain after subtracting thermal pressure.
-	 *
-	 * We only take into account thermal pressure in this detection as it's
-	 * the only metric that actually results in *real* reduction of
-	 * capacity due to performance points (OPPs) being dropped/become
-	 * unreachable due to thermal throttling.
-	 *
-	 * We assume:
-	 *   * That all cpus in a perf domain have the same capacity_orig
-	 *     (same uArch).
-	 *   * Thermal pressure will impact all cpus in this perf domain
-	 *     equally.
-	 */
-	if (sched_energy_enabled()) {
-		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
-		struct perf_domain *pd;
-
-		rcu_read_lock();
-
-		pd = rcu_dereference(rq->rd->pd);
-		rq->cpu_capacity_inverted = 0;
-
-		for (; pd; pd = pd->next) {
-			struct cpumask *pd_span = perf_domain_span(pd);
-			unsigned long pd_cap_orig, pd_cap;
-
-			/* We can't be inverted against our own pd */
-			if (cpumask_test_cpu(cpu_of(rq), pd_span))
-				continue;
-
-			cpu = cpumask_any(pd_span);
-			pd_cap_orig = arch_scale_cpu_capacity(cpu);
-
-			if (capacity_orig < pd_cap_orig)
-				continue;
-
-			/*
-			 * handle the case of multiple perf domains have the
-			 * same capacity_orig but one of them is under higher
-			 * thermal pressure. We record it as capacity
-			 * inversion.
-			 */
-			if (capacity_orig == pd_cap_orig) {
-				pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
-
-				if (pd_cap > inv_cap) {
-					rq->cpu_capacity_inverted = inv_cap;
-					break;
-				}
-			} else if (pd_cap_orig > inv_cap) {
-				rq->cpu_capacity_inverted = inv_cap;
-				break;
-			}
-		}
-
-		rcu_read_unlock();
-	}
-
-	trace_sched_cpu_capacity_tp(rq);
+	cpu_rq(cpu)->cpu_capacity = capacity;
+	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
 
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1072502976df..3e8df6d31c1e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1044,7 +1044,6 @@ struct rq {
 
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
-	unsigned long		cpu_capacity_inverted;
 
 	struct balance_callback *balance_callback;
 
@@ -2899,24 +2898,6 @@ static inline unsigned long capacity_orig_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
 
-/*
- * Returns inverted capacity if the CPU is in capacity inversion state.
- * 0 otherwise.
- *
- * Capacity inversion detection only considers thermal impact where actual
- * performance points (OPPs) gets dropped.
- *
- * Capacity inversion state happens when another performance domain that has
- * equal or lower capacity_orig_of() becomes effectively larger than the perf
- * domain this CPU belongs to due to thermal pressure throttling it hard.
- *
- * See comment in update_cpu_capacity().
- */
-static inline unsigned long cpu_in_capacity_inversion(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_inverted;
-}
-
 /**
  * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
-- 
2.34.1

