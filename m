Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6F675111
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjATJ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjATJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:27:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8C494C98;
        Fri, 20 Jan 2023 01:27:30 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 45AEA6602E83;
        Fri, 20 Jan 2023 09:21:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674206489;
        bh=lcznLPtgtJvQ60PU2ET5xSjALXesFcVHBES0BrXeFys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beMomBTFbEOHG4rWdJkH52yabPWOcak0HncGkOJfd0tX/mGC9ixXUD/yM6yEjftlM
         jznF4mQSrdcST8eSL/EzcDW81fVY4tUqtB3QKtj0Lju7ga75wFK5fTGo/FNE6h8LCK
         5uJ4NAA+3e+CEWJ0LBthwzUjxVeOMFyKSyK42bL8IPnoAloB4R3VKuu2pnmK5iA9FC
         n3wEKlDA1vc3XFCEry6cEBAhoolLdp4W08OUPBcvNu2TDmp4WLxeO2Nmhwc6dRv2+j
         hUppv2WoUI2hFwUlD7NT1y79QZIdoIF+ChvNQ0G/RyYFpk0Y8oIPehx0K4qnbNi4Di
         tZjRAOpYdxelA==
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
Subject: [PATCH v4 18/23] clk: mediatek: clk-mtk: Register MFG notifier in mtk_clk_simple_probe()
Date:   Fri, 20 Jan 2023 10:20:48 +0100
Message-Id: <20230120092053.182923-19-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120092053.182923-1-angelogioacchino.delregno@collabora.com>
References: <20230120092053.182923-1-angelogioacchino.delregno@collabora.com>
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

In preparation for commonizing topckgen probe on various MediaTek SoCs
clock drivers, add the ability to register the MFG MUX notifier in
mtk_clk_simple_probe() by passing a custom notifier register function
pointer, as this function will be slightly different across different
SoCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 8 ++++++++
 drivers/clk/mediatek/clk-mtk.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 281d30d6cb2b..c90c0a6b501b 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -534,6 +534,14 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 			goto unregister_composites;
 	}
 
+	if (mcd->clk_notifier_func) {
+		struct clk *mfg_mux = clk_data->hws[mcd->mfg_clk_idx]->clk;
+
+		r = mcd->clk_notifier_func(&pdev->dev, mfg_mux);
+		if (r)
+			goto unregister_clks;
+	}
+
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_clks;
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 1bdaa0acb909..41f4fa3b0c21 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -231,6 +231,9 @@ struct mtk_clk_desc {
 	const struct mtk_clk_rst_desc *rst_desc;
 	spinlock_t *clk_lock;
 	bool shared_io;
+
+	int (*clk_notifier_func)(struct device *dev, struct clk *clk);
+	unsigned int mfg_clk_idx;
 };
 
 int mtk_clk_simple_probe(struct platform_device *pdev);
-- 
2.39.0

