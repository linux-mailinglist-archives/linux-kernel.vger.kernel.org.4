Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E1872B0FA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjFKJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 05:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjFKJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 05:02:05 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC4184;
        Sun, 11 Jun 2023 02:02:03 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Qf82b70y9z9sWm;
        Sun, 11 Jun 2023 11:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686474120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUQkMyU05f1o8TsGE6GyWXIQbMt2IGEtftkSbTpsBoU=;
        b=VOSqdeAw3YXVBI7ydhqrMTOvwqQp9qU9pDAxyjfzV89AcD/juV+PRdNqLXT0vV5EEIPliB
        3Tu5t1GyUtw/ZDX2FTgDL0bLxXfSO+DjtLMNyxqXpfIM3jpVHhv9L96pYvy++01Jh+EpeZ
        LAy5zzQmYANOZDXucyUKQ6TQkJ5jpETU54nSwLoC33pgperm5+TStBG/0+xsSOi9K6jizL
        mJFA6BBTNLdU19yc69skxhvZz4WRTj1dnpRzTSMQfQxAJG98OnaNpRv00vYZh2eEIY+sE1
        CzL/ERMrljTtm1r1q4nnXZ5rkMFTdJYM64aZRq3vDArQi5VfcUN8bQ7Ofk9Asw==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/2] clk: sunxi-ng: nkm: consider alternative parent rates when finding rate
Date:   Sun, 11 Jun 2023 11:01:42 +0200
Message-ID: <20230611090143.132257-2-frank@oltmanns.dev>
In-Reply-To: <20230611090143.132257-1-frank@oltmanns.dev>
References: <20230611090143.132257-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Qf82b70y9z9sWm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the CLK_SET_RATE_PARENT flag is set, consider using a different
parent rate when determining a new rate.

To find the best match for the requested rate, perform the following
steps for each NKM combination:
 - calculate the optimal parent rate,
 - find the best parent rate that the parent clock actually supports
 - use that parent rate to calculate the effective rate.

In case the clk does not support setting the parent rate, use the same
algorithm as before.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 66 +++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index a0978a50edae..c49d5879fe73 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/math.h>
 
 #include "ccu_gate.h"
 #include "ccu_nkm.h"
@@ -16,10 +17,49 @@ struct _ccu_nkm {
 	unsigned long	m, min_m, max_m;
 };
 
-static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
-				       struct _ccu_nkm *nkm)
+static unsigned long optimal_parent_rate(unsigned long rate, unsigned long n,
+					 unsigned long k, unsigned long m)
 {
-	unsigned long best_rate = 0;
+	unsigned long _rate, parent;
+
+	// We must first try to find the desired parent rate that is rounded up, because there are
+	// cases where truncating makes us miss the requested rate.
+	// E.g. rate=449035712, n=11, k=3, m=16
+	// When truncating, we'd get parent=217714284 and calculating the rate from that would give
+	// us 449035710. When rounding up, we get parent=217714285 which would give us the requested
+	// rate of 449035712.
+	parent = DIV_ROUND_UP(rate * m, n * k);
+
+	// But there are other cases, where rounding up the parent gives us a too high rate.
+	// Therefore, we need to check for this case and, if necessary, truncate the parent rate
+	// instead of rounding up.
+	_rate = parent * n * k / m;
+	if (_rate > rate)
+		parent = rate * m / (n * k);
+	return parent;
+}
+
+/**
+ * ccu_nkm_find_best - Find the best nkm combination for a given rate
+ *
+ * @parent: rate of parent clock. This is used either as an input or out parameter:
+ *           - In cases where the parent clock can be set, this parameter will be updated to contain
+ *             the optimal rate for the parent to achieve the best rate for the nkm clock.
+ *           - In cases where the parent clock can not be set, this parameter must contain the
+ *             current rate of the parent, which is used to determine the best combination of n, k,
+ *             and m.
+ * @rate: requested rate.
+ * @nkm: Input/output parameter that contains the clocks constraints on the n, k, m combinations and
+ *       is updated in this function to contain the resulting best n, k, m combination.
+ * @parent_hw: parent clock. If set, this function assumes that the parent clock can be updated to a
+ *             rate that would be best to in order to get as close as possible to @rate. This
+ *             parameter must be set to NULL if this function shall not try to find the optimal
+ *             parent rate for the requested rate.
+ */
+static unsigned long ccu_nkm_find_best(unsigned long *parent, unsigned long rate,
+				       struct _ccu_nkm *nkm, struct clk_hw *parent_hw)
+{
+	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
 	unsigned long best_n = 0, best_k = 0, best_m = 0;
 	unsigned long _n, _k, _m;
 
@@ -28,12 +68,17 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
 				unsigned long tmp_rate;
 
-				tmp_rate = parent * _n * _k / _m;
-
+				if (parent_hw) {
+					tmp_parent = optimal_parent_rate(rate, _n, _k, _m);
+					tmp_parent = clk_hw_round_rate(parent_hw, tmp_parent);
+				}
+				tmp_rate = tmp_parent * _n * _k / _m;
 				if (tmp_rate > rate)
 					continue;
+
 				if ((rate - tmp_rate) < (rate - best_rate)) {
 					best_rate = tmp_rate;
+					best_parent_rate = tmp_parent;
 					best_n = _n;
 					best_k = _k;
 					best_m = _m;
@@ -46,6 +91,8 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 	nkm->k = best_k;
 	nkm->m = best_m;
 
+	*parent = best_parent_rate;
+
 	return best_rate;
 }
 
@@ -106,7 +153,7 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
 }
 
 static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
-					struct clk_hw *hw,
+					struct clk_hw *parent_hw,
 					unsigned long *parent_rate,
 					unsigned long rate,
 					void *data)
@@ -124,7 +171,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
-	rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
+		rate = ccu_nkm_find_best(parent_rate, rate, &_nkm, NULL);
+	else
+		rate = ccu_nkm_find_best(parent_rate, rate, &_nkm, parent_hw);
 
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nkm->fixed_post_div;
@@ -159,7 +209,7 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
-	ccu_nkm_find_best(parent_rate, rate, &_nkm);
+	ccu_nkm_find_best(&parent_rate, rate, &_nkm, NULL);
 
 	spin_lock_irqsave(nkm->common.lock, flags);
 
-- 
2.41.0

