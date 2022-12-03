Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89824641765
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 15:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLCO5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 09:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLCO5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:57:16 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB642180D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 06:57:15 -0800 (PST)
X-UUID: 496056c72d8947ebabd907ef0a67121f-20221203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vE6F+amuL4HQg98ufXdb8r3lFmPXWGUPA/C/k40J0dM=;
        b=EYNOqUNBhtkGFTkZGZFeBQ66FU2uItNyfPbIhlQzV1iGGcFOpUMMfpo6gJPLkm50kcz3IzR197s0x+zUYhDUWD92YEQKf73yNtwHtKVeoEyB93dBi16pBTa2KETm879Upqby2Xys0y6JqJK04Os2/n7D/MZqXRU40h8DTTG5Ogs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:f078b99a-95fe-424d-b349-51a16681c8d4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:f078b99a-95fe-424d-b349-51a16681c8d4,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:be970c1f-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:2212032256065BJ1DV4N,BulkQuantity:1,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 496056c72d8947ebabd907ef0a67121f-20221203
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 620522784; Sat, 03 Dec 2022 22:56:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 3 Dec 2022 22:56:01 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 3 Dec 2022 22:56:00 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, Eddie Hung <eddie.hung@mediatek.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 1/3] phy: mediatek: fix build warning caused by clang for powerpc
Date:   Sat, 3 Dec 2022 22:55:57 +0800
Message-ID: <20221203145559.24763-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Remove the temporary @mask_, this may cause build warning when use clang
compiler for powerpc, but can't reproduce it when compile for arm64.
the build warning is -Wtautological-constant-out-of-range-compare, and
caused by
"BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask)"

After removing @mask_, there is a "CHECK:MACRO_ARG_REUSE" when run
checkpatch.pl, due to @mask is constant, no reuse problem will happen.

Fixes: 84513eccd678 ("phy: mediatek: fix build warning of FIELD_PREP()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v5: no changes
v4 new patch, I'm not sure it can fix build warning, due to I don't cross compile
    it for powerpc using clang in office.
---
 drivers/phy/mediatek/phy-mtk-io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-io.h b/drivers/phy/mediatek/phy-mtk-io.h
index d20ad5e5be81..58f06db822cb 100644
--- a/drivers/phy/mediatek/phy-mtk-io.h
+++ b/drivers/phy/mediatek/phy-mtk-io.h
@@ -39,8 +39,8 @@ static inline void mtk_phy_update_bits(void __iomem *reg, u32 mask, u32 val)
 /* field @mask shall be constant and continuous */
 #define mtk_phy_update_field(reg, mask, val) \
 ({ \
-	typeof(mask) mask_ = (mask);	\
-	mtk_phy_update_bits(reg, mask_, FIELD_PREP(mask_, val)); \
+	BUILD_BUG_ON_MSG(!__builtin_constant_p(mask), "mask is not constant"); \
+	mtk_phy_update_bits(reg, mask, FIELD_PREP(mask, val)); \
 })
 
 #endif
-- 
2.18.0

