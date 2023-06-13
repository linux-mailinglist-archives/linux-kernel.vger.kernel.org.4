Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D172EBC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbjFMTQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFMTQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:16:23 -0400
Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D68B8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=SIM2hbaxLCBXe7+2v+UqnK6GbLgEd0qwt7rjoZz/WUg=;
        t=1686683781;x=1686773781; 
        b=jup75mOfZvnmgDLkEpVYUIxhpiivdrqW+Tc4+DHwQ42oTo8YqSHcPWarMrP0I2EsmOhHz1IeTHxjb0droyFktVvSenSb7ar4AlvupTIVw2jawPjjTXdsqXUv8DuLixoRLReCbmUutja46l20cNpQQQd2ysw8RAQGXlGjy2voHPd2MJaMt6UPF5n94CKa68xx93xE1dBZ2I6GjJs81GLcuYPYFF6Cq9RbHWhwbQf3il6mtbwx6mgjpNPjzQdmbAXXnMiS7riVoP3GoFKyomHNGaFvEf5wlAeAdZ4/c5dVugiDrcYNDBzMbvEbp2ha6wh9VK2NjwdJZIkLIvFi4HZSDg==;
Received: from [10.161.100.15] (port=44130 helo=smtpng3.i.mail.ru)
        by fallback23.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1q99V3-006f7S-4X
        for linux-kernel@vger.kernel.org; Tue, 13 Jun 2023 22:16:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=SIM2hbaxLCBXe7+2v+UqnK6GbLgEd0qwt7rjoZz/WUg=;
        t=1686683777;x=1686773777; 
        b=JE8Xj8JMDn2LNxS8XIPqAW4/FnGqQChPhdWx0b1VfTtHx4jEPTqEtzWOJDACHN1K1hKAR4VRplvmSP5TjRndTbk2ZQv9qKVeNj9egyLXia2sdGPRYT4b4ciqUEdLU8dHeNmDN0yEGgfj5YeLB5i8bz/ugM2lIQSakpmk/AyYO52NM/SCMLgnyYCaeQhoyoixCK/Q/5/CrqR2SUUaTy0hCAp2l56l7fbYwM/HPFr1o6U95T31E+S+ETx1mLxKvQ4AhA79A1dd+Ps26equHwrMQSxzG5M4N9Z4K1FdeleW3/TaFfs3cW2XbfvMBKPoLG8ZpWr4Q5TNZfQ0ms1LeZBgmQ==;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1q99Uo-0007az-1Q; Tue, 13 Jun 2023 22:16:02 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     alsa-devel@alsa-project.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ASoC: dwc: don't assign addr_width for dt configs
Date:   Tue, 13 Jun 2023 22:15:51 +0300
Message-Id: <20230613191552.724748-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD95D99986233CC4DDC5FE2F5E6723F70B2B5A8ACCF658560FC182A05F5380850407E655930523C17D639AC45AB5C083FA82E722F5874E99C1218C1D4EF41E31883
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75BC5C25D5957B3DFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E16D8B060A9A23898638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8ACEC9A8843F0FAD4A99510ACC6A0F2E56F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE74601F13E4625331C9FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751FBDFBBEFFF4125B51D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BB6FC2C91A742FF12A471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CB1724D34C644744043847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A541016C4333575D4AAACFAB04AB5EB0D4E1025A028F061139F87CCE6106E1FC07E67D4AC08A07B9B062B3BD3CC35DA5889C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFC99611A8606EF2C48E62A0A3BFF44D77B65792F25642EA84D5BF5B4F3AC730E9FA89AC6828CC4048513AFAF93E604BF56E725539BC0402C96C986110FC862FBD464E0F6E1F48538C02C26D483E81D6BEEB84411BD425175970A7FB4ED9620804ADE12199CE9660BE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMslUgTLgY7EBG8KyzHMuiA==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B46CEA984123307E973B46CD0F74303F398CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4E9028C5D3AAACA543469617EE63DA4797F6ACA219C8406C3B647ED114AB003ACBB9C77D4EC66FB80BE50656238423A74703EB85EE46E4E10391505576093E1AB
X-7FA49CB5: 0D63561A33F958A57FEF83A87B5DF1212E0DB9E7334FFC3FDF1CB9060EE0A90FCACD7DF95DA8FC8BD5E8D9A59859A8B6CC2F3E6DF6689A16
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdEX6lzAD8XJKQX6SjhF4mTg==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For proper DMA operation addr_width must corresponds with audio format
(S16, S24, S32, etc). Proper bus width calculations is performed by
snd_hwparams_to_dma_slave_config(). So drop wrong addr_width asignment
for dt configs and let snd_hwparams_to_dma_slave_config() do the job.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 sound/soc/dwc/dwc-i2s.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 9e7065dd854c..21398ee924e4 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -558,13 +558,9 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 	u32 comp1 = i2s_read_reg(dev->i2s_base, I2S_COMP_PARAM_1);
 	u32 comp2 = i2s_read_reg(dev->i2s_base, I2S_COMP_PARAM_2);
 	u32 fifo_depth = 1 << (1 + COMP1_FIFO_DEPTH_GLOBAL(comp1));
-	u32 idx = COMP1_APB_DATA_WIDTH(comp1);
 	u32 idx2;
 	int ret;
 
-	if (WARN_ON(idx >= ARRAY_SIZE(bus_widths)))
-		return -EINVAL;
-
 	ret = dw_configure_dai(dev, dw_i2s_dai, SNDRV_PCM_RATE_8000_192000);
 	if (ret < 0)
 		return ret;
@@ -574,7 +570,6 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 
 		dev->capability |= DWC_I2S_PLAY;
 		dev->play_dma_data.dt.addr = res->start + I2S_TXDMA;
-		dev->play_dma_data.dt.addr_width = bus_widths[idx];
 		dev->play_dma_data.dt.fifo_size = fifo_depth *
 			(fifo_width[idx2]) >> 8;
 		dev->play_dma_data.dt.maxburst = 16;
@@ -584,7 +579,6 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 
 		dev->capability |= DWC_I2S_RECORD;
 		dev->capture_dma_data.dt.addr = res->start + I2S_RXDMA;
-		dev->capture_dma_data.dt.addr_width = bus_widths[idx];
 		dev->capture_dma_data.dt.fifo_size = fifo_depth *
 			(fifo_width[idx2] >> 8);
 		dev->capture_dma_data.dt.maxburst = 16;
-- 
2.40.1

