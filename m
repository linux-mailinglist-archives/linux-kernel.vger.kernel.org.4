Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4283A696910
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBNQQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBNQQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:16:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2EFC5;
        Tue, 14 Feb 2023 08:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676391414; x=1707927414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ed9OZgaBIh0K4cnf+bMJJOjsYI0DgmyhIgZsOzpMPvw=;
  b=RBIOgHP+6RvvgelM4QOyb7/qw0yr2NLBYFn23R7NsV+UAnde9oTxjX3U
   Zs+iv1l6LQfR5FIrNCDaz8XuV2xDVRrTTlnImLB50LWT7GrTsIxfvcwVo
   zvuj3ghrD6At2q1y5IX5yAghQeZurqAq3Bf22u1IQAkuG+UeBBpVMZBa8
   MbeJukxA/jY/FGaE1PuHMJX6s8Pn5QUBgbFvhb3I3kK2sk0QCq/lsCdnL
   4q6g/AzqQcLyh3JZneR3voHfY+k/jYJjedijiQ3Tl62AcP8X9mL0XeIQC
   jQoYYtGw3BRMKe5ue8skULcV+ifs7fRw59q3b1f54czfEMgB/XV25iz9N
   w==;
X-IronPort-AV: E=Sophos;i="5.97,297,1669100400"; 
   d="scan'208";a="200644035"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2023 09:16:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 09:16:53 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 09:16:43 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] ASoC: mchp-pdmc: fix poc noises when starting capture
Date:   Tue, 14 Feb 2023 18:14:32 +0200
Message-ID: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
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
For step 6 was added patch 1/3 from this series. With this, driver sets
its struct snd_dmaengine_pcm_config::start_dma_last = 1 and proper
action is taken based on this flag when starting DAI trigger vs DMA.

The other solution that was identified for this was to extend the already
existing mechanism around struct snd_soc_dai_link::stop_dma_first. The downside
of this was that a potential struct snd_soc_dai_link::start_dma_last
would have to be populated on sound card driver thus, had to be taken
into account in all sound card drivers. At the moment, the mchp-pdmc is used
only with simple-audio-card. In case of simple-audio-card a new DT
binding would had to be introduced to specify this action on dai-link
descriptions (as of my investigation).

Please advice what might be the best approach.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  ASoC: soc-generic-dmaengine-pcm: add option to start DMA after DAI
  ASoC: dt-bindings: sama7g5-pdmc: add microchip,startup-delay-us
    binding
  ASoC: mchp-pdmc: fix poc noise at capture startup

 .../sound/microchip,sama7g5-pdmc.yaml         |  6 ++
 include/sound/dmaengine_pcm.h                 |  1 +
 include/sound/soc-component.h                 |  2 +
 sound/soc/atmel/mchp-pdmc.c                   | 55 +++++++++++++++++--
 sound/soc/soc-generic-dmaengine-pcm.c         |  8 ++-
 sound/soc/soc-pcm.c                           | 27 +++++++--
 6 files changed, 86 insertions(+), 13 deletions(-)

-- 
2.34.1

