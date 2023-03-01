Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9B6A6BD2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCALjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCALjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:39:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6193CE02
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677670731; x=1709206731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xy2RIIqGA7KYL9HehO+5TET6KnrqhumxLiivp/+DeYk=;
  b=CkQeal4EO3EZPLMwFasQLltqPxcTzDBUC6VMZzPbIw1vxOLfqy5ZIV9W
   G9BL+O3iNwtt+YVNgXvB6/mWk1xkeT01SuYtkBESUc0v6/MtWGNZlWVVj
   1vKnCVn9Am4hY/WQ5KD+5KTD9td8nfEkMFjlmDdYrFpUT0syh6OXPxARy
   07zV94XXfoWNcqaTMJockoW5Rkz+chtdTsA1haLtAR3etH5ctOpYdYf0F
   DG5nhRo9tKPnlgtyK8B9QSltPqBnECpsyAr0jURDVibYO3cCuxFlcO6Jw
   Xi05CoZ6UuZ1UWvvmE8s6Ravt9QpVk9xK3/107NoMI5KQHzsXhsGIm3rx
   g==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="scan'208";a="139640271"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 04:38:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 04:38:49 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 04:38:45 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 6/8] ASoC: mchp-pdmc: avoid casting to/from void pointer
Date:   Wed, 1 Mar 2023 13:38:05 +0200
Message-ID: <20230301113807.24036-7-claudiu.beznea@microchip.com>
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

Do not cast to and from void pointer. There is no need for this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index 853a7adfd654..81bfa98fd516 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -783,7 +783,7 @@ static struct snd_soc_dai_driver mchp_pdmc_dai = {
 /* PDMC interrupt handler */
 static irqreturn_t mchp_pdmc_interrupt(int irq, void *dev_id)
 {
-	struct mchp_pdmc *dd = (struct mchp_pdmc *)dev_id;
+	struct mchp_pdmc *dd = dev_id;
 	u32 isr, msr, pending;
 	irqreturn_t ret = IRQ_NONE;
 
@@ -1077,7 +1077,7 @@ static int mchp_pdmc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(dev, irq, mchp_pdmc_interrupt, 0,
-			       dev_name(&pdev->dev), (void *)dd);
+			       dev_name(&pdev->dev), dd);
 	if (ret < 0) {
 		dev_err(dev, "can't register ISR for IRQ %u (ret=%i)\n",
 			irq, ret);
-- 
2.34.1

