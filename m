Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB9468B237
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBEWng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjBEWne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:43:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4171A48B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 14:43:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mc11so29413885ejb.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 14:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIDKpUZt2NnF88laBIzE/5NEaQ9UqssI9HVNrkQhbgE=;
        b=BYL6g5q0EgU9yBxQf59pxMHrdp1oJDqgGJKpiH0qmaXrec/HizPz/+HDUzVpKPquzt
         jwPEksnWqxxjLC4BpeKg0GTRgY32ad/U4zL9/vWP6yA87pREBy9YG7b10bAdwo7bajFV
         mB6ZwqlT9bKrj1w37xQZbbc2C9zoEtmPu9L8akdb8BkhUBUXujw2ZcBeAG+NS9vEcNjD
         pA+FZU5Qe3xN7Mpa8SCiutAXaHs8wU38lo2XdQvmktH6q2GAbK90E2A3GtaQt+hk7SZ/
         eFBSeiDwkHddL+oL7MH846vP1n+U/ZF16gijT9LVsyF+cVo5HkNbRkiX5Ke7dnKf3kSf
         O47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIDKpUZt2NnF88laBIzE/5NEaQ9UqssI9HVNrkQhbgE=;
        b=UC3NrRwN1ALxr7viDtfDXMBz6tSocy6nPpeoY+naDUhZCgRQBTxNszmbGTJHQC3l1B
         b2/op3tGtEe7JntNm6nFSLD82XRIVk+F8/IZS8vkl3A5zl0wdYp+zIqPEMRItmXMj1dz
         EGAou4g5VbDbnFUaHcIOC41aqStpOefly1PDITYIh7sjT4SuwkbAa9Nd7+DoN9pUDjRT
         O7Eke84e1PijoPSRC0MS8wpaTmTDdzmlGgIWb55hE7RA+kUOL2M/DaFO/2YukTpbzp28
         6GnfL+pEf9QB2tORDwPHGKwAwEAu/RVCv7ypKtlziGkYZ17ucRY9ewyZvCyxmXBx3CvZ
         bs/w==
X-Gm-Message-State: AO0yUKXgx724NHWZEOgqCoR/t7AmVCaNDGBR9uI5zvaTy8sW/PkoH22l
        n4DZFUZWDu6PVEL1jJA/seygcg==
X-Google-Smtp-Source: AK7set9y1BvEXoVnsbkqW7Qhol2b9EQ4LeeHNqIPWYhBRR54feDk029SEjVodxBpEatcFD/8XljLPQ==
X-Received: by 2002:a17:907:3a97:b0:880:2870:7849 with SMTP id fh23-20020a1709073a9700b0088028707849mr13763626ejc.74.1675637011804;
        Sun, 05 Feb 2023 14:43:31 -0800 (PST)
Received: from localhost.localdomain (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id m15-20020a1709061ecf00b0087bd2924e74sm4550779ejj.205.2023.02.05.14.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 14:43:31 -0800 (PST)
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
Subject: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
Date:   Sun,  5 Feb 2023 22:43:16 +0000
Message-Id: <20230205224318.2035646-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230205224318.2035646-1-qyousef@layalina.io>
References: <20230205224318.2035646-1-qyousef@layalina.io>
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

Fix the logic by converting the variables into long and treating -1
value as 'not populated' instead of 0 which is a viable and correct
spare capacity value.

Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c6c8e7f52935..7a21ee74139f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7382,11 +7382,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
 		unsigned long cpu_cap, cpu_thermal_cap, util;
-		unsigned long cur_delta, max_spare_cap = 0;
+		long prev_spare_cap = -1, max_spare_cap = -1;
 		unsigned long rq_util_min, rq_util_max;
-		unsigned long prev_spare_cap = 0;
+		unsigned long cur_delta, base_energy;
 		int max_spare_cap_cpu = -1;
-		unsigned long base_energy;
 		int fits, max_fits = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
@@ -7461,7 +7460,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -7469,7 +7468,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > 0) {
+		if (prev_spare_cap > -1) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
-- 
2.25.1

