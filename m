Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F12E615E9C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiKBJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiKBJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:01:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A40A286C8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:01:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so15936557plz.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCbesr7t22BH12koAKaq07PLsfL/CZLX5cbu8l4PC8k=;
        b=MDGtYph3exFjeCg9VqNZzVzu3Vumc0ZwkNtXfKqvGqA0BSAzU1mop8s97+EujGQVla
         BNZJxwW1pPWMa4xpHTzHj0o3RJDIcYEOoM4r/XpG2AY2z1Af5t+GA3ASTdPsSvdAmhLF
         KH2v8yLW13suU86jRHH5EmYzpVX0TArdHKs70YhEYsoVB66y1XZKpNpf7JfujxTehMdz
         lDT+2gmlRAjjycDhG46ZhhwShvUlYruDZbimedwd5yDh0/Ao4xoamKioRjItIVlhv2WB
         kNP7nGE2cVidcRSGdr/lCmIcmbL3m+qvr8sNBxeXRSSVRsCVS6UxPCCPVT8qmLDnzldr
         Re4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCbesr7t22BH12koAKaq07PLsfL/CZLX5cbu8l4PC8k=;
        b=uqybEoP75gT4m3SWBcTQciwakbEPv+quFeebqRpm8+OS+NykhFqvyCV7JBU5avFGBz
         yZ6nkXmdCe8GAw4dCbbUapgklBRAle3qb8orGBMI0eav0qH88clA7JlGHvaAqx6J5CsD
         skNFKi23Xzbr/gZ/w5UPoEena6caAstbhTiq4p1KYVWocWzc6955I1KXlS833qn1Qxt9
         cWO/OjLBngy1zmbeLxEDEtphCMPUXLWJ2saroJ9Zyh5pb3qFsmvSlvgafAekmp0U6HfX
         RMBMjRL2tRQMYDCu+YaCvPyionVV4MAH3Wp87p61JjpGoX2DUDFVYHR1wK5YQitfFdHx
         67rQ==
X-Gm-Message-State: ACrzQf2tbAgcGj62dGGhnoJPrbhjDNz08JBAw+ShhUf46KbfjgY5Rh7D
        jKr7FYccf/jY46v5XJFOFnEK
X-Google-Smtp-Source: AMsMyM7kWzjgmWgi2JYTCNHRGMGFCkgT5IlBpTNmkAhrr2N7dB+zScr1peUE1BOXig/x7+qWL8z6+A==
X-Received: by 2002:a17:903:444:b0:187:428:1317 with SMTP id iw4-20020a170903044400b0018704281317mr23647290plb.151.1667379664568;
        Wed, 02 Nov 2022 02:01:04 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id z10-20020a63d00a000000b0046f7b0f504esm7136389pgf.58.2022.11.02.02.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:01:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org, rafael@kernel.org
Cc:     johan@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/3] cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq
Date:   Wed,  2 Nov 2022 14:30:38 +0530
Message-Id: <20221102090038.64541-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102090038.64541-1-manivannan.sadhasivam@linaro.org>
References: <20221102090038.64541-1-manivannan.sadhasivam@linaro.org>
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
index 6d807956aaf6..5e0598730a04 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -43,7 +43,6 @@ struct qcom_cpufreq_soc_data {
 struct qcom_cpufreq_data {
 	void __iomem *base;
 	struct resource *res;
-	const struct qcom_cpufreq_soc_data *soc_data;
 
 	/*
 	 * Mutex to synchronize between de-init sequence and re-starting LMh
@@ -63,6 +62,7 @@ struct qcom_cpufreq_data {
 
 static struct {
 	struct qcom_cpufreq_data *data;
+	const struct qcom_cpufreq_soc_data *soc_data;
 } qcom_cpufreq;
 
 static unsigned long cpu_hw_rate, xo_rate;
@@ -113,7 +113,7 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 					unsigned int index)
 {
 	struct qcom_cpufreq_data *data = policy->driver_data;
-	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
+	const struct qcom_cpufreq_soc_data *soc_data = qcom_cpufreq.soc_data;
 	unsigned long freq = policy->freq_table[index].frequency;
 	unsigned int i;
 
@@ -141,7 +141,7 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 		return 0;
 
 	data = policy->driver_data;
-	soc_data = data->soc_data;
+	soc_data = qcom_cpufreq.soc_data;
 
 	index = readl_relaxed(data->base + soc_data->reg_perf_state);
 	index = min(index, LUT_MAX_ENTRIES - 1);
@@ -153,7 +153,7 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 						unsigned int target_freq)
 {
 	struct qcom_cpufreq_data *data = policy->driver_data;
-	const struct qcom_cpufreq_soc_data *soc_data = data->soc_data;
+	const struct qcom_cpufreq_soc_data *soc_data = qcom_cpufreq.soc_data;
 	unsigned int index;
 	unsigned int i;
 
@@ -177,7 +177,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	unsigned long rate;
 	int ret;
 	struct qcom_cpufreq_data *drv_data = policy->driver_data;
-	const struct qcom_cpufreq_soc_data *soc_data = drv_data->soc_data;
+	const struct qcom_cpufreq_soc_data *soc_data = qcom_cpufreq.soc_data;
 
 	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
 	if (!table)
@@ -294,10 +294,10 @@ static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
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
@@ -371,9 +371,9 @@ static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
 	disable_irq_nosync(c_data->throttle_irq);
 	schedule_delayed_work(&c_data->throttle_work, 0);
 
-	if (c_data->soc_data->reg_intr_clr)
+	if (qcom_cpufreq.soc_data->reg_intr_clr)
 		writel_relaxed(GT_IRQ_STATUS,
-			       c_data->base + c_data->soc_data->reg_intr_clr);
+			       c_data->base + qcom_cpufreq.soc_data->reg_intr_clr);
 
 	return IRQ_HANDLED;
 }
@@ -528,16 +528,15 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
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
@@ -658,6 +657,8 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	if (!qcom_cpufreq.data)
 		return -ENOMEM;
 
+	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
+
 	for (i = 0; i < num_domains; i++) {
 		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
 		struct resource *res;
-- 
2.25.1

