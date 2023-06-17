Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D7A73411D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbjFQNLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjFQNLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:11:03 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D228F10C8;
        Sat, 17 Jun 2023 06:11:01 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QjxH62X24z9sQ8;
        Sat, 17 Jun 2023 15:10:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1687007458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piM6ASDgch6PVWDiOGs21ydWS2z+iDsSfAmRcYpzIiU=;
        b=KSPOsr5cxsmsYEao8mRDaSqgRmo3HE5aSDD/ijiaVKToPEMnJUPFKjlvEHLfF5v6ZWxbw5
        QamkTttPpyTuSmiMzRV+dK03cJGei4NOtQSyonmD+DzLvJaSBDZXGEW7zmujCn8sVaTWx7
        gtJdJK5rdAzcX4cpP5R9+IpKhdwlwf49QMV3lAjzeMXcMy5fn/Mm5BfAYEe8IWCufgwssS
        t0zyh4vvIO3WsYnTXm7z9Rr1z4vh7CPBgSEGpr4sT9PWlvuCJ/ILGuL23mLxGwibA3y/ig
        W34kAsAkHNPHDQEfW6lZeQlEGWekmwBqu2+hV65R1tZeMgVlgtUlrM/MhlZoMQ==
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
        Shawn Guo <shawnguo@kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v5 1/2] clk: fractional-divider: Improve approximation when zero based and export
Date:   Sat, 17 Jun 2023 15:10:40 +0200
Message-ID: <20230617131041.18313-2-frank@oltmanns.dev>
In-Reply-To: <20230617131041.18313-1-frank@oltmanns.dev>
References: <20230617131041.18313-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4QjxH62X24z9sQ8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the CLK_FRAC_DIVIDER_ZERO_BASED flag when finding the best
approximation for m and n. By doing so, increase the range of valid
values for the numerator and denominator by 1.

Furthermore, export the approximation function so that users of this
function can be compiled as modules.

Cc: A.s. Dong <aisheng.dong@nxp.com>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/clk-fractional-divider.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 479297763e70..5067e067e906 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -123,6 +123,7 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 						  unsigned long *m, unsigned long *n)
 {
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
+	unsigned long max_m, max_n;
 
 	/*
 	 * Get rate closer to *parent_rate to guarantee there is no overflow
@@ -138,10 +139,17 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
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
+EXPORT_SYMBOL_GPL(clk_fractional_divider_general_approximation);
 
 static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
 			      unsigned long *parent_rate)
@@ -169,13 +177,18 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
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

