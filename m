Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98636A6BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCALiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjCALiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:38:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876153B841
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677670725; x=1709206725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=clQO14yQ+ltRDG+JAi8cfBFkK9rtlbuvlOm22OW9SxU=;
  b=d9Al/VB5TaAH1ID8eilZmItUFy6p+NKJT51ivLXJMUkfGmChvSb+fZ94
   xbNNufCKEle40zIDOUb1bsJHBytEF+T9nRzIoC51mRT4IftVcDtX7fM5T
   XJHRt8qMx+NUwv6MM9zrCKu/yuLXtIMAooTdGPD76YbpwWaYWOLiIqq8o
   cyP+iwQ7wZaot7cg2n+h3E3K/GSh4miWKPrZbagoChncLtIXGVH+M0Z+K
   UrQHx3+4bT3+k+qr4foUmXkfvifx+GeSw7cV/m80elCiD8Na62UUwwNwJ
   rh7YFizXWKTDFChdwri5kvnCrC+txSYq3UbGEMI7vftEufRie/2dQGHwz
   g==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="scan'208";a="202995020"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 04:38:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 04:38:33 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 04:38:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/8] ASoC: mchp-spdiftx: use regmap_update_bits()
Date:   Wed, 1 Mar 2023 13:38:01 +0200
Message-ID: <20230301113807.24036-3-claudiu.beznea@microchip.com>
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

Use regmap_update_bits() instead of regmap_read(), running variable,
regmap_write(). There is no need for extra variables and checks around
it as regmap_update_bits() already does this. With this code becomes
simpler.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index bf4252412f9f..e7241d819748 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -306,15 +306,10 @@ static int mchp_spdiftx_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct mchp_spdiftx_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct mchp_spdiftx_mixer_control *ctrl = &dev->control;
-	u32 mr;
-	int running;
 	int ret;
 
 	/* do not start/stop while channel status or user data is updated */
 	spin_lock(&ctrl->lock);
-	regmap_read(dev->regmap, SPDIFTX_MR, &mr);
-	running = !!(mr & SPDIFTX_MR_TXEN_ENABLE);
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_START:
@@ -323,10 +318,8 @@ static int mchp_spdiftx_trigger(struct snd_pcm_substream *substream, int cmd,
 		dev->suspend_irq = 0;
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (!running) {
-			mr &= ~SPDIFTX_MR_TXEN_MASK;
-			mr |= SPDIFTX_MR_TXEN_ENABLE;
-		}
+		ret = regmap_update_bits(dev->regmap, SPDIFTX_MR, SPDIFTX_MR_TXEN_MASK,
+					 SPDIFTX_MR_TXEN_ENABLE);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		regmap_read(dev->regmap, SPDIFTX_IMR, &dev->suspend_irq);
@@ -336,17 +329,12 @@ static int mchp_spdiftx_trigger(struct snd_pcm_substream *substream, int cmd,
 			     SPDIFTX_IR_TXUDR | SPDIFTX_IR_TXOVR);
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (running) {
-			mr &= ~SPDIFTX_MR_TXEN_MASK;
-			mr |= SPDIFTX_MR_TXEN_DISABLE;
-		}
+		ret = regmap_update_bits(dev->regmap, SPDIFTX_MR, SPDIFTX_MR_TXEN_MASK,
+					 SPDIFTX_MR_TXEN_DISABLE);
 		break;
 	default:
-		spin_unlock(&ctrl->lock);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-
-	ret = regmap_write(dev->regmap, SPDIFTX_MR, mr);
 	spin_unlock(&ctrl->lock);
 	if (ret)
 		dev_err(dev->dev, "unable to disable TX: %d\n", ret);
-- 
2.34.1

