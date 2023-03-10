Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614A66B471F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjCJOsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjCJOrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:35 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D02412115C;
        Fri, 10 Mar 2023 06:47:19 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id y184so4386047oiy.8;
        Fri, 10 Mar 2023 06:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOScINdVt5AO68Lh+/aSSo0LSJcWlj/v+OQKQopbrfE=;
        b=eolFuhBLjUSLjh4iH9KotyuBJTqQza0Ns9lw0nM5K0kS70QydcjOAOdONGKCf+NkVn
         amz7/eJhBRQMQpo+P5c8GayjcFdkAs+CnNu3IJ7EM4J1imFDx5fUKhFtt4T/KWYtN7V8
         W67e9+BfNrh83/dWcyHjjLnGMSyaxVFQIviMBfHyP7Nkr9Kgj59VduVRw1YWTztfv002
         BfBg3bTzsOPA/fdPUDrwFJ7puEgHWdvaHyHurkWU87PQKPBoVg8n2GGFXWbgDO4drash
         z43HG9iEzNiIKKORzs+ylVh9jtk59mYB9ub6fJR8WOnQRDFvikoh4p48jVg9GhyyXhl1
         0qDg==
X-Gm-Message-State: AO0yUKVcSoe+pQ6iYwHeI29T6JqbtXypSXx0dBOYKmhCZo/yaqOYOW3v
        XPu9z3avjgBNeuAtf6zf8HzyJw8/WA==
X-Google-Smtp-Source: AK7set+A03WCNhhILxT+Im0HjPRwqAdlpSrjmwLHRwv5tCq6UJ03m7njDAzYDBsWlFqeSLAiKCrC0Q==
X-Received: by 2002:a05:6808:8f1:b0:384:349a:15d0 with SMTP id d17-20020a05680808f100b00384349a15d0mr3352325oic.38.1678459634837;
        Fri, 10 Mar 2023 06:47:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q194-20020a4a33cb000000b00517fc5fdf5bsm801303ooq.17.2023.03.10.06.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:14 -0800 (PST)
Received: (nullmailer pid 1541776 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH] cpufreq: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:02 -0600
Message-Id: <20230310144702.1541730-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
 drivers/cpufreq/imx-cpufreq-dt.c     | 2 +-
 drivers/cpufreq/imx6q-cpufreq.c      | 4 ++--
 drivers/cpufreq/scmi-cpufreq.c       | 2 +-
 drivers/cpufreq/tegra20-cpufreq.c    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index e85703651098..5ac6b9e5270e 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -179,7 +179,7 @@ static bool __init cpu0_node_has_opp_v2_prop(void)
 	struct device_node *np = of_cpu_device_node_get(0);
 	bool ret = false;
 
-	if (of_get_property(np, "operating-points-v2", NULL))
+	if (of_property_present(np, "operating-points-v2"))
 		ret = true;
 
 	of_node_put(np);
diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 76e553af2071..535867a7dfdd 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -89,7 +89,7 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 
 	cpu_dev = get_cpu_device(0);
 
-	if (!of_find_property(cpu_dev->of_node, "cpu-supply", NULL))
+	if (!of_property_present(cpu_dev->of_node, "cpu-supply"))
 		return -ENODEV;
 
 	if (of_machine_is_compatible("fsl,imx7ulp")) {
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index ad4ce8493144..48e1772e98fd 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -222,7 +222,7 @@ static int imx6q_opp_check_speed_grading(struct device *dev)
 	u32 val;
 	int ret;
 
-	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
+	if (of_property_present(dev->of_node, "nvmem-cells")) {
 		ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
 		if (ret)
 			return ret;
@@ -279,7 +279,7 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 	u32 val;
 	int ret = 0;
 
-	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
+	if (of_property_present(dev->of_node, "nvmem-cells")) {
 		ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
 		if (ret)
 			return ret;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 513a071845c2..f34e6382a4c5 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -310,7 +310,7 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 
 #ifdef CONFIG_COMMON_CLK
 	/* dummy clock provider as needed by OPP if clocks property is used */
-	if (of_find_property(dev->of_node, "#clock-cells", NULL))
+	if (of_property_present(dev->of_node, "#clock-cells"))
 		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
 #endif
 
diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index ab7ac7df9e62..dfd2de4f8e07 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -25,7 +25,7 @@ static bool cpu0_node_has_opp_v2_prop(void)
 	struct device_node *np = of_cpu_device_node_get(0);
 	bool ret = false;
 
-	if (of_get_property(np, "operating-points-v2", NULL))
+	if (of_property_present(np, "operating-points-v2"))
 		ret = true;
 
 	of_node_put(np);
-- 
2.39.2

