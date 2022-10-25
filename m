Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B4160C559
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiJYHe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiJYHdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:33:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F88159A11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:33:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w189so9620174pfw.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UeGRLt0I6Ca0YYYt9StoKBqh2LnPMLZ6623L26cNAw=;
        b=X0RL/rMFeNQR0WlRbmLCElOKWXzvpdlLvDkjR4YTO7u8TR4XMeO2egtQYx8G/jG5qe
         Wwz3GBRVRRS9nmz47gxJTR96yUXyD6Cd2gy4jCSHBB5RW2/j0sralt9LqxBu7qxPaxfy
         lGRQw5xJXlCUN60USUCLU0Ktmn0e/YcDqhTsNBNH3ovUkH5ooHLe9cQ2TZMaMIojLlpJ
         1ytohEqsESYOtThDKvxNer4zMK9Z8+UA8/P1CD2Lkm34l9Ie+cYYAI//1N/bDxqpbLpc
         o16rasF6aua2DiHsO348m9fI0oif7ZymhXfonnK13z5c9SvceN/jYgrqRYxuTM3opm7m
         KSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UeGRLt0I6Ca0YYYt9StoKBqh2LnPMLZ6623L26cNAw=;
        b=t4nkVwlHSX5oq2X7GdXta7aa6gkhkX5QzFdhLH5O3aS+bNmiKiodL9rtjh6kBQaPMN
         iv6+bkK/oUi4/sRPZncnUrG1zxlyquH//WL8+/vieXhABhzpYLON0cjkm2vBwswAXU7m
         ApbZifkgDOucVSIi4dQJHOG2vcSc54//RJrVpPefZWDttLE6gqRi48uMKCEIrhH6WcvU
         KziU897WHvhA3Ag7/10bo7KA1hfRZjFZxhZ4bcVHnw771aPpQxG9jgDOOORV+sLCaBCu
         j8QED+7XuxvkuI9G1cwXxFYPSDC1oEE+53AhRkUXkRLe4Mte61noGf7v94gELFPFmIH9
         0VBQ==
X-Gm-Message-State: ACrzQf2kFRcKakt46xnv+RAvO1OuYMWWOmcLl39rGdcmbNq8cQsjCEM8
        1LvTvrHOYcuQKE09Dx7fI4Mf
X-Google-Smtp-Source: AMsMyM5j6iqRSkisi9RIe+WFzEnKm4yugU7gx9b0CI4vdgNgxWZeFWN4UlaLWpYSFevvPnXAFOEqaA==
X-Received: by 2002:a63:5164:0:b0:43b:e57c:a15f with SMTP id r36-20020a635164000000b0043be57ca15fmr31182269pgl.586.1666683214172;
        Tue, 25 Oct 2022 00:33:34 -0700 (PDT)
Received: from localhost.localdomain ([117.193.211.146])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a4d0100b0020dda7efe61sm5048369pjg.5.2022.10.25.00.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 00:33:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 5/7] cpufreq: qcom-hw: Use cached dev pointer in probe()
Date:   Tue, 25 Oct 2022 13:02:52 +0530
Message-Id: <20221025073254.1564622-6-manivannan.sadhasivam@linaro.org>
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

There are multiple instances of dev pointer used in the probe() function.
Instead of referencing pdev->dev all the time, let's use a cached dev
pointer to simplify the code.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 1842e9facaa1..bc991ef10c05 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -604,18 +604,19 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct device *cpu_dev;
 	struct clk *clk;
 	int ret, i, num_domains;
 
-	clk = clk_get(&pdev->dev, "xo");
+	clk = clk_get(dev, "xo");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
 	xo_rate = clk_get_rate(clk);
 	clk_put(clk);
 
-	clk = clk_get(&pdev->dev, "alternate");
+	clk = clk_get(dev, "alternate");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
@@ -634,11 +635,11 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Allocate qcom_cpufreq_data based on the available frequency domains in DT */
-	num_domains = of_property_count_elems_of_size(pdev->dev.of_node, "reg", sizeof(u32) * 4);
+	num_domains = of_property_count_elems_of_size(dev->of_node, "reg", sizeof(u32) * 4);
 	if (num_domains <= 0)
 		return num_domains;
 
-	qcom_cpufreq.data = devm_kzalloc(&pdev->dev, sizeof(struct qcom_cpufreq_data) * num_domains,
+	qcom_cpufreq.data = devm_kzalloc(dev, sizeof(struct qcom_cpufreq_data) * num_domains,
 					 GFP_KERNEL);
 	if (!qcom_cpufreq.data)
 		return -ENOMEM;
@@ -650,7 +651,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 		base = devm_platform_get_and_ioremap_resource(pdev, i, &res);
 		if (IS_ERR(base)) {
-			dev_err(&pdev->dev, "Failed to map resource %pR\n", res);
+			dev_err(dev, "Failed to map resource %pR\n", res);
 			return PTR_ERR(base);
 		}
 
@@ -660,9 +661,9 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
 	if (ret)
-		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
+		dev_err(dev, "CPUFreq HW driver failed to register\n");
 	else
-		dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
+		dev_dbg(dev, "QCOM CPUFreq HW driver initialized\n");
 
 	return ret;
 }
-- 
2.25.1

