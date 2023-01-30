Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135F4680D11
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbjA3MJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbjA3MJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:09:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1080A2C66B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675080521; x=1706616521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/R4wdD0tMsQRvAushbS1DLuKP51g2Gci5WtqH3y3808=;
  b=aS2gFpM0+OTP52azlkK3satyH4GHDTMAdpkGsJPGLEXx0G6321Lx9QRD
   2d/0I5HQOxb3qDIuingRxkX6apPL+3VT+niqFylGxBHZ9aJe+w15zLkkH
   kRJxZ2vkNNbNgRzyjeU0g+Rxa1hVFyhE3J4hSlc45Adn+SPk8It1Cv/lg
   1Hin/3eKj5vjFsV7vcQRqA+eEZvkSeqXfHdmz5r3Ss9DLoHJH8W868+ns
   MbdtgfmLvOAr0jM0U2N350psiURnthqWjVP9U/kK5+/Kj3cKAK71gjYda
   kmhPYM9ubG8CgmZ35SxycGa2l7Vg0aJSHX2G+qPC1YG/6KhM95xQiHKk1
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669100400"; 
   d="scan'208";a="134605326"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2023 05:07:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 05:07:41 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 05:07:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/8] ASoC: mchp-spdifrx: use unsigned long to store clk_get_rate() value
Date:   Mon, 30 Jan 2023 14:06:44 +0200
Message-ID: <20230130120647.638049-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230130120647.638049-1-claudiu.beznea@microchip.com>
References: <20230130120647.638049-1-claudiu.beznea@microchip.com>
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

clk_get_rate() returns an unsigned long. Use a variable of type
unsigned long to store it.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index b81fc77728df..90b2fb3a9844 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -764,8 +764,8 @@ static int mchp_spdifrx_rate_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
 	struct mchp_spdifrx_dev *dev = snd_soc_dai_get_drvdata(dai);
+	unsigned long rate;
 	u32 val;
-	int rate;
 
 	mutex_lock(&dev->mlock);
 
-- 
2.34.1

