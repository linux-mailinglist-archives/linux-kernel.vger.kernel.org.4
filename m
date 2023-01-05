Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA065E69A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjAEIRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjAEIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:17:29 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E713D58318;
        Thu,  5 Jan 2023 00:16:37 -0800 (PST)
X-UUID: 17a39103e3bf466c8e360372f147b107-20230105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eh4Cs4ZcRBlSDIsPuhVfHQleWBG2pqk8rqGH33Owp/w=;
        b=O/vFgLdcRUf3tdYEWpu4snj+t6mEzVljkcmr/Yhh96gA59UNXHZrtJEzDOgl7Yvb7dhNPE3P/ucvvpB6q8SGxaZaWFXIbkP1TnUvKcHpo2s+Z3WW2GzXiNFzk5s4wfBWcjZSF/WoGfinZLqAOTs0e61zF7hOFyBfLReKh6pygno=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:dd763e38-c8ab-4321-9eaf-290c420394d8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.17,REQID:dd763e38-c8ab-4321-9eaf-290c420394d8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:543e81c,CLOUDID:e9ece2f4-ff42-4fb0-b929-626456a83c14,B
        ulkID:230105161614ANHU65AJ,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: 17a39103e3bf466c8e360372f147b107-20230105
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 224817926; Thu, 05 Jan 2023 16:16:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 5 Jan 2023 16:16:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 5 Jan 2023 16:16:13 +0800
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
Subject: [PATCH v5 00/13] ASoC: mediatek: Add support for MT8188 SoC
Date:   Thu, 5 Jan 2023 16:15:53 +0800
Message-ID: <20230105081606.6582-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support for Mediatek AFE of MT8188 SoC.
Patches are based on broonie tree "for-next" branch.

Changes since v4:
  - refine etdm dai driver based on reviewer's suggestions
  - refine dt-binding files based on reviewer's suggestions

Changes since v3:
  - replace apll_ck with apll to sync with the relationship in CCF
  - add mtk-soundcard-driver.c to support codec parsing
  - drop mclk-always-on-rates support in mt8188-dai-etdm.c
  - refine dt-binding files based on reviewer's suggestions

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

Trevor Wu (13):
  ASoC: mediatek: common: add SMC ops and SMC CMD
  ASoC: mediatek: mt8188: add common header
  ASoC: mediatek: mt8188: support audsys clock
  ASoC: mediatek: mt8188: support adda in platform driver
  ASoC: mediatek: mt8188: support etdm in platform driver
  ASoC: mediatek: mt8188: support pcmif in platform driver
  ASoC: mediatek: mt8188: support audio clock control
  ASoC: mediatek: mt8188: add platform driver
  ASoC: mediatek: mt8188: add control for timing select
  ASoC: dt-bindings: mediatek,mt8188-afe: add audio afe document
  ASoC: mediatek: common: add soundcard driver common code
  ASoC: mediatek: mt8188: add machine driver with mt6359
  ASoC: dt-bindings: mediatek,mt8188-mt6359: add mt8188-mt6359 document

 .../bindings/sound/mediatek,mt8188-afe.yaml   |  208 +
 .../sound/mediatek,mt8188-mt6359.yaml         |   97 +
 sound/soc/mediatek/Kconfig                    |   23 +
 sound/soc/mediatek/Makefile                   |    1 +
 sound/soc/mediatek/common/Makefile            |    2 +-
 sound/soc/mediatek/common/mtk-base-afe.h      |   19 +
 .../mediatek/common/mtk-soundcard-driver.c    |   79 +
 .../mediatek/common/mtk-soundcard-driver.h    |   14 +
 sound/soc/mediatek/mt8188/Makefile            |   15 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c    |  658 ++++
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h    |  115 +
 sound/soc/mediatek/mt8188/mt8188-afe-common.h |  151 +
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    | 3359 +++++++++++++++++
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.c |  205 +
 sound/soc/mediatek/mt8188/mt8188-audsys-clk.h |   15 +
 .../soc/mediatek/mt8188/mt8188-audsys-clkid.h |   83 +
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c   |  632 ++++
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c   | 2588 +++++++++++++
 sound/soc/mediatek/mt8188/mt8188-dai-pcm.c    |  367 ++
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     |  785 ++++
 sound/soc/mediatek/mt8188/mt8188-reg.h        | 3180 ++++++++++++++++
 21 files changed, 12595 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8188-afe.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
 create mode 100644 sound/soc/mediatek/common/mtk-soundcard-driver.c
 create mode 100644 sound/soc/mediatek/common/mtk-soundcard-driver.h
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

