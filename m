Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1D6C10E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCTLgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCTLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:36:11 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F9F1114A;
        Mon, 20 Mar 2023 04:35:23 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 20 Mar 2023
 19:35:20 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>
CC:     <kelvin.zhang@amlogic.com>, <qi.duan@amlogic.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V2] clk: meson: vid-pll-div: added meson_vid_pll_div_ops support
Date:   Mon, 20 Mar 2023 19:34:45 +0800
Message-ID: <20230320113445.17260-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the previous code only provides "ro_ops" for the vid_pll_div
clock. In fact, the clock can be set. So add "ops" that can set the
clock, especially for later chips like S4 SOC and so on.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/clk/meson/vid-pll-div.c | 67 +++++++++++++++++++++++++++++++++
 drivers/clk/meson/vid-pll-div.h |  3 ++
 2 files changed, 70 insertions(+)

diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
index daff235bc763..3c9015944f24 100644
--- a/drivers/clk/meson/vid-pll-div.c
+++ b/drivers/clk/meson/vid-pll-div.c
@@ -89,6 +89,73 @@ static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_UP_ULL(parent_rate * div->multiplier, div->divider);
 }
 
+static int meson_vid_pll_div_determine_rate(struct clk_hw *hw,
+					    struct clk_rate_request *req)
+{
+	unsigned long parent_rate, best = 0, now = 0, rate;
+	unsigned long parent_rate_saved = req->best_parent_rate;
+	unsigned int i, best_i = 0;
+
+	for (i = 0 ; i < VID_PLL_DIV_TABLE_SIZE; ++i) {
+		rate = DIV_ROUND_CLOSEST_ULL(req->rate * vid_pll_div_table[i].divider,
+					     vid_pll_div_table[i].multiplier);
+		if (parent_rate_saved == rate) {
+			req->best_parent_rate = parent_rate_saved;
+			best_i = i;
+			break;
+		}
+
+		parent_rate = clk_hw_round_rate(req->best_parent_hw, rate);
+		now = DIV_ROUND_CLOSEST_ULL(parent_rate *
+					    vid_pll_div_table[i].multiplier,
+					    vid_pll_div_table[i].divider);
+		if (abs(now - req->rate) < abs(best - req->rate)) {
+			best = now;
+			best_i = i;
+			req->best_parent_rate = parent_rate;
+		}
+	}
+
+	req->rate = DIV_ROUND_CLOSEST_ULL(req->best_parent_rate *
+					  vid_pll_div_table[best_i].multiplier,
+					  vid_pll_div_table[best_i].divider);
+
+	return 0;
+}
+
+static int meson_vid_pll_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vid_pll_div_data *pll_div = meson_vid_pll_div_data(clk);
+	unsigned long best = 0, now = 0;
+	unsigned int i, best_i = 0;
+
+	for (i = 0 ; i < VID_PLL_DIV_TABLE_SIZE; ++i) {
+		now = DIV_ROUND_CLOSEST_ULL(parent_rate * vid_pll_div_table[i].multiplier,
+					    vid_pll_div_table[i].divider);
+		if (now == rate) {
+			best_i = i;
+			break;
+		} else if (abs(now - rate) < abs(best - rate)) {
+			best = now;
+			best_i = i;
+		}
+	}
+
+	meson_parm_write(clk->map, &pll_div->val, vid_pll_div_table[best_i].shift_val);
+	meson_parm_write(clk->map, &pll_div->sel, vid_pll_div_table[best_i].shift_sel);
+
+	return 0;
+}
+
+const struct clk_ops meson_vid_pll_div_ops = {
+	.recalc_rate	= meson_vid_pll_div_recalc_rate,
+	.determine_rate	= meson_vid_pll_div_determine_rate,
+	.set_rate	= meson_vid_pll_div_set_rate,
+};
+EXPORT_SYMBOL_GPL(meson_vid_pll_div_ops);
+
 const struct clk_ops meson_vid_pll_div_ro_ops = {
 	.recalc_rate	= meson_vid_pll_div_recalc_rate,
 };
diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vid-pll-div.h
index c0128e33ccf9..bbccab340910 100644
--- a/drivers/clk/meson/vid-pll-div.h
+++ b/drivers/clk/meson/vid-pll-div.h
@@ -10,11 +10,14 @@
 #include <linux/clk-provider.h>
 #include "parm.h"
 
+#define VID_PLL_DIV_TABLE_SIZE		14
+
 struct meson_vid_pll_div_data {
 	struct parm val;
 	struct parm sel;
 };
 
 extern const struct clk_ops meson_vid_pll_div_ro_ops;
+extern const struct clk_ops meson_vid_pll_div_ops;
 
 #endif /* __MESON_VID_PLL_DIV_H */
-- 
2.33.1

