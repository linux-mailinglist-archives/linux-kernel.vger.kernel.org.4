Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC7C6DA993
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjDGHxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDGHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:53:32 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E3076A6B;
        Fri,  7 Apr 2023 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=c9Q3W
        9lb23cFj+DGwrbVCpopAjiEpJ3qsb46oaSt7qs=; b=DgHePW1x0fmO5rVwZvRxs
        swQajzjD27XpQ3DzzAPV1H90U9/arbRxb4oq/KIW3Z9l3HpzcnrJVYqhQV/TnbMP
        95AnwLSCZ6eSkn8UMriTEB28Pm4c/CF6KHmK6XNVY60bsBkMFxoET6VdIEbalCYx
        wFG/nm679CAFZRkgoynEm8=
Received: from ubuntu.localdomain (unknown [115.156.140.143])
        by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wAnBKrWyy9kiP0wAw--.39596S4;
        Fri, 07 Apr 2023 15:52:55 +0800 (CST)
From:   Xinyi Hou <Y_Ashley@163.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Xinyi Hou <Y_Ashley@163.com>, Dongliang Mu <dzm91@hust.edu.cn>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3] clk: mediatek: clk-mt7986-infracfg: delete the code related to 'base'
Date:   Fri,  7 Apr 2023 15:49:30 +0800
Message-Id: <20230407074931.31247-1-Y_Ashley@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnBKrWyy9kiP0wAw--.39596S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1ktF4rXF1rKr47ur1DAwb_yoW8JF43pF
        y0gF4akFy5Aw4xCr48ZrZ7u343A3Z29Fy5KFy7Z3WDtr13Can2gr18K392g3WkAFWkZa4Y
        qr1j9348AFW2gFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_2NtUUUUUU=
X-Originating-IP: [115.156.140.143]
X-CM-SenderInfo: p1bd2xxoh1qiywtou0bp/xtbB0xxKxFXlyq1mMAAAsA
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clk_mt7986_infracfg_probe(), 'base' is allocated but never used,
either not released on both success failure path.

Fix this by deleting 'base' and the code related to it.

Signed-off-by: Xinyi Hou <Y_Ashley@163.com>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v2 -> v3: Directly deleted 'base' and its related code based on master.
v1 -> v2: Directly deleted 'base' and its related code based on PATCH v1.

 drivers/clk/mediatek/clk-mt7986-infracfg.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index e80c92167c8f..76b32f3a16b2 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -174,16 +174,9 @@ static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
 	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
-	void __iomem *base;
 	int nr = ARRAY_SIZE(infra_divs) + ARRAY_SIZE(infra_muxes) +
 		 ARRAY_SIZE(infra_clks);
 
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return -ENOMEM;
-	}
-
 	clk_data = mtk_alloc_clk_data(nr);
 
 	if (!clk_data)
-- 
2.25.1

