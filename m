Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD46E68B94E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBFKBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjBFKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:01:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238D71EFEE;
        Mon,  6 Feb 2023 02:01:18 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E5F86602FAE;
        Mon,  6 Feb 2023 10:01:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675677677;
        bh=SUI34CS1BrJFmIaipPdxWm70cNWYkj8EhbTlIi7RZKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRYJBOAsI4wIgnf2YkdFZADBhOfijn33uRNwDyexhlxJw7+ZfNe4ELRmzUAGiAckl
         x/5869CPo/hg5dgqSijs1I2ggAIs1xzVw97/Ta/2FmLhYpWBzDkLm2aLXXi2iqrNi8
         csLUh+PB04G8Sg+0QfPGcgsd8GfSIyFlGfbH/Musk+0tLQNjYmLtFTlzjmfN4KWOuT
         TAx02L1Wv/C2eGZSfktGALCo/K130v25tUNyMHpxp99NiJwuMKRiOQwPWXeKRdtjzd
         ouiYnuvCsyaeoQMPPlajdcNHgUqcRxOjXEJQkKW4Nodhd72AXt1O6lASdZl8/iVno5
         Aii5GC4Cq85Hw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 2/7] clk: mediatek: clk-pllfh: Export register/unregister/parse functions
Date:   Mon,  6 Feb 2023 11:01:00 +0100
Message-Id: <20230206100105.861720-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
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

These functions are used by the various MediaTek apmixed clock drivers
that may be built as modules: export the common functions used to parse
related devicetree properties, register and unregister the PLLFH clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-pllfh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
index b9297726f5a0..7b6e051443f4 100644
--- a/drivers/clk/mediatek/clk-pllfh.c
+++ b/drivers/clk/mediatek/clk-pllfh.c
@@ -103,6 +103,7 @@ void fhctl_parse_dt(const u8 *compatible_node, struct mtk_pllfh_data *pllfhs,
 		pllfh->state.base = base;
 	}
 }
+EXPORT_SYMBOL_GPL(fhctl_parse_dt);
 
 static int pllfh_init(struct mtk_fh *fh, struct mtk_pllfh_data *pllfh_data)
 {
@@ -247,6 +248,7 @@ int mtk_clk_register_pllfhs(struct device_node *node,
 
 	return PTR_ERR(hw);
 }
+EXPORT_SYMBOL_GPL(mtk_clk_register_pllfhs);
 
 void mtk_clk_unregister_pllfhs(const struct mtk_pll_data *plls, int num_plls,
 			       struct mtk_pllfh_data *pllfhs, int num_fhs,
@@ -286,3 +288,4 @@ void mtk_clk_unregister_pllfhs(const struct mtk_pll_data *plls, int num_plls,
 
 	iounmap(base);
 }
+EXPORT_SYMBOL_GPL(mtk_clk_unregister_pllfhs);
-- 
2.39.1

