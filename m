Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DAF744F7C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjGBR4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjGBRz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:55:56 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008DE69;
        Sun,  2 Jul 2023 10:55:49 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QvGtp5jn5z9sWl;
        Sun,  2 Jul 2023 19:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688320546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9fmM0fT8uj3/mQjTtgGNj5UoFoMoqnDLGSIr5/oXTs=;
        b=SdiVR4MaEnrn4e0/1imGtdk3j96t4YqmDLtnEiKreTm9t9nW9wTtLAWgB4thPn4V4JasHy
        9Fl+GZdP/qJ569jahiW8JknXFSmuShk1mepjZk1c0Ll7t9lPAteyRE6+z3lRi+SyV1BBvX
        QJgwvV2EPK7nKW4Q83/zEJ+8a67eWbr1wjAKojZJIe336Oh3CM26whugevkZ01NUGmKIn5
        3BQt70mxv2bBDP3kav/PMzxptjGmCz5T3yeMUR3iZANJ6I93kbiz1MRPcOnYLCv+yno409
        ddVtXdPlbBuz2pRBhVJwrAqqMhSX5CshXfS8uPe1MCkJ2Z5bnbP+svkIj2B08w==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 02 Jul 2023 19:55:20 +0200
Subject: [PATCH v3 1/8] clk: sunxi-ng: nkm: consider alternative parent
 rates when determining rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230702-pll-mipi_set_rate_parent-v3-1-46dcb8aa9cbc@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3396; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=HVQ5eb3Px+mMKJ3qzsFpElQcZwMVX6kra1Fj/PYKI+o=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkobobH6sAdwPDpCnBt7BVKXWjmOzHtCN5tQzCd
 jGIoubVUyqJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZKG6GwAKCRCaaaIIlErT
 x1eYDACPfjAKC+7Gsc70ClrDjNtQWbTy/MzHDJHYfwaPbG56Q4xfN9pNwZE9amuRcJPke0LF6Lc
 jANjHUPkOOSGHWDIda+BopPu28R48OdFZNuUdLtL3fyzA0AgodLkcKZkVUzz08uMxJQIEGxb05q
 fD0/8WnY0GgkxNhIVDByiE8mZCAt/syOzNvYMdERMJ/Q/XEPTcQGs9BBa2Vibo0C/RJ/R76kEXh
 w4y54LeEst5NL/AKNp5c0GgS6jEpYsFJMMT1DQcLiigWTP84++MuPuKH5Pzyi18d9TlCtfLIVou
 UXR5fJ/EAcGqleurg+PUaLQJARw8k9aAX1uqgE2jClgy5V7tdymilCOpmXSo0SmsUO1V7e0SWyM
 E5bLdYwWOkseHRnelpLGbzBXUhlIsbbV/uSfgg3v9fyTkx7QBl4lrg1s49sjqUJ0C2LuarpFuwM
 KpWmBrC+LgPBHklEAQZ/edq0sfeQFMsNOlCqRY8Wx1om8/AFe0cKQZuYooQg7BN/fHd7Y=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4QvGtp5jn5z9sWl
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
 drivers/clk/sunxi-ng/ccu_nkm.c | 48 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index a0978a50edae..d83843e69c25 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/math.h>
 
 #include "ccu_gate.h"
 #include "ccu_nkm.h"
@@ -16,6 +17,44 @@ struct _ccu_nkm {
 	unsigned long	m, min_m, max_m;
 };
 
+static unsigned long ccu_nkm_find_best_with_parent_adj(unsigned long *parent, unsigned long rate,
+						       struct _ccu_nkm *nkm, struct clk_hw *phw)
+{
+	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
+	unsigned long best_n = 0, best_k = 0, best_m = 0;
+	unsigned long _n, _k, _m;
+
+	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
+		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
+			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
+				unsigned long tmp_rate;
+
+				tmp_parent = clk_hw_round_rate(phw, rate * _m / (_n * _k));
+
+				tmp_rate = tmp_parent * _n * _k / _m;
+				if (tmp_rate > rate)
+					continue;
+
+				if ((rate - tmp_rate) < (rate - best_rate)) {
+					best_rate = tmp_rate;
+					best_parent_rate = tmp_parent;
+					best_n = _n;
+					best_k = _k;
+					best_m = _m;
+				}
+			}
+		}
+	}
+
+	nkm->n = best_n;
+	nkm->k = best_k;
+	nkm->m = best_m;
+
+	*parent = best_parent_rate;
+
+	return best_rate;
+}
+
 static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 				       struct _ccu_nkm *nkm)
 {
@@ -106,7 +145,7 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
 }
 
 static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
-					struct clk_hw *hw,
+					struct clk_hw *parent_hw,
 					unsigned long *parent_rate,
 					unsigned long rate,
 					void *data)
@@ -124,7 +163,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
-	rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
+		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+	else
+		rate = ccu_nkm_find_best_with_parent_adj(parent_rate, rate, &_nkm, parent_hw);
 
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nkm->fixed_post_div;
@@ -159,7 +201,7 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
-	ccu_nkm_find_best(parent_rate, rate, &_nkm);
+	ccu_nkm_find_best(&parent_rate, rate, &_nkm);
 
 	spin_lock_irqsave(nkm->common.lock, flags);
 

-- 
2.41.0

