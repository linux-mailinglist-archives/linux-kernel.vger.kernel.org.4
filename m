Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB069D00D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBTPDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjBTPC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:02:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4533A2056E;
        Mon, 20 Feb 2023 07:01:53 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2342C660217D;
        Mon, 20 Feb 2023 15:01:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905311;
        bh=T91Ba3/qDGf8sWWJXdHxINm7g/vf3TN99/lK3EA+d84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+QKTzOPirQoL+nnyWmkVbLGda6NSB+cQyii7xHxVvIo5iGwvB3N8GQNMNDWPjeL9
         GETLl2tb+noVzjdkkQNo4MNztgG/nwvkgTuMgWKWRbcMEenUxXrEDh03WZF82qugZ+
         p5xMO2YVAlJsbanrTGuKiMdV4ILqz97e3UUoLiQ052HktWGH/0gAspKOJAEdLIa+PQ
         9LgU7WdRHYBQScCgg1VVuvz25xljvtW9S3eYSvkmfDodxIevgWQJ9yYlQbo6TqB615
         rwoja89AqMZpm/ejnknOAS/JuS5FXzJQXPUhXCZ27+/3NuPL1njzgfTJ/F+gNTA//e
         Q+Ow2hVuoZUXA==
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
Subject: [PATCH v3 25/55] clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module build
Date:   Mon, 20 Feb 2023 16:00:41 +0100
Message-Id: <20230220150111.77897-26-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
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

Add a .remove() callback to the apmixedsys driver to allow full module
build; while at it, also change the usage of builtin_platform_driver()
to module_platform_driver() to actually make use of the new callback.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
index 497fada797b9..a9f3057d7080 100644
--- a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
@@ -119,6 +119,19 @@ static int clk_mt7622_apmixed_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int clk_mt7622_apmixed_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
 static const struct of_device_id of_match_clk_mt7622_apmixed[] = {
 	{ .compatible = "mediatek,mt7622-apmixedsys" },
 	{ /* sentinel */ }
@@ -126,12 +139,13 @@ static const struct of_device_id of_match_clk_mt7622_apmixed[] = {
 
 static struct platform_driver clk_mt7622_apmixed_drv = {
 	.probe = clk_mt7622_apmixed_probe,
+	.remove = clk_mt7622_apmixed_remove,
 	.driver = {
 		.name = "clk-mt7622-apmixed",
 		.of_match_table = of_match_clk_mt7622_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt7622_apmixed_drv)
+module_platform_driver(clk_mt7622_apmixed_drv)
 
 MODULE_DESCRIPTION("MediaTek MT7622 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.39.1

