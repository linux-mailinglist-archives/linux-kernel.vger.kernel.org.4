Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A2A615DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiKBIdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKBIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:33:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F09C2793F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:33:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o7so12358384pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=947eFVQOjYHgL69E/eIjVgvNC7z93QCjfG2CSFXyEag=;
        b=ZlZBCMG3hTFoKhBTsKDelt14pOhhDhQwNLJuZVILPGvSSm/nKjpgUH0SC3S//UWYMM
         b4+Kie7lVlJBe38UhOuCgLLsICw2QemD9iu6sJsXIO37Wme0GNAqfQzfpe0qkysXe04Y
         eY59mAdBIHJ15nGX9SfLLiUyrRKJ/KQJdCSlsRehKq/azSXqHmlrNA9WNPjDyZ/Vu5iP
         j3zMjoLYGIVN4X7pQSD5bj4NgxjfNI0oYwRrXMhkOhCYXjB9/V5+FoRA5QdMvwq1Ddou
         8auZYtuyuuQe6w8vf/gWZrJrnczHQFhcFPbHS5o5wS16ykWMDpr6N+25KHMvWkBWGK4g
         Fw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=947eFVQOjYHgL69E/eIjVgvNC7z93QCjfG2CSFXyEag=;
        b=Pk1XODpw0NIbP0uTBJK1t8wjldqepHN506zdNJM66FVRVtbstuirEDB7WIqSsruHKp
         ILVmImpU/fx3lxr5qW6TOFEfCfc/kWR6j7qu1UGyNJXC6XmXniTphigzRzkpDkrjs8yi
         y266EkGmj9r1Dkplf6UDoZrYCtMwGsF7btvRf951lmBDLA54gbMWa7JGVh8+rGa3TQ4n
         NdhAHgx2eoGJyOw1wO2qoThx8xhzU2L+XSMUHpyQwAspI7MfBdzYgkY3LnYt9KMEUyAG
         TTRcdldGYpckdnQCy7ANYv7RxGcw11eW0lZTa5D6dxNefiL7gfd4wN40OfYtPeNj/HTh
         GsxA==
X-Gm-Message-State: ACrzQf3sus2ZvANS7iIZVPZhEVblVMQM/l299B3oW8lRYHgYpUXp9j8O
        2nT4/zhm5VfFaCpUOGKE97m0
X-Google-Smtp-Source: AMsMyM5gDKOO3lqyI/YAvYQSnfyq9wcrwBZZlYPm3grO8jtjTBef9KLxteQ/K9YzMfEoW4OsUBnjpw==
X-Received: by 2002:a17:90b:3103:b0:213:2578:e5c5 with SMTP id gc3-20020a17090b310300b002132578e5c5mr24150338pjb.217.1667377986731;
        Wed, 02 Nov 2022 01:33:06 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b00176acd80f69sm7682256pln.102.2022.11.02.01.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:33:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org, rafael@kernel.org
Cc:     johan@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq
Date:   Wed,  2 Nov 2022 14:02:39 +0530
Message-Id: <20221102083239.53826-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102083239.53826-1-manivannan.sadhasivam@linaro.org>
References: <20221102083239.53826-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

soc_data is a static info of the driver and thus no need to cache it inside
the qcom_cpufreq_data struct which is allocated per frequency domain. So,
move it inside qcom_cpufreq struct.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index bc991ef10c05..76f840636828 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -42,7 +42,6 @@ struct qcom_cpufreq_soc_data {
 struct qcom_cpufreq_data {
 	void __iomem *base;
 	struct resource *res;
-	const struct qcom_cpufreq_soc_data *soc_data;
 
 	/*
 	 * Mutex to synchronize between de-init sequence and re-starting LMh
@@ -60,6 +59,7 @@ struct qcom_cpufreq_data {
 
 static struct {
 	struct qcom_cpufreq_data *data;
+	const struct qcom_cpufreq_soc_data *soc_data;
 } qcom_cpufreq;
 
 static unsigned long cpu_hw_rate, xo_rate;
@@ -110,7 +110,7 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
 {
 	struct qcom_cpufreq_data *data = policy->driver_data;
-	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
+	const struct qcom_cpufreq_soc_data *soc_data = qcom_cpufreq.soc_data;
 	unsigned long freq = policy->freq_table[index].frequency;
 	unsigned int i;
 
@@ -138,7 +138,7 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 		return 0;
 
 	data = policy->driver_data;
-	soc_data = data->soc_data;
+	soc_data = qcom_cpufreq.soc_data;
 
 	index = readl_relaxed(data->base + soc_data->reg_perf_state);
 	index = min(index, LUT_MAX_ENTRIES - 1);
@@ -150,7 +150,7 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 						unsigned int target_freq)
 {
 	struct qcom_cpufreq_data *data = policy->driver_data;
-	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
+	const struct qcom_cpufreq_soc_data *soc_data = qcom_cpufreq.soc_data;
 	unsigned int index;
 	unsigned int i;
 
@@ -174,7 +174,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	unsigned long rate;
 	int ret;
 	struct qcom_cpufreq_data *drv_data = policy->driver_data;
-	const struct qcom_cpufreq_soc_data *soc_data = drv_data->soc_data;
+	const struct qcom_cpufreq_soc_data *soc_data = qcom_cpufreq.soc_data;
 
 	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
 	if (!table)
@@ -291,10 +291,10 @@ static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
 {
 	unsigned int lval;
 
-	if (data->soc_data->reg_current_vote)
-		lval = readl_relaxed(data->base + data->soc_data->reg_current_vote) & 0x3ff;
+	if (qcom_cpufreq.soc_data->reg_current_vote)
+		lval = readl_relaxed(data->base + qcom_cpufreq.soc_data->reg_current_vote) & 0x3ff;
 	else
-		lval = readl_relaxed(data->base + data->soc_data->reg_domain_state) & 0xff;
+		lval = readl_relaxed(data->base + qcom_cpufreq.soc_data->reg_domain_state) & 0xff;
 
 	return lval * xo_rate;
 }
@@ -366,9 +366,9 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
 	disable_irq_nosync(c_data->throttle_irq);
 	schedule_delayed_work(&c_data->throttle_work, 0);
 
-	if (c_data->soc_data->reg_intr_clr)
+	if (qcom_cpufreq.soc_data->reg_intr_clr)
 		writel_relaxed(GT_IRQ_STATUS,
-			       c_data->base + c_data->soc_data->reg_intr_clr);
+			       c_data->base + qcom_cpufreq.soc_data->reg_intr_clr);
 
 	return IRQ_HANDLED;
 }
@@ -514,16 +514,15 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		return ret;
 
 	index = args.args[0];
-	data->soc_data = of_device_get_match_data(&pdev->dev);
 	data = &qcom_cpufreq.data[index];
 
 	/* HW should be in enabled state to proceed */
-	if (!(readl_relaxed(data->base + data->soc_data->reg_enable) & 0x1)) {
+	if (!(readl_relaxed(data->base + qcom_cpufreq.soc_data->reg_enable) & 0x1)) {
 		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
 		return -ENODEV;
 	}
 
-	if (readl_relaxed(data->base + data->soc_data->reg_dcvs_ctrl) & 0x1)
+	if (readl_relaxed(data->base + qcom_cpufreq.soc_data->reg_dcvs_ctrl) & 0x1)
 		data->per_core_dcvs = true;
 
 	qcom_get_related_cpus(index, policy->cpus);
@@ -644,6 +643,8 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	if (!qcom_cpufreq.data)
 		return -ENOMEM;
 
+	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
+
 	for (i = 0; i < num_domains; i++) {
 		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
 		struct resource *res;
-- 
2.25.1

