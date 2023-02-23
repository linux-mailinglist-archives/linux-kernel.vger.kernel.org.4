Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FDC6A02D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjBWGbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjBWGbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:31:45 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFA4A1D7;
        Wed, 22 Feb 2023 22:30:57 -0800 (PST)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Thu, 23 Feb 2023
 14:30:55 +0800
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
Subject: [PATCH] clk: meson: vid-pll-div: added meson_vid_pll_div_ops support to enable vid_pll_div to meet clock setting requirements, especially for late chip
Date:   Thu, 23 Feb 2023 14:27:23 +0800
Message-ID: <20230223062723.4770-1-yu.tu@amlogic.com>
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

The previous chip only provides "ro_ops" for the vid_pll_div clock,
which is not satisfied with the operation requirements of the later
chip for this clock, so the ops that can be set for the clock is added.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 drivers/clk/meson/vid-pll-div.c | 59 +++++++++++++++++++++++++++++++++
 drivers/clk/meson/vid-pll-div.h |  1 +
 2 files changed, 60 insertions(+)

diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
index daff235bc763..e75fa6f75efe 100644
--- a/drivers/clk/meson/vid-pll-div.c
+++ b/drivers/clk/meson/vid-pll-div.c
@@ -89,6 +89,65 @@ static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_UP_ULL(parent_rate * div->multiplier, div->divider);
 }
 
+static int meson_vid_pll_div_determine_rate(struct clk_hw *hw,
+					    struct clk_rate_request *req)
+{
+	unsigned long best = 0, now = 0;
+	unsigned int i, best_i = 0;
+
+	for (i = 0 ; i < ARRAY_SIZE(vid_pll_div_table) ; ++i) {
+		now = DIV_ROUND_CLOSEST_ULL(req->best_parent_rate *
+					    vid_pll_div_table[i].multiplier,
+					    vid_pll_div_table[i].divider);
+		if (req->rate == now) {
+			return 0;
+		} else if (abs(now - req->rate) < abs(best - req->rate)) {
+			best = now;
+			best_i = i;
+		}
+	}
+
+	if (best_i < ARRAY_SIZE(vid_pll_div_table))
+		req->rate = DIV_ROUND_CLOSEST_ULL(req->best_parent_rate *
+						  vid_pll_div_table[best_i].multiplier,
+						  vid_pll_div_table[best_i].divider);
+	else
+		req->rate = meson_vid_pll_div_recalc_rate(hw, req->best_parent_rate);
+
+	return 0;
+}
+
+static int meson_vid_pll_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_vid_pll_div_data *pll_div = meson_vid_pll_div_data(clk);
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(vid_pll_div_table) ; ++i) {
+		if (DIV_ROUND_CLOSEST_ULL(parent_rate * vid_pll_div_table[i].multiplier,
+					  vid_pll_div_table[i].divider) == rate) {
+			meson_parm_write(clk->map, &pll_div->val, vid_pll_div_table[i].shift_val);
+			meson_parm_write(clk->map, &pll_div->sel, vid_pll_div_table[i].shift_sel);
+			break;
+		}
+	}
+
+	if (i >= ARRAY_SIZE(vid_pll_div_table)) {
+		pr_debug("%s: Invalid rate value for vid_pll_div\n", __func__);
+		return -EINVAL;
+	}
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
index c0128e33ccf9..3ab729b85fde 100644
--- a/drivers/clk/meson/vid-pll-div.h
+++ b/drivers/clk/meson/vid-pll-div.h
@@ -16,5 +16,6 @@ struct meson_vid_pll_div_data {
 };
 
 extern const struct clk_ops meson_vid_pll_div_ro_ops;
+extern const struct clk_ops meson_vid_pll_div_ops;
 
 #endif /* __MESON_VID_PLL_DIV_H */

base-commit: 8a9fbf00acfeeeaac8efab8091bb464bd71b70ea
-- 
2.33.1

