Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A266467B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 04:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLHDc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 22:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLHDc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 22:32:26 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E9498949;
        Wed,  7 Dec 2022 19:32:20 -0800 (PST)
X-UUID: cf29a85ffae24fa4b889bb7fc402f134-20221208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hIAh/4cfvkBefx7856v3sG8Dug39jOkSPROBqAPpPSo=;
        b=LGOoYCWszLP08U3S3fZsbdqEABL3Y/y+Gax7RkN2VgK7rCnCyknc0qKbmAL8T/KkERO+dotUFwN5Va7Z9iKFfzSwLXMawFcflIWHy6wQ8t2a2SINbMJa+WoqGvts8dshOkPNBC8yHf2IBqZp0ll7cNPWyzwEIl4PBc45Q6gq800=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:2709377f-1a83-4b27-8bae-d22bf7e0979c,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:d517e016-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: cf29a85ffae24fa4b889bb7fc402f134-20221208
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 326426183; Thu, 08 Dec 2022 11:32:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 8 Dec 2022 11:32:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 8 Dec 2022 11:32:11 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <p.zabel@pengutronix.de>
CC:     <trevor.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 00/12] ASoC: mediatek: Add support for MT8188 SoC
Date:   Thu, 8 Dec 2022 11:31:36 +0800
Message-ID: <20221208033148.21866-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support for Mediatek AFE of MT8188 SoC.
Patches are based on broonie tree "for-next" branch.

Changes since v2:
  - drop CLK_IGNORE_UNUSED flag 
  - include bitfield.h to reslove the issue reported by kernel test robot
  - rename mt8188-afe-pcm.yaml to mt8188-afe.yaml
  - refine dt-binding files based on reviewer's suggestions

Changes since v1:
  - remove bus protection functions in case of unmerged dependency problem
  - replace some bit operation macro with FIELD_PREP
  - simplify register control by regmap_set_bits and regmap_clear_bits
  - fix dt-binding errors
  - rename compatible string for recognition

Trevor Wu (12):
  ASoC: mediatek: common: add SMC ops and SMC CMD
  ASoC: mediatek: mt8188: add common header
  ASoC: mediatek: mt8188: support audsys clock
  ASoC: mediatek: mt8188: support adda in platform driver
  ASoC: mediatek: mt8188: support etdm in platform driver
  ASoC: mediatek: mt8188: support pcmif in platform driver
  ASoC: mediatek: mt8188: support audio clock control
  ASoC: mediatek: mt8188: add platform driver
  ASoC: mediatek: mt8188: add control for timing select
  dt-bindings: mediatek: mt8188: add audio afe document
  ASoC: mediatek: mt8188: add machine driver with mt6359
  dt-bindings: mediatek: mt8188: add mt8188-mt6359 document

 .../devicetree/bindings/sound/mt8188-afe.yaml |  196 +
 .../bindings/sound/mt8188-mt6359.yaml         |   60 +
 sound/soc/mediatek/Kconfig                    |   23 +
 sound/soc/mediatek/Makefile                   |    1 +
 sound/soc/mediatek/common/mtk-base-afe.h      |   19 +
 sound/soc/mediatek/mt8188/Makefile            |   15 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c    |  656 ++++
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h    |  114 +
 sound/soc/mediatek/mt8188/mt8188-afe-common.h |  151 +
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    | 3359 +++++++++++++++++
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c |  205 +
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.h |   15 +
 .../soc/mediatek/mt8188/mt8188-audsys-clkid.h |   83 +
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c   |  632 ++++
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c   | 2591 +++++++++++++
 sound/soc/mediatek/mt8188/mt8188-dai-pcm.c    |  367 ++
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     |  808 ++++
 sound/soc/mediatek/mt8188/mt8188-reg.h        | 3180 ++++++++++++++++
 18 files changed, 12475 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8188-afe.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
 create mode 100644 sound/soc/mediatek/mt8188/Makefile
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-audsys-clk.h
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-audsys-clkid.h
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-mt6359.c
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-reg.h

-- 
2.18.0

