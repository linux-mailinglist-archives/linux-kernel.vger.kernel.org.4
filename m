Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3039669ABB1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBQMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjBQMmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:42:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FBE68543;
        Fri, 17 Feb 2023 04:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676637731; x=1708173731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h/jiWEOZsffwI+IMKkal/xKUjU/a6RIroqiEYcdfC9s=;
  b=yNFZtg4dimelCXRG0TAJMSM7ae2DyVdPsFU+OXjK6S+cQHAmjCz9Tjd3
   LsXLPWOJV3vCG+Ki9LITlsZD6QUoMYh3Sxp2VOjZBZVdi8dcigzfu8n+B
   ivSqa3CWLidpij3Zm/eivkkteDAQLg7sF7kuMZO20qpyiOuSWwEcSbio+
   Q2LoK6loZevKF/coEhySjwV7+TL0PSVPFZ4pZAl/7dzTS1kc0ixeEJ5Px
   SuWeHkRpyAFPMqnZtjvX6QeUSsQeAUx/ZiyJz6lwhxct9lOZ7cJi0kBlB
   zcXUKkt1+TmnCPKvZIo8INo/iyLErzfXv16o8h/vq6vu9wTuv4p5qgEAD
   w==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="137771533"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 05:42:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 05:42:07 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 17 Feb 2023 05:42:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/3] ASoC: soc-pcm: add option to start DMA after DAI
Date:   Fri, 17 Feb 2023 14:41:49 +0200
Message-ID: <20230217124151.236216-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217124151.236216-1-claudiu.beznea@microchip.com>
References: <20230217124151.236216-1-claudiu.beznea@microchip.com>
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

Add option to start DMA component after DAI trigger. This is done
by filling the new struct snd_soc_component_driver::start_dma_last.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/sound/soc-component.h |  2 ++
 sound/soc/soc-pcm.c           | 27 ++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-component.h b/include/sound/soc-component.h
index 3203d35bc8c1..0814ed143864 100644
--- a/include/sound/soc-component.h
+++ b/include/sound/soc-component.h
@@ -190,6 +190,8 @@ struct snd_soc_component_driver {
 	bool use_dai_pcm_id;	/* use DAI link PCM ID as PCM device number */
 	int be_pcm_base;	/* base device ID for all BE PCMs */
 
+	unsigned int start_dma_last;
+
 #ifdef CONFIG_DEBUG_FS
 	const char *debugfs_prefix;
 #endif
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 005b179a770a..5eb056b942ce 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1088,22 +1088,39 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	int ret = -EINVAL, _ret = 0;
+	struct snd_soc_component *component;
+	int ret = -EINVAL, _ret = 0, start_dma_last = 0, i;
 	int rollback = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		/* Do we need to start dma last? */
+		for_each_rtd_components(rtd, i, component) {
+			if (component->driver->start_dma_last) {
+				start_dma_last = 1;
+				break;
+			}
+		}
+
 		ret = snd_soc_link_trigger(substream, cmd, 0);
 		if (ret < 0)
 			goto start_err;
 
-		ret = snd_soc_pcm_component_trigger(substream, cmd, 0);
-		if (ret < 0)
-			goto start_err;
+		if (start_dma_last) {
+			ret = snd_soc_pcm_dai_trigger(substream, cmd, 0);
+			if (ret < 0)
+				goto start_err;
+
+			ret = snd_soc_pcm_component_trigger(substream, cmd, 0);
+		} else {
+			ret = snd_soc_pcm_component_trigger(substream, cmd, 0);
+			if (ret < 0)
+				goto start_err;
 
-		ret = snd_soc_pcm_dai_trigger(substream, cmd, 0);
+			ret = snd_soc_pcm_dai_trigger(substream, cmd, 0);
+		}
 start_err:
 		if (ret < 0)
 			rollback = 1;
-- 
2.34.1

