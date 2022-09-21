Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94A5BF1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIUANQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIUANN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:13:13 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B37F5B790;
        Tue, 20 Sep 2022 17:13:11 -0700 (PDT)
Received: from localhost.localdomain (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 656B71FA1E;
        Wed, 21 Sep 2022 02:13:09 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] clk: qcom: alpha: Add support for programming the PLL_FSM_LEGACY_MODE bit
Date:   Wed, 21 Sep 2022 02:13:01 +0200
Message-Id: <20220921001303.56151-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used on at least SM6375 and its variations.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
No changes since v3

 drivers/clk/qcom/clk-alpha-pll.c | 5 +++++
 drivers/clk/qcom/clk-alpha-pll.h | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index b42684703fbb..ea157723906a 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -27,6 +27,7 @@
 # define PLL_VOTE_FSM_RESET	BIT(21)
 # define PLL_UPDATE		BIT(22)
 # define PLL_UPDATE_BYPASS	BIT(23)
+# define PLL_FSM_LEGACY_MODE	BIT(24)
 # define PLL_OFFLINE_ACK	BIT(28)
 # define ALPHA_PLL_ACK_LATCH	BIT(29)
 # define PLL_ACTIVE_FLAG	BIT(30)
@@ -1102,6 +1103,10 @@ void clk_fabia_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 		regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
 	}
 
+	if (pll->flags & SUPPORTS_FSM_LEGACY_MODE)
+		regmap_update_bits(regmap, PLL_MODE(pll), PLL_FSM_LEGACY_MODE,
+							PLL_FSM_LEGACY_MODE);
+
 	regmap_update_bits(regmap, PLL_MODE(pll), PLL_UPDATE_BYPASS,
 							PLL_UPDATE_BYPASS);
 
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 447efb82fe59..b15a62cb8e36 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -70,9 +70,10 @@ struct clk_alpha_pll {
 
 	const struct pll_vco *vco_table;
 	size_t num_vco;
-#define SUPPORTS_OFFLINE_REQ	BIT(0)
-#define SUPPORTS_FSM_MODE	BIT(2)
+#define SUPPORTS_OFFLINE_REQ		BIT(0)
+#define SUPPORTS_FSM_MODE		BIT(2)
 #define SUPPORTS_DYNAMIC_UPDATE	BIT(3)
+#define SUPPORTS_FSM_LEGACY_MODE	BIT(4)
 	u8 flags;
 
 	struct clk_regmap clkr;
-- 
2.37.3

