Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94DB68B856
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjBFJL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjBFJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:11:24 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E8540D2;
        Mon,  6 Feb 2023 01:11:20 -0800 (PST)
X-UUID: 330d3cfea5fe11ed945fc101203acc17-20230206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zkkGEptdcWzfg6Wo61o31AGU1sxDPuS2Rq0VohDQEDA=;
        b=cyNYCtwXM0MDTqJZHdqNyYuCUXfjZ1bpVnfE3nGrP6Tt0K677k9DKb41e1RtGOrTI2lrWukPytIq14hJ9VvtbMgiC0zWe8fEZmnk/YOMBa/8sZytgyQqwEPLaz6udRiT+LNduv2OlgmLshUPBkRTiVjWQbmyHgVLagkm2u0QY6U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:ec263648-de86-4b30-9024-41fe2ed2aece,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:885ddb2,CLOUDID:da2499f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 330d3cfea5fe11ed945fc101203acc17-20230206
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1324486426; Mon, 06 Feb 2023 17:11:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 6 Feb 2023 17:11:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 6 Feb 2023 17:11:10 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v7 0/6] add support for MT8195 VPPSYS on MMSYS and MUTEX
Date:   Mon, 6 Feb 2023 17:11:03 +0800
Message-ID: <20230206091109.1324-1-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6:
- Rebase on linux-next.
- For MMSYS api changes, fix corresponding functionality in [4/6] patch.

Changes since v5:
- Depend on :
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=713031

Changes since v4:
- Rebase on linux-next.
- Remove MMSYS fallback compatible.
- Migrate MT8195 VPPSYS0/1 from clock to mtk-mmsys driver.

Changes since v3:
- Rebase on linux-next.

Changes since v2:
- Depend on :
  [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
- Split dts settings into two patches based on belonging to MMSYS or MUTEX.

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
  arm64: dts: mediatek: mt8195: add MUTEX configuration for VPPSYS

Roy-CW.Yeh (5):
  dt-bindings: soc: mediatek: Add support for MT8195 VPPSYS
  arm64: dts: mediatek: mt8195: add MMSYS configuration for VPPSYS
  soc: mediatek: mmsys: add config api for RSZ switching and DCM
  soc: mediatek: mutex: Add mtk_mutex_set_mod support to set MOD1
  soc: mediatek: mutex: support MT8195 VPPSYS

 .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  26 +++-
 drivers/soc/mediatek/mt8195-mmsys.h           |  13 ++
 drivers/soc/mediatek/mtk-mmsys.c              |  44 ++++++
 drivers/soc/mediatek/mtk-mutex.c              | 135 +++++++++++++++++-
 include/linux/soc/mediatek/mtk-mmsys.h        |   6 +
 include/linux/soc/mediatek/mtk-mutex.h        |  35 +++++
 7 files changed, 249 insertions(+), 11 deletions(-)

-- 
2.18.0

