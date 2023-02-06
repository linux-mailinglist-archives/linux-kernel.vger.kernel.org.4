Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55A268C184
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjBFPbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjBFPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:30:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5ED2A174;
        Mon,  6 Feb 2023 07:30:15 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0FB046602F93;
        Mon,  6 Feb 2023 15:30:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697414;
        bh=GpOUfLNoNBLyqKtJemD+2rCvxOWa8Gt/8HCL/s9i2Uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYn1IRGEtMpqfxX0dAOoLPpcnyzczjZ1HuEexGTyUeaMc1BGZVR6wJDz+5a1h4r/t
         TdaTaWrrqwhdBQZ6xeWyFDPNt2nQvhYkEkf1hJb7xJlyLBWMYh7acV8sEQFjTfJMMz
         /8lfzG4xN9zfcS/jnSY65SovnedilmYXZKZ48UCWTCqqfk7Gj5N2ESwV+PFNkCklZF
         o8hovMydH6JAWcHKjAbjZJQ25JZ6SZ9t7J5mCW4FMYG1Tx06vOn8wY07QomasVR3/E
         LdCn5fzPYQf+ltEKXRd3CUXAG2rr1l8zpwnxEkpsUBBHmjWkcMmEJ7axKKahrcgXVM
         RUbjvGbPKqYGg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 20/45] clk: mediatek: Consistently use GATE_MTK() macro
Date:   Mon,  6 Feb 2023 16:29:03 +0100
Message-Id: <20230206152928.918562-21-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
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

All the various MediaTek clock drivers are, in a way or another,
redefining the GATE_MTK() macro with different names: while some
are doing that by actually using GATE_MTK(), others are copying
it entirely (hence, entirely redefining it).

Change all clock drivers to always and consistently use this macro.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt2701-aud.c      | 44 +++--------
 drivers/clk/mediatek/clk-mt2701-bdp.c      | 22 ++----
 drivers/clk/mediatek/clk-mt2701-eth.c      | 11 +--
 drivers/clk/mediatek/clk-mt2701-g3d.c      | 11 +--
 drivers/clk/mediatek/clk-mt2701-hif.c      | 11 +--
 drivers/clk/mediatek/clk-mt2701-img.c      | 10 +--
 drivers/clk/mediatek/clk-mt2701-mm.c       | 20 +----
 drivers/clk/mediatek/clk-mt2701-vdec.c     | 22 ++----
 drivers/clk/mediatek/clk-mt2701.c          | 44 +++--------
 drivers/clk/mediatek/clk-mt2712-bdp.c      | 11 +--
 drivers/clk/mediatek/clk-mt2712-img.c      | 10 +--
 drivers/clk/mediatek/clk-mt2712-jpgdec.c   | 11 +--
 drivers/clk/mediatek/clk-mt2712-mfg.c      | 10 +--
 drivers/clk/mediatek/clk-mt2712-mm.c       | 30 ++------
 drivers/clk/mediatek/clk-mt2712-vdec.c     | 22 ++----
 drivers/clk/mediatek/clk-mt2712-venc.c     | 11 +--
 drivers/clk/mediatek/clk-mt2712.c          | 72 ++++++------------
 drivers/clk/mediatek/clk-mt6765-audio.c    | 22 ++----
 drivers/clk/mediatek/clk-mt6765-cam.c      | 11 +--
 drivers/clk/mediatek/clk-mt6765-img.c      | 10 +--
 drivers/clk/mediatek/clk-mt6765-mipi0a.c   | 11 +--
 drivers/clk/mediatek/clk-mt6765-mm.c       | 10 +--
 drivers/clk/mediatek/clk-mt6765-vcodec.c   | 11 +--
 drivers/clk/mediatek/clk-mt6765.c          | 88 ++++++----------------
 drivers/clk/mediatek/clk-mt6797-img.c      | 10 +--
 drivers/clk/mediatek/clk-mt6797-mm.c       | 20 +----
 drivers/clk/mediatek/clk-mt6797-vdec.c     | 22 ++----
 drivers/clk/mediatek/clk-mt6797-venc.c     | 11 +--
 drivers/clk/mediatek/clk-mt6797.c          | 45 ++++-------
 drivers/clk/mediatek/clk-mt7622-aud.c      | 44 +++--------
 drivers/clk/mediatek/clk-mt7622-eth.c      | 22 ++----
 drivers/clk/mediatek/clk-mt7622-hif.c      | 24 ++----
 drivers/clk/mediatek/clk-mt7622.c          | 66 +++++-----------
 drivers/clk/mediatek/clk-mt7629-eth.c      | 22 ++----
 drivers/clk/mediatek/clk-mt7629-hif.c      | 24 ++----
 drivers/clk/mediatek/clk-mt7629.c          | 44 +++--------
 drivers/clk/mediatek/clk-mt7986-eth.c      | 27 +++----
 drivers/clk/mediatek/clk-mt7986-infracfg.c | 27 +++----
 drivers/clk/mediatek/clk-mt8135.c          | 30 ++------
 drivers/clk/mediatek/clk-mt8167-aud.c      | 12 +--
 drivers/clk/mediatek/clk-mt8167-img.c      | 10 +--
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c   | 10 +--
 drivers/clk/mediatek/clk-mt8167-mm.c       | 20 +----
 drivers/clk/mediatek/clk-mt8167-vdec.c     | 22 ++----
 drivers/clk/mediatek/clk-mt8173-mm.c       | 20 +----
 drivers/clk/mediatek/clk-mt8516-aud.c      | 11 +--
 drivers/clk/mediatek/clk-mt8516.c          | 66 +++++-----------
 47 files changed, 305 insertions(+), 839 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index 1a32d8b7db84..9059e5aa473e 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -15,41 +15,21 @@
 
 #include <dt-bindings/clock/mt2701-clk.h>
 
-#define GATE_AUDIO0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio0_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio1_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO2(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio2_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO3(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio3_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO3(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio3_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate_regs audio0_cg_regs = {
 	.set_ofs = 0x0,
diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index 435ed4819d56..3e5a2241ee1d 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -24,23 +24,13 @@ static const struct mtk_gate_regs bdp1_cg_regs = {
 	.sta_ofs = 0x0110,
 };
 
-#define GATE_BDP0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &bdp0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_BDP0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &bdp0_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_BDP1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &bdp1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_BDP1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &bdp1_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate bdp_clks[] = {
 	GATE_BDP0(CLK_BDP_BRG_BA, "brg_baclk", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index f3cb78e7f6e9..54d9b57f308f 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -16,14 +16,9 @@ static const struct mtk_gate_regs eth_cg_regs = {
 	.sta_ofs = 0x0030,
 };
 
-#define GATE_ETH(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &eth_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_ETH(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &eth_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate eth_clks[] = {
 	GATE_DUMMY(CLK_DUMMY, "eth_dummy"),
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 499a170ba5f9..f071728a0ea4 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -16,14 +16,9 @@
 
 #include <dt-bindings/clock/mt2701-clk.h>
 
-#define GATE_G3D(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &g3d_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_G3D(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &g3d_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate_regs g3d_cg_regs = {
 	.sta_ofs = 0x0,
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index d5465d782993..1ca42a3c5190 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -16,14 +16,9 @@ static const struct mtk_gate_regs hif_cg_regs = {
 	.sta_ofs = 0x0030,
 };
 
-#define GATE_HIF(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &hif_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_HIF(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &hif_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate hif_clks[] = {
 	GATE_DUMMY(CLK_DUMMY, "hif_dummy"),
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index 7e53deb7f990..eb172473f075 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs img_cg_regs = {
 	.sta_ofs = 0x0000,
 };
 
-#define GATE_IMG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &img_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_SMI_COMM, "img_smi_comm", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index a8d94ca0eefd..993d904d619f 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -24,23 +24,11 @@ static const struct mtk_gate_regs disp1_cg_regs = {
 	.sta_ofs = 0x0110,
 };
 
-#define GATE_DISP0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &disp0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_DISP0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &disp0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_DISP1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &disp1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_DISP1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &disp1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mm_clks[] = {
 	GATE_DISP0(CLK_MM_SMI_COMMON, "mm_smi_comm", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index d3089da0ab62..1a0504b04c22 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -24,23 +24,13 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	.sta_ofs = 0x0008,
 };
 
-#define GATE_VDEC0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_VDEC1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate vdec_clks[] = {
 	GATE_VDEC0(CLK_VDEC_CKGEN, "vdec_cken", "vdec_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 06ca81359d35..cf74d4bdb75e 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -636,14 +636,9 @@ static const struct mtk_gate_regs top_aud_cg_regs = {
 	.sta_ofs = 0x012C,
 };
 
-#define GATE_TOP_AUD(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top_aud_cg_regs,		\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_TOP_AUD(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &top_aud_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate top_clks[] = {
 	GATE_TOP_AUD(CLK_TOP_AUD_48K_TIMING, "a1sys_hp_ck", "aud_mux1_div",
@@ -702,14 +697,9 @@ static const struct mtk_gate_regs infra_cg_regs = {
 	.sta_ofs = 0x0048,
 };
 
-#define GATE_ICG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &infra_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_ICG(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate infra_clks[] = {
 	GATE_ICG(CLK_INFRA_DBG, "dbgclk", "axi_sel", 0),
@@ -823,23 +813,13 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 	.sta_ofs = 0x001c,
 };
 
-#define GATE_PERI0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_PERI0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_PERI1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate peri_clks[] = {
 	GATE_PERI0(CLK_PERI_USB0_MCU, "usb0_mcu_ck", "axi_sel", 31),
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index 684d03e9f6de..b6d8086f8067 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -18,14 +18,9 @@ static const struct mtk_gate_regs bdp_cg_regs = {
 	.sta_ofs = 0x100,
 };
 
-#define GATE_BDP(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &bdp_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_BDP(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &bdp_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate bdp_clks[] = {
 	GATE_BDP(CLK_BDP_BRIDGE_B, "bdp_bridge_b", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index 335049cdc856..3ffa51384e6b 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs img_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_IMG(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &img_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_SMI_LARB2, "img_smi_larb2", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index 07ba7c5e80af..97dc2ec8d9cf 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -18,14 +18,9 @@ static const struct mtk_gate_regs jpgdec_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_JPGDEC(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &jpgdec_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_JPGDEC(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &jpgdec_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate jpgdec_clks[] = {
 	GATE_JPGDEC(CLK_JPGDEC_JPGDEC1, "jpgdec_jpgdec1", "jpgdec_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index 42f8cf3ecf4c..8949315c2dd2 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs mfg_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_MFG(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mfg_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MFG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mfg_clks[] = {
 	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 615f6b0fe96e..850cef9f2009 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -30,32 +30,14 @@ static const struct mtk_gate_regs mm2_cg_regs = {
 	.sta_ofs = 0x220,
 };
 
-#define GATE_MM0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MM0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_MM1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MM1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_MM2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MM2(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mm_clks[] = {
 	/* MM0 */
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index 6296ed5c5b55..9519cec19a99 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -24,23 +24,13 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	.sta_ofs = 0x8,
 };
 
-#define GATE_VDEC0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_VDEC1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate vdec_clks[] = {
 	/* VDEC0 */
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index b9bfc35de629..2043b6d3ff1c 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -18,14 +18,9 @@ static const struct mtk_gate_regs venc_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_VENC(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &venc_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VENC(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate venc_clks[] = {
 	GATE_VENC(CLK_VENC_SMI_COMMON_CON, "venc_smi", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 65c1cbcbd54e..568c23620d21 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -814,23 +814,13 @@ static const struct mtk_gate_regs top1_cg_regs = {
 	.sta_ofs = 0x424,
 };
 
-#define GATE_TOP0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
-
-#define GATE_TOP1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_TOP0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr)
+
+#define GATE_TOP1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate top_clks[] = {
 	/* TOP0 */
@@ -854,14 +844,9 @@ static const struct mtk_gate_regs infra_cg_regs = {
 	.sta_ofs = 0x48,
 };
 
-#define GATE_INFRA(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &infra_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_INFRA(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate infra_clks[] = {
 	GATE_INFRA(CLK_INFRA_DBGCLK, "infra_dbgclk", "axi_sel", 0),
@@ -891,32 +876,17 @@ static const struct mtk_gate_regs peri2_cg_regs = {
 	.sta_ofs = 0x42c,
 };
 
-#define GATE_PERI0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
-
-#define GATE_PERI1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
-
-#define GATE_PERI2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_PERI0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
+
+#define GATE_PERI1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
+
+#define GATE_PERI2(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri2_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate peri_clks[] = {
 	/* PERI0 */
diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
index 0aa6c0d352ca..310dd32f4baa 100644
--- a/drivers/clk/mediatek/clk-mt6765-audio.c
+++ b/drivers/clk/mediatek/clk-mt6765-audio.c
@@ -24,23 +24,13 @@ static const struct mtk_gate_regs audio1_cg_regs = {
 	.sta_ofs = 0x4,
 };
 
-#define GATE_AUDIO0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio0_cg_regs,		\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio0_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio1_cg_regs,		\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio1_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate audio_clks[] = {
 	/* AUDIO0 */
diff --git a/drivers/clk/mediatek/clk-mt6765-cam.c b/drivers/clk/mediatek/clk-mt6765-cam.c
index 25f2bef38126..7904f5f44e24 100644
--- a/drivers/clk/mediatek/clk-mt6765-cam.c
+++ b/drivers/clk/mediatek/clk-mt6765-cam.c
@@ -18,14 +18,9 @@ static const struct mtk_gate_regs cam_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_CAM(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &cam_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_CAM(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &cam_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate cam_clks[] = {
 	GATE_CAM(CLK_CAM_LARB3, "cam_larb3", "mm_ck", 0),
diff --git a/drivers/clk/mediatek/clk-mt6765-img.c b/drivers/clk/mediatek/clk-mt6765-img.c
index a62303ef4f41..cfbc907988af 100644
--- a/drivers/clk/mediatek/clk-mt6765-img.c
+++ b/drivers/clk/mediatek/clk-mt6765-img.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs img_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_IMG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &img_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_LARB2, "img_larb2", "mm_ck", 0),
diff --git a/drivers/clk/mediatek/clk-mt6765-mipi0a.c b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
index 25c829fc3866..d6866a66ccef 100644
--- a/drivers/clk/mediatek/clk-mt6765-mipi0a.c
+++ b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
@@ -18,14 +18,9 @@ static const struct mtk_gate_regs mipi0a_cg_regs = {
 	.sta_ofs = 0x80,
 };
 
-#define GATE_MIPI0A(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mipi0a_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_MIPI0A(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mipi0a_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate mipi0a_clks[] = {
 	GATE_MIPI0A(CLK_MIPI0A_CSR_CSI_EN_0A,
diff --git a/drivers/clk/mediatek/clk-mt6765-mm.c b/drivers/clk/mediatek/clk-mt6765-mm.c
index bda774668a36..a4570c9dbefa 100644
--- a/drivers/clk/mediatek/clk-mt6765-mm.c
+++ b/drivers/clk/mediatek/clk-mt6765-mm.c
@@ -18,14 +18,8 @@ static const struct mtk_gate_regs mm_cg_regs = {
 	.sta_ofs = 0x100,
 };
 
-#define GATE_MM(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MM(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mm_clks[] = {
 	/* MM */
diff --git a/drivers/clk/mediatek/clk-mt6765-vcodec.c b/drivers/clk/mediatek/clk-mt6765-vcodec.c
index 2bc1fbde87da..3ce955bbeee2 100644
--- a/drivers/clk/mediatek/clk-mt6765-vcodec.c
+++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
@@ -18,14 +18,9 @@ static const struct mtk_gate_regs venc_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_VENC(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &venc_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VENC(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate venc_clks[] = {
 	GATE_VENC(CLK_VENC_SET0_LARB, "venc_set0_larb", "mm_ck", 0),
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 6f5c92a7f620..470a84748b8d 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -483,32 +483,17 @@ static const struct mtk_gate_regs top2_cg_regs = {
 	.sta_ofs = 0x320,
 };
 
-#define GATE_TOP0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_TOP0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_TOP1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_TOP1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
-#define GATE_TOP2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_TOP2(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top2_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate top_clks[] = {
 	/* TOP0 */
@@ -559,41 +544,21 @@ static const struct mtk_gate_regs ifr5_cg_regs = {
 	.sta_ofs = 0xc8,
 };
 
-#define GATE_IFR2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR2(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ifr2_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_IFR3(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr3_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR3(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ifr3_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_IFR4(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr4_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR4(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ifr4_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_IFR5(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ifr5_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IFR5(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ifr5_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate ifr_clks[] = {
 	/* INFRA_TOPAXI */
@@ -674,14 +639,9 @@ static const struct mtk_gate_regs apmixed_cg_regs = {
 	.sta_ofs = 0x14,
 };
 
-#define GATE_APMIXED(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &apmixed_cg_regs,		\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,		\
-	}
+#define GATE_APMIXED(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate apmixed_clks[] = {
 	/* AUDIO0 */
diff --git a/drivers/clk/mediatek/clk-mt6797-img.c b/drivers/clk/mediatek/clk-mt6797-img.c
index 7c6a53fbb8be..06441393478f 100644
--- a/drivers/clk/mediatek/clk-mt6797-img.c
+++ b/drivers/clk/mediatek/clk-mt6797-img.c
@@ -16,14 +16,8 @@ static const struct mtk_gate_regs img_cg_regs = {
 	.sta_ofs = 0x0000,
 };
 
-#define GATE_IMG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &img_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_FDVT, "img_fdvt", "mm_sel", 11),
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index 706c9775646d..e7a5a43f91f1 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -23,23 +23,11 @@ static const struct mtk_gate_regs mm1_cg_regs = {
 	.sta_ofs = 0x0110,
 };
 
-#define GATE_MM0(_id, _name, _parent, _shift) {			\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &mm0_cg_regs,				\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr,		\
-}
+#define GATE_MM0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_MM1(_id, _name, _parent, _shift) {			\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &mm1_cg_regs,				\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr,		\
-}
+#define GATE_MM1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mm_clks[] = {
 	GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt6797-vdec.c b/drivers/clk/mediatek/clk-mt6797-vdec.c
index 6120fccc859f..1ed5da5c7286 100644
--- a/drivers/clk/mediatek/clk-mt6797-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6797-vdec.c
@@ -24,23 +24,13 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	.sta_ofs = 0x0008,
 };
 
-#define GATE_VDEC0(_id, _name, _parent, _shift) {		\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &vdec0_cg_regs,				\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr_inv,		\
-}
+#define GATE_VDEC0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_VDEC1(_id, _name, _parent, _shift) {		\
-	.id = _id,					\
-	.name = _name,					\
-	.parent_name = _parent,				\
-	.regs = &vdec1_cg_regs,				\
-	.shift = _shift,				\
-	.ops = &mtk_clk_gate_ops_setclr_inv,		\
-}
+#define GATE_VDEC1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate vdec_clks[] = {
 	GATE_VDEC0(CLK_VDEC_CKEN_ENG, "vdec_cken_eng", "vdec_sel", 8),
diff --git a/drivers/clk/mediatek/clk-mt6797-venc.c b/drivers/clk/mediatek/clk-mt6797-venc.c
index 834d3834d2bb..3da96e177ca5 100644
--- a/drivers/clk/mediatek/clk-mt6797-venc.c
+++ b/drivers/clk/mediatek/clk-mt6797-venc.c
@@ -18,14 +18,9 @@ static const struct mtk_gate_regs venc_cg_regs = {
 	.sta_ofs = 0x0000,
 };
 
-#define GATE_VENC(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &venc_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VENC(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate venc_clks[] = {
 	GATE_VENC(CLK_VENC_0, "venc_0", "mm_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 105a512857b3..23c19e6426a1 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -421,40 +421,25 @@ static const struct mtk_gate_regs infra2_cg_regs = {
 	.sta_ofs = 0x00b0,
 };
 
-#define GATE_ICG0(_id, _name, _parent, _shift) {		\
-	.id = _id,						\
-	.name = _name,						\
-	.parent_name = _parent,					\
-	.regs = &infra0_cg_regs,				\
-	.shift = _shift,					\
-	.ops = &mtk_clk_gate_ops_setclr,			\
-}
+#define GATE_ICG0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_ICG1(_id, _name, _parent, _shift)			\
-	GATE_ICG1_FLAGS(_id, _name, _parent, _shift, 0)
+#define GATE_ICG1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_ICG1_FLAGS(_id, _name, _parent, _shift, _flags) {	\
-	.id = _id,						\
-	.name = _name,						\
-	.parent_name = _parent,					\
-	.regs = &infra1_cg_regs,				\
-	.shift = _shift,					\
-	.ops = &mtk_clk_gate_ops_setclr,			\
-	.flags = _flags,					\
-}
+#define GATE_ICG1_FLAGS(_id, _name, _parent, _shift, _flags)		\
+	GATE_MTK_FLAGS(_id, _name, _parent, &infra1_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_setclr, _flags)
 
-#define GATE_ICG2(_id, _name, _parent, _shift)			\
-	GATE_ICG2_FLAGS(_id, _name, _parent, _shift, 0)
+#define GATE_ICG2(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra2_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_ICG2_FLAGS(_id, _name, _parent, _shift, _flags) {	\
-	.id = _id,						\
-	.name = _name,						\
-	.parent_name = _parent,					\
-	.regs = &infra2_cg_regs,				\
-	.shift = _shift,					\
-	.ops = &mtk_clk_gate_ops_setclr,			\
-	.flags = _flags,					\
-}
+#define GATE_ICG2_FLAGS(_id, _name, _parent, _shift, _flags)		\
+	GATE_MTK_FLAGS(_id, _name, _parent, &infra2_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_setclr, _flags)
 
 /*
  * Clock gates dramc and dramc_b are needed by the DRAM controller.
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index b8aabfeb1cba..f676581edbfe 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -16,41 +16,21 @@
 
 #include <dt-bindings/clock/mt7622-clk.h>
 
-#define GATE_AUDIO0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio0_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio1_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO2(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio2_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_AUDIO3(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &audio3_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_AUDIO3(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio3_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate_regs audio0_cg_regs = {
 	.set_ofs = 0x0,
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index aee583fa77d0..bd248277cef7 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -16,14 +16,9 @@
 
 #include <dt-bindings/clock/mt7622-clk.h>
 
-#define GATE_ETH(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &eth_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_ETH(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &eth_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate_regs eth_cg_regs = {
 	.set_ofs = 0x30,
@@ -45,14 +40,9 @@ static const struct mtk_gate_regs sgmii_cg_regs = {
 	.sta_ofs = 0xE4,
 };
 
-#define GATE_SGMII(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &sgmii_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_SGMII(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &sgmii_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate sgmii_clks[] = {
 	GATE_SGMII(CLK_SGMII_TX250M_EN, "sgmii_tx250m_en",
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index ab5cad0c2b1c..33a34576d726 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -16,23 +16,13 @@
 
 #include <dt-bindings/clock/mt7622-clk.h>
 
-#define GATE_PCIE(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &pcie_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
-
-#define GATE_SSUSB(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ssusb_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_PCIE(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &pcie_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_SSUSB(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ssusb_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate_regs pcie_cg_regs = {
 	.set_ofs = 0x30,
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 5a82c2270bfb..d0466f1353fc 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -50,59 +50,29 @@
 		 _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift,  \
 		 NULL, "clkxtal")
 
-#define GATE_APMIXED(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &apmixed_cg_regs,				\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,			\
-	}
+#define GATE_APMIXED(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
-#define GATE_INFRA(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &infra_cg_regs,					\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_setclr,			\
-	}
+#define GATE_INFRA(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_TOP0(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &top0_cg_regs,					\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_no_setclr,			\
-	}
+#define GATE_TOP0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_TOP1(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &top1_cg_regs,					\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_no_setclr,			\
-	}
+#define GATE_TOP1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr)
 
-#define GATE_PERI0(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &peri0_cg_regs,					\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_setclr,			\
-	}
+#define GATE_PERI0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI1(_id, _name, _parent, _shift) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.parent_name = _parent,					\
-		.regs = &peri1_cg_regs,					\
-		.shift = _shift,					\
-		.ops = &mtk_clk_gate_ops_setclr,			\
-	}
+#define GATE_PERI1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
 static DEFINE_SPINLOCK(mt7622_clk_lock);
 
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index a4ae7d6c7a71..cc605cd2d376 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -16,14 +16,9 @@
 
 #include <dt-bindings/clock/mt7629-clk.h>
 
-#define GATE_ETH(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &eth_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_ETH(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &eth_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate_regs eth_cg_regs = {
 	.set_ofs = 0x30,
@@ -45,14 +40,9 @@ static const struct mtk_gate_regs sgmii_cg_regs = {
 	.sta_ofs = 0xE4,
 };
 
-#define GATE_SGMII(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &sgmii_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_SGMII(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &sgmii_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate sgmii_clks[2][4] = {
 	{
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index c3eb09ea6036..497628bd8c29 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -16,23 +16,13 @@
 
 #include <dt-bindings/clock/mt7629-clk.h>
 
-#define GATE_PCIE(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &pcie_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
-
-#define GATE_SSUSB(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &ssusb_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_PCIE(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &pcie_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_SSUSB(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &ssusb_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate_regs pcie_cg_regs = {
 	.set_ofs = 0x30,
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index cf062d4a7ecc..fa1bce943c45 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -50,41 +50,21 @@
 		_pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift,	\
 		NULL, "clk20m")
 
-#define GATE_APMIXED(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &apmixed_cg_regs,		\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
-	}
+#define GATE_APMIXED(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
-#define GATE_INFRA(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &infra_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_INFRA(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI0(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_PERI0(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &peri1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_PERI1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
 static DEFINE_SPINLOCK(mt7629_clk_lock);
 
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index 703872239ecc..615b4b10d37c 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -22,12 +22,9 @@ static const struct mtk_gate_regs sgmii0_cg_regs = {
 	.sta_ofs = 0xe4,
 };
 
-#define GATE_SGMII0(_id, _name, _parent, _shift)                               \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &sgmii0_cg_regs, .shift = _shift,                      \
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,                        \
-	}
+#define GATE_SGMII0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &sgmii0_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate sgmii0_clks[] __initconst = {
 	GATE_SGMII0(CLK_SGMII0_TX250M_EN, "sgmii0_tx250m_en", "top_xtal", 2),
@@ -42,12 +39,9 @@ static const struct mtk_gate_regs sgmii1_cg_regs = {
 	.sta_ofs = 0xe4,
 };
 
-#define GATE_SGMII1(_id, _name, _parent, _shift)                               \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &sgmii1_cg_regs, .shift = _shift,                      \
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,                        \
-	}
+#define GATE_SGMII1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &sgmii1_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate sgmii1_clks[] __initconst = {
 	GATE_SGMII1(CLK_SGMII1_TX250M_EN, "sgmii1_tx250m_en", "top_xtal", 2),
@@ -62,12 +56,9 @@ static const struct mtk_gate_regs eth_cg_regs = {
 	.sta_ofs = 0x30,
 };
 
-#define GATE_ETH(_id, _name, _parent, _shift)                                  \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &eth_cg_regs, .shift = _shift,                         \
-		.ops = &mtk_clk_gate_ops_no_setclr_inv,                        \
-	}
+#define GATE_ETH(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &eth_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr_inv)
 
 static const struct mtk_gate eth_clks[] __initconst = {
 	GATE_ETH(CLK_ETH_FE_EN, "eth_fe_en", "netsys_2x_sel", 6),
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index e80c92167c8f..7a75cc85769d 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -87,26 +87,17 @@ static const struct mtk_gate_regs infra2_cg_regs = {
 	.sta_ofs = 0x68,
 };
 
-#define GATE_INFRA0(_id, _name, _parent, _shift)                               \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &infra0_cg_regs, .shift = _shift,                      \
-		.ops = &mtk_clk_gate_ops_setclr,                               \
-	}
+#define GATE_INFRA0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &infra0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_INFRA1(_id, _name, _parent, _shift)                               \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &infra1_cg_regs, .shift = _shift,                      \
-		.ops = &mtk_clk_gate_ops_setclr,                               \
-	}
+#define GATE_INFRA1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &infra1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_INFRA2(_id, _name, _parent, _shift)                               \
-	{                                                                      \
-		.id = _id, .name = _name, .parent_name = _parent,              \
-		.regs = &infra2_cg_regs, .shift = _shift,                      \
-		.ops = &mtk_clk_gate_ops_setclr,                               \
-	}
+#define GATE_INFRA2(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &infra2_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate infra_clks[] = {
 	/* INFRA0 */
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 2b9c925c2a2b..97a115d2c3da 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -401,14 +401,8 @@ static const struct mtk_gate_regs infra_cg_regs = {
 	.sta_ofs = 0x0048,
 };
 
-#define GATE_ICG(_id, _name, _parent, _shift) {	\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &infra_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
+#define GATE_ICG(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate infra_clks[] __initconst = {
 	GATE_ICG(CLK_INFRA_PMIC_WRAP, "pmic_wrap_ck", "axi_sel", 23),
@@ -438,23 +432,11 @@ static const struct mtk_gate_regs peri1_cg_regs = {
 	.sta_ofs = 0x001c,
 };
 
-#define GATE_PERI0(_id, _name, _parent, _shift) {	\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &peri0_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
+#define GATE_PERI0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &peri0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_PERI1(_id, _name, _parent, _shift) {	\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &peri1_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
+#define GATE_PERI1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &peri1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate peri_gates[] __initconst = {
 	/* PERI0 */
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index eec9de190cb6..621f04313546 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -23,14 +23,10 @@ static const struct mtk_gate_regs aud_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_AUD(_id, _name, _parent, _shift) {	\
-		.id = _id,			\
-		.name = _name,			\
-		.parent_name = _parent,		\
-		.regs = &aud_cg_regs,		\
-		.shift = _shift,		\
-		.ops = &mtk_clk_gate_ops_no_setclr,		\
-	}
+#define GATE_AUD(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &aud_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
+
 
 static const struct mtk_gate aud_clks[] = {
 	GATE_AUD(CLK_AUD_AFE, "aud_afe", "clk26m_ck", 2),
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 5cd51d894d32..6a068f2a9dce 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -23,14 +23,8 @@ static const struct mtk_gate_regs img_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_IMG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &img_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate img_clks[] = {
 	GATE_IMG(CLK_IMG_LARB1_SMI, "img_larb1_smi", "smi_mm", 0),
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 2cf88d5d245d..7fcb944134b6 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -23,14 +23,8 @@ static const struct mtk_gate_regs mfg_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_MFG(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mfg_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MFG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mfg_clks[] = {
 	GATE_MFG(CLK_MFG_BAXI, "mfg_baxi", "ahb_infra_sel", 0),
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index 78c023b0565a..5a5192d0dc45 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -29,23 +29,11 @@ static const struct mtk_gate_regs mm1_cg_regs = {
 	.sta_ofs = 0x110,
 };
 
-#define GATE_MM0(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MM0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_MM1(_id, _name, _parent, _shift) {		\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &mm1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_MM1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mm_clks[] = {
 	/* MM0 */
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index da15f34765ff..f4ae8d98c43a 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -29,23 +29,13 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	.sta_ofs = 0x8,
 };
 
-#define GATE_VDEC0_I(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec0_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC0_I(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_VDEC1_I(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &vdec1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_VDEC1_I(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate vdec_clks[] = {
 	/* VDEC0 */
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index ffec2d917661..435cfae25492 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -25,23 +25,11 @@ static const struct mtk_gate_regs mm1_cg_regs = {
 	.sta_ofs = 0x0110,
 };
 
-#define GATE_MM0(_id, _name, _parent, _shift) {			\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &mm0_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
+#define GATE_MM0(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
-#define GATE_MM1(_id, _name, _parent, _shift) {			\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &mm1_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
+#define GATE_MM1(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate mt8173_mm_clks[] = {
 	GATE_DUMMY(CLK_DUMMY, "mm_dummy"),
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index 00f356fe7c7a..84b26da02ef3 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -22,14 +22,9 @@ static const struct mtk_gate_regs aud_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_AUD(_id, _name, _parent, _shift) {	\
-		.id = _id,			\
-		.name = _name,			\
-		.parent_name = _parent,		\
-		.regs = &aud_cg_regs,		\
-		.shift = _shift,		\
-		.ops = &mtk_clk_gate_ops_no_setclr,		\
-	}
+#define GATE_AUD(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &aud_cg_regs, _shift,	\
+		 &mtk_clk_gate_ops_no_setclr)
 
 static const struct mtk_gate aud_clks[] __initconst = {
 	GATE_AUD(CLK_AUD_AFE, "aud_afe", "clk26m_ck", 2),
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 2c0cae7b3bcf..bea2128b4446 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -525,59 +525,29 @@ static const struct mtk_gate_regs top5_cg_regs = {
 	.sta_ofs = 0x44,
 };
 
-#define GATE_TOP1(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top1_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_TOP1(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_TOP2(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_TOP2(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top2_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_TOP2_I(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top2_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_TOP2_I(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &top2_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_TOP3(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top3_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr,	\
-	}
+#define GATE_TOP3(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top3_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
-#define GATE_TOP4_I(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top4_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_setclr_inv,	\
-	}
+#define GATE_TOP4_I(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &top4_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr_inv)
 
-#define GATE_TOP5(_id, _name, _parent, _shift) {	\
-		.id = _id,				\
-		.name = _name,				\
-		.parent_name = _parent,			\
-		.regs = &top5_cg_regs,			\
-		.shift = _shift,			\
-		.ops = &mtk_clk_gate_ops_no_setclr,	\
-	}
+#define GATE_TOP5(_id, _name, _parent, _shift)				\
+	GATE_MTK(_id, _name, _parent, &top5_cg_regs, _shift,		\
+		 &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate top_clks[] __initconst = {
 	/* TOP1 */
-- 
2.39.1

