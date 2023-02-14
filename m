Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6490F69691B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjBNQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjBNQRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:17:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223C2B0A6;
        Tue, 14 Feb 2023 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676391440; x=1707927440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uALPcs3Vx7BPrxo0UgAKw4uy0dcv8BW3De7tw3ZgiME=;
  b=t4JY7/upbIvwslGvqbQW4m3Qpt3zwsXYc8F9FpbCYchlAnvmn0CSK9lX
   wVVjWViWUxge5nq2D+DvCKPw9ZYdD4+RhwrYtjcYQpXYA6E1bQ70/msqc
   PTj3DwPaaccH6mZJLaOfM8rAL4v/wBOz2Mu/4LESwIKgRD2TJ2PBuu9DQ
   FtP3amgOBggEQ7EFt8/pfWU+6JxCRkZTbEtbd1kbMSJyQLoLO2e5Fc4cS
   zjz8I0zzgQYqcw5K78acXC6iGrMv8nYEHDDvovVEbdcNXi2V0Tvh1Svgl
   UvISJ9Muf+Izoi3AyE5cCUVF0/2WP2cnsqWTcuWrVyJopRScwoj6h8txP
   A==;
X-IronPort-AV: E=Sophos;i="5.97,297,1669100400"; 
   d="scan'208";a="196891478"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 09:17:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 09:17:07 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 09:17:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] ASoC: mchp-pdmc: fix poc noise at capture startup
Date:   Tue, 14 Feb 2023 18:14:35 +0200
Message-ID: <20230214161435.1088246-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
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

Microchip PDMC IP doesn't filter microphone noises on startup. By default,
it captures data received from digital microphones after
the MCHP_PDMC_MR.EN bits are set. Thus when enable is set on PDMC side the
digital microphones might not be ready yet and PDMC captures data from then
in this time. This data captured is poc noise. To avoid this the software
workaround is to the following:
1/ enable PDMC channel
2/ wait 150ms (on SAMA7G5-EK setup)
3/ execute 16 dummy reads from RHR
4/ clear interrupts
5/ enable interrupts
6/ enable DMA channel

Fixes: 50291652af52 ("ASoC: atmel: mchp-pdmc: add PDMC driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 55 +++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index cf4084dcbd5e..c5f597ebfa47 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -114,6 +114,7 @@ struct mchp_pdmc {
 	struct clk *gclk;
 	u32 pdmcen;
 	u32 suspend_irq;
+	u32 startup_delay_us;
 	int mic_no;
 	int sinc_order;
 	bool audio_filter_en;
@@ -632,6 +633,29 @@ static int mchp_pdmc_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static void mchp_pdmc_noise_filter_workaround(struct mchp_pdmc *dd)
+{
+	u32 tmp, steps = 16;
+
+	/*
+	 * PDMC doesn't wait for microphones' startup time thus the acquisition
+	 * may start before the microphones are ready leading to poc noises at
+	 * the beginning of capture. To avoid this, we need to wait 50ms (in
+	 * normal startup procedure) or 150 ms (worst case after resume from sleep
+	 * states) after microphones are enabled and then clear the FIFOs (by
+	 * reading the RHR 16 times) and possible interrupts before continuing.
+	 * Also, for this to work the DMA needs to be started after interrupts
+	 * are enabled.
+	 */
+	usleep_range(dd->startup_delay_us, dd->startup_delay_us + 5);
+
+	while (steps--)
+		regmap_read(dd->regmap, MCHP_PDMC_RHR, &tmp);
+
+	/* Clear interrupts. */
+	regmap_read(dd->regmap, MCHP_PDMC_ISR, &tmp);
+}
+
 static int mchp_pdmc_trigger(struct snd_pcm_substream *substream,
 			     int cmd, struct snd_soc_dai *dai)
 {
@@ -644,15 +668,17 @@ static int mchp_pdmc_trigger(struct snd_pcm_substream *substream,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_START:
-		/* Enable overrun and underrun error interrupts */
-		regmap_write(dd->regmap, MCHP_PDMC_IER, dd->suspend_irq |
-			     MCHP_PDMC_IR_RXOVR | MCHP_PDMC_IR_RXUDR);
-		dd->suspend_irq = 0;
-		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		snd_soc_component_update_bits(cpu, MCHP_PDMC_MR,
 					      MCHP_PDMC_MR_PDMCEN_MASK,
 					      dd->pdmcen);
+
+		mchp_pdmc_noise_filter_workaround(dd);
+
+		/* Enable interrupts. */
+		regmap_write(dd->regmap, MCHP_PDMC_IER, dd->suspend_irq |
+			     MCHP_PDMC_IR_RXOVR | MCHP_PDMC_IR_RXUDR);
+		dd->suspend_irq = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		regmap_read(dd->regmap, MCHP_PDMC_IMR, &dd->suspend_irq);
@@ -796,6 +822,7 @@ static bool mchp_pdmc_readable_reg(struct device *dev, unsigned int reg)
 	case MCHP_PDMC_CFGR:
 	case MCHP_PDMC_IMR:
 	case MCHP_PDMC_ISR:
+	case MCHP_PDMC_RHR:
 	case MCHP_PDMC_VER:
 		return true;
 	default:
@@ -817,6 +844,17 @@ static bool mchp_pdmc_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool mchp_pdmc_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MCHP_PDMC_ISR:
+	case MCHP_PDMC_RHR:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool mchp_pdmc_precious_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -836,6 +874,7 @@ static const struct regmap_config mchp_pdmc_regmap_config = {
 	.readable_reg	= mchp_pdmc_readable_reg,
 	.writeable_reg	= mchp_pdmc_writeable_reg,
 	.precious_reg	= mchp_pdmc_precious_reg,
+	.volatile_reg	= mchp_pdmc_volatile_reg,
 	.cache_type	= REGCACHE_FLAT,
 };
 
@@ -918,6 +957,11 @@ static int mchp_pdmc_dt_init(struct mchp_pdmc *dd)
 		dd->channel_mic_map[i].clk_edge = edge;
 	}
 
+	ret = of_property_read_u32(np, "microchip,startup-delay-us",
+				   &dd->startup_delay_us);
+	if (ret)
+		dd->startup_delay_us = 150000;
+
 	return 0;
 }
 
@@ -941,6 +985,7 @@ static int mchp_pdmc_process(struct snd_pcm_substream *substream,
 static struct snd_dmaengine_pcm_config mchp_pdmc_config = {
 	.process = mchp_pdmc_process,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.start_dma_last = 1,
 };
 
 static int mchp_pdmc_runtime_suspend(struct device *dev)
-- 
2.34.1

