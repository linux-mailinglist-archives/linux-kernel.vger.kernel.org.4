Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE2564C99E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbiLNNCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiLNNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:02:11 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48795313;
        Wed, 14 Dec 2022 05:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1671022886; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xz93IPFieV9WZW5Gg4FpvmQyVwuBdgxq4Bwe+uEuf+8=;
        b=CXGjkewKSL1heZ8BJd/MmWY9TG4IYsU+t6d6zAoCqRIO/38IJF0Vf0XAOaGlMhzmwubZau
        aUuw1svfwrCu7RL+gHSITIsyKtt/BFIbrSaT6NXuCjLsG+RMfeHNmpkcN+1f/CbST2CRJ9
        WfFnBedMnAlwEOjVq7eiXeKw81g6O4w=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 09/10] drm: bridge: it66121: Move VID/PID to new it66121_chip_info structure
Date:   Wed, 14 Dec 2022 14:01:22 +0100
Message-Id: <20221214130122.12911-1-paul@crapouillou.net>
In-Reply-To: <20221214125821.12489-1-paul@crapouillou.net>
References: <20221214125821.12489-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will make it easier later to introduce support for new chips in
this driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 7972003d4776..43b027b85b8e 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -35,10 +35,6 @@
 #define IT66121_DEVICE_ID0_REG			0x02
 #define IT66121_DEVICE_ID1_REG			0x03
 
-#define IT66121_VENDOR_ID0			0x54
-#define IT66121_VENDOR_ID1			0x49
-#define IT66121_DEVICE_ID0			0x12
-#define IT66121_DEVICE_ID1			0x06
 #define IT66121_REVISION_MASK			GENMASK(7, 4)
 #define IT66121_DEVICE_ID1_MASK			GENMASK(3, 0)
 
@@ -286,13 +282,12 @@
 #define IT66121_AUD_SWL_16BIT			0x2
 #define IT66121_AUD_SWL_NOT_INDICATED		0x0
 
-#define IT66121_VENDOR_ID0			0x54
-#define IT66121_VENDOR_ID1			0x49
-#define IT66121_DEVICE_ID0			0x12
-#define IT66121_DEVICE_ID1			0x06
-#define IT66121_DEVICE_MASK			0x0F
 #define IT66121_AFE_CLK_HIGH			80000 /* Khz */
 
+struct it66121_chip_info {
+	u16 vid, pid;
+};
+
 struct it66121_ctx {
 	struct regmap *regmap;
 	struct drm_bridge bridge;
@@ -311,6 +306,7 @@ struct it66121_ctx {
 		u8 swl;
 		bool auto_cts;
 	} audio;
+	const struct it66121_chip_info *info;
 };
 
 static const struct regmap_range_cfg it66121_regmap_banks[] = {
@@ -1451,6 +1447,7 @@ static const char * const it66121_supplies[] = {
 
 static int it66121_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
 	struct device_node *ep;
 	int ret;
@@ -1472,6 +1469,7 @@ static int it66121_probe(struct i2c_client *client)
 
 	ctx->dev = dev;
 	ctx->client = client;
+	ctx->info = (const struct it66121_chip_info *) id->driver_data;
 
 	of_property_read_u32(ep, "bus-width", &ctx->bus_width);
 	of_node_put(ep);
@@ -1523,8 +1521,8 @@ static int it66121_probe(struct i2c_client *client)
 	revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
 	device_ids[1] &= IT66121_DEVICE_ID1_MASK;
 
-	if (vendor_ids[0] != IT66121_VENDOR_ID0 || vendor_ids[1] != IT66121_VENDOR_ID1 ||
-	    device_ids[0] != IT66121_DEVICE_ID0 || device_ids[1] != IT66121_DEVICE_ID1) {
+	if ((vendor_ids[1] << 8 | vendor_ids[0]) != ctx->info->vid ||
+	    (device_ids[1] << 8 | device_ids[0]) != ctx->info->pid) {
 		return -ENODEV;
 	}
 
@@ -1563,8 +1561,13 @@ static const struct of_device_id it66121_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, it66121_dt_match);
 
+static const struct it66121_chip_info it66121_chip_info = {
+	.vid = 0x4954,
+	.pid = 0x0612,
+};
+
 static const struct i2c_device_id it66121_id[] = {
-	{ "it66121", 0 },
+	{ "it66121", (kernel_ulong_t) &it66121_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, it66121_id);
-- 
2.35.1

