Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90956615DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKBIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiKBIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:33:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5227B00
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:32:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 4so15926126pli.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2nlS3XahONFZFIAHmPH/AavNAlCb2gKg69yTobdo08=;
        b=oeMpWeKeP0rveiNwGyuAN4gNDf6JHLEQ6H7aQ7WK5bkqfCdJaus2WQZ0Cae7Uv/Whj
         hmjZj5wn7hGNTy92X9wOPaRdkvK5gElRihTmougdTTd7kQBjrQ/HWqxFvIm3NXe/53vZ
         /SQ1IHi4fWZ58LmeMC1USf5Uq+5gMHU1LqUhXWz3TMYL1nHemu91jJfDFV+ajlNoMTzo
         GfzjJXaoOZki5KVPJqwoTs1/cyFJErlvsvAVrnNxt+YtFn/gvzH+qakawhw4p2zIkdwH
         /+4D2LsTgiMw+MsE5eC8g+SWurCzNG9cLvqhQaK/J6hujAy5tHtDjb7Fih6Lael72zk9
         i8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2nlS3XahONFZFIAHmPH/AavNAlCb2gKg69yTobdo08=;
        b=RAlAIOdqtn6c0B8CDWOQ5uH/1pV/nA9+63BsZmfoPmCOntRCVT6trRCRhktBMS7eqX
         U0JgWdRESsbMe5miiwGLqJ8vTICEjn01cQLyq4MxMr/Kz1dOOs3rw0TApN5lhXWupYIb
         XEK+IvPL5QK+ajkkj5cwlXaOw3J/9Vyx8M6isyRXa4uW9/TibiOqQEp6+2fI2mJTyuxC
         QroipdCCEKYb3FIgHgf++knLduqvR/TC733F18cVgVWgiw3eiR1IG0pMC+XoPxoBPjGp
         hf8ymlc6WAhZnaEwXULbABJkUW6nvZXudE2H9YBSnAGjRbemNzo8qqN+61qbhke4N6Dt
         oNHg==
X-Gm-Message-State: ACrzQf0zs8Iiq4eXfUVwY0AiBxlZV95zAeVgI7feCj5Qc7tCGs8RLTNp
        f0RBuFUKo+4OWWCKqhEGlakH
X-Google-Smtp-Source: AMsMyM4ElgaogpH3aOKa4/LTBdF1aWHexA+c5wQiud780R9cduZbExY/WAmOT8CGQs/Mp9sUBCfPpQ==
X-Received: by 2002:a17:90a:6d22:b0:213:7e1e:9be0 with SMTP id z31-20020a17090a6d2200b002137e1e9be0mr24188999pjj.17.1667377977781;
        Wed, 02 Nov 2022 01:32:57 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b00176acd80f69sm7682256pln.102.2022.11.02.01.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:32:56 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org, rafael@kernel.org
Cc:     johan@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe
Date:   Wed,  2 Nov 2022 14:02:37 +0530
Message-Id: <20221102083239.53826-2-manivannan.sadhasivam@linaro.org>
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

qcom_cpufreq_data is allocated based on the number of frequency domains
defined in DT which is static and won't change during runtime. There is
no real reason to allocate it during the CPU init() callback and deallocate
it during exit(). Hence, move the allocation to probe() and use the
allocated memory during init().

This also allows us to use devm_platform_get_and_ioremap_resource() helper
for acquiring the freq-domain resources from DT.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 86 +++++++++++++------------------
 1 file changed, 37 insertions(+), 49 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a5b3b8d0e164..1842e9facaa1 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -58,6 +58,10 @@ struct qcom_cpufreq_data {
 	bool per_core_dcvs;
 };
 
+static struct {
+	struct qcom_cpufreq_data *data;
+} qcom_cpufreq;
+
 static unsigned long cpu_hw_rate, xo_rate;
 static bool icc_scaling_enabled;
 
@@ -489,8 +493,6 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct of_phandle_args args;
 	struct device_node *cpu_np;
 	struct device *cpu_dev;
-	struct resource *res;
-	void __iomem *base;
 	struct qcom_cpufreq_data *data;
 	int ret, index;
 
@@ -512,43 +514,16 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 		return ret;
 
 	index = args.args[0];
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	if (!res) {
-		dev_err(dev, "failed to get mem resource %d\n", index);
-		return -ENODEV;
-	}
-
-	if (!request_mem_region(res->start, resource_size(res), res->name)) {
-		dev_err(dev, "failed to request resource %pR\n", res);
-		return -EBUSY;
-	}
-
-	base = ioremap(res->start, resource_size(res));
-	if (!base) {
-		dev_err(dev, "failed to map resource %pR\n", res);
-		ret = -ENOMEM;
-		goto release_region;
-	}
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto unmap_base;
-	}
-
 	data->soc_data = of_device_get_match_data(&pdev->dev);
-	data->base = base;
-	data->res = res;
+	data = &qcom_cpufreq.data[index];
 
 	/* HW should be in enabled state to proceed */
-	if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) {
+	if (!(readl_relaxed(data->base + data->soc_data->reg_enable) & 0x1)) {
 		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
-		ret = -ENODEV;
-		goto error;
+		return -ENODEV;
 	}
 
-	if (readl_relaxed(base + data->soc_data->reg_dcvs_ctrl) & 0x1)
+	if (readl_relaxed(data->base + data->soc_data->reg_dcvs_ctrl) & 0x1)
 		data->per_core_dcvs = true;
 
 	qcom_get_related_cpus(index, policy->cpus);
@@ -559,14 +534,13 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
 	if (ret) {
 		dev_err(dev, "Domain-%d failed to read LUT\n", index);
-		goto error;
+		return ret;
 	}
 
 	ret = dev_pm_opp_get_opp_count(cpu_dev);
 	if (ret <= 0) {
 		dev_err(cpu_dev, "Failed to add OPPs\n");
-		ret = -ENODEV;
-		goto error;
+		return -ENODEV;
 	}
 
 	if (policy_has_boost_freq(policy)) {
@@ -575,18 +549,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
 	}
 
-	ret = qcom_cpufreq_hw_lmh_init(policy, index);
-	if (ret)
-		goto error;
-
-	return 0;
-error:
-	kfree(data);
-unmap_base:
-	iounmap(base);
-release_region:
-	release_mem_region(res->start, resource_size(res));
-	return ret;
+	return qcom_cpufreq_hw_lmh_init(policy, index);
 }
 
 static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
@@ -643,7 +606,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
 	struct device *cpu_dev;
 	struct clk *clk;
-	int ret;
+	int ret, i, num_domains;
 
 	clk = clk_get(&pdev->dev, "xo");
 	if (IS_ERR(clk))
@@ -670,6 +633,31 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Allocate qcom_cpufreq_data based on the available frequency domains in DT */
+	num_domains = of_property_count_elems_of_size(pdev->dev.of_node, "reg", sizeof(u32) * 4);
+	if (num_domains <= 0)
+		return num_domains;
+
+	qcom_cpufreq.data = devm_kzalloc(&pdev->dev, sizeof(struct qcom_cpufreq_data) * num_domains,
+					 GFP_KERNEL);
+	if (!qcom_cpufreq.data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_domains; i++) {
+		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
+		struct resource *res;
+		void __iomem *base;
+
+		base = devm_platform_get_and_ioremap_resource(pdev, i, &res);
+		if (IS_ERR(base)) {
+			dev_err(&pdev->dev, "Failed to map resource %pR\n", res);
+			return PTR_ERR(base);
+		}
+
+		data->base = base;
+		data->res = res;
+	}
+
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
 	if (ret)
 		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
-- 
2.25.1

