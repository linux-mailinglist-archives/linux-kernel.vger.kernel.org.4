Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1020D744F7D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGBR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGBRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:55:58 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D47E60;
        Sun,  2 Jul 2023 10:55:54 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QvGtw65Pwz9sbm;
        Sun,  2 Jul 2023 19:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688320552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fFSE4aJXFFiLcg46myKzbINBS8Qh8rFz5Co1KmVIz9c=;
        b=NxjLsHxmcDG+O4jv6nkpiaLmfTc5Rti/kGk7qPjQ+szKNf2CJB+T36Qn39RKMwMM6YKwQh
        QTRZhlPJf0HOEdT5OPVZk2eTLWlrKh0zg8Zeb85+yKjB3bUAMxEZOY06e3TW93YebdLrRb
        pC6KiIEMuh2H4sNtdP/k2QxVA3dxd37fs0MmJZOVr284oHSzKzI+XJQ84Q/xjRTqut4PA+
        NE3IU4sA6Gwg4TyN1q6dgQx0PVTpBFFaRld1b71ecUQGd2KHSLdYg20U5oYK7yqgD+au4L
        fOvmTXkjEk1qzc7ecvO8BXoKD9x6pTcZUinvfVlxUxy7+xKfBC5LLlSPsTvkFA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 02 Jul 2023 19:55:23 +0200
Subject: [PATCH v3 4/8] clk: sunxi-ng: nm: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230702-pll-mipi_set_rate_parent-v3-4-46dcb8aa9cbc@oltmanns.dev>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6190; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=5Cd03N4wCNx9JuiFbCYwulRT4Tt8W9Fv6aFmgI2nQA0=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkobobzLxhZc/Ur48ZGOAn+H+uJYSqXhqjjM0Py
 RUV9MIN6cuJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZKG6GwAKCRCaaaIIlErT
 x53GC/9lHsOibQro7hT4RiGVeZ8l2DsILXW5s9Q6CWufBDacRWxz6H73PI2jo3tvJGpQL+6MRiH
 A1uN5YRAtSvqQ0FqNGl6GEsIA9sTJQr7vfZGh4nelI7e0jW3Sg6f2+G+Msp7E1aEvi/DJgTSsxm
 lJ2jBOM/FxALfrKKzhOZThjPs9PbTKzuBvJw2F65KAbgMyK1usOJVEIgRPqQxthXLcfrX1rq1al
 GciCpuFrmI+n/1Ag7vGt8Jd+PpCvB6HpSWuAMz/i6zSgco1w3EiZ9MsnZLZLaawAdKFkdHtuUn0
 KMQQu6NkVzyfrk48ugtDIuJUbO9GLzzp/OI8da0McEDa24QQBd8zRm+/pjS+5/8gQC/3YgJdpK5
 e22vixHylxMVtQBm92TenOOsZWp2ubv+7j6faTgeaozCwbMLulBFMVM2Ds28aJ4T0/aDSGvqD8z
 voDdxm05UoHnz2XIp4xl1RVRiog8DfIzq5sy4AZLAQHqQFwVlCntykRayuV/I77rgvqIM=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4QvGtw65Pwz9sbm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorporate a new function, ccu_nm_find_best_closest, that selects the
closest possible rate instead of the closest rate that is less than the
requested rate. Utilizing rational_best_approximation has the additional
effect of boosting performance in clock rate selection.

In cases where the CCU_FEATURE_CLOSEST_RATE flag is set, use
ccu_nm_find_best_closest instead of the original ccu_nm_find_best
function.

Extend the macro SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX to allow
selecting additional features and update all usages of the macro with no
additional flags set.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c |  6 ++++--
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c   |  3 ++-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c  |  6 ++++--
 drivers/clk/sunxi-ng/ccu_nm.c         | 23 +++++++++++++++++++++--
 drivers/clk/sunxi-ng/ccu_nm.h         |  6 ++++--
 5 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index a139a5c438d4..ebfab1fdbb96 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -80,7 +80,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk, "pll-video0",
 						297000000,	/* frac rate 1 */
 						BIT(31),	/* gate */
 						BIT(28),	/* lock */
-						CLK_SET_RATE_UNGATE);
+						CLK_SET_RATE_UNGATE,
+						0);		/* features */
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					"osc24M", 0x018,
@@ -143,7 +144,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video1_clk, "pll-video1",
 						297000000,	/* frac rate 1 */
 						BIT(31),	/* gate */
 						BIT(28),	/* lock */
-						CLK_SET_RATE_UNGATE);
+						CLK_SET_RATE_UNGATE,
+						0);		/* features */
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 					"osc24M", 0x038,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index bfebe8dbbe65..1e2669648a24 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -76,7 +76,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video_clk, "pll-video",
 						297000000, /* frac rate 1 */
 						BIT(31),   /* gate */
 						BIT(28),   /* lock */
-						CLK_SET_RATE_UNGATE);
+						CLK_SET_RATE_UNGATE,
+						0);        /* features */
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					"osc24M", 0x0018,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 31eca0d3bc1e..63907b86ce06 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -82,7 +82,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk, "pll-video0",
 						297000000,  /* frac rate 1 */
 						BIT(31),    /* gate */
 						BIT(28),    /* lock */
-						CLK_SET_RATE_UNGATE);
+						CLK_SET_RATE_UNGATE,
+						0);         /* features */
 
 /* TODO: The result of N/M is required to be in [8, 25] range. */
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
@@ -169,7 +170,8 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video1_clk, "pll-video1",
 						297000000,  /* frac rate 1 */
 						BIT(31),    /* gate */
 						BIT(28),    /* lock */
-						CLK_SET_RATE_UNGATE);
+						CLK_SET_RATE_UNGATE,
+						0);         /* features */
 
 static struct ccu_nkm pll_sata_clk = {
 	.enable		= BIT(31),
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index c1fd11542c45..97d8d9e3255c 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/rational.h>
 
 #include "ccu_frac.h"
 #include "ccu_gate.h"
@@ -56,6 +57,18 @@ static unsigned long ccu_nm_find_best(unsigned long parent, unsigned long rate,
 	return best_rate;
 }
 
+static unsigned long ccu_nm_find_best_closest(unsigned long parent, unsigned long rate,
+				      struct _ccu_nm *nm)
+{
+	unsigned long best_rate = 0;
+
+	rational_best_approximation(rate, parent, nm->max_n, nm->max_m, &nm->n, &nm->m);
+
+	best_rate = ccu_nm_calc_rate(parent, nm->n, nm->m);
+
+	return best_rate;
+}
+
 static void ccu_nm_disable(struct clk_hw *hw)
 {
 	struct ccu_nm *nm = hw_to_ccu_nm(hw);
@@ -159,7 +172,10 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
-	rate = ccu_nm_find_best(*parent_rate, rate, &_nm);
+	if (nm->common.features & CCU_FEATURE_CLOSEST_RATE)
+		rate = ccu_nm_find_best_closest(*parent_rate, rate, &_nm);
+	else
+		rate = ccu_nm_find_best(*parent_rate, rate, &_nm);
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nm->fixed_post_div;
@@ -210,7 +226,10 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 					   &_nm.m, &_nm.n);
 	} else {
 		ccu_sdm_helper_disable(&nm->common, &nm->sdm);
-		ccu_nm_find_best(parent_rate, rate, &_nm);
+		if (nm->common.features & CCU_FEATURE_CLOSEST_RATE)
+			ccu_nm_find_best_closest(parent_rate, rate, &_nm);
+		else
+			ccu_nm_find_best(parent_rate, rate, &_nm);
 	}
 
 	spin_lock_irqsave(nm->common.lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
index 2904e67f05a8..a3825c4e8d42 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.h
+++ b/drivers/clk/sunxi-ng/ccu_nm.h
@@ -116,7 +116,8 @@ struct ccu_nm {
 						 _frac_en, _frac_sel,	\
 						 _frac_rate_0,		\
 						 _frac_rate_1,		\
-						 _gate, _lock, _flags)	\
+						 _gate, _lock, _flags,	\
+						 _features)		\
 	struct ccu_nm _struct = {					\
 		.enable		= _gate,				\
 		.lock		= _lock,				\
@@ -129,7 +130,8 @@ struct ccu_nm {
 		.max_rate	= _max_rate,				\
 		.common		= {					\
 			.reg		= _reg,				\
-			.features	= CCU_FEATURE_FRACTIONAL,	\
+			.features	= CCU_FEATURE_FRACTIONAL |	\
+					  _features,	\
 			.hw.init	= CLK_HW_INIT(_name,		\
 						      _parent,		\
 						      &ccu_nm_ops,	\

-- 
2.41.0

