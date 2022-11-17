Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64C62D2C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbiKQFcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbiKQFcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:32:13 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F01963151
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 21:32:10 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l2so599434pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 21:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OvsIbRKjLs7ZX9h1wlc3YCPycyX8ACIte6CDckfX6U=;
        b=BGyW9bWVtdS5mgE3nioOqgLfTm7+DHwgyeTpo9L9qsBEO6dKaPKCgo/Ig1VwqrGrPv
         K5NIJDOMx1Hzb1pWHMIx5mXDUPyIlxFpDGl2sF5RSQSV3QHzQAlswolZUrnAxhgCJXUp
         56DNxzLShqfz/5xcKzgZl6psOoflOrZZ1m1KhncJVCtJos2k/20YD/4SN4l8N6cA0Zd3
         EVGOBcSCagsTCLtJ89CgljI+kbrwFjQjJJVWklnHWjFy+LC9+9xHOgxnDXEVG1dA8uQd
         LM4cK0MCtMr7ySTjD1UVQSzmQSfBR2SEwCYJkPxGGQhkOIs5U93000lP4N8LI99X2XzC
         Hyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OvsIbRKjLs7ZX9h1wlc3YCPycyX8ACIte6CDckfX6U=;
        b=cSR6heRF3FkgoTo84sQZenU04+LesAgExaZHeotsmAKrO6O3zo5Eb2YvkBOwW9cdZv
         rMcSpUycnfjA4En199rlE5yZ+OMnuaXGC9mOhC0diSCgf5FzwTabQ69J1mNzKCWSzVi7
         dgCkHz3NuMkbir1rYSbYuzLpGYX9cZeAMPIcTwRgb+fdEAW/u0mZKUeLaVU3VgC0j551
         VGp2XEcRmQbXyRGtMoM9NaNSVmF9b0QrCr19CCLlk+fpCBUuoDRvWCG9cAGkHujaZgky
         jQPjVGk8jLbhJ2cq6IEPLMKOwnn+dfmdHXINGBCZUrdQ5/pGY/CfrqsuQjPznBVo0Jxp
         I9RA==
X-Gm-Message-State: ANoB5pn2ZOob3c2Qq7g5Gcgy5h0PNz0OHcF7apcE5YfJ7E/9zh0WzMHw
        LLCfcnvoq2VPdXEuskXfSz+3
X-Google-Smtp-Source: AA0mqf5AilcpDgWcYGXfrJIQufqZd9/IoWsAyMTrH6188RIZlil1KxKNZdQKQlwPg0lwITx0IFFv3Q==
X-Received: by 2002:a17:90a:dd83:b0:218:61bd:d00d with SMTP id l3-20020a17090add8300b0021861bdd00dmr4554709pjv.236.1668663129783;
        Wed, 16 Nov 2022 21:32:09 -0800 (PST)
Received: from localhost.localdomain ([117.193.208.31])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b001865c298588sm96600plh.258.2022.11.16.21.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 21:32:08 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 3/4] cpufreq: qcom-hw: Add CPU clock provider support
Date:   Thu, 17 Nov 2022 11:01:44 +0530
Message-Id: <20221117053145.10409-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom CPUFreq hardware (EPSS/OSM) controls clock and voltage to the CPU
cores. But this relationship is not represented with the clk framework
so far.

So, let's make the qcom-cpufreq-hw driver a clock provider. This makes the
clock producer/consumer relationship cleaner and is also useful for CPU
related frameworks like OPP to know the frequency at which the CPUs are
running.

The clock frequency provided by the driver is for each frequency domain.
We cannot get the frequency of each CPU core because, not all platforms
support per-core DCVS feature.

Also the frequency supplied by the driver is the actual frequency that
comes out of the EPSS/OSM block after the DCVS operation. This frequency is
not same as what the CPUFreq framework has set but it is the one that gets
supplied to the CPUs after throttling by LMh.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 5e0598730a04..1faa325d3e52 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk-provider.h>
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/interconnect.h>
@@ -54,6 +55,7 @@ struct qcom_cpufreq_data {
 	bool cancel_throttle;
 	struct delayed_work throttle_work;
 	struct cpufreq_policy *policy;
+	struct clk_hw cpu_clk;
 
 	bool per_core_dcvs;
 
@@ -615,8 +617,20 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.ready		= qcom_cpufreq_ready,
 };
 
+static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
+
+	return qcom_lmh_get_throttle_freq(data);
+}
+
+static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
+	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
+};
+
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
+	struct clk_hw_onecell_data *clk_data;
 	struct device *dev = &pdev->dev;
 	struct device *cpu_dev;
 	struct clk *clk;
@@ -659,8 +673,15 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
 
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_domains), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = num_domains;
+
 	for (i = 0; i < num_domains; i++) {
 		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
+		struct clk_init_data clk_init = {};
 		struct resource *res;
 		void __iomem *base;
 
@@ -672,6 +693,30 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 		data->base = base;
 		data->res = res;
+
+		/* Register CPU clock for each frequency domain */
+		clk_init.name = kasprintf(GFP_KERNEL, "qcom_cpufreq%d", i);
+		if (!clk_init.name)
+			return -ENOMEM;
+
+		clk_init.flags = CLK_GET_RATE_NOCACHE;
+		clk_init.ops = &qcom_cpufreq_hw_clk_ops;
+		data->cpu_clk.init = &clk_init;
+
+		ret = devm_clk_hw_register(dev, &data->cpu_clk);
+		if (ret < 0) {
+			dev_err(dev, "Failed to register clock %d: %d\n", i, ret);
+			return ret;
+		}
+
+		clk_data->hws[i] = &data->cpu_clk;
+		kfree(clk_init.name);
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add clock provider\n");
+		return ret;
 	}
 
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
-- 
2.25.1

