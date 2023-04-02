Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766936D368F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjDBJm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjDBJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:42:26 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC3A1BF7B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 02:42:24 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id iuDzpwm4hwFKBiuEApeDi6; Sun, 02 Apr 2023 11:42:23 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Apr 2023 11:42:23 +0200
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
Subject: [PATCH v2 1/4] clk: Compute masks for fractional_divider clk when needed.
Date:   Sun,  2 Apr 2023 11:42:04 +0200
Message-Id: <0fd6357242c974259c9e034c6e28a0391c480bf0.1680423909.git.christophe.jaillet@wanadoo.fr>
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

There is no real need to pre-compute mmask and nmask when handling
fractional_divider clk.

They can be computed when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clk/clk-fractional-divider.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 6affe3565025..479297763e70 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -71,6 +71,7 @@ static void clk_fd_get_div(struct clk_hw *hw, struct u32_fract *fract)
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
 	unsigned long flags = 0;
 	unsigned long m, n;
+	u32 mmask, nmask;
 	u32 val;
 
 	if (fd->lock)
@@ -85,8 +86,11 @@ static void clk_fd_get_div(struct clk_hw *hw, struct u32_fract *fract)
 	else
 		__release(fd->lock);
 
-	m = (val & fd->mmask) >> fd->mshift;
-	n = (val & fd->nmask) >> fd->nshift;
+	mmask = GENMASK(fd->mwidth - 1, 0) << fd->mshift;
+	nmask = GENMASK(fd->nwidth - 1, 0) << fd->nshift;
+
+	m = (val & mmask) >> fd->mshift;
+	n = (val & nmask) >> fd->nshift;
 
 	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
 		m++;
@@ -166,6 +170,7 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
 	unsigned long flags = 0;
 	unsigned long m, n;
+	u32 mmask, nmask;
 	u32 val;
 
 	rational_best_approximation(rate, parent_rate,
@@ -182,8 +187,11 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		__acquire(fd->lock);
 
+	mmask = GENMASK(fd->mwidth - 1, 0) << fd->mshift;
+	nmask = GENMASK(fd->nwidth - 1, 0) << fd->nshift;
+
 	val = clk_fd_readl(fd);
-	val &= ~(fd->mmask | fd->nmask);
+	val &= ~(mmask | nmask);
 	val |= (m << fd->mshift) | (n << fd->nshift);
 	clk_fd_writel(fd, val);
 
@@ -260,10 +268,8 @@ struct clk_hw *clk_hw_register_fractional_divider(struct device *dev,
 	fd->reg = reg;
 	fd->mshift = mshift;
 	fd->mwidth = mwidth;
-	fd->mmask = GENMASK(mwidth - 1, 0) << mshift;
 	fd->nshift = nshift;
 	fd->nwidth = nwidth;
-	fd->nmask = GENMASK(nwidth - 1, 0) << nshift;
 	fd->flags = clk_divider_flags;
 	fd->lock = lock;
 	fd->hw.init = &init;
-- 
2.34.1

