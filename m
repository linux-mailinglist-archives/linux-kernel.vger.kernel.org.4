Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BEF6F6271
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 02:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjEDAtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 20:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjEDAtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 20:49:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3900F107;
        Wed,  3 May 2023 17:49:05 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 70741660484E;
        Thu,  4 May 2023 01:49:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683161344;
        bh=u8XBXZldjo0pv5hTDvJ4RWujEWWiFgrxeXoopBw2qJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9a8FxggP8hhRCVLp6wIzFVNcqkmdoUIfr9Bvp1Ry6BcXZ/BCn7G3mm05+JrU3c4b
         auL7Q+cfn1fZLP98Lss+/LpIzInsDyMoXGgPDI34PGglmFuIgJhEqG538mQXirmmAt
         BWkoNI0kmYsT/RjyhqQAUi0WnyR440ATT5wtx4Tzt/8e4QIc39fXoHT8vFYhTJZMjV
         HVTPvEPxh4ivWPGEaRD002ALtrm37HrbZiqsdC+I4LGMt10bJf5fiztiTe0JGx5eI0
         yo0O2ndkco5fctdiSTBSON05ULvdBL1pin6yAmeXYStf0jbHIRZxJl5CVNOn6j+xw9
         4yc7M1V5d2IKw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/6] thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate mode
Date:   Wed,  3 May 2023 20:48:48 -0400
Message-Id: <20230504004852.627049-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504004852.627049-1-nfraprado@collabora.com>
References: <20230504004852.627049-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each controller can be configured to operate on immediate or filtered
mode. On filtered mode, the sensors are enabled by setting the
corresponding bits in MONCTL0, while on immediate mode, by setting
MSRCTL1.

Previously, the code would set MSRCTL1 for all four sensors when
configured to immediate mode, but given that the controller might not
have all four sensors connected, this would cause interrupts to trigger
for non-existent sensors. Fix this by handling the MSRCTL1 register
analogously to the MONCTL0: only enable the sensors that were declared.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---

(no changes since v1)

 drivers/thermal/mediatek/lvts_thermal.c | 50 +++++++++++++------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 2988f201633a..f7d998a45ea0 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -922,24 +922,6 @@ static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 			LVTS_HW_FILTER << 3 | LVTS_HW_FILTER;
 	writel(value, LVTS_MSRCTL0(lvts_ctrl->base));
 
-	/*
-	 * LVTS_MSRCTL1 : Measurement control
-	 *
-	 * Bits:
-	 *
-	 * 9: Ignore MSRCTL0 config and do immediate measurement on sensor3
-	 * 6: Ignore MSRCTL0 config and do immediate measurement on sensor2
-	 * 5: Ignore MSRCTL0 config and do immediate measurement on sensor1
-	 * 4: Ignore MSRCTL0 config and do immediate measurement on sensor0
-	 *
-	 * That configuration will ignore the filtering and the delays
-	 * introduced below in MONCTL1 and MONCTL2
-	 */
-	if (lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE) {
-		value = BIT(9) | BIT(6) | BIT(5) | BIT(4);
-		writel(value, LVTS_MSRCTL1(lvts_ctrl->base));
-	}
-
 	/*
 	 * LVTS_MONCTL1 : Period unit and group interval configuration
 	 *
@@ -1004,6 +986,8 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 	struct lvts_sensor *lvts_sensors = lvts_ctrl->sensors;
 	struct thermal_zone_device *tz;
 	u32 sensor_map = 0;
+	u32 sensor_map_bits[][4] = {{BIT(4), BIT(5), BIT(6), BIT(9)},
+				    {BIT(0), BIT(1), BIT(2), BIT(3)}};
 	int i;
 
 	for (i = 0; i < lvts_ctrl->num_lvts_sensor; i++) {
@@ -1040,20 +1024,38 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 		 * map, so we can enable the temperature monitoring in
 		 * the hardware thermal controller.
 		 */
-		sensor_map |= BIT(i);
+		sensor_map |= sensor_map_bits[lvts_ctrl->mode][i];
 	}
 
 	/*
-	 * Bits:
-	 *      9: Single point access flow
-	 *    0-3: Enable sensing point 0-3
-	 *
 	 * The initialization of the thermal zones give us
 	 * which sensor point to enable. If any thermal zone
 	 * was not described in the device tree, it won't be
 	 * enabled here in the sensor map.
 	 */
-	writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
+	if (lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE) {
+		/*
+		 * LVTS_MSRCTL1 : Measurement control
+		 *
+		 * Bits:
+		 *
+		 * 9: Ignore MSRCTL0 config and do immediate measurement on sensor3
+		 * 6: Ignore MSRCTL0 config and do immediate measurement on sensor2
+		 * 5: Ignore MSRCTL0 config and do immediate measurement on sensor1
+		 * 4: Ignore MSRCTL0 config and do immediate measurement on sensor0
+		 *
+		 * That configuration will ignore the filtering and the delays
+		 * introduced in MONCTL1 and MONCTL2
+		 */
+		writel(sensor_map, LVTS_MSRCTL1(lvts_ctrl->base));
+	} else {
+		/*
+		 * Bits:
+		 *      9: Single point access flow
+		 *    0-3: Enable sensing point 0-3
+		 */
+		writel(sensor_map | BIT(9), LVTS_MONCTL0(lvts_ctrl->base));
+	}
 
 	return 0;
 }
-- 
2.40.1

