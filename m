Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DBD72DC9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbjFMIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbjFMIgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:36:53 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49587171D;
        Tue, 13 Jun 2023 01:36:47 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QgMNX092sz9sTt;
        Tue, 13 Jun 2023 10:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686645404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrLmhksuKVuR06TD0+BUnlxKpggr1/sz/Cz0h1//L8s=;
        b=Vn9AAUwZtb+2x7aHjLSfk3YCkuxQKW5xymxW/Z+3LwyDyDIG8d5wdgov0/ug1qt1Fw4OUd
        KRovHYh4Cf9DicZc3sKgf3Qhc2uForzTLMoz4XbX2iI0qRF873r8rCBgfXV+VqvH+jqA0f
        glGUlNgP7ijupRHJaq09IREqfO7HH7dBVepSoVb+Yu7Is1U6fnD4Q6G1TSUDo1+XkM+TPY
        4kxsxOtePM4hNKE07pE1U2fwMpM4yswIIvdmtdUvw41ldMxD/lvTfeloXYU+GLiQZDU7kI
        08v7oEIsTg1NDL04YCdVRZiNczUceAbkrgfKftsMoca1oteZE/kYuIQQ89Jwgw==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        "A . s . Dong" <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 1/2] clk: fractional-divider: Improve approximation when zero based
Date:   Tue, 13 Jun 2023 10:36:25 +0200
Message-ID: <20230613083626.227476-2-frank@oltmanns.dev>
In-Reply-To: <20230613083626.227476-1-frank@oltmanns.dev>
References: <20230613083626.227476-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4QgMNX092sz9sTt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the CLK_FRAC_DIVIDER_ZERO_BASED flag when finding the best
approximation for m and n. By doing so, increase the range of valid
values for the numerator and denominator by 1.

Cc: A.s. Dong <aisheng.dong@nxp.com>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
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
2.41.0

