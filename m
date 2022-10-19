Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6719F604940
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiJSO37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiJSO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:29:36 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0118709F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:14:17 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id g9so11404300qvo.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOX/hC2X41UFwbpGdGHI430ElqEtPDdbL5GfxahROlI=;
        b=dVd2escWA07wQyW29+yHtf1Aabg3rIpLGn64iqrAMkpAVqzr3PKpKo/woq+fpTux+P
         OV67s5a2ZUJCkU53QILMfg3ASfe6ticcgpoQ/U4Ya1KJv4LQfq/hn7SkBgDWzyfGAyG7
         Z2sTsQ0afOXdPkM1cDbQVYIHt1pWH0qp+k7Lv8VQfsB5tj66huJLPa8kMWzeBN8aKHIv
         G5TtWxDNa8HL5kvhyQiEr5qLzZ3jxsOTIZNmd6VciiQbbg0tX7kSlhZdssOO/8zcTMm1
         UiOqYIq1amvuIMkbhcK3FXbyPq478KivxxiUekU7kInHLyB/fV8dkcm5Tzbucaq/pBYr
         Z+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOX/hC2X41UFwbpGdGHI430ElqEtPDdbL5GfxahROlI=;
        b=gX2YWzXt1pRnXbm9ARZcYgpQb3l392ARmeVHWTOm7GjNbsdou33Gtd6O34DmaTmgTi
         cRnA/rf56TcURft3rRifxSN/d8tGKswyXOVVCTR/yo9roedMe/K5zvt19tVsHpRe5eOy
         i5xFOqymUHWmA/5rs15hRbFBq/Itaj6wWgQIq+Bq9tFzK+LwnUQhOWGV7Rw4xNNGckvF
         3fLq5XOMD45xcSGCTPIEzdaaIPE9cL2Yx91TMkIOtgk1EJF5B2LIpjQIZbi+ZGEzi2LB
         GayWGPa/wXJwANh9VKjEzu2jfiiqm+JSvBLopJtthBO2qDM+lSaFnqx4vyR3o6ECFpzy
         4kYw==
X-Gm-Message-State: ACrzQf1Qj9rLSDxv1QxFLMUGbPoJEA/M84+yd+MU4JXB5dYxgX/cWGk1
        An1l5f7jw7gTwCdjiF4RXwnZ65KBt0Mgj/g1uA==
X-Google-Smtp-Source: AMsMyM4Rf1cbF2sWXTg1dfLCfhcWy6pUBvlDplgDIArkHHmRI+jsUANiVp81hJPfsEUHqgPOVBNUDg==
X-Received: by 2002:a17:902:d588:b0:180:cf18:e76c with SMTP id k8-20020a170902d58800b00180cf18e76cmr8498867plh.138.1666187994228;
        Wed, 19 Oct 2022 06:59:54 -0700 (PDT)
Received: from localhost.localdomain ([117.193.210.93])
        by smtp.gmail.com with ESMTPSA id 194-20020a6216cb000000b0053e199aa99bsm11240322pfw.220.2022.10.19.06.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 06:59:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/4] cpufreq: qcom-hw: Add CPU clock provider support
Date:   Wed, 19 Oct 2022 19:29:24 +0530
Message-Id: <20221019135925.366162-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
References: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
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

The clock frequency provided by the driver is for each CPU policy. We
cannot get the frequency of each CPU core because, not all platforms
support per-core DCVS feature.

Also the frequency supplied by the driver is the actual frequency that
comes out of the EPSS/OSM block after the DCVS operation. This frequency is
not same as what the CPUFreq framework has set but it is the one that gets
supplied to the CPUs after throttling by LMh.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 67 +++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a5b3b8d0e164..4dd710f9fb69 100644
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
 };
@@ -482,6 +484,54 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
 	free_irq(data->throttle_irq, data);
 }
 
+static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
+
+	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
+}
+
+static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
+	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
+};
+
+static int qcom_cpufreq_hw_clk_add(struct qcom_cpufreq_data *data, u32 index)
+{
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct device *dev = &pdev->dev;
+	char *clk_name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", index);
+	static struct clk_init_data init = {};
+	int ret;
+
+	init.name = clk_name;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.ops = &qcom_cpufreq_hw_clk_ops;
+	data->cpu_clk.init = &init;
+
+	ret = clk_hw_register(dev, &data->cpu_clk);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register Qcom CPUFreq clock\n");
+		return ret;
+	}
+
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get, &data->cpu_clk);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add Qcom CPUFreq clock provider\n");
+		clk_hw_unregister(&data->cpu_clk);
+	}
+
+	return ret;
+}
+
+static void qcom_cpufreq_hw_clk_remove(struct qcom_cpufreq_data *data)
+{
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	struct device *dev = &pdev->dev;
+
+	of_clk_del_provider(dev->of_node);
+	clk_hw_unregister(&data->cpu_clk);
+}
+
 static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 {
 	struct platform_device *pdev = cpufreq_get_driver_data();
@@ -556,19 +606,24 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	policy->driver_data = data;
 	policy->dvfs_possible_from_any_cpu = true;
 
+	ret = qcom_cpufreq_hw_clk_add(data, index);
+	if (ret) {
+		dev_err(dev, "Domain-%d failed to add CPU clock\n", index);
+		goto error;
+	}
+
 	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
 	if (ret) {
 		dev_err(dev, "Domain-%d failed to read LUT\n", index);
-		goto error;
+		goto clk_remove;
 	}
 
 	ret = dev_pm_opp_get_opp_count(cpu_dev);
 	if (ret <= 0) {
 		dev_err(cpu_dev, "Failed to add OPPs\n");
 		ret = -ENODEV;
-		goto error;
+		goto clk_remove;
 	}
-
 	if (policy_has_boost_freq(policy)) {
 		ret = cpufreq_enable_boost_support();
 		if (ret)
@@ -577,9 +632,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	ret = qcom_cpufreq_hw_lmh_init(policy, index);
 	if (ret)
-		goto error;
+		goto clk_remove;
 
 	return 0;
+
+clk_remove:
+	qcom_cpufreq_hw_clk_remove(data);
 error:
 	kfree(data);
 unmap_base:
@@ -599,6 +657,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	qcom_cpufreq_hw_lmh_exit(data);
+	qcom_cpufreq_hw_clk_remove(data);
 	kfree(policy->freq_table);
 	kfree(data);
 	iounmap(base);
-- 
2.25.1

