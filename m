Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3D72FE22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFNMPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbjFNMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:15:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A31BC5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686744928; x=1718280928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P+MmFBvDwsbGKAJINRgeRSJGf75kuY7a6+YGCSbxmxY=;
  b=UBtDLPsLxXXwnzmL7byqllHHpGcMD4tjVOqbOf55fTQcZ2BhJwiw7NWm
   aNrHy2PdaCHzuoGIsq4UlWw77n0SZfB8/tj/p/SzxccNeSWbpbUzRfTm2
   MeAYbZc5yK3nz3mlDoUjicT+AgJx0QYjvwymg8MPGHsJYP2BemvQrzEhq
   o2DkpFaxCg/GBLzawGg0vX9tljebGa1W1AeS3lnl+tliNerZcerTDaYhq
   9QXIrgxn43Ji7nFgJjC7ZZopTL5lXbdVBwwje+oioZ4RIxrfHwRKHewzW
   t3o23txgA3NFz2H+KlAOvXXQjH1R7E0s9MhaBPQebtnRgMe6FMsuFFVgf
   g==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="217804545"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2023 05:15:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 14 Jun 2023 05:15:27 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 14 Jun 2023 05:15:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <shengjiu.wang@gmail.com>, <Xiubo.Lee@gmail.com>,
        <festevam@gmail.com>, <nicoleotsuka@gmail.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <linux-imx@nxp.com>,
        <viorel.suman@nxp.com>
CC:     <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ASoC: imx-audmix: check return value of devm_kasprintf()
Date:   Wed, 14 Jun 2023 15:15:09 +0300
Message-ID: <20230614121509.443926-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kasprintf() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: b86ef5367761 ("ASoC: fsl: Add Audio Mixer machine driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi,

This has been addressed using kmerr.cocci script proposed for update
at [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/all/20230530074044.1603426-1-claudiu.beznea@microchip.com/

 sound/soc/fsl/imx-audmix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 2c57fe9d2d08..af06268ee57b 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -228,6 +228,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 
 		dai_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%s",
 					  fe_name_pref, args.np->full_name + 1);
+		if (!dai_name)
+			return -ENOMEM;
 
 		dev_info(pdev->dev.parent, "DAI FE name:%s\n", dai_name);
 
@@ -236,6 +238,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 			capture_dai_name =
 				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
 					       dai_name, "CPU-Capture");
+			if (!capture_dai_name)
+				return -ENOMEM;
 		}
 
 		priv->dai[i].cpus = &dlc[0];
@@ -263,6 +267,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 				       "AUDMIX-Playback-%d", i);
 		be_cp = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 				       "AUDMIX-Capture-%d", i);
+		if (!be_name || !be_pb || !be_cp)
+			return -ENOMEM;
 
 		priv->dai[num_dai + i].cpus = &dlc[2];
 		priv->dai[num_dai + i].codecs = &dlc[3];
@@ -287,6 +293,9 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		priv->dapm_routes[i].source =
 			devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
 				       dai_name, "CPU-Playback");
+		if (!priv->dapm_routes[i].source)
+			return -ENOMEM;
+
 		priv->dapm_routes[i].sink = be_pb;
 		priv->dapm_routes[num_dai + i].source   = be_pb;
 		priv->dapm_routes[num_dai + i].sink     = be_cp;
-- 
2.34.1

