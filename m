Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1146E72EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjDSGMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjDSGL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:11:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7459F5;
        Tue, 18 Apr 2023 23:11:56 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 92E6A660320D;
        Wed, 19 Apr 2023 07:11:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681884714;
        bh=nTpGrftsRIa7La3Ejz06bZ6jB8zQMnXxmXPyKaNjl/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M74pTcM2OYwN/86mnbjQC8NtUEu1+y2BszQaVWA5XmA58kF/QX36GJS5PufvkkNDK
         W/xIK9tgxVMdjwSF3zgk+KSoLSjAZ8HSSniKJ7krsOM/67iEjr6/ApL4v8rdMWCtP1
         DZPI2v+REMfaovVo1BIJHqYFb/F7aFEXou/FOxisRP9C72l0SJI9N8CE7zNOdTcpdU
         FIZ30HuKz+bNUqZTuS14AMGZxC3yZo9zML61T4dhuQDdMwpIHbdS/MXv5KofNmAu6D
         S9Oizd5d7KETbIdFVbLbBloacfuYcr6xrd3KJNEJhbFgdnMsSQINIIqnSYfpT/RYW5
         Om0+KjwDsCTsQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        aouledameur@baylibre.com, bchihi@baylibre.com,
        daniel@makrotopia.org, ye.xingchen@zte.com.cn, hsinyi@chromium.org,
        michael.kao@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] thermal/drivers/mediatek: Add temperature constraints to validate read
Date:   Wed, 19 Apr 2023 08:11:46 +0200
Message-Id: <20230419061146.22246-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419061146.22246-1-angelogioacchino.delregno@collabora.com>
References: <20230419061146.22246-1-angelogioacchino.delregno@collabora.com>
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

The AUXADC thermal v1 allows reading temperature range between -20°C to
150°C and any value out of this range is invalid.

Add new definitions for MT8173_TEMP_{MIN_MAX} and a new small helper
mtk_thermal_temp_is_valid() to check if new readings are in range: if
not, we tell to the API that the reading is invalid by returning
THERMAL_TEMP_INVALID.

It was chosen to introduce the helper function because, even though this
temperature range is realistically ok for all, it comes from a downstream
kernel driver for version 1, but here we also support v2 and v3 which may
may have wider constraints.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 24 +++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 3c959a827451..e908c8e9d558 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -116,6 +116,10 @@
 /* The calibration coefficient of sensor  */
 #define MT8173_CALIBRATION	165
 
+/* Valid temperatures range */
+#define MT8173_TEMP_MIN		-20000
+#define MT8173_TEMP_MAX		150000
+
 /*
  * Layout of the fuses providing the calibration data
  * These macros could be used for MT8183, MT8173, MT2701, and MT2712.
@@ -689,6 +693,11 @@ static const struct mtk_thermal_data mt7986_thermal_data = {
 	.version = MTK_THERMAL_V3,
 };
 
+static bool mtk_thermal_temp_is_valid(int temp)
+{
+	return (temp >= MT8173_TEMP_MIN) && (temp <= MT8173_TEMP_MAX);
+}
+
 /**
  * raw_to_mcelsius_v1 - convert a raw ADC value to mcelsius
  * @mt:	The thermal controller
@@ -815,14 +824,17 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 		temp = mt->raw_to_mcelsius(
 			mt, conf->bank_data[bank->id].sensors[i], raw);
 
-
 		/*
-		 * The first read of a sensor often contains very high bogus
-		 * temperature value. Filter these out so that the system does
-		 * not immediately shut down.
+		 * Depending on the filt/sen intervals and ADC polling time,
+		 * we may need up to 60 milliseconds after initialization: this
+		 * will result in the first reading containing an out of range
+		 * temperature value.
+		 * Validate the reading to both address the aforementioned issue
+		 * and to eventually avoid bogus readings during runtime in the
+		 * event that the AUXADC gets unstable due to high EMI, etc.
 		 */
-		if (temp > 200000)
-			temp = 0;
+		if (!mtk_thermal_temp_is_valid(temp))
+			temp = THERMAL_TEMP_INVALID;
 
 		if (temp > max)
 			max = temp;
-- 
2.40.0

