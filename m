Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8966952B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjAMLN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240984AbjAMLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:12:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D029A40C27;
        Fri, 13 Jan 2023 03:07:11 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 65A8A6602DD3;
        Fri, 13 Jan 2023 11:07:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673608030;
        bh=GGQBiBEeum02wzJcRprKO+Yvg5qHXyXn5xKwlPyEGJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxNBeUkVqMNr65Cv5KnVbonazfGugB6wKjV39Tb3rE6peeMexRqgd2zZFHHXttqwI
         W0XR8hUrEcIr8pKrSRmGMD2P0qo7VrhdorH6EoT3BwXM2KOmtH/Ukk/Rq8C1790PpW
         +q77MPqRt9v04uBgsuwY+1SSQtYUp95/Q4tDGYGAjX+pEOWsalV969AKbpMsbu39aT
         i9lJwMe9znTMVtYUy35Kx2uAw7L78aRw4HaqNF+AkoxyJzVyhRupY5a69Nc3pfL7RS
         +6cyx8tIkAyEJYqtHcmHE6u/7ox7lmNcgPsBghWCmYDXa4AlSdKFpFd6Lo9Lhi0dJS
         OsrfbgoWyYXmw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 07/23] clk: mediatek: clk-mtk: Add dummy clock ops
Date:   Fri, 13 Jan 2023 12:06:00 +0100
Message-Id: <20230113110616.111001-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113110616.111001-1-angelogioacchino.delregno@collabora.com>
References: <20230113110616.111001-1-angelogioacchino.delregno@collabora.com>
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

In order to migrate some (few) old clock drivers to the common
mtk_clk_simple_probe() function, add dummy clock ops to be able
to insert a dummy clock with ID 0 at the beginning of the list.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
 drivers/clk/mediatek/clk-mtk.h | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index cf2f465ecf22..7d7a5bfe1214 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -18,6 +18,21 @@
 #include "clk-mtk.h"
 #include "clk-gate.h"
 
+const struct mtk_gate_regs cg_regs_dummy = { 0, 0, 0 };
+
+static int mtk_clk_dummy_enable(struct clk_hw *hw)
+{
+	return 0;
+}
+
+static void mtk_clk_dummy_disable(struct clk_hw *hw) { }
+
+const struct clk_ops mtk_clk_dummy_ops = {
+	.enable		= mtk_clk_dummy_enable,
+	.disable	= mtk_clk_dummy_disable,
+};
+EXPORT_SYMBOL_GPL(mtk_clk_dummy_ops);
+
 static void mtk_init_clk_data(struct clk_hw_onecell_data *clk_data,
 			      unsigned int clk_num)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index cd97d2722380..ed329d8d7349 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -22,6 +22,25 @@
 
 struct platform_device;
 
+/*
+ * We need the clock IDs to start from zero but to maintain devicetree
+ * backwards compatibility we can't change bindings to start from zero.
+ * Only a few platforms are affected, so we solve issues given by the
+ * commonized MTK clocks probe function(s) by adding a dummy clock at
+ * the beginning where needed.
+ */
+#define CLK_DUMMY		0
+
+extern const struct clk_ops mtk_clk_dummy_ops;
+extern const struct mtk_gate_regs cg_regs_dummy;
+
+#define GATE_DUMMY(_id, _name) {				\
+		.id = _id,					\
+		.name = _name,					\
+		.regs = &cg_regs_dummy,				\
+		.ops = &mtk_clk_dummy_ops,			\
+	}
+
 struct mtk_fixed_clk {
 	int id;
 	const char *name;
-- 
2.39.0

