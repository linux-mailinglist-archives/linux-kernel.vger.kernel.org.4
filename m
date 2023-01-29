Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32D368002B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjA2QPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjA2QPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:15:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD621E5D2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:15:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso6605549wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak21MYAOZ7aWgrYAGlhxd83OK7kequIiU355HpFkf1A=;
        b=ICcjvdpPznFZpudAxu6ViPrqzHSPoc/9oUm7cGZfHr1BNTQ8p0zmrtAWnzoMQj2uhC
         dM+fF8Uxne0gk0n7XKSKhru6IKPm4xKS7Am0UZqkQ9oB8IjYJQXMUJr9xkgAJjtYLmD6
         ZxPi4HsHd2MMMRf4W6Yw5ZZ1dI+tsvxDcKlrJkqj/ZIlbPODQIZOyTizWAjPZeJRno/q
         kh16KH+XS532GUPYMprXkSfAh+KIfRAqxRaGPr0scUjYCJjDmf6jB7RK3KvRHYIQp1wT
         rcn4VpZpq9RgFwHbqOJQYt38uCWJ/SGyF3eAVWLVUjuyzRebPqF3dBts6leSYtI8Veqe
         fiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak21MYAOZ7aWgrYAGlhxd83OK7kequIiU355HpFkf1A=;
        b=jJL2pvE74Uaenb1C7MK86eQx/qNDQujN+6v036e0t+2vpLHNmxUNbrWNC0VnPFWKkd
         waZLcC5cGoWfhOChgOv3v6qvBxQ0NKuRN0+jprs7lVXz8z2gdcj0O7AWsOdCBzRbpD90
         MC9ZetVpMWCDuIf8k2OW5WDnt3leQg/34ElRhfrOyr2u76YhVsJqnF8UZEUQbpADT/f4
         Xk8WSS6R3BYnUuI6iyIZvbg0n0lBRZjSofteY3tZeT4okxgd470yPzPVmZ6ql8AHP3+O
         akq55jc423qsb5UqPeEedjRgjXPCTnoX4+lAYSo0gWCxOkSQ29Y5tmGGFl1IJ/3xOxrj
         WVJA==
X-Gm-Message-State: AFqh2ko/7VftEkEpXiHuEXk2vM2345W1II5nlPSXQG1Ght0T3tyNV3a/
        Q7BZgIe+ueQaMLewQEvhn+u+BQ==
X-Google-Smtp-Source: AMrXdXvejAaCAN7C6aTeIKUHly/yzfVLPsgdUh9JHwPyVTV9ywIF7h13vrMSNgJmDsdpr3MfGWIN5g==
X-Received: by 2002:a7b:ce15:0:b0:3da:2932:b61a with SMTP id m21-20020a7bce15000000b003da2932b61amr47156468wmc.18.1675008900390;
        Sun, 29 Jan 2023 08:15:00 -0800 (PST)
Received: from localhost.localdomain (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c254500b003dc47fb33dasm5324783wma.18.2023.01.29.08.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 08:15:00 -0800 (PST)
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
Subject: [PATCH 3/3] sched/tp: Add new tracepoint to track compute energy computation
Date:   Sun, 29 Jan 2023 16:14:44 +0000
Message-Id: <20230129161444.1674958-4-qyousef@layalina.io>
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

It was useful to track feec() placement decision and debug the spare
capacity and optimization issues vs uclamp_max.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/trace/events/sched.h | 4 ++++
 kernel/sched/core.c          | 1 +
 kernel/sched/fair.c          | 7 ++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..20cc884f72ff 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
 	TP_PROTO(struct rq *rq, int change),
 	TP_ARGS(rq, change));
 
+DECLARE_TRACE(sched_compute_energy_tp,
+	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy),
+	TP_ARGS(p, dst_cpu, energy));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 03b8529db73f..79ad6b8ea93e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -110,6 +110,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3521aad67aa0..3b55dbb0fcfe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7303,11 +7303,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
 {
 	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
 	unsigned long busy_time = eenv->pd_busy_time;
+	unsigned long energy;
 
 	if (dst_cpu >= 0)
 		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
 
-	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+
+	trace_sched_compute_energy_tp(p, dst_cpu, energy);
+
+	return energy;
 }
 
 /*
-- 
2.25.1

