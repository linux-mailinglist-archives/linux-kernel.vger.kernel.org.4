Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF97685D1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBACJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjBACJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:09:52 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DA32686C;
        Tue, 31 Jan 2023 18:09:32 -0800 (PST)
X-UUID: 73d31d6ca1d511ed945fc101203acc17-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=uZQlJmnF/+Yv7xhOhj08U2bLyxxao2MYgk/ImgAraJc=;
        b=CsMPYaVKRUd8y+rW2KU+4XHBVmCwazdKiAUR8IRhW4PEMXMTKZIX7ylhZHrk2xN184mJn7vXvVBRdsYGPXcnO2TdMksPBgW48qjA9WgQ1MKFdH1a+9JWRjnsiXMTHslc40Iv1ZFKVVjcdDmqgiMSVtYtZqsDhWg4FIV6UuqkB1o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:97ae4d56-c983-49de-bd68-98506ec7496f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.18,REQID:97ae4d56-c983-49de-bd68-98506ec7496f,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:3ca2d6b,CLOUDID:db36ea55-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230201100928JNPH1VG8,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 73d31d6ca1d511ed945fc101203acc17-20230201
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1707502869; Wed, 01 Feb 2023 10:09:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Feb 2023 10:09:24 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Feb 2023 10:09:23 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chuanhong Guo <gch981213@gmail.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benliang.zhao@mediatek.com>,
        <bin.zhang@mediatek.com>
Subject: [PATCH v6 0/5] Add MediaTek MT7986 SPI NAND support
Date:   Wed, 1 Feb 2023 10:09:16 +0800
Message-ID: <20230201020921.26712-1-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch series split from bellow series which pick-up spi relevant patches
https://lore.kernel.org/all/20230130030656.12127-1-xiangsheng.hou@mediatek.com.
This series add MediaTek MT7986 SPI NAND controller support, add read latch
latency, smaple delay adjust and add optional nfi_hclk.

Changes since V5:
 - Split spi relevant patches from previous series V4

Changes since V4:
 - none

Changes since V3:
 - none

Changes since V2:
 - Change snfi mediatek,rx-latch-latency to mediatek,rx-latch-latency-ns.

Changes since V1:
 - Use existing sample delay property.
 - Add restricting for optional nfi_hclk.
 - Improve and perfect dt-bindings documentation.

Xiangsheng Hou (5):
  spi: mtk-snfi: Change default page format to setup default setting
  spi: mtk-snfi: Add optional nfi_hclk which is needed for MT7986
  dt-bindings: spi: mtk-snfi: Add compatible for MT7986
  spi: mtk-snfi: Add snfi sample delay and read latency adjustment
  dt-bindings: spi: mtk-snfi: Add read latch latency property

 .../bindings/spi/mediatek,spi-mtk-snfi.yaml   | 54 +++++++++++++++----
 drivers/spi/spi-mtk-snfi.c                    | 41 +++++++++++++-
 2 files changed, 84 insertions(+), 11 deletions(-)

-- 
2.25.1

