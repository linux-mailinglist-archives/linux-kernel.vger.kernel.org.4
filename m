Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3591B62DAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbiKQMeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbiKQMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:33:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A6A742F4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668688401; x=1700224401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dC+Z+2dJnvsXSsxV5IVXyOSHXTLenZC0GCwpi+PbA7c=;
  b=GMTLUBs7XffKEK7ICH5o2rI5aRZYXuV1ibCy+AhP57KT7Crd8XUfIGAJ
   dm/LRTx4+OOav9tjDamkmqyB4f9UNEGy+fkuYrVpsuGwO0kq5w63ADRVT
   4oybVUwQG2vqBjS1WKE5VNfbmUSY5INVGzOvUJZbHu2/FwDHTFhLXN/3z
   Q2UTSTiYsN4mTgUK9gciNAx/1H8QDaTMNX6DLyiNfvmK9egEqvt5kAY+L
   YONoXdvPCTdr/Krbc0UdWz2QDTdb8XlWQnrUEDhO6Xrk/HWA0iGhdeLnD
   qdOwUUwbS2bAjdkyigX7X+nAp6vFkxRMMrOMbPo4nfMUz8Pj38sfQdnWx
   w==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="189407195"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 05:33:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 05:33:16 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 05:33:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] ASoC: mchp-spdiftx: add support for system suspend/resume
Date:   Thu, 17 Nov 2022 14:37:50 +0200
Message-ID: <20221117123750.291911-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221117123750.291911-1-claudiu.beznea@microchip.com>
References: <20221117123750.291911-1-claudiu.beznea@microchip.com>
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

Add support for system suspend/resume by moving the enable/disable
of interrupts in mchp_spdiftx_trigger() on SNDRV_PCM_TRIGGER_SUSPEND/
SNDRV_PCM_TRIGGER_RESUME commands.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index ec454e64d85c..dc96a6fbf514 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -198,6 +198,7 @@ struct mchp_spdiftx_dev {
 	struct clk				*pclk;
 	struct clk				*gclk;
 	unsigned int				fmt;
+	unsigned int				suspend_irq;
 };
 
 static inline int mchp_spdiftx_is_running(struct mchp_spdiftx_dev *dev)
@@ -318,16 +319,25 @@ static int mchp_spdiftx_trigger(struct snd_pcm_substream *substream, int cmd,
 	running = !!(mr & SPDIFTX_MR_TXEN_ENABLE);
 
 	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_START:
+		regmap_write(dev->regmap, SPDIFTX_IER, dev->suspend_irq |
+			     SPDIFTX_IR_TXUDR | SPDIFTX_IR_TXOVR);
+		dev->suspend_irq = 0;
+		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (!running) {
 			mr &= ~SPDIFTX_MR_TXEN_MASK;
 			mr |= SPDIFTX_MR_TXEN_ENABLE;
 		}
 		break;
-	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
+		regmap_read(dev->regmap, SPDIFTX_IMR, &dev->suspend_irq);
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_STOP:
+		regmap_write(dev->regmap, SPDIFTX_IDR, dev->suspend_irq |
+			     SPDIFTX_IR_TXUDR | SPDIFTX_IR_TXOVR);
+		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (running) {
 			mr &= ~SPDIFTX_MR_TXEN_MASK;
@@ -507,10 +517,6 @@ static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(dev->dev, "%s(): GCLK set to %d\n", __func__,
 		params_rate(params) * SPDIFTX_GCLK_RATIO);
 
-	/* Enable interrupts */
-	regmap_write(dev->regmap, SPDIFTX_IER,
-		     SPDIFTX_IR_TXUDR | SPDIFTX_IR_TXOVR);
-
 	regmap_write(dev->regmap, SPDIFTX_MR, mr);
 
 	return 0;
@@ -521,9 +527,6 @@ static int mchp_spdiftx_hw_free(struct snd_pcm_substream *substream,
 {
 	struct mchp_spdiftx_dev *dev = snd_soc_dai_get_drvdata(dai);
 
-	regmap_write(dev->regmap, SPDIFTX_IDR,
-		     SPDIFTX_IR_TXUDR | SPDIFTX_IR_TXOVR);
-
 	return regmap_write(dev->regmap, SPDIFTX_CR,
 			    SPDIFTX_CR_SWRST | SPDIFTX_CR_FCLR);
 }
@@ -785,6 +788,7 @@ static int mchp_spdiftx_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops mchp_spdiftx_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	RUNTIME_PM_OPS(mchp_spdiftx_runtime_suspend, mchp_spdiftx_runtime_resume,
 		       NULL)
 };
-- 
2.34.1

