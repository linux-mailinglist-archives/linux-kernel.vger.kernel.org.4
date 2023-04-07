Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0F6DAA49
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbjDGIiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjDGIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:38:08 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A25746BF;
        Fri,  7 Apr 2023 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bvMeT
        VYjDyKEP8ZQMTHGrWbs6rZELtxOvEXtr+caOtg=; b=Y48temyT0/21qJteKk2rk
        s1ByLfixQXhq8XSvWsoiN7b3/nmJdRfFjA2EczXHyZ68Iz1ihOin55DaQWJC+WG4
        BoMA96tUeD1WHi60zS8ZuBgtBqDLVKw+dpgTJVyy5fbfCDWZzL4r3Hj2+ooM7akC
        fSEjcmv8P/KyzKvgV24lq0=
Received: from ubuntu.localdomain (unknown [115.156.140.143])
        by zwqz-smtp-mta-g1-4 (Coremail) with SMTP id _____wCnrdpS1i9kggMuAw--.20049S4;
        Fri, 07 Apr 2023 16:37:39 +0800 (CST)
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
Subject: [PATCH] clk: mediatek: clk-mt7986-infracfg: delete the code related to 'base'
Date:   Fri,  7 Apr 2023 16:37:28 +0800
Message-Id: <20230407083729.31498-1-Y_Ashley@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnrdpS1i9kggMuAw--.20049S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF47Wry3uw48Zw48Xr4xWFg_yoWkWFX_Zr
        s5ur97Zr17KF4kGr47Wwn2vF9rtFs3Zr97Z3WYywn8JFyxKa1rJr1vqa95Aw47Ww4Svry5
        Jrn7Kry7CF4rZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRLF4EPUUUUU==
X-Originating-IP: [115.156.140.143]
X-CM-SenderInfo: p1bd2xxoh1qiywtou0bp/1tbiShRKxGI0XrQwOgAAsm
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

