Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EE3639B53
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 15:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiK0OSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 09:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiK0OSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 09:18:07 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF525DF2B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:18:06 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so6700757wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgcAWBJdxBqHoNuM/m9bsANWdisyh2T9vffT0LuLN3Y=;
        b=aYJrxtYCrDMcXnPEqawG6vMJITTsdHOlN+f1gP9rE7xYHbZlt5xSW1RpwdA2HATted
         XX2GO8LtjHfU7JomPTjpJCOMM19wJ5l6Hr3qC2NDPXb68FLQwrOhD/dSaTGhUIfigajq
         txiQXB9YO7nujtiCbwfr9rYJCnvwCtXg8oj+4cjqZc21VA6CsPF/YOx4oSzISh94IDMU
         uuTykuXHOIPRJYH7YMef8gWPKeU5Lh8Nf8a0aq3ElWBJbS19LnaTFP4ARYWkXZZ1KcAm
         qYPXgF9KuiCzxTDxOGktcwnSXEq+LqX/pop1jXlVwoxkH1OG7ThNYiJU9VAthZgUdWJe
         qa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgcAWBJdxBqHoNuM/m9bsANWdisyh2T9vffT0LuLN3Y=;
        b=gad8XbOALDNI24AIeBsnT9GPTDPAgv917dnmvhszUe30RYi2s78NnpbsGtuNmE3jIe
         3daoWkG7t93oUKT2sZFsvZHOrwhGQbEyNaE0l3GZY7ynxcw1zQCrry0/JDqjfeMmXtzB
         ReKhXVQumuutLQOOe3gvC2dGvRJ088Ya8HfrKwSvim1r+YKw6TKmeTOf1ptADxFWqumW
         Id5v4oJusBEQ2+sxsmRdT8Zn1w38gki0cDjAMZmeHaEWghBc68t7figPYxB2GpZAz1N9
         yW2fETYXPuakojFEsonP/qFR1pEU2mRR9JPvSyS2okash8E8Cap2bshu7OB58XbXoI28
         TM2A==
X-Gm-Message-State: ANoB5pnVh0IIfkbWmG6Bz3cKV1ixsYGokqpRFduce1G2VLJ70TnGk3SW
        SAgO5P9d9TkZ9IPj6p3WAqAyqg==
X-Google-Smtp-Source: AA0mqf5RakAbKVmf1L04PaahKIblX57RfWx06vcIc8AuetTKU3Q+Rz5skc7JqwX7cHMHw6gPfbsusA==
X-Received: by 2002:a05:600c:384f:b0:3cf:9377:c76f with SMTP id s15-20020a05600c384f00b003cf9377c76fmr22582044wmr.189.1669558685424;
        Sun, 27 Nov 2022 06:18:05 -0800 (PST)
Received: from localhost.localdomain (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b003c6f3f6675bsm17109757wmq.26.2022.11.27.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 06:18:05 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 2/3] sched/fair: Fixes for capacity inversion detection
Date:   Sun, 27 Nov 2022 14:17:41 +0000
Message-Id: <20221127141742.1644023-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221127141742.1644023-1-qyousef@layalina.io>
References: <20221127141742.1644023-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 89dadaafc1ec..7c0dd57e562a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8856,16 +8856,22 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	 *   * Thermal pressure will impact all cpus in this perf domain
 	 *     equally.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (sched_energy_enabled()) {
 		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
 		struct perf_domain *pd = rcu_dereference(rq->rd->pd);
 
 		rq->cpu_capacity_inverted = 0;
 
+		SCHED_WARN_ON(!rcu_read_lock_held());
+
 		for (; pd; pd = pd->next) {
 			struct cpumask *pd_span = perf_domain_span(pd);
 			unsigned long pd_cap_orig, pd_cap;
 
+			/* We can't be inverted against our own pd */
+			if (cpumask_test_cpu(cpu_of(rq), pd_span))
+				continue;
+
 			cpu = cpumask_any(pd_span);
 			pd_cap_orig = arch_scale_cpu_capacity(cpu);
 
-- 
2.25.1

