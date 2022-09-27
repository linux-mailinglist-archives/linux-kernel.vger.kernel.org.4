Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF05EBF77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiI0KMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiI0KLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:11:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A159D9F77F;
        Tue, 27 Sep 2022 03:11:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 78DF1660226A;
        Tue, 27 Sep 2022 11:11:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664273499;
        bh=c6labVOlxHaBOFZ68h/R4tczr9z6s9kpvKf0dE8Nn84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mn30Af4O5NTdRp/rdLb5NOwwOHcYSYdQ5r8uJBFsgAjZfhiKCni9vF2iNDherWzQf
         WJFB9Uha2sWGCbI1BV9CD3yFayxxAYNdhiDMBpIqpXAcohnuvB9NppEGry43EBy87M
         9jsSLyYC2vXD/dlXaNukDHdwfNU+6OTiJmOmeACSleSO2ViQTPdiItOx4dBlPfebr2
         9aykN7n9sG2tLuux/w2fLlbyQsMTyMtpsiN42GrQ5SKNpL6i+g3z2angTgY1kjHquz
         M5jgwzgSsWJg0u20LjXNa0uHMkf2K5uzckeex7/cIs438rJZJw2u0/YZZqwGmzwqkM
         xN836mOHP/iKg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v3 05/10] clk: mediatek: clk-mt8195-mfg: Reparent mfg_bg3d and propagate rate changes
Date:   Tue, 27 Sep 2022 12:11:23 +0200
Message-Id: <20220927101128.44758-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
References: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MFG_BG3D is a gate to enable/disable clock output to the GPU,
but the actual output is decided by multiple muxes; in particular:
mfg_ck_fast_ref muxes between "slow" (top_mfg_core_tmp) and
"fast" (MFGPLL) clock, while top_mfg_core_tmp muxes between the
26MHz clock and various system PLLs.

The clock gate comes after all the muxes, so its parent is
mfg_ck_fast_reg, not top_mfg_core_tmp.
Reparent MFG_BG3D to the latter to match the hardware and add the
CLK_SET_RATE_PARENT flag to it: this way we ensure propagating
rate changes that are requested on MFG_BG3D along its entire clock
tree.

Fixes: 35016f10c0e5 ("clk: mediatek: Add MT8195 mfgcfg clock support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8195-mfg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
index 9411c556a5a9..c94cb71bd9b9 100644
--- a/drivers/clk/mediatek/clk-mt8195-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
@@ -17,10 +17,12 @@ static const struct mtk_gate_regs mfg_cg_regs = {
 };
 
 #define GATE_MFG(_id, _name, _parent, _shift)			\
-	GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+	GATE_MTK_FLAGS(_id, _name, _parent, &mfg_cg_regs,	\
+		       _shift, &mtk_clk_gate_ops_setclr,	\
+		       CLK_SET_RATE_PARENT)
 
 static const struct mtk_gate mfg_clks[] = {
-	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "top_mfg_core_tmp", 0),
+	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_ck_fast_ref", 0),
 };
 
 static const struct mtk_clk_desc mfg_desc = {
-- 
2.37.2

