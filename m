Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3318172EC57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbjFMTzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMTyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F50170E;
        Tue, 13 Jun 2023 12:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE82261800;
        Tue, 13 Jun 2023 19:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070A1C433F0;
        Tue, 13 Jun 2023 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686686084;
        bh=01Gy2b0SAp8++a2vjuQkj4/e/l8budPgWfPPBbejKNM=;
        h=From:To:Cc:Subject:Date:From;
        b=l5Rn/F83C70fysAwoHA+9nJdR8eCqM0WUQWwkLnPgY5m84IO+ApRXZdcpGi7JOzsL
         dEkZl60e5ywxRY2ZSTbNiEplcxNVlyZAmAk623GdTTwOShmUCxhUAFFP77h4Ie3iGo
         1JoDZXPVhJIYNV7HoGiafU6vkZU1z8xtTnE+ZOk6BjwsyALCJCSNu2JA86mJlu9Ufa
         rIYa53660HdtMjHwvWGA2EHZlGDMkVmSFtt65wwxrBmwK5hqjvXSNbMDHULEiZz8RF
         /c7Np2W/RvaFuKeO8ULIzI48uwCrYN3Il/H8ipvp5SzTI6DlOuL+AEPZvEqtWclwKL
         0CXEsvPNc8mkg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH] clk: sprd: composite: Simplify determine_rate implementation
Date:   Tue, 13 Jun 2023 12:54:42 -0700
Message-ID: <20230613195443.1555132-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sprd_div_helper_round_rate() function calls divider_round_rate()
which calls divider_round_rate_parent() which calls
divider_determine_rate(). This call chain converts back and forth from
the rate request structure to make a determine_rate clk_op fit with a
round_rate clk_op. Simplify the code here by directly calling
divider_determine_rate() instead.

This fixes a smatch warning where an unsigned long is compared to less
than zero, which is impossible. This makes sprd_div_helper_round_rate()
unnecessary as well so simply remove it and fold it into the only caller
left.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/r/45fdc54e-7ab6-edd6-d55a-473485608473@oracle.com
Cc: Maxime Ripard <maxime@cerno.tech>
Fixes: 302d2f836d78 ("clk: sprd: composite: Switch to determine_rate")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/sprd/composite.c |  9 +--------
 drivers/clk/sprd/div.c       | 14 ++------------
 drivers/clk/sprd/div.h       |  5 -----
 3 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/sprd/composite.c b/drivers/clk/sprd/composite.c
index d3a852720c07..ad6b6383e21f 100644
--- a/drivers/clk/sprd/composite.c
+++ b/drivers/clk/sprd/composite.c
@@ -13,15 +13,8 @@ static int sprd_comp_determine_rate(struct clk_hw *hw,
 				    struct clk_rate_request *req)
 {
 	struct sprd_comp *cc = hw_to_sprd_comp(hw);
-	unsigned long rate;
 
-	rate = sprd_div_helper_round_rate(&cc->common, &cc->div,
-					  req->rate, &req->best_parent_rate);
-	if (rate < 0)
-		return rate;
-
-	req->rate = rate;
-	return 0;
+	return divider_determine_rate(hw, req, NULL, cc->div.width, 0);
 }
 
 static unsigned long sprd_comp_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/sprd/div.c b/drivers/clk/sprd/div.c
index 7621a1d1ab9c..c7261630cab4 100644
--- a/drivers/clk/sprd/div.c
+++ b/drivers/clk/sprd/div.c
@@ -9,23 +9,13 @@
 
 #include "div.h"
 
-long sprd_div_helper_round_rate(struct sprd_clk_common *common,
-				const struct sprd_div_internal *div,
-				unsigned long rate,
-				unsigned long *parent_rate)
-{
-	return divider_round_rate(&common->hw, rate, parent_rate,
-				  NULL, div->width, 0);
-}
-EXPORT_SYMBOL_GPL(sprd_div_helper_round_rate);
-
 static long sprd_div_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *parent_rate)
 {
 	struct sprd_div *cd = hw_to_sprd_div(hw);
 
-	return sprd_div_helper_round_rate(&cd->common, &cd->div,
-					  rate, parent_rate);
+	return divider_round_rate(&cd->common.hw, rate, parent_rate, NULL,
+				  cd->div.width, 0);
 }
 
 unsigned long sprd_div_helper_recalc_rate(struct sprd_clk_common *common,
diff --git a/drivers/clk/sprd/div.h b/drivers/clk/sprd/div.h
index 6acfe6b179fc..f5d614b3dcf1 100644
--- a/drivers/clk/sprd/div.h
+++ b/drivers/clk/sprd/div.h
@@ -64,11 +64,6 @@ static inline struct sprd_div *hw_to_sprd_div(const struct clk_hw *hw)
 	return container_of(common, struct sprd_div, common);
 }
 
-long sprd_div_helper_round_rate(struct sprd_clk_common *common,
-				const struct sprd_div_internal *div,
-				unsigned long rate,
-				unsigned long *parent_rate);
-
 unsigned long sprd_div_helper_recalc_rate(struct sprd_clk_common *common,
 					  const struct sprd_div_internal *div,
 					  unsigned long parent_rate);
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

