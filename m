Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A162DAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiKQMeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbiKQMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:33:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78CE14D36
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668688388; x=1700224388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mriXUUv4YdVpJ92OHSjzRqvTpbgG5OABDyze4/Hv4to=;
  b=NjTVonB6rztUISm0KDDKcA4UE/ydaUb1OQOvO9lslJqRnSRxOrvN/poB
   10WkmjwCU6dPxo8oId7z+Er/jLf8wRoybjfa6Su+xbIMwstoqufv704OV
   26JTSxlXFKE0u0M2VkwuT+k8Hf/bKcHy8AVTolkl6HStBiB2l6xHILBT1
   6pgRD650Ulj+VxBrlwMjaMX7QjBxFwESwhp23g7n1skuHaqUKCPeOf+q9
   h6UcgoEG8AgF1Gmjup0QVRCYELLn4B+ITtTQkNjVGRDUZY4PvkVFHghVd
   o9/yKkUD4sV4jcNHhS+JKrS0UuDj/NQQTssgdIYrDyVrtaev63Ucmz80k
   g==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="183977381"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 05:33:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 05:33:06 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 05:33:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] ASoC: mchp-spdiftx: simplify locking around ctrl->ch_stat
Date:   Thu, 17 Nov 2022 14:37:48 +0200
Message-ID: <20221117123750.291911-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221117123750.291911-1-claudiu.beznea@microchip.com>
References: <20221117123750.291911-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a temporary variable to keep the AES3 value. With this a
spin_unlock_irqrestore() call has been removed from the final code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index ab2d7a791f39..4e231cec9045 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -355,6 +355,7 @@ static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
 	struct mchp_spdiftx_mixer_control *ctrl = &dev->control;
 	u32 mr;
 	unsigned int bps = params_physical_width(params) / 8;
+	unsigned char aes3;
 	int ret;
 
 	dev_dbg(dev->dev, "%s() rate=%u format=%#x width=%u channels=%u\n",
@@ -440,48 +441,48 @@ static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
 
 	mr |= SPDIFTX_MR_BPS(bps);
 
-	spin_lock_irqsave(&ctrl->lock, flags);
-	ctrl->ch_stat[3] &= ~IEC958_AES3_CON_FS;
 	switch (params_rate(params)) {
 	case 22050:
-		ctrl->ch_stat[3] |= IEC958_AES3_CON_FS_22050;
+		aes3 = IEC958_AES3_CON_FS_22050;
 		break;
 	case 24000:
-		ctrl->ch_stat[3] |= IEC958_AES3_CON_FS_24000;
+		aes3 = IEC958_AES3_CON_FS_24000;
 		break;
 	case 32000:
-		ctrl->ch_stat[3] |= IEC958_AES3_CON_FS_32000;
+		aes3 = IEC958_AES3_CON_FS_32000;
 		break;
 	case 44100:
-		ctrl->ch_stat[3] |= IEC958_AES3_CON_FS_44100;
+		aes3 = IEC958_AES3_CON_FS_44100;
 		break;
 	case 48000:
-		ctrl->ch_stat[3] |= IEC958_AES3_CON_FS_48000;
+		aes3 = IEC958_AES3_CON_FS_48000;
 		break;
 	case 88200:
-		ctrl->ch_stat[3] |= IEC958_AES3_CON_FS_88200;
+		aes3 = IEC958_AES3_CON_FS_88200;
 		break;
 	case 96000:
-		ctrl->ch_stat[3] |= IEC958_AES3_CON_FS_96000;
+		aes3 = IEC958_AES3_CON_FS_96000;
 		break;
 	case 176400:
-		ctrl->ch_stat[3] |= IEC958_AES3_CON_FS_176400;
+		aes3 = IEC958_AES3_CON_FS_176400;
 		break;
 	case 192000:
-		ctrl->ch_stat[3] |= IEC958_AES3_CON_FS_192000;
+		aes3 = IEC958_AES3_CON_FS_192000;
 		break;
 	case 8000:
 	case 11025:
 	case 16000:
 	case 64000:
-		ctrl->ch_stat[3] |= IEC958_AES3_CON_FS_NOTID;
+		aes3 = IEC958_AES3_CON_FS_NOTID;
 		break;
 	default:
 		dev_err(dev->dev, "unsupported sample frequency: %u\n",
 			params_rate(params));
-		spin_unlock_irqrestore(&ctrl->lock, flags);
 		return -EINVAL;
 	}
+	spin_lock_irqsave(&ctrl->lock, flags);
+	ctrl->ch_stat[3] &= ~IEC958_AES3_CON_FS;
+	ctrl->ch_stat[3] |= aes3;
 	mchp_spdiftx_channel_status_write(dev);
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
-- 
2.34.1

