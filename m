Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0487F62432C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKJN1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKJN11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:27:27 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0371F13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:27:25 -0800 (PST)
X-UUID: e7d423d543bd47e0b46778ba1c5491c0-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=S8W6/VsKY9UBnV+rl6xlAuNJ77NeZ4guQ3Yk9GbydsY=;
        b=rgnvi34RUZgE7I1TKuea+OOjW01mxCfJArfXiccXJFrtnCcQoDcpFzeMrPjo/2uUDYfTqJ8dYLnS9fbT5KCF5J0e75m/2G7y944/SlNQYk2PT8ID7wV/Xs6/cZWSPrQfdSd+55WPcsTKE45mksLQQxRhFKcfTaToxjDhz0UhG4M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:daf2ea40-0b73-4d8d-b2ef-52c26726cc5b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:4886315d-100c-4555-952b-a62c895efded,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e7d423d543bd47e0b46778ba1c5491c0-20221110
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 551466290; Thu, 10 Nov 2022 21:27:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 21:27:18 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 10 Nov 2022 21:27:17 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
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
        Tianping Fang <tianping.fang@mediatek.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 1/3] phy: mediatek: fix build warning caused by clang for powerpc
Date:   Thu, 10 Nov 2022 21:27:14 +0800
Message-ID: <20221110132716.12294-1-chunfeng.yun@mediatek.com>
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

