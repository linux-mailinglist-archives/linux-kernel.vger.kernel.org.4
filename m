Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18076A6BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCALjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjCALiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:38:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26963CE0B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677670728; x=1709206728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5tklInZTjxW7nUOT7xUU9g3nrOpxKYCG1GaGB1k0my8=;
  b=nNgHoJw9tSmNmZWkIEx550NuYE+D4164Oq7oEnrT/5iRZ5BcM8IRSKjx
   +OIzcM9ioQsGKQkycjszzroVCXwWA1bqv+6/0XO0M3FcokzyfPaDbinHq
   NFhUNpvnVqh54da27dLk4Qf6rM8Jwe3JW0uXU6oTeudatKQL5GTiXEVn1
   Zbnm8GzHq5hTkkKOHtZEypyV2q5iupaRm5E4flfDT8otmkGSmrKHqST20
   keEZ935Mm32j57B5IHOv3IIhrCxGPEyy2PVBfuwsDYgfVCZ2Wd06e5EYn
   iY4R4YO57Nfth+ls+RFMEhkZRyg8Giof06X5YqZgAubZVJqx8jMFfXvzj
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="scan'208";a="139640258"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 04:38:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 04:38:41 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 04:38:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/8] ASoC: mchp-pdmc: use FIELD_PREP() where possible
Date:   Wed, 1 Mar 2023 13:38:03 +0200
Message-ID: <20230301113807.24036-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301113807.24036-1-claudiu.beznea@microchip.com>
References: <20230301113807.24036-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use FIELD_PREP() macro where possible instead of driver local defined
macros.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index 1aed3baa9369..6ec5324fd65e 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/sound/microchip,pdmc.h>
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -49,8 +50,6 @@
 #define MCHP_PDMC_MR_OSR256		(3 << 16)
 
 #define MCHP_PDMC_MR_SINCORDER_MASK	GENMASK(23, 20)
-#define MCHP_PDMC_MR_SINCORDER(order)	(((order) << 20) & \
-					 MCHP_PDMC_MR_SINCORDER_MASK)
 
 #define MCHP_PDMC_MR_SINC_OSR_MASK	GENMASK(27, 24)
 #define MCHP_PDMC_MR_SINC_OSR_DIS	(0 << 24)
@@ -62,8 +61,6 @@
 #define MCHP_PDMC_MR_SINC_OSR_256	(6 << 24)
 
 #define MCHP_PDMC_MR_CHUNK_MASK		GENMASK(31, 28)
-#define MCHP_PDMC_MR_CHUNK(chunk)	(((chunk) << 28) & \
-					 MCHP_PDMC_MR_CHUNK_MASK)
 
 /*
  * ---- Configuration Register (Read/Write) ----
@@ -617,10 +614,10 @@ static int mchp_pdmc_hw_params(struct snd_pcm_substream *substream,
 
 	mr_val |= mchp_pdmc_mr_set_osr(dd->audio_filter_en, osr);
 
-	mr_val |= MCHP_PDMC_MR_SINCORDER(dd->sinc_order);
+	mr_val |= FIELD_PREP(MCHP_PDMC_MR_SINCORDER_MASK, dd->sinc_order);
 
 	dd->addr.maxburst = mchp_pdmc_period_to_maxburst(snd_pcm_lib_period_bytes(substream));
-	mr_val |= MCHP_PDMC_MR_CHUNK(dd->addr.maxburst);
+	mr_val |= FIELD_PREP(MCHP_PDMC_MR_CHUNK_MASK, dd->addr.maxburst);
 	dev_dbg(comp->dev, "maxburst set to %d\n", dd->addr.maxburst);
 
 	snd_soc_component_update_bits(comp, MCHP_PDMC_MR,
-- 
2.34.1

