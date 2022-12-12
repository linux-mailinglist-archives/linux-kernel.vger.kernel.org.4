Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF02A64A4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiLLQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiLLQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:38:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2799415FEA;
        Mon, 12 Dec 2022 08:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670863005; x=1702399005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iy5q+w5KsVwT75Q4h3iNbvjdzEM5LASpylZyLWvqsmU=;
  b=AP2Fe9VRdER6aqB10bGrlWQIFp7lg2FbLWgM8HF7ZM/V4UzSTxU7Kkin
   jc5ALt+FsIZjVNVoIN7bP/pDNIwgtjot08okKv4XjsE4tdUBahkUeyOPs
   AHAnmplcgsMEVOpgc9nusVxi7QhvdMYsHXjrNcG3FOjJRfkKwKuQY+Ags
   DUZEcoWmmRUEpv21cl0GJfy36pnYJfue71tE//H9IoJg7xhMPjjkOtRwF
   F9JJMcCMF8OcsITEA+6gCtHJLMJkVrYgk0KyDsAwJ3Dn7aqLr43la+I/2
   5hQlSURCziQTCKCaA+LyqhEuuPRhV5opnmNqs3dBJ6X0mE9aOvDcQoKjY
   A==;
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="127727088"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Dec 2022 09:36:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 09:36:33 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 09:36:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/4] ASoC: microchip: power saving features and cleanups
Date:   Mon, 12 Dec 2022 18:41:49 +0200
Message-ID: <20221212164153.78677-1-claudiu.beznea@microchip.com>
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

Changes in v2:
- s/microchip,sama7g5-i2s-mcc/microchip,sama7g5-i2smcc as
  this is the 1st available compatible

Claudiu Beznea (4):
  ASoC: dt-bindings: microchip: use proper naming syntax
  ASoC: mchp-pdmc: use runtime pm for clock power saving
  ASoC: mchp-pdmc: add support for suspend to RAM
  ASoC: mchp-spdiftx: use FIELD_PREP() where possible

 .../bindings/sound/mchp,i2s-mcc.yaml          | 108 -------------
 ...,pdmc.yaml => microchip,sama7g5-pdmc.yaml} |   0
 ...rx.yaml => microchip,sama7g5-spdifrx.yaml} |   0
 ...tx.yaml => microchip,sama7g5-spdiftx.yaml} |   0
 sound/soc/atmel/mchp-pdmc.c                   | 145 ++++++++++++------
 sound/soc/atmel/mchp-spdiftx.c                |   8 +-
 6 files changed, 101 insertions(+), 160 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
 rename Documentation/devicetree/bindings/sound/{microchip,pdmc.yaml => microchip,sama7g5-pdmc.yaml} (100%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdifrx.yaml => microchip,sama7g5-spdifrx.yaml} (100%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdiftx.yaml => microchip,sama7g5-spdiftx.yaml} (100%)

-- 
2.34.1

