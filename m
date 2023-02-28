Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1801E6A5762
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjB1LCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjB1LB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:01:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9A35BA9;
        Tue, 28 Feb 2023 03:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677582115; x=1709118115;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uqW3J0nWK2v55D9GYjZBWcYdTtQfZj4KNiRlbuF0uC8=;
  b=PwLIJyIiLu1gsuPHvQljrNAzB5xmSjMqOZm/+1Em96u7s1YjFWYupDh/
   j+F8bzJTt+VmdzhKdbuqjkwUmLtL5hDPRO9n1kxyNtt2hGdLNOsOHP//g
   nqf+xStjaAITfGy+nSPVRO3DdwIhssb/enardbIJNvCqu0ADtxtHD8MVX
   KVjznEMnxL+ZcK1g1wBqs1tkKD8bREKo9RbmnmDKoUZn7tVoG53oihcxA
   kgvGhJ94ACq7GL+cNCMmirkzrTUmJjP95mjV5VnX5prTYMdb0uPEClT2x
   jaevvM3dk/1IcOZC2bcygE9YB5DVHBMzssNnctTFOEyQtV4NYs8GkZ3zD
   w==;
X-IronPort-AV: E=Sophos;i="5.98,221,1673938800"; 
   d="scan'208";a="213967684"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2023 04:01:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 04:01:54 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 04:01:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/3] ASoC: mchp-pdmc: fix poc noises when starting capture
Date:   Tue, 28 Feb 2023 13:01:42 +0200
Message-ID: <20230228110145.3770525-1-claudiu.beznea@microchip.com>
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

Changes in v3:
- update the commit message of patch 2/3 to be more descriptive
- in patch 3/3 initialize dd->startup_delay_us before calling
  of_property_read_u32() and don't check its return value; property is optional
  and the the default value is 150ms 

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


Claudiu Beznea (3):
  ASoC: soc-pcm: add option to start DMA after DAI
  ASoC: dt-bindings: sama7g5-pdmc: add microchip,startup-delay-us
    binding
  ASoC: mchp-pdmc: fix poc noise at capture startup

 .../sound/microchip,sama7g5-pdmc.yaml         |  6 +++
 include/sound/soc-component.h                 |  2 +
 sound/soc/atmel/mchp-pdmc.c                   | 53 +++++++++++++++++--
 sound/soc/soc-pcm.c                           | 27 ++++++++--
 4 files changed, 78 insertions(+), 10 deletions(-)

-- 
2.34.1

