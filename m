Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429C06695A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbjAMLda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbjAMLcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:32:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9D64883B;
        Fri, 13 Jan 2023 03:07:28 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D97596602DD4;
        Fri, 13 Jan 2023 11:07:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673608047;
        bh=soqoVSF9tVJj9LPbEsm5KtjYNzQFuQRSnoVxuMrxji0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItpW2T2jfkqnJ2rCC2xgZRIqfoVTm/IwuJl8MxbMKnuLQEGDZurmM25ORskRKAt9k
         yeM/g+97m2gOp/Y8Xd5sgyVPB3HrGQy/czHNl35bLKG50vfOTggOyB1zw5TYt3MCKI
         jzD+AifSOzhQ5Ibdls2FQRZ7DnTD6TLs5HdDNfFiZWlAEl4amwZkm5Hhn9PWDgMCOn
         EaZA16rq/+J2e8jpsJqNerINgHmCoVKVFe2HZN3M04Q9xr34E3+vdKRvR2potk80MK
         CvIs5SxB5zdeB07JcfMbkGfbjjOkdKKSa3L2bV/9jNTzEd25uY+HqG9c+VBgom3yu7
         hG8uE2/Ai5xrg==
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
Subject: [PATCH v3 18/23] clk: mediatek: clk-mtk: Register MFG notifier in mtk_clk_simple_probe()
Date:   Fri, 13 Jan 2023 12:06:11 +0100
Message-Id: <20230113110616.111001-19-angelogioacchino.delregno@collabora.com>
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

In preparation for commonizing topckgen probe on various MediaTek SoCs
clock drivers, add the ability to register the MFG MUX notifier in
mtk_clk_simple_probe() by passing a custom notifier register function
pointer, as this function will be slightly different across different
SoCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.c | 8 ++++++++
 drivers/clk/mediatek/clk-mtk.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 171d6dfc880b..82faca9a8771 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -533,6 +533,14 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
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

