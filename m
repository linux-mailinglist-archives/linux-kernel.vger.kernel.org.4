Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BACF647245
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiLHOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiLHOzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:55:03 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608823EB4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:55:02 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so3517138wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 06:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwow+FQpjW2ep1FliQEBGTwsCEydRxIkqCnEq1m12V8=;
        b=XDLBxNq5R90wi5DLKbADIeRyoSa0yFGPjOwvPYJkK+Gp8+0NUig2HhYQbipF08HgB5
         uDua9QdHjM3N+wu05Ds/WDRlfvTijDsTseP3oOw6W2/1zJfnLyguFrDLLZ5O4J6LcIXg
         vO4tNneZ+ps7oGgVX7b0BAg8mw2PP64aXfJ2o0XMGpp1UpvTwPPdgPW47yPAp0JRU8Mp
         Ia9pi74grSNcRaoHiBN94MWe1kDW7BSmH3l0WomTRCW4NNhDQv4unjYDQz6KK+O8RPWP
         bK4axa2l0lG+mzQ7rFNxIa+/h4buoxClyW+W6unX0FoFy4fNIAlrb4gP7ao/8sR4gcTg
         t8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwow+FQpjW2ep1FliQEBGTwsCEydRxIkqCnEq1m12V8=;
        b=X0mSnLThPi4nJGT4aDpoolJrvlayOR3+Db7DgNRcjvGe3BiOK39QDXHyl0ZweWPl8i
         ZPMVZez8vWnaDosRObUrtfkAg6yvQNSbraofvz+7pLLVFPaSMIhBXaTg1VCCzMcBRXlY
         uQv3NezF9Wwa75fxV4nC3TDz8i0Mv6NjlcDPQVTgSlVR8GLaTOoC4gXC3gaSnaPQQdkJ
         LS9MNJyyWY132rqkDNyWmoCWkoMDrj2N70GiFSP1lW/jIlcZZzIQH8rHTfyoYuWHOfTE
         +jUDfTyK5K4/dK+cltlYxKcpoVN9+iq+GjlpVbI06wPMyvinLVRkR84bevg19sfg+jKq
         zIUA==
X-Gm-Message-State: ANoB5pk0DPz8FAuYIRFRtqUO982e+2Z7WidhdW70fgEpBHPnmWMhPxTm
        J6kaBBzI9HGn/W6CZAETfZDRWQ==
X-Google-Smtp-Source: AA0mqf4yz1Hvjz6iO79R15fZbsPhiI/S62JWD6dOgWvntEQOhsbR7q2pGK+RgxCw9KtzWrK3izrDOA==
X-Received: by 2002:a05:600c:6899:b0:3d1:cf66:3afa with SMTP id fn25-20020a05600c689900b003d1cf663afamr2093112wmb.19.1670511301333;
        Thu, 08 Dec 2022 06:55:01 -0800 (PST)
Received: from localhost.localdomain ([2a00:79e1:abc:9:c7d:8d2a:a83c:450a])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003d1e4f3ac8esm4993931wmi.33.2022.12.08.06.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 06:55:00 -0800 (PST)
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
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2] sched/fair: Fixes for capacity inversion detection
Date:   Thu,  8 Dec 2022 14:54:09 +0000
Message-Id: <20221208145409.453308-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f06321f0-def6-6f9d-b72f-f700e7e9a60a@arm.com>
References: <f06321f0-def6-6f9d-b72f-f700e7e9a60a@arm.com>
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

Traversing the Perf Domains requires rcu_read_lock() to be held and is
conditional on sched_energy_enabled(). rcu_read_lock() is held while in
load_balance(), add an assert to ensure this is always the case.

Also skip capacity inversion detection for our own pd; which was an
error.

Fixes: 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---

Changes in v2:

	* Make sure to hold rcu_read_lock() as we need it's not held in all
	  paths (thanks Dietmar!)

 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a2fc2ca5078..2b1442093bd6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8856,16 +8856,23 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
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
 
@@ -8890,6 +8897,8 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 				break;
 			}
 		}
+
+		rcu_read_unlock();
 	}
 
 	trace_sched_cpu_capacity_tp(rq);
-- 
2.25.1

