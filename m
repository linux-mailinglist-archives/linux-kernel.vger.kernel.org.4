Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0292C6A3511
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBZW4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBZWzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:55:43 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED42D306
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so5934526wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noGAcNm9i/TJIg+l6poaaVPqMFcIQlGqlbm0Xx4JGsg=;
        b=Atf/Nqa5UNuh+s6fLpEF6QW87xZW5fN+C69FaTOwwqTO74TOa3Vd4QEaT5qHUMzRFj
         Qal/rqygkcPbMJ0B2CIvJ/RjFbis+CoP9PldKHVB+HGEQouF+OFnVx8brKwxb26XCVMR
         6Oxlbc8fkMI03L6nR7xzavw9DNyPetuIhD3FpFCC46+zl1rWZdD6aDirBltiJQOaQR4v
         HmIFRmU2agvAy+tDrnjRgh3HKyTb8ygSgp54lZhFZN8oV2FGZ3XKTtFUgX9ciLT5fZyk
         RfdE/nc+ffafr84jKxbnPDAVu2840n9hs59IILpkDltxmhCqdtjQd15E7ndbQpb7fYPK
         g7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noGAcNm9i/TJIg+l6poaaVPqMFcIQlGqlbm0Xx4JGsg=;
        b=GAvk2WeqBlpEHNwrmkT9Uf4lhQ2XYhP0wK6z4tJZGZHwRqUqyrK3VOXu5xxth7pHlW
         1gBAMSJf1u7xY68kMJIcU0RNADqmLripi/BWWNDpFINy1j8Uk1hel4JxT899nyRtJa7d
         x0VH7wyphq+nnoNstgJ+5v/6twU80DrslN1N2b5FNCN4eDoEnL9EtY2h49AKpuYUf/2x
         /TpkDd1EirTux+1CckYNZ3tu5GO6chIYZGJ8vPnm+LTd0Mmnmyb4q1f0eQQYcXNyixHw
         1Eh0wNl99Xpl29ZH8MKBgN6ER+J3AmacmX4oiDdI1GctlSBug6YfA49E5FfAqSp7QY3k
         XqNg==
X-Gm-Message-State: AO0yUKWvPejEVZASirxVlQFQxdAjoD6yEyB5E0zyLWeShNwwdpVPTnUN
        XM2CHa+wJiy+L7I9ZQXl+78hpQ==
X-Google-Smtp-Source: AK7set/gLMMuJmDxUpHEa1263AmSza+LiGZ4tjKWcDj14SVxcGIh9A3CRwIfMCIYx0UC/x0rI0M9wg==
X-Received: by 2002:a05:600c:154e:b0:3eb:29fe:f91e with SMTP id f14-20020a05600c154e00b003eb29fef91emr8135692wmg.21.1677452101887;
        Sun, 26 Feb 2023 14:55:01 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:01 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-amlogic@lists.infradead.org (open list:THERMAL DRIVER FOR AMLOGIC
        SOCS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH v3 08/20] thermal/hwmon: Use the right device for devm_thermal_add_hwmon_sysfs()
Date:   Sun, 26 Feb 2023 23:53:54 +0100
Message-Id: <20230226225406.979703-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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

The devres variant of thermal_add_hwmon_sysfs() only takes the thermal
zone structure pointer as parameter.

Actually, it uses the tz->device to add it in the devres list.

It is preferable to use the device registering the thermal zone
instead of the thermal zone device itself. That prevents the driver
accessing the thermal zone structure internals and it is from my POV
more correct regarding how devm_ is used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #amlogic_thermal
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com> #sun8i_thermal
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> #MediaTek auxadc
---
 drivers/thermal/amlogic_thermal.c                  | 2 +-
 drivers/thermal/imx8mm_thermal.c                   | 2 +-
 drivers/thermal/imx_sc_thermal.c                   | 2 +-
 drivers/thermal/k3_bandgap.c                       | 2 +-
 drivers/thermal/mediatek/auxadc_thermal.c          | 2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 2 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        | 2 +-
 drivers/thermal/qcom/tsens.c                       | 2 +-
 drivers/thermal/qoriq_thermal.c                    | 2 +-
 drivers/thermal/sun8i_thermal.c                    | 2 +-
 drivers/thermal/tegra/tegra30-tsensor.c            | 2 +-
 drivers/thermal/thermal_hwmon.c                    | 4 ++--
 drivers/thermal/thermal_hwmon.h                    | 4 ++--
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 +-
 14 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index dfcc93e45cdd..4bf36386462f 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -285,7 +285,7 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(pdata->tzd))
+	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd))
 		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
 
 	ret = amlogic_thermal_initialize(pdata);
diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index efa1a4ffc368..e0de6ac49469 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -343,7 +343,7 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 		}
 		tmu->sensors[i].hw_id = i;
 
-		if (devm_thermal_add_hwmon_sysfs(tmu->sensors[i].tzd))
+		if (devm_thermal_add_hwmon_sysfs(&pdev->dev, tmu->sensors[i].tzd))
 			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
 	}
 
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 2d7a6bd2846b..839bb9958f60 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -116,7 +116,7 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(sensor->tzd))
+		if (devm_thermal_add_hwmon_sysfs(&pdev->dev, sensor->tzd))
 			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
 	}
 
diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index b5cd2c85e0c3..791210458606 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -222,7 +222,7 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 			goto err_alloc;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(data[id].tzd))
+		if (devm_thermal_add_hwmon_sysfs(dev, data[id].tzd))
 			dev_warn(dev, "Failed to add hwmon sysfs attributes\n");
 	}
 
diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 755baa4e5bd2..7b146350050d 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1210,7 +1210,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_peri_therm;
 	}
 
-	ret = devm_thermal_add_hwmon_sysfs(tzdev);
+	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
 	if (ret)
 		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
 
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index ed204489a950..5749149ae2e4 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -689,7 +689,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 			return PTR_ERR(tzd);
 		}
 		adc_tm->channels[i].tzd = tzd;
-		if (devm_thermal_add_hwmon_sysfs(tzd))
+		if (devm_thermal_add_hwmon_sysfs(adc_tm->dev, tzd))
 			dev_warn(adc_tm->dev,
 				 "Failed to add hwmon sysfs attributes\n");
 	}
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index b196d8d01726..0f88e98428ac 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -459,7 +459,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(chip->tz_dev))
+	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev))
 		dev_warn(&pdev->dev,
 			 "Failed to add hwmon sysfs attributes\n");
 
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6cc935379f00..d3218127e617 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1189,7 +1189,7 @@ static int tsens_register(struct tsens_priv *priv)
 		if (priv->ops->enable)
 			priv->ops->enable(priv, i);
 
-		if (devm_thermal_add_hwmon_sysfs(tzd))
+		if (devm_thermal_add_hwmon_sysfs(priv->dev, tzd))
 			dev_warn(priv->dev,
 				 "Failed to add hwmon sysfs attributes\n");
 	}
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index d2dc99247f61..e58756323457 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -157,7 +157,7 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 			return ret;
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(tzd))
+		if (devm_thermal_add_hwmon_sysfs(dev, tzd))
 			dev_warn(dev,
 				 "Failed to add hwmon sysfs attributes\n");
 
diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 6b550f0f90bf..793ddce72132 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -475,7 +475,7 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 		if (IS_ERR(tmdev->sensor[i].tzd))
 			return PTR_ERR(tmdev->sensor[i].tzd);
 
-		if (devm_thermal_add_hwmon_sysfs(tmdev->sensor[i].tzd))
+		if (devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd))
 			dev_warn(tmdev->dev,
 				 "Failed to add hwmon sysfs attributes\n");
 	}
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 42c6fb494dd9..4b2ea17910cd 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -528,7 +528,7 @@ static int tegra_tsensor_register_channel(struct tegra_tsensor *ts,
 		return 0;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(tsc->tzd))
+	if (devm_thermal_add_hwmon_sysfs(ts->dev, tsc->tzd))
 		dev_warn(ts->dev, "failed to add hwmon sysfs attributes\n");
 
 	return 0;
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index c594c42bea6d..964db7941e31 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -263,7 +263,7 @@ static void devm_thermal_hwmon_release(struct device *dev, void *res)
 	thermal_remove_hwmon_sysfs(*(struct thermal_zone_device **)res);
 }
 
-int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+int devm_thermal_add_hwmon_sysfs(struct device *dev, struct thermal_zone_device *tz)
 {
 	struct thermal_zone_device **ptr;
 	int ret;
@@ -280,7 +280,7 @@ int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	}
 
 	*ptr = tz;
-	devres_add(&tz->device, ptr);
+	devres_add(dev, ptr);
 
 	return ret;
 }
diff --git a/drivers/thermal/thermal_hwmon.h b/drivers/thermal/thermal_hwmon.h
index 1a9d65f6a6a8..b429f6e7abdb 100644
--- a/drivers/thermal/thermal_hwmon.h
+++ b/drivers/thermal/thermal_hwmon.h
@@ -17,7 +17,7 @@
 
 #ifdef CONFIG_THERMAL_HWMON
 int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
-int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
+int devm_thermal_add_hwmon_sysfs(struct device *dev, struct thermal_zone_device *tz);
 void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz);
 #else
 static inline int
@@ -27,7 +27,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 }
 
 static inline int
-devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
+devm_thermal_add_hwmon_sysfs(struct device *dev, struct thermal_zone_device *tz)
 {
 	return 0;
 }
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 3e998c9799bb..216b29068b08 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -182,7 +182,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
 
-	if (devm_thermal_add_hwmon_sysfs(data->ti_thermal))
+	if (devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal))
 		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
 
 	return 0;
-- 
2.34.1

