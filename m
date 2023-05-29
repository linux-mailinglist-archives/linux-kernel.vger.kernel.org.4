Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908C9714A71
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjE2NfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjE2NfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:35:06 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA1F90;
        Mon, 29 May 2023 06:35:03 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QVGjW6BrQz9slB;
        Mon, 29 May 2023 15:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685367295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=embt6Ls9k2VANJwMs4RIikcIM5ejyhPH8j4QEL/1Chc=;
        b=pr9UbGDU54G0Xsls/ofB+w5J0fzZb/9S0Um4muqDszOKa1qBqPlPGQiWADhuDz+D0NVbxZ
        qY9udn/s6sy1N5b/rZN6OQXtu/S5ME2jEhO3SlPx9+lZ3ikiXPCs/eE9m4IY+BTLBTGZzt
        ziVsW2w3LV2crmzS21t+/JZYcYQH9hVCWSAyGzAGrJ12maXwajgNo4AJKmIqz33+TEw40L
        wSbuFn4/P6DJeN50rJmPgja+mVnq82y/NLzLnPkbjhe9A1wcUrUoP5oUuY1+Vi3WlCPWSN
        /0DS+bz2w7Q0C2KNKkHCQy2vcUlwec/yfVsBeBJD7MIWE8DpAwEIqqjhXMJo2A==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: fractional-divider: Improve approximation when zero based
Date:   Mon, 29 May 2023 15:34:33 +0200
Message-Id: <20230529133433.56215-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the CLK_FRAC_DIVIDER_ZERO_BASED flag when finding the best
approximation for m and n. By doing so, increase the range of valid
values for the numerator and denominator by 1.

Cc: A.s. Dong <aisheng.dong@nxp.com
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
I stumpled upon this, when familiarizing myself with clk drivers. Unfortunately,
I have no boards to test this patch. It seems the only user of this flag in
mainline is drivers/clk/imx/clk-composite-7ulp.c, therefore I'm cc-ing
get_maintainers.pl --git-blame -f drivers/clk/imx/clk-composite-7ulp.c
in the hopes of a wider audience.

Thank you for considering this contribution,
  Frank

 drivers/clk/clk-fractional-divider.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 479297763e70..7da21cd2bdb1 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -123,6 +123,7 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 						  unsigned long *m, unsigned long *n)
 {
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
+	unsigned long max_m, max_n;
 
 	/*
 	 * Get rate closer to *parent_rate to guarantee there is no overflow
@@ -138,9 +139,15 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 			rate <<= scale - fd->nwidth;
 	}
 
-	rational_best_approximation(rate, *parent_rate,
-			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
-			m, n);
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		max_m = 1 << fd->mwidth;
+		max_n = 1 << fd->nwidth;
+	} else {
+		max_m = GENMASK(fd->mwidth - 1, 0);
+		max_n = GENMASK(fd->nwidth - 1, 0);
+	}
+
+	rational_best_approximation(rate, *parent_rate, max_m, max_n, m, n);
 }
 
 static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -169,13 +176,18 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
 	unsigned long flags = 0;
-	unsigned long m, n;
+	unsigned long m, n, max_m, max_n;
 	u32 mmask, nmask;
 	u32 val;
 
-	rational_best_approximation(rate, parent_rate,
-			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
-			&m, &n);
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		max_m = 1 << fd->mwidth;
+		max_n = 1 << fd->nwidth;
+	} else {
+		max_m = GENMASK(fd->mwidth - 1, 0);
+		max_n = GENMASK(fd->nwidth - 1, 0);
+	}
+	rational_best_approximation(rate, parent_rate, max_m, max_n, &m, &n);
 
 	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
 		m--;
-- 
2.40.1

