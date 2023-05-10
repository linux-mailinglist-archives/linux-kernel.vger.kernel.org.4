Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9496FD4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjEJD4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjEJDzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:55:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AD526B8;
        Tue,  9 May 2023 20:55:32 -0700 (PDT)
X-UUID: 80c45b2ceee611ed9cb5633481061a41-20230510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KFl4o2oTEXIuC50VUjceM5T7L1ImEjmdWMIVmJIbIvc=;
        b=jKfy59Y1vONy/t1+KS9cKxwxovYtuLkW8OxpvhnFHiNK59mQwo9imP+zy54SUBVGoUaae7KjvJkF5zxjIfnUrtxaDRchR2Zxlnxou07miK+vTzS+AqusVbFiW6yY6d6cUjTMPlkaQhun6f2YtkKcDJZd2UooD8JWrGNNnzaVM10=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:b51a0dff-3b6d-47b4-a77f-84bd3675140c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:051d516b-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 80c45b2ceee611ed9cb5633481061a41-20230510
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 419546605; Wed, 10 May 2023 11:55:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 11:55:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 11:55:28 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/9] ASoC: mediatek: mt8188: revise AFE driver
Date:   Wed, 10 May 2023 11:55:17 +0800
Message-ID: <20230510035526.18137-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series of patches consists of four major changes.
First, remove redundant supply for ADDA DAI dirver. Second, revise ETDM
control including APLL dynamic switch via DAPM, so APLL can be enabled
when it is really required. Third, update AFE probe function. Bus
protection change was dropped at the previous patch because the dependent
change was not accepted at that time. Finally, correct some binding errors
and add required clocks.

Changes since v3:
  - correct errors in binding file
  - add required clocks which are possibly used in the future

Changes since v2:
  - remove required properties in dt-binding file

Changes since v1:
  - replace unnecessary dev_info with dev_dbg
  - fix dt-binging ABI breaking behavior

Trevor Wu (9):
  ASoC: mediatek: mt8188: remove supply AUDIO_HIRES
  ASoC: mediatek: mt8188: complete set_tdm_slot function
  ASoC: mediatek: mt8188: revise ETDM control flow
  ASoC: mediatek: mt8188: refine APLL control
  ASoC: mediatek: mt8188: combine afe component registration
  ASoC: mediatek: mt8188: add bus protection
  ASoC: mediatek: mt8188: add required clocks
  ASoC: dt-bindings: mediatek,mt8188-afe: correct clock name
  ASoC: dt-bindings: mediatek,mt8188-afe: add audio properties

 .../bindings/sound/mediatek,mt8188-afe.yaml   |  66 +-
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c    | 142 ++-
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h    |  15 +
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    | 113 ++-
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c   |  37 -
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c   | 922 ++++++++++--------
 sound/soc/mediatek/mt8188/mt8188-reg.h        |   2 +
 7 files changed, 795 insertions(+), 502 deletions(-)

-- 
2.18.0

