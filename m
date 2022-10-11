Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC24D5FAD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJKHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJKHEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:04:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC5F857DB;
        Tue, 11 Oct 2022 00:04:03 -0700 (PDT)
X-UUID: a9ee2ea3f0fb494ebf835a562f2a0be6-20221011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vgyP3iJSMe9TwBKbKheoFtjDlfAFaGgHy8h/DUtQK6k=;
        b=sXh6vLHT52FSryzxa0SZw6NMmKLeFS9NmpyERvqyikVoI6pc8CvinNlzTx3zKB1SGgLKS8tuzzMb4PSDU779l3Z975RmRya22DNPFrO+QX6yXyoXrX6HWnFegs5kAJfDcSQBtZOlSyTnGuCzf5J9cbAMX3DafxnzsN0+70gbVg0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:e9f94e92-d55d-4ba4-9b5a-ddf24f665038,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:0ff81501-cdeb-479d-93af-53f947adce9d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a9ee2ea3f0fb494ebf835a562f2a0be6-20221011
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 493829069; Tue, 11 Oct 2022 15:03:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 11 Oct 2022 15:03:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Oct 2022 15:03:56 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v2 0/7] add support for MT8195 VPPSYS on MMSYS and MUTEX
Date:   Tue, 11 Oct 2022 15:03:49 +0800
Message-ID: <20221011070356.682-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Depend on :
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
- Add compatible names to VPPSYS0 and VPPSYS1 in MMSYS binding file.
- Fix VPPSYS's MMSYS and MUTEX dts to pass the dtsb_check.
- Rename mtk_mmsys_merge_config() and mtk_mmsys_rsz_dcm_config() to
  mtk_mmsys_vpp_rsz_merge_config() and mtk_mmsys_vpp_rsz_dcm_config().
- Clean up mtk_mmsys_vpp_rsz_dcm_config().
- Add a comment to mtk_mutex_write_mod() and clean it up for use in more
  than 32 mods.

Hi,

This series add support for MT8195's two VPPSYS(Video Processor Pipe Subsystem),
under which there will be corresponding MMSYS and MUTEX settings that
need to be configured.

Moudy Ho (1):
  dt-bindings: arm: mediatek: mmsys: Add support for MT8195 VPPSYS

Roy-CW.Yeh (6):
  dt-bindings: soc: mediatek: Add support for MT8195 VPPSYS
  dts: arm64: mt8195: add MMSYS and MUTEX configuration for VPPSYS
  soc: mediatek: mmsys: add support for MT8195 VPPSYS
  soc: mediatek: mmsys: add config api for RSZ switching and DCM
  soc: mediatek: mutex: Add mtk_mutex_set_mod support to set MOD1
  soc: mediatek: mutex: support MT8195 VPPSYS

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   5 +-
 .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  30 +++-
 drivers/soc/mediatek/mt8195-mmsys.h           |  13 ++
 drivers/soc/mediatek/mtk-mmsys.c              |  64 +++++++++
 drivers/soc/mediatek/mtk-mmsys.h              |   1 +
 drivers/soc/mediatek/mtk-mutex.c              | 135 +++++++++++++++++-
 include/linux/soc/mediatek/mtk-mmsys.h        |   4 +
 include/linux/soc/mediatek/mtk-mutex.h        |  35 +++++
 9 files changed, 276 insertions(+), 12 deletions(-)

-- 
2.18.0

