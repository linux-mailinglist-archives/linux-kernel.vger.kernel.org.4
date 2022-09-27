Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5A5EBF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiI0KL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiI0KLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:11:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B716A3D49;
        Tue, 27 Sep 2022 03:11:38 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D18D6602266;
        Tue, 27 Sep 2022 11:11:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664273497;
        bh=BE0zMqDnpD97J3kq9y5nwtB15tR6atriJmbEfAuXnXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZ5i2naiUWywWhYOMDxN+ma45e4ePKly0Q4q5qdMaHq0V5mduvF+1zD2xCcV15SzI
         rY68bKCejWU+ZGw8Bicbz5xIMxmQVLIpwjdwwQF48a2D8Od3hxtBizAnPJpUy/qG2K
         NQaC4mLO8UbLL/ZLlDP3b2J+ARuN3UkCIxhMllonrd6MbdQa0s+yADIX81EdG6xThU
         TI9ZLvZtx2g4GX4wof5sYE2FMFTvPe8oNB5R5sKpfX142WyDNMVPNwBqbe6rnhxBt6
         9M+lympMPmnX+Uzd5kW5+fsVmpp4cnI5xcbpF+QyYeWXYN5ld28QBXGs9QJ/qkhMFk
         amuB74pHvTxaA==
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
Subject: [PATCH v3 03/10] clk: mediatek: mux: add clk notifier functions
Date:   Tue, 27 Sep 2022 12:11:21 +0200
Message-Id: <20220927101128.44758-4-angelogioacchino.delregno@collabora.com>
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

From: Chen-Yu Tsai <wenst@chromium.org>

With device frequency scaling, the mux clock that (indirectly) feeds the
device selects between a dedicated PLL, and some other stable clocks.

When a clk rate change is requested, the (normally) upstream PLL is
reconfigured. It's possible for the clock output of the PLL to become
unstable during this process.

To avoid causing the device to glitch, the mux should temporarily be
switched over to another "stable" clock during the PLL rate change.
This is done with clk notifiers.

This patch adds common functions for notifiers to temporarily and
transparently reparent mux clocks.

This was loosely based on commit 8adfb08605a9 ("clk: sunxi-ng: mux: Add
clk notifier functions").

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
[Angelo: Changed mtk_mux_nb to hold a pointer to clk_ops instead of mtk_mux]
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mux.c | 38 ++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.h | 15 ++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index cd5f9fd8cb98..4421e4859257 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -4,6 +4,7 @@
  * Author: Owen Chen <owen.chen@mediatek.com>
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/compiler_types.h>
 #include <linux/container_of.h>
@@ -259,4 +260,41 @@ void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_muxes);
 
+/*
+ * This clock notifier is called when the frequency of the parent
+ * PLL clock is to be changed. The idea is to switch the parent to a
+ * stable clock, such as the main oscillator, while the PLL frequency
+ * stabilizes.
+ */
+static int mtk_clk_mux_notifier_cb(struct notifier_block *nb,
+				   unsigned long event, void *_data)
+{
+	struct clk_notifier_data *data = _data;
+	struct clk_hw *hw = __clk_get_hw(data->clk);
+	struct mtk_mux_nb *mux_nb = to_mtk_mux_nb(nb);
+	int ret = 0;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		mux_nb->original_index = mux_nb->ops->get_parent(hw);
+		ret = mux_nb->ops->set_parent(hw, mux_nb->bypass_index);
+		break;
+	case POST_RATE_CHANGE:
+	case ABORT_RATE_CHANGE:
+		ret = mux_nb->ops->set_parent(hw, mux_nb->original_index);
+		break;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+int devm_mtk_clk_mux_notifier_register(struct device *dev, struct clk *clk,
+				       struct mtk_mux_nb *mux_nb)
+{
+	mux_nb->nb.notifier_call = mtk_clk_mux_notifier_cb;
+
+	return devm_clk_notifier_register(dev, clk, &mux_nb->nb);
+}
+EXPORT_SYMBOL_GPL(devm_mtk_clk_mux_notifier_register);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index 6539c58f5d7d..83ff420f4ebe 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -7,12 +7,14 @@
 #ifndef __DRV_CLK_MTK_MUX_H
 #define __DRV_CLK_MTK_MUX_H
 
+#include <linux/notifier.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
 struct clk;
 struct clk_hw_onecell_data;
 struct clk_ops;
+struct device;
 struct device_node;
 
 struct mtk_mux {
@@ -89,4 +91,17 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
 			      struct clk_hw_onecell_data *clk_data);
 
+struct mtk_mux_nb {
+	struct notifier_block	nb;
+	const struct clk_ops	*ops;
+
+	u8	bypass_index;	/* Which parent to temporarily use */
+	u8	original_index;	/* Set by notifier callback */
+};
+
+#define to_mtk_mux_nb(_nb)	container_of(_nb, struct mtk_mux_nb, nb)
+
+int devm_mtk_clk_mux_notifier_register(struct device *dev, struct clk *clk,
+				       struct mtk_mux_nb *mux_nb);
+
 #endif /* __DRV_CLK_MTK_MUX_H */
-- 
2.37.2

