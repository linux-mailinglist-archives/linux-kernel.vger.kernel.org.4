Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9715FB373
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJKNbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJKNbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:31:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B7F26FA;
        Tue, 11 Oct 2022 06:31:33 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C31F6602343;
        Tue, 11 Oct 2022 14:31:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665495091;
        bh=YIDLbypIschps2IdMEivbgC0X3XT1Np+1ZTSQYgwLaA=;
        h=From:To:Cc:Subject:Date:From;
        b=fnH6+oLoqHSIBSxTtNxFzgzdknpvd7fIeN+GuoOBkBt+iV2PZw4S16FqQLLG3AayR
         xQtK48qvM1T/NQhw8ETVnh6qC8nF3qkZhYRSTTU8329UcnOw70pnRrj6hlfriHeyjY
         QaY4g/H2rMfIMQK9xreLd7kGVtDFsZHtQYdHRhswVER2raw9c3yQ2iXlfeFzQuNwJL
         P7bpw4HV4Ex+3IzDTY9K0ytnmARHru2kCUFW30UBhZfxp3RYJ2Kf7sWAL1dQm721sI
         Yt4WBXbiRZjTd97LJpMTB24y8oEeyCORa+vB0nmcfVH93NSKiBqj3blAUQ90sboMbn
         kraPfSlNNLXMA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, maxime@cerno.tech, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mediatek: clk-mux: Add .determine_rate() callback
Date:   Tue, 11 Oct 2022 15:31:25 +0200
Message-Id: <20221011133125.311763-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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

Since commit 262ca38f4b6e ("clk: Stop forwarding clk_rate_requests
to the parent"), the clk_rate_request is .. as the title says, not
forwarded anymore to the parent: this produces an issue with the
MediaTek clock MUX driver during GPU DVFS on MT8195, but not on
MT8192 or others.

This is because, differently from others, like MT8192 where all of
the clocks in the MFG parents tree are of mtk_mux type, but in the
parent tree of MT8195's MFG clock, we have one mtk_mux clock and
one (clk framework generic) mux clock, like so:

names: mfg_bg3d -> mfg_ck_fast_ref -> top_mfg_core_tmp (or) mfgpll
types: mtk_gate ->      mux        ->     mtk_mux      (or) mtk_pll

To solve this issue and also keep the GPU DVFS clocks code working
as expected, wire up a .determine_rate() callback for the mtk_mux
ops; for that, the standard clk_mux_determine_rate_flags() was used
as it was possible to.

This commit was successfully tested on MT6795 Xperia M5, MT8173 Elm,
MT8192 Spherion and MT8195 Tomato; no regressions were seen.

For the sake of some more documentation about this issue here's the
trace of it:

[   12.211587] ------------[ cut here ]------------
[   12.211589] WARNING: CPU: 6 PID: 78 at drivers/clk/clk.c:1462 clk_core_init_rate_req+0x84/0x90
[   12.211593] Modules linked in: stp crct10dif_ce mtk_adsp_common llc rfkill snd_sof_xtensa_dsp
               panfrost(+) sbs_battery cros_ec_lid_angle cros_ec_sensors snd_sof_of
               cros_ec_sensors_core hid_multitouch cros_usbpd_logger snd_sof gpu_sched
               snd_sof_utils fuse ipv6
[   12.211614] CPU: 6 PID: 78 Comm: kworker/u16:2 Tainted: G        W          6.0.0-next-20221011+ #58
[   12.211616] Hardware name: Acer Tomato (rev2) board (DT)
[   12.211617] Workqueue: devfreq_wq devfreq_monitor
[   12.211620] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   12.211622] pc : clk_core_init_rate_req+0x84/0x90
[   12.211625] lr : clk_core_forward_rate_req+0xa4/0xe4
[   12.211627] sp : ffff80000893b8e0
[   12.211628] x29: ffff80000893b8e0 x28: ffffdddf92f9b000 x27: ffff46a2c0e8bc05
[   12.211632] x26: ffff46a2c1041200 x25: 0000000000000000 x24: 00000000173eed80
[   12.211636] x23: ffff80000893b9c0 x22: ffff80000893b940 x21: 0000000000000000
[   12.211641] x20: ffff46a2c1039f00 x19: ffff46a2c1039f00 x18: 0000000000000000
[   12.211645] x17: 0000000000000038 x16: 000000000000d904 x15: 0000000000000003
[   12.211649] x14: ffffdddf9357ce48 x13: ffffdddf935e71c8 x12: 000000000004803c
[   12.211653] x11: 00000000a867d7ad x10: 00000000a867d7ad x9 : ffffdddf90c28df4
[   12.211657] x8 : ffffdddf9357a980 x7 : 0000000000000000 x6 : 0000000000000004
[   12.211661] x5 : ffffffffffffffc8 x4 : 00000000173eed80 x3 : ffff80000893b940
[   12.211665] x2 : 00000000173eed80 x1 : ffff80000893b940 x0 : 0000000000000000
[   12.211669] Call trace:
[   12.211670]  clk_core_init_rate_req+0x84/0x90
[   12.211673]  clk_core_round_rate_nolock+0xe8/0x10c
[   12.211675]  clk_mux_determine_rate_flags+0x174/0x1f0
[   12.211677]  clk_mux_determine_rate+0x1c/0x30
[   12.211680]  clk_core_determine_round_nolock+0x74/0x130
[   12.211682]  clk_core_round_rate_nolock+0x58/0x10c
[   12.211684]  clk_core_round_rate_nolock+0xf4/0x10c
[   12.211686]  clk_core_set_rate_nolock+0x194/0x2ac
[   12.211688]  clk_set_rate+0x40/0x94
[   12.211691]  _opp_config_clk_single+0x38/0xa0
[   12.211693]  _set_opp+0x1b0/0x500
[   12.211695]  dev_pm_opp_set_rate+0x120/0x290
[   12.211697]  panfrost_devfreq_target+0x3c/0x50 [panfrost]
[   12.211705]  devfreq_set_target+0x8c/0x2d0
[   12.211707]  devfreq_update_target+0xcc/0xf4
[   12.211708]  devfreq_monitor+0x40/0x1d0
[   12.211710]  process_one_work+0x294/0x664
[   12.211712]  worker_thread+0x7c/0x45c
[   12.211713]  kthread+0x104/0x110
[   12.211716]  ret_from_fork+0x10/0x20
[   12.211718] irq event stamp: 7102
[   12.211719] hardirqs last  enabled at (7101): [<ffffdddf904ea5a0>] finish_task_switch.isra.0+0xec/0x2f0
[   12.211723] hardirqs last disabled at (7102): [<ffffdddf91794b74>] el1_dbg+0x24/0x90
[   12.211726] softirqs last  enabled at (6716): [<ffffdddf90410be4>] __do_softirq+0x414/0x588
[   12.211728] softirqs last disabled at (6507): [<ffffdddf904171d8>] ____do_softirq+0x18/0x24
[   12.211730] ---[ end trace 0000000000000000 ]---

Fixes: 262ca38f4b6e ("clk: Stop forwarding clk_rate_requests to the parent")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8186-mfg.c      |  5 ++--
 drivers/clk/mediatek/clk-mt8186-topckgen.c | 27 ++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.c             | 10 ++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8186-mfg.c b/drivers/clk/mediatek/clk-mt8186-mfg.c
index f1f92216f894..0142d741053a 100644
--- a/drivers/clk/mediatek/clk-mt8186-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8186-mfg.c
@@ -16,8 +16,9 @@ static const struct mtk_gate_regs mfg_cg_regs = {
 	.sta_ofs = 0x0,
 };
 
-#define GATE_MFG(_id, _name, _parent, _shift)			\
-	GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+#define GATE_MFG(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &mfg_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, CLK_SET_RATE_PARENT)
 
 static const struct mtk_gate mfg_clks[] = {
 	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "top_mfg", 0),
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index d7f2c4663c85..f6387c2eb5cf 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -689,6 +689,28 @@ static const struct of_device_id of_match_clk_mt8186_topck[] = {
 	{}
 };
 
+/* Register mux notifier for MFG mux */
+static int clk_mt8186_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
+{
+	struct mtk_mux_nb *mfg_mux_nb;
+	int i;
+
+	mfg_mux_nb = devm_kzalloc(dev, sizeof(*mfg_mux_nb), GFP_KERNEL);
+	if (!mfg_mux_nb)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(top_mtk_muxes); i++)
+		if (top_mtk_muxes[i].id == CLK_TOP_MFG)
+			break;
+	if (i == ARRAY_SIZE(top_mtk_muxes))
+		return -EINVAL;
+
+	mfg_mux_nb->ops = top_mtk_muxes[i].ops;
+	mfg_mux_nb->bypass_index = 0; /* Bypass to 26M crystal */
+
+	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
+}
+
 static int clk_mt8186_topck_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -730,6 +752,11 @@ static int clk_mt8186_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_composite_muxes;
 
+	r = clk_mt8186_reg_mfg_mux_notifier(&pdev->dev,
+					    clk_data->hws[CLK_TOP_MFG]->clk);
+	if (r)
+		goto unregister_composite_divs;
+
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_composite_divs;
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 4421e4859257..ba1720b9e231 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -129,9 +129,18 @@ static int mtk_clk_mux_set_parent_setclr_lock(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
+static int mtk_clk_mux_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+
+	return clk_mux_determine_rate_flags(hw, req, mux->data->flags);
+}
+
 const struct clk_ops mtk_mux_clr_set_upd_ops = {
 	.get_parent = mtk_clk_mux_get_parent,
 	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
+	.determine_rate = mtk_clk_mux_determine_rate,
 };
 EXPORT_SYMBOL_GPL(mtk_mux_clr_set_upd_ops);
 
@@ -141,6 +150,7 @@ const struct clk_ops mtk_mux_gate_clr_set_upd_ops  = {
 	.is_enabled = mtk_clk_mux_is_enabled,
 	.get_parent = mtk_clk_mux_get_parent,
 	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
+	.determine_rate = mtk_clk_mux_determine_rate,
 };
 EXPORT_SYMBOL_GPL(mtk_mux_gate_clr_set_upd_ops);
 
-- 
2.37.2

