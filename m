Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C667134F8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjE0N2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjE0N21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 09:28:27 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C87B1;
        Sat, 27 May 2023 06:28:25 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QT2fp11vSz9scm;
        Sat, 27 May 2023 15:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685194098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4E0//LKBNUllQfAtkiLIrhWN7vXYAzX6w6tTzQQg8xk=;
        b=OvGVuYsKY7RuRPhxEsjloD+qLuaq7awbeJKTP8VfsQmuXdzIo5jrdutG53X3Lo2nnc+rpG
        76ZGsRemAnDeuwaChPtGROHGTOXlVweQHvkn03uIuBEguEACkXmNr7MzE+KmkYbrdnkJeY
        y30NivBAuv6lziTLewyWXYZprgOfcd0gwsXNTPf2LquA/K8NtM3YKv1luQ1cjJo2u8z/+y
        gNwhnCk70+EoQKHm853UIogoYSwytYF9+j7EUAO7qFab5WvI4t3CcG4G0c+SfXI88DycWo
        JtQeA69v9mbTY7igiAfe8A/hFN42x+8awJX66stHWJKYVDJ4ZIaFkQPjYlCviQ==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH 2/3] clk: sunxi-ng: Implement precalculated NKM rate selection
Date:   Sat, 27 May 2023 15:27:46 +0200
Message-Id: <20230527132747.83196-3-frank@oltmanns.dev>
In-Reply-To: <20230527132747.83196-1-frank@oltmanns.dev>
References: <20230527132747.83196-1-frank@oltmanns.dev>
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

Add a new precalculation method for NKM clock rate selection in the
sunxi-ng clock driver. Introduce ccu_nkm_find_best_precalc which uses a
precalculated table of valid NKM combinations (struct clk_nkm_table and
struct clk_nkm_combo) to find the best rate. This approach provides
faster rate selection by searching a table of valid combinations rather
than calculating for all possible combinations.

The table of NKM combinations needs to be initialized with meaningful
combinations only, i.e. removing redundant combinations that result in
the same rate.

Keep the existing ccu_nkm_find_best function in place and use it as a
fallback if no precalculated table is provided.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 84 +++++++++++++++++++++++++++-------
 drivers/clk/sunxi-ng/ccu_nkm.h | 26 +++++++++++
 2 files changed, 94 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 94d2a83992b2..9652f6df17bd 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -54,6 +54,49 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 	return best_rate;
 }
 
+static unsigned long ccu_nkm_find_best_precalc(unsigned long parent,
+					       unsigned long rate,
+					       struct _ccu_nkm *nkm,
+					       struct clk_nkm_table *table)
+{
+	unsigned long best_rate = 0, best_diff = ULONG_MAX;
+	unsigned long best_n = 0, best_k = 0, best_m = 0;
+	int start = 0, end = table->num - 1, mid;
+
+	while (start <= end) {
+		unsigned long tmp_rate;
+		unsigned long tmp_diff;
+
+		mid = (start + end) / 2;
+
+		tmp_rate = parent * table->combos[mid].n * table->combos[mid].k /
+			   table->combos[mid].m;
+
+		tmp_diff = abs(rate - tmp_rate);
+
+		if (tmp_diff < best_diff) {
+			best_rate = tmp_rate;
+			best_diff = tmp_diff;
+			best_n = table->combos[mid].n;
+			best_k = table->combos[mid].k;
+			best_m = table->combos[mid].m;
+			if (best_diff == 0)
+				goto out;
+		}
+		if (rate < tmp_rate)
+			end = mid - 1;
+		else
+			start = mid + 1;
+	}
+
+out:
+	nkm->n = best_n;
+	nkm->k = best_k;
+	nkm->m = best_m;
+
+	return best_rate;
+}
+
 static void ccu_nkm_disable(struct clk_hw *hw)
 {
 	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
@@ -119,17 +162,22 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	struct ccu_nkm *nkm = data;
 	struct _ccu_nkm _nkm;
 
-	_nkm.min_n = nkm->n.min ?: 1;
-	_nkm.max_n = nkm->n.max ?: 1 << nkm->n.width;
-	_nkm.min_k = nkm->k.min ?: 1;
-	_nkm.max_k = nkm->k.max ?: 1 << nkm->k.width;
-	_nkm.min_m = 1;
-	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
-
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
-	rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+	if (nkm->table.num)
+		rate = ccu_nkm_find_best_precalc(*parent_rate, rate, &_nkm,
+						 &nkm->table);
+	else {
+		_nkm.min_n = nkm->n.min ?: 1;
+		_nkm.max_n = nkm->n.max ?: 1 << nkm->n.width;
+		_nkm.min_k = nkm->k.min ?: 1;
+		_nkm.max_k = nkm->k.max ?: 1 << nkm->k.width;
+		_nkm.min_m = 1;
+		_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
+
+		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+	}
 
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nkm->fixed_post_div;
@@ -157,14 +205,18 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
-	_nkm.min_n = nkm->n.min ?: 1;
-	_nkm.max_n = nkm->n.max ?: 1 << nkm->n.width;
-	_nkm.min_k = nkm->k.min ?: 1;
-	_nkm.max_k = nkm->k.max ?: 1 << nkm->k.width;
-	_nkm.min_m = 1;
-	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
-
-	ccu_nkm_find_best(parent_rate, rate, &_nkm);
+	if (nkm->table.num)
+		rate = ccu_nkm_find_best_precalc(*parent_rate, rate, &_nkm,
+						 &nkm->table);
+	else {
+		_nkm.min_n = nkm->n.min ?: 1;
+		_nkm.max_n = nkm->n.max ?: 1 << nkm->n.width;
+		_nkm.min_k = nkm->k.min ?: 1;
+		_nkm.max_k = nkm->k.max ?: 1 << nkm->k.width;
+		_nkm.min_m = 1;
+		_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
+		ccu_nkm_find_best(parent_rate, rate, &_nkm);
+	}
 
 	spin_lock_irqsave(nkm->common.lock, flags);
 
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
index 6601defb3f38..fa5551724921 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.h
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -12,6 +12,30 @@
 #include "ccu_div.h"
 #include "ccu_mult.h"
 
+struct clk_nkm_combo {
+	u8	n;
+	u8	k;
+	u8	m;
+};
+
+/**
+ * struct clk_nkm_table - Table of all meaningful combinations for n, k, and m
+ *
+ * @num: Number of entries in the table
+ * @combos: Array of combos (of size num) that are supported by this clock.
+ *
+ * This table shall contain all meaningful combinations of n, k, and m. That
+ * means that combinations that result in the same clock rate shall only be
+ * listed once. For example, if both
+ * { .n = 1, .k = 2, .m = 2} and  { .n = 2, .k = 2, .m = 4}
+ * are valid values for n, k, and m, only one of them would be allowed because
+ * both result in a factor of 1.0.
+ */
+struct clk_nkm_table {
+	size_t			num;
+	struct clk_nkm_combo	*combos;
+};
+
 /*
  * struct ccu_nkm - Definition of an N-K-M clock
  *
@@ -29,6 +53,8 @@ struct ccu_nkm {
 	unsigned int		fixed_post_div;
 
 	struct ccu_common	common;
+
+	struct clk_nkm_table	table;
 };
 
 #define SUNXI_CCU_NKM_WITH_MUX_GATE_LOCK(_struct, _name, _parents, _reg, \
-- 
2.40.1

