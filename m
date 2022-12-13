Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417BD64B413
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiLMLXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiLMLXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:23:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFBA31C;
        Tue, 13 Dec 2022 03:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670930614; x=1702466614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9xO7lRNTpGk6Xw7msQY+tumPYTeSzK6G728DFAXM2UI=;
  b=Ope8pwpO2kytcxQcCmfpy4LvCPkQVpaFoUK/lAKuWmM98Ol/FSxgkp6X
   4eZQsqngmbCMzVyfT44ZKOSjAOQEiqSrQYRSMmMXo3JN+KLpRh/QZ0Hha
   wncyItAXRW8YDXCkGBVOyAAH6wkCGxr33l+StLxve26vN4k3HEshoGbox
   FbpgTi+T+h/SDKjAM5thKRLuxCqJZrkE8BQeOMfIzFqkvM6F59dbB4+Ov
   ahSv9gDCd4q+N5HLCe88vJ1y+nONKA2QYGkFeNEsCuJZn4f6XM1QKZRI+
   gcSt+G5l/WvwRM0wAcGG0jhDSs5EVe9SAYzZ2X5uZMy2ukqMsnPyrqf/n
   g==;
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="187911739"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2022 04:23:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 04:23:32 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 04:23:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/4] ASoC: microchip: power saving features and cleanups
Date:   Tue, 13 Dec 2022 13:28:47 +0200
Message-ID: <20221213112851.89212-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
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

Hi,

The following series adds runtime PM and suspend to RAM features for
mchp-pdmc driver.

Along with it 2 cleanup patches were added:
- patch 1/4: use vendor,device.yaml file format for Microchip AT91 ASoC
  bindings
- patch 4/4: use FIELD_PREP() in mchp-spdiftx.c

Thank you,
Claudiu Beznea

Changes in v3:
- in patch 1/4 add back microchip,sama7g5-i2smcc.yaml as it was removed
  by mistake in v2
- in patch 1/4 fixed the schema id to match the new naming

Changes in v2:
- s/microchip,sama7g5-i2s-mcc/microchip,sama7g5-i2smcc as
  this is the 1st available compatible

Claudiu Beznea (4):
  ASoC: dt-bindings: microchip: use proper naming syntax
  ASoC: mchp-pdmc: use runtime pm for clock power saving
  ASoC: mchp-pdmc: add support for suspend to RAM
  ASoC: mchp-spdiftx: use FIELD_PREP() where possible

 ...mcc.yaml => microchip,sama7g5-i2smcc.yaml} |   2 +-
 ...,pdmc.yaml => microchip,sama7g5-pdmc.yaml} |   2 +-
 ...rx.yaml => microchip,sama7g5-spdifrx.yaml} |   2 +-
 ...tx.yaml => microchip,sama7g5-spdiftx.yaml} |   2 +-
 sound/soc/atmel/mchp-pdmc.c                   | 145 ++++++++++++------
 sound/soc/atmel/mchp-spdiftx.c                |   8 +-
 6 files changed, 105 insertions(+), 56 deletions(-)
 rename Documentation/devicetree/bindings/sound/{mchp,i2s-mcc.yaml => microchip,sama7g5-i2smcc.yaml} (97%)
 rename Documentation/devicetree/bindings/sound/{microchip,pdmc.yaml => microchip,sama7g5-pdmc.yaml} (97%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdifrx.yaml => microchip,sama7g5-spdifrx.yaml} (95%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdiftx.yaml => microchip,sama7g5-spdiftx.yaml} (95%)

-- 
2.34.1

