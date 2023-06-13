Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BBF72EBCE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjFMTUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFMTU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:20:29 -0400
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC52B8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=h/MocxZZY8RaZOfp7gLNY7VCpf7RUx7xvYUlaMEvuNs=;
        t=1686684027;x=1686774027; 
        b=pR0BHf+JS6maWv1ALOxxTJQkhAU7XgtEsXO6jyyq2FT2mo7op2EuEK6wciKxQLLyNqi4+YP2yz/bEZ1MYUsRQdyrhnwzoEkYHi7ExBFlrLLFaeDvw8bfE1qs4A//LeFeHF/t3rtQ3xkVaSD8faqjz4PJfJ3yTr7DZY6gtoygRR0PjEl2ZvA10+1/CEyltKYEhQ+SSHG783vVKVnmkrKRMcOuZ6vwCmw16jhz0MqrPCiiTmy8V3s58RddUOT5/JcAf+Qu4kZ58Z+f8XcKzRraaWo1Im9imYnacn7ZPR7+aGcyLviM7jYvf9MtLfm/4fwovnXUHs+/Ina9ZokiaMWTMw==;
Received: from [10.161.55.49] (port=39758 helo=smtpng1.i.mail.ru)
        by fallback1.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1q99Z3-006OEM-OV
        for linux-kernel@vger.kernel.org; Tue, 13 Jun 2023 22:20:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=h/MocxZZY8RaZOfp7gLNY7VCpf7RUx7xvYUlaMEvuNs=;
        t=1686684025;x=1686774025; 
        b=kkN7bwXoNDdQ0GnqDBd+11iHYK0Vdg0hrI5ngZCquqGFsFpFP1uC5gY698d+xuW2t74fjT7zD43NYTZ6OVsyhlQMrn3tEIe5eFteoo6xGAiva86zkayFKM9pPciDcCZOC1a2aQmjyCIHemKgFgV2p97bhTV3AJsSgaYIAGRPU1wmcqlOaIPS0MignOdV7j5fxqJMnRplDptu10kfG018GY0hkAFGWEq7HeSkit+6EAQsQuUBri/p71YelE9/Dt5n8m3Gr0TsIz1ci97gH5snm0j5mjaldQOMLx76wJ1TgAE0LDjoHYZZXaQq+wFbmijuJXlMsn3XkkgDSPOAdFkIyA==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1q99Yo-0004RB-FR; Tue, 13 Jun 2023 22:20:10 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     alsa-devel@alsa-project.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ASoC: dwc: add DMA handshake control
Date:   Tue, 13 Jun 2023 22:19:08 +0300
Message-Id: <20230613191910.725049-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDC1DBB6C3EBD37189F6AA3DE0BD4C4F69B182A05F538085040E0E7776396F042F7254649D147650561F7F22C361045218E56B3565F567D1BB9
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE76574C3D62D66A535EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637160171C9EBC7AFE48638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8345564E8F5B93C7057DFDA784C71EC186F9789CCF6C18C3F8528715B7D10C86859CC434672EE6371117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCF87214F1A954108EA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352041BF15D38FB6CB3A618001F51B5FD3F9D2E47CDBA5A96583BA9C0B312567BB231DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6753C3A5E0A5AB5B7089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A59FDFF15DC32349A54F3A3590F1E48026FA34DBAAA459B824F87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9F07DD80A176A3FEC3680CDDE082CCDCCDA9E59ED755A0934DA4EF5A276EBD5BA161E968D9DBB349513AFAF93E604BF59AA2BE663C95F38C3FAE0DD5D9DF71F6464E0F6E1F48538C02C26D483E81D6BEEB84411BD425175970A7FB4ED9620804ADE12199CE9660BE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMslUgTLgY7GrpO6CGEzBgQ==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B1F95BF9A3CEDE7523E34D31F511E352698CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E9028C5D3AAACA541B7C9AC5AE5CBE45D64F8DB41054FBA7B647ED114AB003AC3A7F0C419816BCDB2BF15E55662A0C9535FCDFF1B9B2E7D6409FAA64C6C5FECC
X-7FA49CB5: 0D63561A33F958A5AC2357D1CC8972C53248D60C708AF9AC3F940E9F1CDEDE45CACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdEX6lzAD8XJLoGCOsNgvIpg==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA mode uses hardware handshake signals. DMACR register is used to enable
the DMA Controller interface operation. So add DMA enable/disable to
i2s_start()/i2s_stop() functions if using DMA mode.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 sound/soc/dwc/dwc-i2s.c | 39 +++++++++++++++++++++++++++++++++++++--
 sound/soc/dwc/local.h   |  6 ++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 9e7065dd854c..02b9894e99a7 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -150,19 +150,51 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 }
 
+static void i2s_enable_dma(struct dw_i2s_dev *dev, u32 stream)
+{
+	u32 dma_reg = i2s_read_reg(dev->i2s_base, I2S_DMACR);
+
+	/* Enable DMA handshake for stream */
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_reg |= I2S_DMAEN_TXBLOCK;
+	else
+		dma_reg |= I2S_DMAEN_RXBLOCK;
+
+	i2s_write_reg(dev->i2s_base, I2S_DMACR, dma_reg);
+}
+
+static void i2s_disable_dma(struct dw_i2s_dev *dev, u32 stream)
+{
+	u32 dma_reg = i2s_read_reg(dev->i2s_base, I2S_DMACR);
+
+	/* Disable DMA handshake for stream */
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		dma_reg &= ~I2S_DMAEN_TXBLOCK;
+		i2s_write_reg(dev->i2s_base, I2S_RTXDMA, 1);
+	} else {
+		dma_reg &= ~I2S_DMAEN_RXBLOCK;
+		i2s_write_reg(dev->i2s_base, I2S_RRXDMA, 1);
+	}
+	i2s_write_reg(dev->i2s_base, I2S_DMACR, dma_reg);
+}
+
 static void i2s_start(struct dw_i2s_dev *dev,
 		      struct snd_pcm_substream *substream)
 {
 	struct i2s_clk_config_data *config = &dev->config;
 
 	i2s_write_reg(dev->i2s_base, IER, 1);
-	i2s_enable_irqs(dev, substream->stream, config->chan_nr);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		i2s_write_reg(dev->i2s_base, ITER, 1);
 	else
 		i2s_write_reg(dev->i2s_base, IRER, 1);
 
+	if (dev->use_pio)
+		i2s_enable_irqs(dev, substream->stream, config->chan_nr);
+	else
+		i2s_enable_dma(dev, substream->stream);
+
 	i2s_write_reg(dev->i2s_base, CER, 1);
 }
 
@@ -176,7 +208,10 @@ static void i2s_stop(struct dw_i2s_dev *dev,
 	else
 		i2s_write_reg(dev->i2s_base, IRER, 0);
 
-	i2s_disable_irqs(dev, substream->stream, 8);
+	if (dev->use_pio)
+		i2s_disable_irqs(dev, substream->stream, 8);
+	else
+		i2s_disable_dma(dev, substream->stream);
 
 	if (!dev->active) {
 		i2s_write_reg(dev->i2s_base, CER, 0);
diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
index d64bd4f8fd34..ba4e397099be 100644
--- a/sound/soc/dwc/local.h
+++ b/sound/soc/dwc/local.h
@@ -53,6 +53,12 @@
 #define I2S_COMP_VERSION	0x01F8
 #define I2S_COMP_TYPE		0x01FC
 
+#define I2S_RRXDMA		0x01C4
+#define I2S_RTXDMA		0x01CC
+#define I2S_DMACR		0x0200
+#define I2S_DMAEN_RXBLOCK	(1 << 16)
+#define I2S_DMAEN_TXBLOCK	(1 << 17)
+
 /*
  * Component parameter register fields - define the I2S block's
  * configuration.
-- 
2.40.1

