Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69D060C55A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiJYHec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiJYHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:33:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBAB159963
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:33:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso8818980pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=947eFVQOjYHgL69E/eIjVgvNC7z93QCjfG2CSFXyEag=;
        b=rpLJ6UQtAPwIpX/vSn6NBqFp7r9mxD4dNkqOGChOIy1x+6RAQjtKqce54O9LM33EVP
         0KYjdWSz5fy3SUW3TTfPV0D9jsyIl6zkSU121AGp5AASPl0OA4GvDPJD4/yMkhtZKyYY
         MPguHWDVDpRegL6EdwNJ4o4fKzxYUfajd+H4WSnre6zeHEGda0Ri8XkxXwDGROpOKtv7
         BuK9WVolLJ5AEcuI2KtIwRDnW5BB4ed1RGmQkF7tsuINngiv7uRv6mYSDf3IlhmUtIGI
         xd8aOXLyJ5/ooL+CDFus/q5D2Jd9zMVLj+9nhsWNMyWhs6gpvIyRxBCzUcZl0yFIL7Hr
         4NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=947eFVQOjYHgL69E/eIjVgvNC7z93QCjfG2CSFXyEag=;
        b=TufUXaeibOlC6BLKd/TTOJFfyo5Fzdr3dseDsCSrYKK2rB3LEmRLkD716G1ljfKE6Q
         SZj/IKBGcRMqw4kQIrgc63F3Dcn7bxf2+1pfoFUUNtcWeol2L4ZCMXWX5zC/pzOCIzxN
         EzmsakSPlPZW3L/qepiWbkXthIMLHti79d8wKceG11MJE9DTj9f8ymB6K9MYGSusz0sc
         qMHtTlfq5aPJ2DN2e8AcLutpZnYofJKn+pqi9uE4WRD/TMQ6OZFb0kS3pjcPRWXK0KWn
         cbm3yzr7SD54Ovae6gSqcCtA2K41F44tUQuDqxOBDQ9bJHKWL1qqlP2yOEqazcruv0eV
         f82w==
X-Gm-Message-State: ACrzQf1nKKdRDNRij/oxGSMaDDS5WAZ4Kd0ZGFOVgK30e01cE5sLBv6R
        9EuJoZ1btFQBOgh8l2MjShwN
X-Google-Smtp-Source: AMsMyM4a6vUHbgqeKEegoymZD8RDm1GIEbQ8fhCoqggXkXBOJV1Hpmn/CQumeig285Ga9Ch7elnS6A==
X-Received: by 2002:a17:902:f78b:b0:17f:9c94:b247 with SMTP id q11-20020a170902f78b00b0017f9c94b247mr36034344pln.137.1666683219074;
        Tue, 25 Oct 2022 00:33:39 -0700 (PDT)
Received: from localhost.localdomain ([117.193.211.146])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a4d0100b0020dda7efe61sm5048369pjg.5.2022.10.25.00.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 00:33:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 6/7] cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq
Date:   Tue, 25 Oct 2022 13:02:53 +0530
Message-Id: <20221025073254.1564622-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
References: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

