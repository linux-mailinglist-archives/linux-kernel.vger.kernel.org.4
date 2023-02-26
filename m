Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15AB6A34F1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBZWzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjBZWy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:54:57 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CCFEFAE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:54:45 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso2781617wmp.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU6ZwUsV+1vPfrDcdZNiADbV8jceZGcLkY6sCJA8sDM=;
        b=uW1QmW8eBHhqsH1ijFi4qgwUmB7TVRK70bPx+Z2mxrn0eG+v83BaXqDvrH2YgvYm89
         C7tspjTGigV6/eT3zLwrc5eTQWP1jQNSuiZCwfqDlgfcpzNs04eW5L3cipInJjBNunEK
         hMX861JOutQtI8NJREoU2KEAbaalXX/27hyqH5HBIaaBRV4oB+uDz8pa+mSuOYUWts0R
         TU5lLISPOu9kRocXFK4Rq3y6OJTmkPZnM64sucGgRibM0fPhSbYuTFK8s/BbKZOvOVLL
         HZ1dmJ/BJg0zVNN68Rg6aQTcaItjqNeIt6QGsZqdF2sF3hRqmYf1jDDF4d/ZZM0lUPZM
         OggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dU6ZwUsV+1vPfrDcdZNiADbV8jceZGcLkY6sCJA8sDM=;
        b=HqMuCVKor+45KUIobGh2IP8gpzW08+VafmZrHqnbX3DEO46x5Q4OWk1JMzUk47Y7cL
         d/9CfO7c68f+9gP8/l0RK1XRBfF3k7Q80EK8GXgnbMUQYtmxCLYmI94BwiaTqPr1u+JL
         8E49HxajJoi18zxArnJI4Pq8hqOCx+DO70XpYKI6PoeG6QLH2sIZ9sAdf50No6rXrjR5
         ADTs0uLReTq3Npg0XRErky0yWsnEW6oTfVkhDr2vbXJ7HoonH/fKibuT2rRT8phO/dU7
         YDaBuccFlGsqPZZI+Nrx9FYPycjQs7ixEOtQqDwDFBDaL+3Y9Akq9KqasxlFHk0R46UW
         93OQ==
X-Gm-Message-State: AO0yUKW21SfmTbBhc9Ll4ESoqQUKPhuKiMDKx7O9yep54jyjf8kXf/hZ
        1b517xuKWD6sxFs3f54N1fE//g==
X-Google-Smtp-Source: AK7set+F0lqW9BKq08fC1eaWSVoeOOck0/VhUuZRQrVR4LOJaLi1lw0fM77JDD/qtDPHGeYW8dcq2Q==
X-Received: by 2002:a05:600c:a4c:b0:3ea:e667:b1ee with SMTP id c12-20020a05600c0a4c00b003eae667b1eemr8782478wmq.38.1677452083204;
        Sun, 26 Feb 2023 14:54:43 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:54:42 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Talel Shenhar <talel@amazon.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Tim Zimmermann <tim@linux4.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Jiang Jian <jiangjian@cdjrlc.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-amlogic@lists.infradead.org (open list:THERMAL DRIVER FOR AMLOGIC
        SOCS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-msm@vger.kernel.org (open list:QUALCOMM TSENS THERMAL DRIVER),
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v3 02/20] thermal/core: Use the thermal zone 'devdata' accessor in thermal located drivers
Date:   Sun, 26 Feb 2023 23:53:48 +0100
Message-Id: <20230226225406.979703-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The thermal zone device structure is exposed to the different drivers
and obviously they access the internals while that should be
restricted to the core thermal code.

In order to self-encapsulate the thermal core code, we need to prevent
the drivers accessing directly the thermal zone structure and provide
accessor functions to deal with.

Use the devdata accessor introduced in the previous patch.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se> #R-Car
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> #MediaTek auxadc and lvts
Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek lvts
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com> #da9062
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>  #spread
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com> #sun8i_thermal
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com> #Broadcom
---
 drivers/thermal/amlogic_thermal.c                   |  2 +-
 drivers/thermal/armada_thermal.c                    |  4 ++--
 drivers/thermal/broadcom/bcm2711_thermal.c          |  2 +-
 drivers/thermal/broadcom/bcm2835_thermal.c          |  2 +-
 drivers/thermal/broadcom/brcmstb_thermal.c          |  4 ++--
 drivers/thermal/broadcom/ns-thermal.c               |  2 +-
 drivers/thermal/broadcom/sr-thermal.c               |  2 +-
 drivers/thermal/da9062-thermal.c                    |  2 +-
 drivers/thermal/db8500_thermal.c                    |  2 +-
 drivers/thermal/dove_thermal.c                      |  2 +-
 drivers/thermal/hisi_thermal.c                      |  2 +-
 drivers/thermal/imx8mm_thermal.c                    |  2 +-
 drivers/thermal/imx_sc_thermal.c                    |  2 +-
 drivers/thermal/imx_thermal.c                       |  6 +++---
 .../thermal/intel/int340x_thermal/int3400_thermal.c |  2 +-
 .../intel/int340x_thermal/int340x_thermal_zone.c    |  4 ++--
 .../int340x_thermal/processor_thermal_device_pci.c  |  4 ++--
 drivers/thermal/intel/intel_pch_thermal.c           |  2 +-
 drivers/thermal/intel/intel_quark_dts_thermal.c     |  6 +++---
 drivers/thermal/intel/intel_soc_dts_iosf.c          | 13 +++++--------
 drivers/thermal/intel/x86_pkg_temp_thermal.c        |  4 ++--
 drivers/thermal/k3_bandgap.c                        |  2 +-
 drivers/thermal/k3_j72xx_bandgap.c                  |  2 +-
 drivers/thermal/kirkwood_thermal.c                  |  2 +-
 drivers/thermal/max77620_thermal.c                  |  2 +-
 drivers/thermal/mediatek/auxadc_thermal.c           |  2 +-
 drivers/thermal/mediatek/lvts_thermal.c             |  4 ++--
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c            |  4 ++--
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c         |  4 ++--
 drivers/thermal/qcom/tsens.c                        |  4 ++--
 drivers/thermal/qoriq_thermal.c                     |  2 +-
 drivers/thermal/rcar_gen3_thermal.c                 |  4 ++--
 drivers/thermal/rcar_thermal.c                      |  3 +--
 drivers/thermal/rockchip_thermal.c                  |  4 ++--
 drivers/thermal/rzg2l_thermal.c                     |  2 +-
 drivers/thermal/samsung/exynos_tmu.c                |  4 ++--
 drivers/thermal/spear_thermal.c                     |  8 ++++----
 drivers/thermal/sprd_thermal.c                      |  2 +-
 drivers/thermal/st/st_thermal.c                     |  2 +-
 drivers/thermal/st/stm_thermal.c                    |  4 ++--
 drivers/thermal/sun8i_thermal.c                     |  2 +-
 drivers/thermal/tegra/soctherm.c                    |  6 +++---
 drivers/thermal/tegra/tegra-bpmp-thermal.c          |  6 ++++--
 drivers/thermal/tegra/tegra30-tsensor.c             |  4 ++--
 drivers/thermal/thermal-generic-adc.c               |  2 +-
 drivers/thermal/thermal_mmio.c                      |  2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c  |  4 ++--
 drivers/thermal/uniphier_thermal.c                  |  2 +-
 48 files changed, 79 insertions(+), 81 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 9235fda4ec1e..dfcc93e45cdd 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -181,7 +181,7 @@ static int amlogic_thermal_disable(struct amlogic_thermal *data)
 static int amlogic_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	unsigned int tval;
-	struct amlogic_thermal *pdata = tz->devdata;
+	struct amlogic_thermal *pdata = thermal_zone_device_priv(tz);
 
 	if (!pdata)
 		return -EINVAL;
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 2efc222a379b..ebd606861a61 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -398,7 +398,7 @@ static int armada_read_sensor(struct armada_thermal_priv *priv, int *temp)
 static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
 				  int *temp)
 {
-	struct armada_thermal_priv *priv = thermal->devdata;
+	struct armada_thermal_priv *priv = thermal_zone_device_priv(thermal);
 	int ret;
 
 	/* Valid check */
@@ -420,7 +420,7 @@ static struct thermal_zone_device_ops legacy_ops = {
 
 static int armada_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct armada_thermal_sensor *sensor = tz->devdata;
+	struct armada_thermal_sensor *sensor = thermal_zone_device_priv(tz);
 	struct armada_thermal_priv *priv = sensor->priv;
 	int ret;
 
diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index 1f8651d15160..fcfcbbf044a4 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -33,7 +33,7 @@ struct bcm2711_thermal_priv {
 
 static int bcm2711_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct bcm2711_thermal_priv *priv = tz->devdata;
+	struct bcm2711_thermal_priv *priv = thermal_zone_device_priv(tz);
 	int slope = thermal_zone_get_slope(tz);
 	int offset = thermal_zone_get_offset(tz);
 	u32 val;
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 23918bb76ae6..86aaf459de37 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -90,7 +90,7 @@ static int bcm2835_thermal_temp2adc(int temp, int offset, int slope)
 
 static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct bcm2835_thermal_data *data = tz->devdata;
+	struct bcm2835_thermal_data *data = thermal_zone_device_priv(tz);
 	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
 
 	if (!(val & BCM2835_TS_TSENSSTAT_VALID))
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 4d02c28331e3..60173cc83c46 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -152,7 +152,7 @@ static inline u32 avs_tmon_temp_to_code(struct brcmstb_thermal_priv *priv,
 
 static int brcmstb_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct brcmstb_thermal_priv *priv = tz->devdata;
+	struct brcmstb_thermal_priv *priv = thermal_zone_device_priv(tz);
 	u32 val;
 	long t;
 
@@ -262,7 +262,7 @@ static irqreturn_t brcmstb_tmon_irq_thread(int irq, void *data)
 
 static int brcmstb_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct brcmstb_thermal_priv *priv = tz->devdata;
+	struct brcmstb_thermal_priv *priv = thermal_zone_device_priv(tz);
 
 	dev_dbg(priv->dev, "set trips %d <--> %d\n", low, high);
 
diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index 07a8a3f49bd0..d255aa879fc0 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -16,7 +16,7 @@
 
 static int ns_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	void __iomem *pvtmon = tz->devdata;
+	void __iomem *pvtmon = thermal_zone_device_priv(tz);
 	int offset = thermal_zone_get_offset(tz);
 	int slope = thermal_zone_get_slope(tz);
 	u32 val;
diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
index 2b93502543ff..747915890022 100644
--- a/drivers/thermal/broadcom/sr-thermal.c
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -32,7 +32,7 @@ struct sr_thermal {
 
 static int sr_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sr_tmon *tmon = tz->devdata;
+	struct sr_tmon *tmon = thermal_zone_device_priv(tz);
 	struct sr_thermal *sr_thermal = tmon->priv;
 
 	*temp = readl(sr_thermal->regs + SR_TMON_TEMP_BASE(tmon->tmon_id));
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index a805a6666c44..e7097f354750 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -123,7 +123,7 @@ static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
 static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 				   int *temp)
 {
-	struct da9062_thermal *thermal = z->devdata;
+	struct da9062_thermal *thermal = thermal_zone_device_priv(z);
 
 	mutex_lock(&thermal->lock);
 	*temp = thermal->temperature;
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index cb10e280681f..607c10a712ec 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -60,7 +60,7 @@ struct db8500_thermal_zone {
 /* Callback to get current temperature */
 static int db8500_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct db8500_thermal_zone *th = tz->devdata;
+	struct db8500_thermal_zone *th = therma_zone_device_priv(tz);
 
 	/*
 	 * TODO: There is no PRCMU interface to get temperature data currently,
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 056622a58d00..6db1882e8229 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -87,7 +87,7 @@ static int dove_get_temp(struct thermal_zone_device *thermal,
 			  int *temp)
 {
 	unsigned long reg;
-	struct dove_thermal_priv *priv = thermal->devdata;
+	struct dove_thermal_priv *priv = thermal_zone_device_priv(thermal);
 
 	/* Valid check */
 	reg = readl_relaxed(priv->control + PMU_TEMP_DIOD_CTRL1_REG);
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 32a7c3cf073d..f3a374266fa0 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -431,7 +431,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 
 static int hisi_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct hisi_thermal_sensor *sensor = tz->devdata;
+	struct hisi_thermal_sensor *sensor = thermal_zone_device_priv(tz);
 	struct hisi_thermal_data *data = sensor->data;
 
 	*temp = data->ops->get_temp(sensor);
diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index 72b5d6f319c1..efa1a4ffc368 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -141,7 +141,7 @@ static int imx8mp_tmu_get_temp(void *data, int *temp)
 
 static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tmu_sensor *sensor = tz->devdata;
+	struct tmu_sensor *sensor = thermal_zone_device_priv(tz);
 	struct imx8mm_tmu *tmu = sensor->priv;
 
 	return tmu->socdata->get_temp(sensor, temp);
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index f32e59e74623..ddde4bdfc94a 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -46,7 +46,7 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct imx_sc_msg_misc_get_temp msg;
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	struct imx_sc_sensor *sensor = tz->devdata;
+	struct imx_sc_sensor *sensor = thermal_zone_device_priv(tz);
 	int ret;
 
 	msg.data.req.resource_id = sensor->resource_id;
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index fb0d5cab70af..a22b8086a209 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -252,7 +252,7 @@ static void imx_set_alarm_temp(struct imx_thermal_data *data,
 
 static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct imx_thermal_data *data = tz->devdata;
+	struct imx_thermal_data *data = thermal_zone_device_priv(tz);
 	const struct thermal_soc_data *soc_data = data->socdata;
 	struct regmap *map = data->tempmon;
 	unsigned int n_meas;
@@ -311,7 +311,7 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 static int imx_change_mode(struct thermal_zone_device *tz,
 			   enum thermal_device_mode mode)
 {
-	struct imx_thermal_data *data = tz->devdata;
+	struct imx_thermal_data *data = thermal_zone_device_priv(tz);
 
 	if (mode == THERMAL_DEVICE_ENABLED) {
 		pm_runtime_get(data->dev);
@@ -342,7 +342,7 @@ static int imx_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
 			     int temp)
 {
-	struct imx_thermal_data *data = tz->devdata;
+	struct imx_thermal_data *data = thermal_zone_device_priv(tz);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(data->dev);
diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index d0295123cc3e..810231b59dcd 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -497,7 +497,7 @@ static int int3400_thermal_get_temp(struct thermal_zone_device *thermal,
 static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
 				       enum thermal_device_mode mode)
 {
-	struct int3400_thermal_priv *priv = thermal->devdata;
+	struct int3400_thermal_priv *priv = thermal_zone_device_priv(thermal);
 	int result = 0;
 
 	if (!priv)
diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 00665967ca52..89cf007146ea 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -14,7 +14,7 @@
 static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 					 int *temp)
 {
-	struct int34x_thermal_zone *d = zone->devdata;
+	struct int34x_thermal_zone *d = thermal_zone_device_priv(zone);
 	unsigned long long tmp;
 	acpi_status status;
 
@@ -41,7 +41,7 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
 static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 					 int trip, int temp)
 {
-	struct int34x_thermal_zone *d = zone->devdata;
+	struct int34x_thermal_zone *d = thermal_zone_device_priv(zone);
 	char name[] = {'P', 'A', 'T', '0' + trip, '\0'};
 	acpi_status status;
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 40725cbc6eb0..0404d4db70f0 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -135,7 +135,7 @@ static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 {
-	struct proc_thermal_pci *pci_info = tzd->devdata;
+	struct proc_thermal_pci *pci_info = thermal_zone_device_priv(tzd);
 	u32 _temp;
 
 	proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_PKG_TEMP, &_temp);
@@ -146,7 +146,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 
 static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
-	struct proc_thermal_pci *pci_info = tzd->devdata;
+	struct proc_thermal_pci *pci_info = thermal_zone_device_priv(tzd);
 	int tjmax, _temp;
 
 	if (temp <= 0) {
diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index b855d031a855..dce50d239357 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -119,7 +119,7 @@ static int pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd, int trip)
 
 static int pch_thermal_get_temp(struct thermal_zone_device *tzd, int *temp)
 {
-	struct pch_thermal_device *ptd = tzd->devdata;
+	struct pch_thermal_device *ptd = thermal_zone_device_priv(tzd);
 
 	*temp = GET_WPT_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
 	return 0;
diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index 97b843fa7568..63569185ed82 100644
--- a/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -120,7 +120,7 @@ static DEFINE_MUTEX(dts_update_mutex);
 static int soc_dts_enable(struct thermal_zone_device *tzd)
 {
 	u32 out;
-	struct soc_sensor_entry *aux_entry = tzd->devdata;
+	struct soc_sensor_entry *aux_entry = thermal_zone_device_priv(tzd);
 	int ret;
 
 	ret = iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
@@ -148,7 +148,7 @@ static int soc_dts_enable(struct thermal_zone_device *tzd)
 static int soc_dts_disable(struct thermal_zone_device *tzd)
 {
 	u32 out;
-	struct soc_sensor_entry *aux_entry = tzd->devdata;
+	struct soc_sensor_entry *aux_entry = thermal_zone_device_priv(tzd);
 	int ret;
 
 	ret = iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
@@ -250,7 +250,7 @@ static int update_trip_temp(struct soc_sensor_entry *aux_entry,
 static inline int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
 				int temp)
 {
-	return update_trip_temp(tzd->devdata, trip, temp);
+	return update_trip_temp(thermal_zone_device_priv(tzd), trip, temp);
 }
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzd,
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index 8c26f7b2316b..f99dc7e4ae89 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -54,7 +54,7 @@ static int sys_get_trip_temp(struct thermal_zone_device *tzd, int trip,
 	struct intel_soc_dts_sensor_entry *dts;
 	struct intel_soc_dts_sensors *sensors;
 
-	dts = tzd->devdata;
+	dts = thermal_zone_device_priv(tzd);
 	sensors = dts->sensors;
 	mutex_lock(&sensors->dts_update_lock);
 	status = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
@@ -168,7 +168,7 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
 static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
 			     int temp)
 {
-	struct intel_soc_dts_sensor_entry *dts = tzd->devdata;
+	struct intel_soc_dts_sensor_entry *dts = thermal_zone_device_priv(tzd);
 	struct intel_soc_dts_sensors *sensors = dts->sensors;
 	int status;
 
@@ -176,7 +176,7 @@ static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
 		return -EINVAL;
 
 	mutex_lock(&sensors->dts_update_lock);
-	status = update_trip_temp(tzd->devdata, trip, temp,
+	status = update_trip_temp(dts, trip, temp,
 				  dts->trip_types[trip]);
 	mutex_unlock(&sensors->dts_update_lock);
 
@@ -186,9 +186,7 @@ static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
 static int sys_get_trip_type(struct thermal_zone_device *tzd,
 			     int trip, enum thermal_trip_type *type)
 {
-	struct intel_soc_dts_sensor_entry *dts;
-
-	dts = tzd->devdata;
+	struct intel_soc_dts_sensor_entry *dts = thermal_zone_device_priv(tzd);
 
 	*type = dts->trip_types[trip];
 
@@ -200,11 +198,10 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 {
 	int status;
 	u32 out;
-	struct intel_soc_dts_sensor_entry *dts;
+	struct intel_soc_dts_sensor_entry *dts = thermal_zone_device_priv(tzd);
 	struct intel_soc_dts_sensors *sensors;
 	unsigned long raw;
 
-	dts = tzd->devdata;
 	sensors = dts->sensors;
 	status = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
 			       SOC_DTS_OFFSET_TEMP, &out);
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 1c2de84742df..c4ec314441be 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -107,7 +107,7 @@ static struct zone_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 {
-	struct zone_device *zonedev = tzd->devdata;
+	struct zone_device *zonedev = thermal_zone_device_priv(tzd);
 	int val;
 
 	val = intel_tcc_get_temp(zonedev->cpu, true);
@@ -122,7 +122,7 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 static int
 sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
-	struct zone_device *zonedev = tzd->devdata;
+	struct zone_device *zonedev = thermal_zone_device_priv(tzd);
 	u32 l, h, mask, shift, intr;
 	int tj_max, ret;
 
diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 22c9bcb899c3..b5cd2c85e0c3 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -141,7 +141,7 @@ static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 
 static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = tz->devdata;
+	struct k3_thermal_data *data = thermal_zone_device_priv(tz);
 	int ret = 0;
 
 	ret = k3_bgp_read_temp(data, temp);
diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 031ea1091909..5be1f09eeb2c 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -248,7 +248,7 @@ static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 /* Get temperature callback function for thermal zone */
 static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	return k3_bgp_read_temp(tz->devdata, temp);
+	return k3_bgp_read_temp(thermal_zone_device_priv(tz), temp);
 }
 
 static const struct thermal_zone_device_ops k3_of_thermal_ops = {
diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index bec7ec20e79d..92b3ce426b9d 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -27,7 +27,7 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
 			  int *temp)
 {
 	unsigned long reg;
-	struct kirkwood_thermal_priv *priv = thermal->devdata;
+	struct kirkwood_thermal_priv *priv = thermal_zone_device_priv(thermal);
 
 	reg = readl_relaxed(priv->sensor);
 
diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index 6451a55eb582..bf1679765f1b 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -46,7 +46,7 @@ struct max77620_therm_info {
 
 static int max77620_thermal_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct max77620_therm_info *mtherm = tz->devdata;
+	struct max77620_therm_info *mtherm = thermal_zone_device_priv(tz);
 	unsigned int val;
 	int ret;
 
diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index ab730f9552d0..755baa4e5bd2 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -763,7 +763,7 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 
 static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
 {
-	struct mtk_thermal *mt = tz->devdata;
+	struct mtk_thermal *mt = thermal_zone_device_priv(tz);
 	int i;
 	int tempmax = INT_MIN;
 
diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 84ba65a27acf..fb4b1b4db245 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -252,7 +252,7 @@ static u32 lvts_temp_to_raw(int temperature)
 
 static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct lvts_sensor *lvts_sensor = tz->devdata;
+	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
 	void __iomem *msr = lvts_sensor->msr;
 	u32 value;
 
@@ -290,7 +290,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
 
 static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct lvts_sensor *lvts_sensor = tz->devdata;
+	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
 	void __iomem *base = lvts_sensor->base;
 	u32 raw_low = lvts_temp_to_raw(low);
 	u32 raw_high = lvts_temp_to_raw(high);
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 31164ade2dd1..ed204489a950 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -360,7 +360,7 @@ static irqreturn_t adc_tm5_gen2_isr(int irq, void *data)
 
 static int adc_tm5_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct adc_tm5_channel *channel = tz->devdata;
+	struct adc_tm5_channel *channel = thermal_zone_device_priv(tz);
 	int ret;
 
 	if (!channel || !channel->iio)
@@ -642,7 +642,7 @@ static int adc_tm5_gen2_configure(struct adc_tm5_channel *channel, int low, int
 
 static int adc_tm5_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct adc_tm5_channel *channel = tz->devdata;
+	struct adc_tm5_channel *channel = thermal_zone_device_priv(tz);
 	struct adc_tm5_chip *chip;
 	int ret;
 
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index 101c75d0e13f..b196d8d01726 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -187,7 +187,7 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 
 static int qpnp_tm_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct qpnp_tm_chip *chip = tz->devdata;
+	struct qpnp_tm_chip *chip = thermal_zone_device_priv(tz);
 	int ret, mili_celsius;
 
 	if (!temp)
@@ -265,7 +265,7 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
 
 static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
 {
-	struct qpnp_tm_chip *chip = tz->devdata;
+	struct qpnp_tm_chip *chip = thermal_zone_device_priv(tz);
 	struct thermal_trip trip;
 	int ret;
 
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 8020ead2794e..6cc935379f00 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -673,7 +673,7 @@ static irqreturn_t tsens_combined_irq_thread(int irq, void *data)
 
 static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct tsens_sensor *s = tz->devdata;
+	struct tsens_sensor *s = thermal_zone_device_priv(tz);
 	struct tsens_priv *priv = s->priv;
 	struct device *dev = priv->dev;
 	struct tsens_irq_data d;
@@ -1057,7 +1057,7 @@ int __init init_common(struct tsens_priv *priv)
 
 static int tsens_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tsens_sensor *s = tz->devdata;
+	struct tsens_sensor *s = thermal_zone_device_priv(tz);
 	struct tsens_priv *priv = s->priv;
 
 	return priv->ops->get_temp(s, temp);
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 431c29c0898a..d2dc99247f61 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -83,7 +83,7 @@ static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
 
 static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct qoriq_sensor *qsensor = tz->devdata;
+	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 	/*
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index d6b5b59c5c53..2b7537ef141d 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -167,7 +167,7 @@ static int rcar_gen3_thermal_round(int temp)
 
 static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct rcar_gen3_thermal_tsc *tsc = tz->devdata;
+	struct rcar_gen3_thermal_tsc *tsc = thermal_zone_device_priv(tz);
 	int mcelsius, val;
 	int reg;
 
@@ -206,7 +206,7 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 
 static int rcar_gen3_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct rcar_gen3_thermal_tsc *tsc = tz->devdata;
+	struct rcar_gen3_thermal_tsc *tsc = thermal_zone_device_priv(tz);
 	u32 irqmsk = 0;
 
 	if (low != -INT_MAX) {
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 436f5f9cf729..e0440f63ae77 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -101,7 +101,6 @@ struct rcar_thermal_priv {
 	list_for_each_entry(pos, &common->head, list)
 
 #define MCELSIUS(temp)			((temp) * 1000)
-#define rcar_zone_to_priv(zone)		((zone)->devdata)
 #define rcar_priv_to_dev(priv)		((priv)->common->dev)
 #define rcar_has_irq_support(priv)	((priv)->common->base)
 #define rcar_id_to_shift(priv)		((priv)->id * 8)
@@ -273,7 +272,7 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
 
 static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 {
-	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
+	struct rcar_thermal_priv *priv = thermal_zone_device_priv(zone);
 
 	return rcar_thermal_get_current_temp(priv, temp);
 }
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 4b7c43f34d1a..8a51eb26e798 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1213,7 +1213,7 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 
 static int rockchip_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct rockchip_thermal_sensor *sensor = tz->devdata;
+	struct rockchip_thermal_sensor *sensor = thermal_zone_device_priv(tz);
 	struct rockchip_thermal_data *thermal = sensor->thermal;
 	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
 
@@ -1226,7 +1226,7 @@ static int rockchip_thermal_set_trips(struct thermal_zone_device *tz, int low, i
 
 static int rockchip_thermal_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct rockchip_thermal_sensor *sensor = tz->devdata;
+	struct rockchip_thermal_sensor *sensor = thermal_zone_device_priv(tz);
 	struct rockchip_thermal_data *thermal = sensor->thermal;
 	const struct rockchip_tsadc_chip *tsadc = sensor->thermal->chip;
 	int retval;
diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 2e0649f38506..7631430ce8a9 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -75,7 +75,7 @@ static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 reg,
 
 static int rzg2l_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct rzg2l_thermal_priv *priv = tz->devdata;
+	struct rzg2l_thermal_priv *priv = thermal_zone_device_priv(tz);
 	u32 result = 0, dsensor, ts_code_ave;
 	int val, i;
 
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 527d1eb0663a..45e5c840d130 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -645,7 +645,7 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 
 static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct exynos_tmu_data *data = tz->devdata;
+	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
 	int value, ret = 0;
 
 	if (!data || !data->tmu_read)
@@ -723,7 +723,7 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
 
 static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
 {
-	struct exynos_tmu_data *data = tz->devdata;
+	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
 	int ret = -EINVAL;
 
 	if (data->soc == SOC_ARCH_EXYNOS4210)
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 6a722b10d738..653439b965c8 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -31,7 +31,7 @@ struct spear_thermal_dev {
 static inline int thermal_get_temp(struct thermal_zone_device *thermal,
 				int *temp)
 {
-	struct spear_thermal_dev *stdev = thermal->devdata;
+	struct spear_thermal_dev *stdev = thermal_zone_device_priv(thermal);
 
 	/*
 	 * Data are ready to be read after 628 usec from POWERDOWN signal
@@ -48,7 +48,7 @@ static struct thermal_zone_device_ops ops = {
 static int __maybe_unused spear_thermal_suspend(struct device *dev)
 {
 	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
-	struct spear_thermal_dev *stdev = spear_thermal->devdata;
+	struct spear_thermal_dev *stdev = thermal_zone_device_priv(spear_thermal);
 	unsigned int actual_mask = 0;
 
 	/* Disable SPEAr Thermal Sensor */
@@ -64,7 +64,7 @@ static int __maybe_unused spear_thermal_suspend(struct device *dev)
 static int __maybe_unused spear_thermal_resume(struct device *dev)
 {
 	struct thermal_zone_device *spear_thermal = dev_get_drvdata(dev);
-	struct spear_thermal_dev *stdev = spear_thermal->devdata;
+	struct spear_thermal_dev *stdev = thermal_zone_device_priv(spear_thermal);
 	unsigned int actual_mask = 0;
 	int ret = 0;
 
@@ -154,7 +154,7 @@ static int spear_thermal_exit(struct platform_device *pdev)
 {
 	unsigned int actual_mask = 0;
 	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
-	struct spear_thermal_dev *stdev = spear_thermal->devdata;
+	struct spear_thermal_dev *stdev = thermal_zone_device_priv(spear_thermal);
 
 	thermal_zone_device_unregister(spear_thermal);
 
diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index ac884514f116..2fb90fdad76e 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -206,7 +206,7 @@ static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
 
 static int sprd_thm_read_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sprd_thermal_sensor *sen = tz->devdata;
+	struct sprd_thermal_sensor *sen = thermal_zone_device_priv(tz);
 	u32 data;
 
 	data = readl(sen->data->base + SPRD_THM_TEMP(sen->id)) &
diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 1009f08e64e3..6ed393218eb8 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -108,7 +108,7 @@ static int st_thermal_calibration(struct st_thermal_sensor *sensor)
 /* Callback to get temperature from HW*/
 static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
 {
-	struct st_thermal_sensor *sensor = th->devdata;
+	struct st_thermal_sensor *sensor = thermal_zone_device_priv(th);
 	struct device *dev = sensor->dev;
 	unsigned int temp;
 	unsigned int overflow;
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 735401958f01..6f2bad8ef82f 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -303,7 +303,7 @@ static int stm_disable_irq(struct stm_thermal_sensor *sensor)
 
 static int stm_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct stm_thermal_sensor *sensor = tz->devdata;
+	struct stm_thermal_sensor *sensor = thermal_zone_device_priv(tz);
 	u32 itr1, th;
 	int ret;
 
@@ -351,7 +351,7 @@ static int stm_thermal_set_trips(struct thermal_zone_device *tz, int low, int hi
 /* Callback to get temperature from HW */
 static int stm_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct stm_thermal_sensor *sensor = tz->devdata;
+	struct stm_thermal_sensor *sensor = thermal_zone_device_priv(tz);
 	u32 periods;
 	int freqM, ret;
 
diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 497beac63e5d..6b550f0f90bf 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -110,7 +110,7 @@ static int sun50i_h5_calc_temp(struct ths_device *tmdev,
 
 static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tsensor *s = tz->devdata;
+	struct tsensor *s = thermal_zone_device_priv(tz);
 	struct ths_device *tmdev = s->tmdev;
 	int val = 0;
 
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 220873298d77..ea66cba09e56 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -423,7 +423,7 @@ static int translate_temp(u16 val)
 
 static int tegra_thermctl_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct tegra_thermctl_zone *zone = tz->devdata;
+	struct tegra_thermctl_zone *zone = thermal_zone_device_priv(tz);
 	u32 val;
 
 	val = readl(zone->reg);
@@ -584,7 +584,7 @@ static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
 
 static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
 {
-	struct tegra_thermctl_zone *zone = tz->devdata;
+	struct tegra_thermctl_zone *zone = thermal_zone_device_priv(tz);
 	struct tegra_soctherm *ts = zone->ts;
 	struct thermal_trip trip;
 	const struct tegra_tsensor_group *sg = zone->sg;
@@ -658,7 +658,7 @@ static void thermal_irq_disable(struct tegra_thermctl_zone *zn)
 
 static int tegra_thermctl_set_trips(struct thermal_zone_device *tz, int lo, int hi)
 {
-	struct tegra_thermctl_zone *zone = tz->devdata;
+	struct tegra_thermctl_zone *zone = thermal_zone_device_priv(tz);
 	u32 r;
 
 	thermal_irq_disable(zone);
diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index 0b7a1a1948cb..7bd8ea770fa1 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -62,12 +62,14 @@ static int __tegra_bpmp_thermal_get_temp(struct tegra_bpmp_thermal_zone *zone,
 
 static int tegra_bpmp_thermal_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	return __tegra_bpmp_thermal_get_temp(tz->devdata, out_temp);
+	struct tegra_bpmp_thermal_zone *zone = thermal_zone_device_priv(tz);
+	
+	return __tegra_bpmp_thermal_get_temp(zone, out_temp);
 }
 
 static int tegra_bpmp_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct tegra_bpmp_thermal_zone *zone = tz->devdata;
+	struct tegra_bpmp_thermal_zone *zone = thermal_zone_device_priv(tz);
 	struct mrq_thermal_host_to_bpmp_request req;
 	struct tegra_bpmp_message msg;
 	int err;
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index b3218b71b6d9..42c6fb494dd9 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -160,7 +160,7 @@ static void devm_tegra_tsensor_hw_disable(void *data)
 
 static int tegra_tsensor_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	const struct tegra_tsensor_channel *tsc = tz->devdata;
+	const struct tegra_tsensor_channel *tsc = thermal_zone_device_priv(tz);
 	const struct tegra_tsensor *ts = tsc->ts;
 	int err, c1, c2, c3, c4, counter;
 	u32 val;
@@ -218,7 +218,7 @@ static int tegra_tsensor_temp_to_counter(const struct tegra_tsensor *ts, int tem
 
 static int tegra_tsensor_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	const struct tegra_tsensor_channel *tsc = tz->devdata;
+	const struct tegra_tsensor_channel *tsc = thermal_zone_device_priv(tz);
 	const struct tegra_tsensor *ts = tsc->ts;
 	u32 val;
 
diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 323e273e3298..2c283e762d81 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -54,7 +54,7 @@ static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 
 static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct gadc_thermal_info *gti = tz->devdata;
+	struct gadc_thermal_info *gti = thermal_zone_device_priv(tz);
 	int val;
 	int ret;
 
diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index ea616731066c..6845756ad5e7 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -23,7 +23,7 @@ static u32 thermal_mmio_readb(void __iomem *mmio_base)
 static int thermal_mmio_get_temperature(struct thermal_zone_device *tz, int *temp)
 {
 	int t;
-	struct thermal_mmio *sensor = tz->devdata;
+	struct thermal_mmio *sensor = thermal_zone_device_priv(tz);
 
 	t = sensor->read_mmio(sensor->mmio_base) & sensor->mask;
 	t *= sensor->factor;
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 8a9055bd376e..3e998c9799bb 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -68,7 +68,7 @@ static inline int ti_thermal_hotspot_temperature(int t, int s, int c)
 static inline int __ti_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct thermal_zone_device *pcb_tz = NULL;
-	struct ti_thermal_data *data = tz->devdata;
+	struct ti_thermal_data *data = thermal_zone_device_priv(tz);
 	struct ti_bandgap *bgp;
 	const struct ti_temp_sensor *s;
 	int ret, tmp, slope, constant;
@@ -109,7 +109,7 @@ static inline int __ti_thermal_get_temp(struct thermal_zone_device *tz, int *tem
 
 static int __ti_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
 {
-	struct ti_thermal_data *data = tz->devdata;
+	struct ti_thermal_data *data = thermal_zone_device_priv(tz);
 	struct ti_bandgap *bgp;
 	int id, tr, ret = 0;
 
diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 47801841b3f5..aef6119cc004 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -187,7 +187,7 @@ static void uniphier_tm_disable_sensor(struct uniphier_tm_dev *tdev)
 
 static int uniphier_tm_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct uniphier_tm_dev *tdev = tz->devdata;
+	struct uniphier_tm_dev *tdev = thermal_zone_device_priv(tz);
 	struct regmap *map = tdev->regmap;
 	int ret;
 	u32 temp;
-- 
2.34.1

