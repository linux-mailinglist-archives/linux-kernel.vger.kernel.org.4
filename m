Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3685469ABAF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBQMmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBQMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:42:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB23A64B23;
        Fri, 17 Feb 2023 04:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676637724; x=1708173724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U2iLnm4KuI3Sgwn+ds9QR6hu9ocdgvXPg7MffzvqL48=;
  b=hl2JQTefPHUPZfv24BOnO3f15TWJoL5f095xBX1d7SZtTbHJMa3O1vOz
   ybSsBpRK/ll7WbWHEVUEBI7bGrNY3B/wONULA80fZ61RcEQ5EuIwyxQHe
   MRBTSGB5AiNpNhjGo4rDhwKgx+f2sMTqUROaAOYmypqYZYbXMvUR/UVRa
   eyigjwdWoMq+Vcwy/EdSQNTD6yudIgsIgpmnOhezj8PrrHa9sgQX9q2q+
   dHCAybjvjMs65b2NaF7sTRd4JCV7FbqNyWZb2oA0+aCbEBxG7vxLK+6B/
   FE1khUthOTAeH2QHEtQOERPIe/Lo+CNcd3Tw3KxMyuC9wzoAsT4Ef76p7
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="137771389"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 05:42:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 05:42:03 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 17 Feb 2023 05:42:00 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/3] ASoC: mchp-pdmc: fix poc noises when starting capture
Date:   Fri, 17 Feb 2023 14:41:48 +0200
Message-ID: <20230217124151.236216-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
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

To start capture on Microchip PDMC the enable bits for each supported
microphone need to be set. After this bit is set the PDMC starts to
receive data from microphones and it considers this data as valid data.
Thus if microphones are not ready the PDMC captures anyway data from its
lines. This data is interpreted by the human ear as poc noises.

To avoid this the following software workaround need to be applied when
starting capture:
1/ enable PDMC channel
2/ wait 150ms
3/ execute 16 dummy reads from RHR
4/ clear interrupts
5/ enable interrupts
6/ enable DMA channel

For this workaround to work step 6 need to be executed at the end.
For step 6 was added patch 1/3 from this series. With this, component
DAI driver sets its struct snd_soc_component_driver::start_dma_last = 1
and proper action is taken based on this flag when starting DAI trigger
vs DMA.

Thank you,
Claudiu Beznea

Changes in v2:
- patch 1/3 from v1 is now "ASoC: soc-pcm: add option to start DMA after DAI"
- pass start_dma_last from component DAI driver object
  (struct snd_soc_component_driver::start_dma_last); adapt patch 3/3 after this;
- in patch 1/3 s/Do we need to start dma first/Do we need to start dma last
  in comment from soc_pcm_trigger()
- collect review tag from Krzysztof

Claudiu Beznea (3):
  ASoC: soc-pcm: add option to start DMA after DAI
  ASoC: dt-bindings: sama7g5-pdmc: add microchip,startup-delay-us
    binding
  ASoC: mchp-pdmc: fix poc noise at capture startup

 .../sound/microchip,sama7g5-pdmc.yaml         |  6 ++
 include/sound/soc-component.h                 |  2 +
 sound/soc/atmel/mchp-pdmc.c                   | 55 +++++++++++++++++--
 sound/soc/soc-pcm.c                           | 27 +++++++--
 4 files changed, 80 insertions(+), 10 deletions(-)

-- 
2.34.1

