Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C496B483C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCJPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjCJPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:00:17 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB4C12C713;
        Fri, 10 Mar 2023 06:54:16 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bi17so4406374oib.3;
        Fri, 10 Mar 2023 06:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kDFnMhlDjXbQhhC8cyka2MH9qZ1qf0f7uQ7y1/E2wc=;
        b=IcYlxUmCpI4bJisf6t1mXNhASlCmGHOt/gztv79+k72tPBzmdunCZGNhehrCMNT5xP
         X+q3puBg6VKct9uLZLYByxZwQ/X+stA8+zkNJjsEg4YaNfPN41xTw5GkuRLex1Rd/NMi
         ZyiJ40ZL7MsL1qB3NSHIbcl8EjMvmrOjc/Zo7zG/d/fAfytIgXSSCoZicNMtxQKR4ofx
         ANfpRXraUuypgv3/sUNv+sBz13kl0x83oGNKrobl3+PvWdpZzH/tQQEGTE4OxuCi6rPH
         4BQPHsUWYWF46QrUmhWCI/OzctpJaVgQlx8wxMbE0rrOv93X/7nzSDi8IYFykbJNpxbw
         brJQ==
X-Gm-Message-State: AO0yUKWHRe8Ky1jWDbEpE5xC+pQLPdFX9TxKSIt7Y+56YfsxhQfJfnzb
        zp6KfT7bnI7DYBXesfY6Ow==
X-Google-Smtp-Source: AK7set8wyTPqB0zymJsFHoosApuhG8yLkiRC9jhDOWpmPaOxeYvrXuRmGrs8h0Q1Jwi9MFpU5m2ehQ==
X-Received: by 2002:a05:6808:481:b0:383:b2c0:4ea1 with SMTP id z1-20020a056808048100b00383b2c04ea1mr11230371oid.16.1678459680625;
        Fri, 10 Mar 2023 06:48:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u25-20020a544399000000b0038467f03345sm971615oiv.10.2023.03.10.06.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:00 -0800 (PST)
Received: (nullmailer pid 1545569 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: [PATCH] thermal: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:26 -0600
Message-Id: <20230310144726.1545543-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/thermal/cpufreq_cooling.c                  | 2 +-
 drivers/thermal/imx8mm_thermal.c                   | 2 +-
 drivers/thermal/imx_thermal.c                      | 4 ++--
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 9f8b438fcf8f..4608555b7ec3 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -633,7 +633,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 		return NULL;
 	}
 
-	if (of_find_property(np, "#cooling-cells", NULL)) {
+	if (of_property_present(np, "#cooling-cells")) {
 		struct em_perf_domain *em = em_cpu_get(policy->cpu);
 
 		cdev = __cpufreq_cooling_register(np, policy, em);
diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index 72b5d6f319c1..334ce8e9830b 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -282,7 +282,7 @@ static int imx8mm_tmu_probe_set_calib(struct platform_device *pdev,
 	 * strongly recommended to update such old DTs to get correct
 	 * temperature compensation values for each SoC.
 	 */
-	if (!of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
+	if (!of_property_present(pdev->dev.of_node, "nvmem-cells")) {
 		dev_warn(dev,
 			 "No OCOTP nvmem reference found, SoC-specific calibration not loaded. Please update your DT.\n");
 		return 0;
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index fb0d5cab70af..77d6567a3f47 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -594,7 +594,7 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 
 	np = of_get_cpu_node(data->policy->cpu, NULL);
 
-	if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
+	if (!np || !of_property_present(np, "#cooling-cells")) {
 		data->cdev = cpufreq_cooling_register(data->policy);
 		if (IS_ERR(data->cdev)) {
 			ret = PTR_ERR(data->cdev);
@@ -671,7 +671,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	if (of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
+	if (of_property_present(pdev->dev.of_node, "nvmem-cells")) {
 		ret = imx_init_from_nvmem_cells(pdev);
 		if (ret)
 			return dev_err_probe(&pdev->dev, ret,
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 8a9055bd376e..dace6591220e 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -223,7 +223,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 	 * using DT, then it must be aware that the cooling device
 	 * loading has to happen via cpufreq driver.
 	 */
-	if (of_find_property(np, "#thermal-sensor-cells", NULL))
+	if (of_property_present(np, "#thermal-sensor-cells"))
 		return 0;
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
-- 
2.39.2

