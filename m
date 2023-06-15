Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5307318E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbjFOMWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343863AbjFOMWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:22:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8602296A;
        Thu, 15 Jun 2023 05:21:08 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 84B476606F67;
        Thu, 15 Jun 2023 13:21:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686831667;
        bh=4aiyV1F8YWPE0QD7T7sc+5l0IdShBNTT+itlcGPT43I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NCUM0nDMs5IMGeF+0E/wTawLh3jskwUw8sCRy1RThhXvkSDJPKuIZTifDIaCAnOgp
         Q9wwEIgF53IKfBI1fddxs9UfYV/G/+bAMaDVW6W5MfGbfyxNSYQhmuiZ0sbUNlAVvi
         /s2jwO87uDepvGqpsINWuiqzvgEvn501qhnMwrCyztORDlcwphRxJ/THWq2/69p0lP
         TJi5VOzl9jBj7RZl7kkPz8CvmScFIMFK8YuzQ4G8DHLofXOB/h74xfmmMG9GNsjtvi
         HEA8FQmgvbSbpAOeXYuE58DYnQ4sqMrIzTO7dY7a5Ymavzqfnb3rmKh1pgYZmSAmaF
         ohfZZdU4aIdug==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, msp@baylibre.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 1/3] clk: mediatek: clk-mtk: Grab iomem pointer for divider clocks
Date:   Thu, 15 Jun 2023 14:20:49 +0200
Message-Id: <20230615122051.546985-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com>
References: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the rare case in which one of the clock drivers has divider clocks
but not composite clocks, mtk_clk_simple_probe() would not io(re)map,
hence passing a NULL pointer to mtk_clk_register_dividers().

To fix this issue, extend the `if` conditional to also check if any
divider clocks are present. While at it, also make sure the iomem
pointer is NULL if no composite/divider clocks are declared, as we
are checking for that when iounmapping it in the error path.

This hasn't been seen on any MediaTek clock driver as the current ones
always declare composite clocks along with divider clocks, but this is
still an important fix for a future potential KP.

Fixes: 1fe074b1f112 ("clk: mediatek: Add divider clocks to mtk_clk_simple_{probe,remove}()")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index cf3514c8e97e..b00ef4213335 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -469,7 +469,7 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 	const struct platform_device_id *id;
 	const struct mtk_clk_desc *mcd;
 	struct clk_hw_onecell_data *clk_data;
-	void __iomem *base;
+	void __iomem *base = NULL;
 	int num_clks, r;
 
 	mcd = device_get_match_data(&pdev->dev);
@@ -483,8 +483,8 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 			return -EINVAL;
 	}
 
-	/* Composite clocks needs us to pass iomem pointer */
-	if (mcd->composite_clks) {
+	/* Composite and divider clocks needs us to pass iomem pointer */
+	if (mcd->composite_clks || mcd->divider_clks) {
 		if (!mcd->shared_io)
 			base = devm_platform_ioremap_resource(pdev, 0);
 		else
-- 
2.40.1

