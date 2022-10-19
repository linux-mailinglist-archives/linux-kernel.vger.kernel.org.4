Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7E7604948
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiJSOd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiJSOdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:33:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E5B193744
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:18:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j16so29402290wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyeoHLNYgE+7jRWrI7Gid0gjC7DyyjDTDuyVioxNv2s=;
        b=fd2H3oNq5MmlrHBIUeEAt5HznMAZ2POQtEIeR09QEcojJHXyuzAyCpqcKtxRmHv939
         e4Z7TpU6LrsAVi7ME645aV5eRSukfeCtUwEzga1p+sF2bPzK9BT0F/bqlpvT7XTnlDMV
         U6IZmMD4pxg5qJh2kGnDnP+Xuh8nhP9JM4u68gkEm0H779qBk+j1YzU3ycjtIOVxWI0h
         /EJhekxrIKT0c9Lm9QokfFAM3McA67e5PccyWNPZoTgFMgJ9NmA1jZ0zHanvRL5oNODZ
         1Btlq0O8pbi8sKHIIhS7KNFnjAl7c3zzDyMjHImKcHVFgfGedsSQahyhJrmsMtCeF0pm
         JDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyeoHLNYgE+7jRWrI7Gid0gjC7DyyjDTDuyVioxNv2s=;
        b=JnMjMnx+JcE+aHlvu4iuivBm+GbdZxm+5bQI/lOjkwiBVIEajB7PPv7nIN0UeQjJXD
         ys230ZXdwzfXpzNAOe51ejSVyhGizkX4zZKgsyBxCD4JL7f1J8T0GVJ3ND7esNqtCYNY
         1mCfiN16vstadxJVSq6SJgSXLa1/Asi1r2O+PXYMOuLlFPg5zserehOtNwvQssFKA54R
         uLNn0ozDcLeS2ik6qn0XQEVr415cE4nl3XBJrUCi1jz/M1MEolWIYD+J5Xa92lwEuIoP
         PuEoilw6yU3SECsWFaMb+GX1jTLzqzupSkulCaTKtFlYQY9f/mzdVdsHRRjfgpoC5Bys
         34+A==
X-Gm-Message-State: ACrzQf0qV0QxCETGv01OshI1nRtD7IlNN2Jokew8hMPEPN7yO8+Y+jM2
        4OJGBPMvPW15Pu16imYZkkFCAA==
X-Google-Smtp-Source: AMsMyM6Y0dtt2fThAblWCgNb77KCrIudxhVEmZ7gKIrjKDhykgfz+sMekViuzb9RepprVLdj7p2OkA==
X-Received: by 2002:a5d:6a48:0:b0:22e:34f0:617f with SMTP id t8-20020a5d6a48000000b0022e34f0617fmr5220654wrw.644.1666189079254;
        Wed, 19 Oct 2022 07:17:59 -0700 (PDT)
Received: from [127.0.1.1] (rtr.23.90.200.126.unyc.it. [23.90.200.126])
        by smtp.googlemail.com with ESMTPSA id n9-20020a05600c3b8900b003b4ff30e566sm2126577wms.3.2022.10.19.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:17:58 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Wed, 19 Oct 2022 16:17:55 +0200
Subject: [PATCH v6 2/4] thermal: mediatek: control buffer enablement tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-up-i350-thermal-bringup-v6-2-c87b9f75550b@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v6-0-c87b9f75550b@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v6-0-c87b9f75550b@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666189076; l=2549;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=BUYgiWUyEmLmv5YqBlzSOjPnRULIXZAPNGFdkdhmkOQ=;
 b=DuTCH2nYQby2Rp3rUYfbKfiiNFfGGwSHOKQAOBeLAf4oWTYlJ5qTJGiqvCQvObkl5s1dpqQ5GpOv
 3eK/2IoPDmqAKTAP4GM6xGNbfcEtstHqPfVKPpPJpZh3kiuqEiPL
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

Add logic in order to be able to turn on the control buffer on MT8365.
This change now allows to have control buffer support for MTK_THERMAL_V1,
and it allows to define the register offset, and mask used to enable it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mtk_thermal.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 8440692e3890..d8ddceb75372 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -271,6 +271,9 @@ struct mtk_thermal_data {
 	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 	enum mtk_thermal_version version;
+	u32 apmixed_buffer_ctl_reg;
+	u32 apmixed_buffer_ctl_mask;
+	u32 apmixed_buffer_ctl_set;
 };
 
 struct mtk_thermal {
@@ -514,6 +517,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
 	.adcpnp = mt7622_adcpnp,
 	.sensor_mux_values = mt7622_mux_values,
 	.version = MTK_THERMAL_V2,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
+	.apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
+	.apmixed_buffer_ctl_set = BIT(0),
 };
 
 /*
@@ -963,14 +969,18 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
 
-static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
+static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
+				       void __iomem *apmixed_base)
 {
-	int tmp;
+	u32 tmp;
+
+	if (!mt->conf->apmixed_buffer_ctl_reg)
+		return;
 
-	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
-	tmp &= ~(0x37);
-	tmp |= 0x1;
-	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
+	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
+	tmp &= mt->conf->apmixed_buffer_ctl_mask;
+	tmp |= mt->conf->apmixed_buffer_ctl_set;
+	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
 	udelay(200);
 }
 
@@ -1070,8 +1080,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_auxadc;
 	}
 
+	mtk_thermal_turn_on_buffer(mt, apmixed_base);
+
 	if (mt->conf->version == MTK_THERMAL_V2) {
-		mtk_thermal_turn_on_buffer(apmixed_base);
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
 

-- 
b4 0.10.1
