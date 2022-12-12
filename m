Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB51649F80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiLLNKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiLLNK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:10:29 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B8C64C5;
        Mon, 12 Dec 2022 05:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670850625; x=1702386625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2+4Tum5TqK0jYXDMEU7nxm14PXJrp+jdhI5kLhgO3ec=;
  b=XEkfcuDnnm4t0j/l2UQZVGgfTQnJYikXNA9f7WvSrMzR+XgQPdCZllaB
   aURlLYVpbXgHU3NtE53BfM8iL0e4PevmRH2sM33RO7octU+jGrvqjL4v6
   BQHA1fLogll4D3sVc2iRYGUp/yrz0iIV077NbtrD9LxDL3/lZYhT9+Kfy
   JNnBDnSl1QeNV2Qmm/7exJi/HB5gLZLjEEnZMbqSJ3SB3s8O1gzqIVUgq
   2b294NTD0X4v2TGgl5+X5n6bvcshvqUK8SQLICBbsGvrkwmUHc/NPrsza
   aT/VktFjoRqWEWfuWy0MnV720vRmriE2ZlgsjpxHL2uK8D4nleXZvCXKN
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="187716903"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Dec 2022 06:10:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 06:10:24 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 06:10:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/4] ASoC: mchp-pdmc: add support for suspend to RAM
Date:   Mon, 12 Dec 2022 15:15:34 +0200
Message-ID: <20221212131535.76111-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221212131535.76111-1-claudiu.beznea@microchip.com>
References: <20221212131535.76111-1-claudiu.beznea@microchip.com>
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

Add support for suspend to RAM by re-aranging the lines in switch..case
from mchp_pdmc_trigger() and saving/restoring the enabled interrupts. These
are necessary as AT91 devices has a special power saving mode (called
backup and self-refresh) where most of the SoC parts are powered off and
thus we need to reconfigure the PDMC on resume.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index f184404e74e5..cf4084dcbd5e 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -113,6 +113,7 @@ struct mchp_pdmc {
 	struct clk *pclk;
 	struct clk *gclk;
 	u32 pdmcen;
+	u32 suspend_irq;
 	int mic_no;
 	int sinc_order;
 	bool audio_filter_en;
@@ -641,22 +642,27 @@ static int mchp_pdmc_trigger(struct snd_pcm_substream *substream,
 #endif
 
 	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_START:
 		/* Enable overrun and underrun error interrupts */
-		regmap_write(dd->regmap, MCHP_PDMC_IER,
+		regmap_write(dd->regmap, MCHP_PDMC_IER, dd->suspend_irq |
 			     MCHP_PDMC_IR_RXOVR | MCHP_PDMC_IR_RXUDR);
+		dd->suspend_irq = 0;
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		snd_soc_component_update_bits(cpu, MCHP_PDMC_MR,
 					      MCHP_PDMC_MR_PDMCEN_MASK,
 					      dd->pdmcen);
 		break;
-	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		regmap_read(dd->regmap, MCHP_PDMC_IMR, &dd->suspend_irq);
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_STOP:
 		/* Disable overrun and underrun error interrupts */
-		regmap_write(dd->regmap, MCHP_PDMC_IDR,
+		regmap_write(dd->regmap, MCHP_PDMC_IDR, dd->suspend_irq |
 			     MCHP_PDMC_IR_RXOVR | MCHP_PDMC_IR_RXUDR);
+		fallthrough;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		snd_soc_component_update_bits(cpu, MCHP_PDMC_MR,
 					      MCHP_PDMC_MR_PDMCEN_MASK, 0);
 		break;
@@ -1107,6 +1113,7 @@ static const struct of_device_id mchp_pdmc_of_match[] = {
 MODULE_DEVICE_TABLE(of, mchp_pdmc_of_match);
 
 static const struct dev_pm_ops mchp_pdmc_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	RUNTIME_PM_OPS(mchp_pdmc_runtime_suspend, mchp_pdmc_runtime_resume,
 		       NULL)
 };
-- 
2.34.1

