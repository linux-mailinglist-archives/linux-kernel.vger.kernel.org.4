Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A47652BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiLUDof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiLUDoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:44:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA461EAE1;
        Tue, 20 Dec 2022 19:44:18 -0800 (PST)
X-UUID: 8cfb122b2b4a457bbde9c29fb8a0996c-20221221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UZa93UET80bJSwOG9nn9/Z7Z/jlBWTvj0iQxh9MxR+w=;
        b=tzAVQlVn0Aam263ZlhvRJdZLuyGYeBtVPBiws7HaP4sCT1Xl3xKz3Tkuu6+AdF9auwptLQgZTZI70/5VQzLiMOgUtqwOoRvg2PE95lur6OUTVqBz+jpC6a9rjDn5ZJrTGdNHlPJDGAn3Q7focVXoX0U/Rd+3KOKnCn5niQaOs2A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:39f7488b-92e4-44f9-9191-c878f9a3082c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:39f7488b-92e4-44f9-9191-c878f9a3082c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:1e3283f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:2212211144139IVENG50,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8cfb122b2b4a457bbde9c29fb8a0996c-20221221
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1577682678; Wed, 21 Dec 2022 11:44:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 21 Dec 2022 11:44:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 21 Dec 2022 11:44:09 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 0/6] Add ADSP power domains controller support for MT8192
Date:   Wed, 21 Dec 2022 11:44:01 +0800
Message-ID: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on matthias github, v6.1-next.
The previous discussion: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20221201073328.1559-1-allen-kh.cheng@mediatek.com/

Change from v1:
 - move allOf before additionalProperties
 - add buck isolation setting patches into series

Allen-KH Cheng (6):
  soc: mediatek: pm-domains: Add buck isolation offset and mask to power
    domain data
  soc: mediatek: pm-domains: Add buck isolation setting in power domain
  dt-bindings: power: Add MT8192 ADSP power domain
  soc: mediatek: pm-domains: Add ADSP power domain data for MT8192
  dt-bindings: arm: mediatek: Add missing power-domains property
  arm64: dts: mediatek: Add the missing ADSP power domains controller
    for MT8192

 .../arm/mediatek/mediatek,mt8192-clock.yaml     | 17 +++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi        |  9 +++++++++
 drivers/soc/mediatek/mt8192-pm-domains.h        | 16 ++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c           |  8 ++++++++
 drivers/soc/mediatek/mtk-pm-domains.h           |  5 +++++
 include/dt-bindings/power/mt8192-power.h        |  1 +
 6 files changed, 56 insertions(+)

-- 
2.18.0

