Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5386A6BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjCALil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCALii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:38:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953C23B3D7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677670716; x=1709206716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kN9zmelvhJBgNAO5EUo3ZIXHZ2yIk12eJ4vuPHyz4Js=;
  b=SpMIzKhnav5oVN3ppizKwNidZeFCmV67JTf5yDC5FrwrEYYqgvhb29pq
   CB04iYDj8h052czg2WrPmsjjbIcK5TdUMoeuCWZtdUK+/FoZecZa2e+R4
   HIynW1HF2s2N/z9D90G1zI+fTeJf/EjUQrQNSwQKe+qWMiaz7BRKPW00C
   I1Lw0vIB39I8eU0PDLU3S12ewp+Jhwl0iBUSz55ir01yIvyecf8zSLewR
   ODCinM40iuEREoWHyLoqOJgGiJ4zCahxMF7pb2wLuB3Sk88LR8EJ7/2yb
   XbN4cfkGT1lyGVaaT7anved/j2kfih+BGNqSm4A/RGoTO+RsM4VTyJN+T
   w==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="scan'208";a="202995009"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 04:38:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 04:38:30 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 04:38:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/8] ASoC: mchp-spdiftx: use FIELD_PREP() where possible
Date:   Wed, 1 Mar 2023 13:38:00 +0200
Message-ID: <20230301113807.24036-2-claudiu.beznea@microchip.com>
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

Use directly FIELD_PREP() marco where possible. There is no need for
the extra wrappers.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 20d135c718b0..bf4252412f9f 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -72,11 +72,9 @@
 
 /* Valid Bits per Sample */
 #define SPDIFTX_MR_VBPS_MASK		GENMASK(13, 8)
-#define SPDIFTX_MR_VBPS(bps)		FIELD_PREP(SPDIFTX_MR_VBPS_MASK, bps)
 
 /* Chunk Size */
 #define SPDIFTX_MR_CHUNK_MASK		GENMASK(19, 16)
-#define SPDIFTX_MR_CHUNK(size)		FIELD_PREP(SPDIFTX_MR_CHUNK_MASK, size)
 
 /* Validity Bits for Channels 1 and 2 */
 #define SPDIFTX_MR_VALID1			BIT(24)
@@ -89,7 +87,6 @@
 
 /* Bytes per Sample */
 #define SPDIFTX_MR_BPS_MASK		GENMASK(29, 28)
-#define SPDIFTX_MR_BPS(bytes)		FIELD_PREP(SPDIFTX_MR_BPS_MASK, (bytes - 1))
 
 /*
  * ---- Interrupt Enable/Disable/Mask/Status Register (Write/Read-only) ----
@@ -402,47 +399,47 @@ static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
 			params_channels(params));
 		return -EINVAL;
 	}
-	mr |= SPDIFTX_MR_CHUNK(dev->playback.maxburst);
+	mr |= FIELD_PREP(SPDIFTX_MR_CHUNK_MASK, dev->playback.maxburst);
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
-		mr |= SPDIFTX_MR_VBPS(8);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 8);
 		break;
 	case SNDRV_PCM_FORMAT_S16_BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S16_LE:
-		mr |= SPDIFTX_MR_VBPS(16);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 16);
 		break;
 	case SNDRV_PCM_FORMAT_S18_3BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S18_3LE:
-		mr |= SPDIFTX_MR_VBPS(18);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 18);
 		break;
 	case SNDRV_PCM_FORMAT_S20_3BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S20_3LE:
-		mr |= SPDIFTX_MR_VBPS(20);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 20);
 		break;
 	case SNDRV_PCM_FORMAT_S24_3BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S24_3LE:
-		mr |= SPDIFTX_MR_VBPS(24);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 24);
 		break;
 	case SNDRV_PCM_FORMAT_S24_BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S24_LE:
-		mr |= SPDIFTX_MR_VBPS(24);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 24);
 		break;
 	case SNDRV_PCM_FORMAT_S32_BE:
 		mr |= SPDIFTX_MR_ENDIAN_BIG;
 		fallthrough;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		mr |= SPDIFTX_MR_VBPS(32);
+		mr |= FIELD_PREP(SPDIFTX_MR_VBPS_MASK, 32);
 		break;
 	default:
 		dev_err(dev->dev, "unsupported PCM format: %d\n",
@@ -450,7 +447,7 @@ static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	mr |= SPDIFTX_MR_BPS(bps);
+	mr |= FIELD_PREP(SPDIFTX_MR_BPS_MASK, bps - 1);
 
 	switch (params_rate(params)) {
 	case 22050:
-- 
2.34.1

