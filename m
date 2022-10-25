Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6748360C55B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiJYHek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiJYHeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:34:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7734153E17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:33:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 4so4584961pli.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNFZLWBDpEQVVP8PITjRVb+C8Kzi0WYhsCO8eonBgh0=;
        b=QsWpwnJULajs9HDqiZmXgkvTZGZkYUVcrZ3B7G7duiqEitktj9vkDQ/g75wHP7rLUf
         Y3LQKXcUxrmrcTzZApvHSGRd8WDKxJl9BFS9YeQiQcopN147yzmCmsbwfVwQ74Cuf4L2
         t6CsM7bnebtyY0C+qYldRH6J+y7Ie3OM/phjKEuQ8PpE2kMUEcwqpwEvi8QWsVca1d9F
         qeqMrcfJHFDjWyDBS6zLxeUfs4BG+K7Jx85MsYbjBWRCwUhEvznPHZtGZrkNkeITMnsP
         MZAph4ZsdQmxqbeYbzw4waTcN8bE5p+L9Bexg9B2yhAH0liE2Mh33RrsCYUIVpwE8XQM
         N0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNFZLWBDpEQVVP8PITjRVb+C8Kzi0WYhsCO8eonBgh0=;
        b=vvjkWvKYqFFCX5N6iFD1wCJQ6JChEdj9Jxqmw7D1KI+7414etRB6NP4ImfXoYNs/6G
         u270N+8ArptHp64p/SmcT4KKF4D25fcfFy0YcHCRWqX9O/ZtX/UBDpmtG9HHkziDyJKm
         wqphOkF9MeWSkun4tRrx9IEMCxqLyenT3xwnOcNml1wiZBSvcaOpSB69pIZvPcfaQyqZ
         0gFRKrmKjNopvQ078+OeutjM/zIw1lAY6iOhikDee9RB+nsJvI4tqNlpzZ/KuRt/qNoK
         NLi/zY+z+kSjXwicmpJCX8cIC4dkO0k5tXyfHbLqSoX97EmkdRDmYacqaxOsaUVtzo1w
         2Sxw==
X-Gm-Message-State: ACrzQf2MxCKgXeoM1i2iHKrwtE1xA2e3qbbgU6FoJ5osvoUbqdLqsmUO
        FFiHbLK1LQl9it2fUN4XoH52
X-Google-Smtp-Source: AMsMyM6+ep5OX6LFLnBIpKwOJqjTdnabuv3UlmkbhDRgTYaCRuGzjWjDmrmMeJFhb7UIoHNASgukig==
X-Received: by 2002:a17:902:ce09:b0:178:bb78:49a5 with SMTP id k9-20020a170902ce0900b00178bb7849a5mr37984224plg.100.1666683223934;
        Tue, 25 Oct 2022 00:33:43 -0700 (PDT)
Received: from localhost.localdomain ([117.193.211.146])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a4d0100b0020dda7efe61sm5048369pjg.5.2022.10.25.00.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 00:33:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 7/7] cpufreq: qcom-hw: Add CPU clock provider support
Date:   Tue, 25 Oct 2022 13:02:54 +0530
Message-Id: <20221025073254.1564622-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
References: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/cpufreq/qcom-cpufreq-hw.c | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 76f840636828..66677db3e267 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk-provider.h>
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/interconnect.h>
@@ -53,6 +54,7 @@ struct qcom_cpufreq_data {
 	bool cancel_throttle;
 	struct delayed_work throttle_work;
 	struct cpufreq_policy *policy;
+	struct clk_hw cpu_clk;
 
 	bool per_core_dcvs;
 };
@@ -601,8 +603,20 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.ready		= qcom_cpufreq_ready,
 };
 
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
 static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
+	struct clk_hw_onecell_data *clk_data;
 	struct device *dev = &pdev->dev;
 	struct device *cpu_dev;
 	struct clk *clk;
@@ -645,8 +659,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
 
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_domains), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = num_domains;
+
 	for (i = 0; i < num_domains; i++) {
 		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
+		static struct clk_init_data init = {};
+		const char *clk_name;
 		struct resource *res;
 		void __iomem *base;
 
@@ -658,6 +680,27 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 		data->base = base;
 		data->res = res;
+
+		/* Register CPU clock for each frequency domain */
+		clk_name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", i);
+		init.name = clk_name;
+		init.flags = CLK_GET_RATE_NOCACHE;
+		init.ops = &qcom_cpufreq_hw_clk_ops;
+		data->cpu_clk.init = &init;
+
+		ret = devm_clk_hw_register(dev, &data->cpu_clk);
+		if (ret < 0) {
+			dev_err(dev, "Failed to register Qcom CPUFreq clock\n");
+			return ret;
+		}
+
+		clk_data->hws[i] = &data->cpu_clk;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add Qcom CPUFreq clock provider\n");
+		return ret;
 	}
 
 	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
-- 
2.25.1

