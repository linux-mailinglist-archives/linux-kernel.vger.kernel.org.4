Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEA26E0BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjDMKri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:47:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C263CA;
        Thu, 13 Apr 2023 03:47:26 -0700 (PDT)
X-UUID: 8fba5aead9e811edb6b9f13eb10bd0fe-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MyZMZdgvFlBgGHc9fU8TE+T3ZTrU0IQYLqH+CTEw/R8=;
        b=gLm8EM70fkxwpaIUFG0epXDZELlcBk2NyVQrz/GWZlGNqlyBJHUdb00w5HntlHYPYYOWA1NdMuM6UkKADZbkv26/uOaNaNjGD1O5/eHMnX6wbLBJfl/TQN5ROUdGImdN8aBbANpbZqoXiMUMpgD1wfPDEZ2ci5qrJaFYwtEzwDY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:c3a45b9a-5dd5-4314-bb96-a44b0d9e3004,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:c3a45b9a-5dd5-4314-bb96-a44b0d9e3004,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:cdbb37a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230413184721Z3BDBYIJ,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 8fba5aead9e811edb6b9f13eb10bd0fe-20230413
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 382357207; Thu, 13 Apr 2023 18:47:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Apr 2023 18:47:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 13 Apr 2023 18:47:17 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/7] ASoC: mediatek: mt8188: revise AFE driver
Date:   Thu, 13 Apr 2023 18:47:06 +0800
Message-ID: <20230413104713.7174-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series of patches consists of three major changes.
First, remove redundant supply for ADDA DAI dirver. Second, revise ETDM
control including APLL dynamic switch via DAPM, so APLL can be enabled
when it is really required. Finally, AFE probe function is updated. Bus
protection change was dropped at the previous patch because the dependent
change was not accepted.

Trevor Wu (7):
  ASoC: mediatek: mt8188: remove supply AUDIO_HIRES
  ASoC: mediatek: mt8188: complete set_tdm_slot function
  ASoC: mediatek: mt8188: revise ETDM control flow
  ASoC: mediatek: mt8188: refine APLL control
  ASoC: mediatek: mt8188: combine afe component registration
  ASoC: mediatek: mt8188: add bus protection
  ASoC: dt-bindings: mediatek,mt8188-afe: add audio properties

 .../bindings/sound/mediatek,mt8188-afe.yaml   |  18 +
 sound/soc/mediatek/mt8188/mt8188-afe-clk.c    | 138 ++-
 sound/soc/mediatek/mt8188/mt8188-afe-clk.h    |  11 +
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    | 113 ++-
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c   |  37 -
 sound/soc/mediatek/mt8188/mt8188-dai-etdm.c   | 922 ++++++++++--------
 sound/soc/mediatek/mt8188/mt8188-reg.h        |   2 +
 7 files changed, 759 insertions(+), 482 deletions(-)

-- 
2.18.0

