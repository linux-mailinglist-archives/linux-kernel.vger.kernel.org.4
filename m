Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2D87182F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbjEaNqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbjEaNov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:44:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610FD1706;
        Wed, 31 May 2023 06:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B34263B22;
        Wed, 31 May 2023 13:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D483C433D2;
        Wed, 31 May 2023 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540503;
        bh=iFJEowEoUDRgZP74DXM1b0/nKlercBiGuQHhIiZB0oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6NWPWQgNV7bWyOZo/0qJbH2dEfS0p+GNNHHqKmxFej0aXa2Nxt//GDM/SDSee9R8
         K0rib8aMLWNnr/2TDAToatlSRB34f4wHpZXA9zJqw/Tr12dyhk69ueusctp/dRT2rL
         HCefiQIY2uOZAjsrCBxt+cHZ/eCN1rPgzsHRtvYO4ZlAYCXPbLWI7Baa45YmdLYDcf
         oCt3ZX5+VzTnJy/jvCJnHBu2GV4j2IfZ2C6uRn6zLEay7GVViGe8CWh+MVDAODuQ2b
         6JfCUPXpKw4O9/jNgaEaEmkdZ52+mu/HO1J3IbetGsFoUsB07FHrwYSB5rzNunSA9m
         ZHecB37+ZIyJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        u.kleine-koenig@pengutronix.de, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 33/37] ASoC: dwc: move DMA init to snd_soc_dai_driver probe()
Date:   Wed, 31 May 2023 09:40:15 -0400
Message-Id: <20230531134020.3383253-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Kochetkov <fido_max@inbox.ru>

[ Upstream commit 011a8719d6105dcb48077ea7a6a88ac019d4aa50 ]

When using DMA mode we are facing with Oops:
[  396.458157] Unable to handle kernel access to user memory without uaccess routines at virtual address 000000000000000c
[  396.469374] Oops [#1]
[  396.471839] Modules linked in:
[  396.475144] CPU: 0 PID: 114 Comm: arecord Not tainted 6.0.0-00164-g9a8eccdaf2be-dirty #68
[  396.483619] Hardware name: YMP ELCT FPGA (DT)
[  396.488156] epc : dmaengine_pcm_open+0x1d2/0x342
[  396.493227]  ra : dmaengine_pcm_open+0x1d2/0x342
[  396.498140] epc : ffffffff807fe346 ra : ffffffff807fe346 sp : ffffffc804e138f0
[  396.505602]  gp : ffffffff817bf730 tp : ffffffd8042c8ac0 t0 : 6500000000000000
[  396.513045]  t1 : 0000000000000064 t2 : 656e69676e65616d s0 : ffffffc804e13990
[  396.520477]  s1 : ffffffd801b86a18 a0 : 0000000000000026 a1 : ffffffff816920f8
[  396.527897]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000000000
[  396.535319]  a5 : 0000000000000000 a6 : ffffffd801b87040 a7 : 0000000000000038
[  396.542740]  s2 : ffffffd801b94a00 s3 : 0000000000000000 s4 : ffffffd80427f5e8
[  396.550153]  s5 : ffffffd80427f5e8 s6 : ffffffd801b44410 s7 : fffffffffffffff5
[  396.557569]  s8 : 0000000000000800 s9 : 0000000000000001 s10: ffffffff8066d254
[  396.564978]  s11: ffffffd8059cf768 t3 : ffffffff817d5577 t4 : ffffffff817d5577
[  396.572391]  t5 : ffffffff817d5578 t6 : ffffffc804e136e8
[  396.577876] status: 0000000200000120 badaddr: 000000000000000c cause: 000000000000000d
[  396.586007] [<ffffffff806839f4>] snd_soc_component_open+0x1a/0x68
[  396.592439] [<ffffffff807fdd62>] __soc_pcm_open+0xf0/0x502
[  396.598217] [<ffffffff80685d86>] soc_pcm_open+0x2e/0x4e
[  396.603741] [<ffffffff8066cea4>] snd_pcm_open_substream+0x442/0x68e
[  396.610313] [<ffffffff8066d1ea>] snd_pcm_open+0xfa/0x212
[  396.615868] [<ffffffff8066d39c>] snd_pcm_capture_open+0x3a/0x60
[  396.622048] [<ffffffff8065b35a>] snd_open+0xa8/0x17a
[  396.627421] [<ffffffff801ae036>] chrdev_open+0xa0/0x218
[  396.632893] [<ffffffff801a5a28>] do_dentry_open+0x17c/0x2a6
[  396.638713] [<ffffffff801a6d9a>] vfs_open+0x1e/0x26
[  396.643850] [<ffffffff801b8544>] path_openat+0x96e/0xc96
[  396.649518] [<ffffffff801b9390>] do_filp_open+0x7c/0xf6
[  396.655034] [<ffffffff801a6ff2>] do_sys_openat2+0x8a/0x11e
[  396.660765] [<ffffffff801a735a>] sys_openat+0x50/0x7c
[  396.666068] [<ffffffff80003aca>] ret_from_syscall+0x0/0x2
[  396.674964] ---[ end trace 0000000000000000 ]---

It happens because of play_dma_data/capture_dma_data pointers are NULL.
Current implementation assigns these pointers at snd_soc_dai_driver
startup() callback and reset them back to NULL at shutdown(). But
soc_pcm_open() sequence uses DMA pointers in dmaengine_pcm_open()
before snd_soc_dai_driver startup().
Most generic DMA capable I2S drivers use snd_soc_dai_driver probe()
callback to init DMA pointers only once at probe. So move DMA init
to dw_i2s_dai_probe and drop shutdown() and startup() callbacks.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
Link: https://lore.kernel.org/r/20230512110343.66664-1-fido_max@inbox.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/dwc/dwc-i2s.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 7f7dd07c63b2f..d2dd865e5ad89 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -183,30 +183,6 @@ static void i2s_stop(struct dw_i2s_dev *dev,
 	}
 }
 
-static int dw_i2s_startup(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *cpu_dai)
-{
-	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
-	union dw_i2s_snd_dma_data *dma_data = NULL;
-
-	if (!(dev->capability & DWC_I2S_RECORD) &&
-			(substream->stream == SNDRV_PCM_STREAM_CAPTURE))
-		return -EINVAL;
-
-	if (!(dev->capability & DWC_I2S_PLAY) &&
-			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK))
-		return -EINVAL;
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = &dev->play_dma_data;
-	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		dma_data = &dev->capture_dma_data;
-
-	snd_soc_dai_set_dma_data(cpu_dai, substream, (void *)dma_data);
-
-	return 0;
-}
-
 static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
 {
 	u32 ch_reg;
@@ -305,12 +281,6 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void dw_i2s_shutdown(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	snd_soc_dai_set_dma_data(dai, substream, NULL);
-}
-
 static int dw_i2s_prepare(struct snd_pcm_substream *substream,
 			  struct snd_soc_dai *dai)
 {
@@ -382,8 +352,6 @@ static int dw_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 }
 
 static const struct snd_soc_dai_ops dw_i2s_dai_ops = {
-	.startup	= dw_i2s_startup,
-	.shutdown	= dw_i2s_shutdown,
 	.hw_params	= dw_i2s_hw_params,
 	.prepare	= dw_i2s_prepare,
 	.trigger	= dw_i2s_trigger,
@@ -625,6 +593,14 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 
 }
 
+static int dw_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai, &dev->play_dma_data, &dev->capture_dma_data);
+	return 0;
+}
+
 static int dw_i2s_probe(struct platform_device *pdev)
 {
 	const struct i2s_platform_data *pdata = pdev->dev.platform_data;
@@ -643,6 +619,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dw_i2s_dai->ops = &dw_i2s_dai_ops;
+	dw_i2s_dai->probe = dw_i2s_dai_probe;
 
 	dev->i2s_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(dev->i2s_base))
-- 
2.39.2

