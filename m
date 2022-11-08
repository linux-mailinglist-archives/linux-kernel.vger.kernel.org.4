Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09162189A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiKHPlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiKHPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:41:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DBC5C769
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:41:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k8so21639080wrh.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIl+Qt8RB0v0fumM9NIaZyrAwuRsmhqUeWJ9GHQ1hx0=;
        b=tCARyLvz99VJwDDOt8Xky84bnUUHQRpdVlzGY8N2/kstISvgFZ+XRmF3dnucaExqjU
         gNoMznVSOT/l6qRF6bSuD5jGOUxvgL5DQu9fGg5ChzhmOpWBGmA/BbS1g5mEHxdrYwJ/
         3zfsblPBHjc1Q+F8VJQX86okwjgtp9PDxP6WwNgVDYi0Sjmcc1DzH0iZofsJTiMc0XX5
         nLAnCvaUJcoAcPZAm61QUewMNYtiJCJqvqO/OgUIhWUGXHtk/ixGsh8f+TKuuHjnWQvP
         QurTk0FpZ1lY1NntzdpbWCdYzPID6aKOgnwDTfMpcv9eRHouTlhzK/FnCIFI1bon23yk
         CrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIl+Qt8RB0v0fumM9NIaZyrAwuRsmhqUeWJ9GHQ1hx0=;
        b=NcgoE8nZdG1QBEMA+L6ZgkLVFxc50V9pG8tYsJ47MKoLRUP0zbfk1qGA0eTbM+MPBy
         +zOtry6r3ClicK2s/jsDVvgfP8VCfxaiEdYbO+t9c/oBOLZrkz/psFsK9XEHsvH95ydt
         5dj0rUKpToit1ICl+Ac8BlBoQZPbiIUcxAaTfSW+pJovkHL/tZMfDjiY/RFngqzZsX8h
         4g2BFzmkU6Lp80pACVrDzFmIq8LgycXZ9sgR6mBPW0XOux0hlAsJtgmTYKHnBtRVxpis
         IfRA2dMV19ILmC6YDnmYzXOVb1RGsNh6DGSXorZHDDjo56VAbG41gbuyTq3sI1/1FqXb
         D7UA==
X-Gm-Message-State: ACrzQf0CP0AZGg0MWmPytyPpKCSRPbl1+jGQ1K5RXbc4Ii8JaeLmC7T4
        FzUUmy2KJJWAqN1roW4lACnH
X-Google-Smtp-Source: AMsMyM7+d+ZWrTGxRSmDihyy1b++yj9QqCARq+aXt+XyRNBTeMJ0PMfwCPVQ1bkXDOvpnQRdItpMAw==
X-Received: by 2002:adf:d08f:0:b0:238:55af:b5db with SMTP id y15-20020adfd08f000000b0023855afb5dbmr607597wrh.97.1667922080766;
        Tue, 08 Nov 2022 07:41:20 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.46])
        by smtp.gmail.com with ESMTPSA id e4-20020adff344000000b002364c77bc96sm10906899wrp.33.2022.11.08.07.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:41:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Date:   Tue,  8 Nov 2022 21:10:37 +0530
Message-Id: <20221108154037.111794-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
References: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
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
 drivers/cpufreq/qcom-cpufreq-hw.c | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 5e0598730a04..86bb11de347f 100644
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
@@ -659,8 +673,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
 
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_domains), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = num_domains;
+
 	for (i = 0; i < num_domains; i++) {
 		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
+		struct clk_init_data init = {};
+		const char *clk_name;
 		struct resource *res;
 		void __iomem *base;
 
@@ -672,6 +694,27 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
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

