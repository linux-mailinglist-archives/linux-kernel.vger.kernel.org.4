Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480726D3695
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjDBJmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjDBJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:42:29 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E741D1BF76
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:42:26 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id iuDzpwm4hwFKBiuEDpeDiY; Sun, 02 Apr 2023 11:42:25 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Apr 2023 11:42:25 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mturquette@baylibre.com, sboyd@kernel.org, abelvesa@kernel.org,
        peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 2/4] clk: imx: Remove values for mmask and nmask in struct clk_fractional_divider
Date:   Sun,  2 Apr 2023 11:42:05 +0200
Message-Id: <187a2266c3a034a593a151d6e5e6b21118043b5d.1680423909.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680423909.git.christophe.jaillet@wanadoo.fr>
References: <cover.1680423909.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that fractional_divider clk computes mmask and nmask when needed, there
is no more need to provide them explicitly anymore.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/imx/clk-composite-7ulp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-composite-7ulp.c
index 4eedd45dbaa8..e208ddc51133 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -19,10 +19,8 @@
 #define PCG_CGC_SHIFT	30
 #define PCG_FRAC_SHIFT	3
 #define PCG_FRAC_WIDTH	1
-#define PCG_FRAC_MASK	BIT(3)
 #define PCG_PCD_SHIFT	0
 #define PCG_PCD_WIDTH	3
-#define PCG_PCD_MASK	0x7
 
 #define SW_RST		BIT(28)
 
@@ -102,10 +100,8 @@ static struct clk_hw *imx_ulp_clk_hw_composite(const char *name,
 		fd->reg = reg;
 		fd->mshift = PCG_FRAC_SHIFT;
 		fd->mwidth = PCG_FRAC_WIDTH;
-		fd->mmask  = PCG_FRAC_MASK;
 		fd->nshift = PCG_PCD_SHIFT;
 		fd->nwidth = PCG_PCD_WIDTH;
-		fd->nmask = PCG_PCD_MASK;
 		fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
 		if (has_swrst)
 			fd->lock = &imx_ccm_lock;
-- 
2.34.1

