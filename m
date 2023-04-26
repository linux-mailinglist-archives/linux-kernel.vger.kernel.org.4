Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF06EFB2A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbjDZTeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjDZTeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87A1B3;
        Wed, 26 Apr 2023 12:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C9B66387B;
        Wed, 26 Apr 2023 19:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1D21C4339B;
        Wed, 26 Apr 2023 19:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682537660;
        bh=O/VWdbP4YDhYnZDCeiwc2oYiQYwSdnJXhX/AEWAFsQc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=n7FQRmLL4WyEjlCwAsQsGm1r5uWN5+zgAl0jyfT9JVjuxx+iku7EbqlvtFF6yuCUC
         49uLGvh4Y/iWJjGHMgS8doTofkgvhftsT9trSEWXVpjyhc6T9vfXRvTGR/p9mkCavj
         IAsfulTuTyq7St7krk1ia0HkIh5ARmD/l5pyF0Xa/lc1MMZeOmOjvP3KbfJKj56JKm
         qPeDgBT1qPF8Q1jE0RfbG4qx+3epLeU3+1H/fYVB7/E/6q3YR2qC52n20b8C5k2Ptw
         qf+lcG0dgX8X7NxjQUo8NRtlg7LG2CKcFp9AwwKmCwMVV/bc5hP0QnkoBOAKarRodB
         GYzcN70ISs1Eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 84EEDC77B7E;
        Wed, 26 Apr 2023 19:34:20 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Thu, 27 Apr 2023 03:34:17 +0800
Subject: [PATCH v3 2/2] clk: tests: Add missing test cases for mux
 determine_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-clk-v3-2-9ff79e7e7fed@outlook.com>
References: <20230421-clk-v3-0-9ff79e7e7fed@outlook.com>
In-Reply-To: <20230421-clk-v3-0-9ff79e7e7fed@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682537658; l=5403;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=ukorzXXoz+p+cK/h39SCI45QuctGTK8HaAHvB2BLCPA=;
 b=6p+VF7zVTR+fhfTHdnuIoe2hf+VoUFHmMHisF+4IK1eRKaodzSANNDsUSQY+kTsu9fyva1loQ
 OtvgowCOTkdBy3JMtQTG3eA1Xl6373lZVPcdn/NHyKh/1DsvQo8Ra4g
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Xiwen <forbidden405@outlook.com>

Add lots of test cases for mux determine_rate to cover more possible
cases, the original test case is renamed for the change.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk_test.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index f9a5c2964c65d..4f7f9a964637a 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -2194,7 +2194,47 @@ static void clk_leaf_mux_set_rate_parent_test_exit(struct kunit *test)
  * parent, the rate request structure returned by __clk_determine_rate
  * is sane and will be what we expect.
  */
-static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
+static void clk_leaf_mux_set_rate_parent_determine_rate_case1(struct kunit *test)
+{
+	struct clk_leaf_mux_ctx *ctx = test->priv;
+	struct clk_hw *hw = &ctx->hw;
+	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk_rate_request req;
+	unsigned long rate;
+	int ret;
+
+	rate = clk_get_rate(clk);
+	KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
+
+	clk_hw_init_rate_request(hw, &req, 0);
+
+	ret = __clk_determine_rate(hw, &req);
+	KUNIT_ASSERT_EQ(test, ret, -EINVAL);
+
+	clk_put(clk);
+}
+
+static void clk_leaf_mux_set_rate_parent_determine_rate_case2(struct kunit *test)
+{
+	struct clk_leaf_mux_ctx *ctx = test->priv;
+	struct clk_hw *hw = &ctx->hw;
+	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk_rate_request req;
+	unsigned long rate;
+	int ret;
+
+	rate = clk_get_rate(clk);
+	KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
+
+	clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_INIT_RATE);
+
+	ret = __clk_determine_rate(hw, &req);
+	KUNIT_ASSERT_EQ(test, ret, -EINVAL);
+
+	clk_put(clk);
+}
+
+static void clk_leaf_mux_set_rate_parent_determine_rate_case3(struct kunit *test)
 {
 	struct clk_leaf_mux_ctx *ctx = test->priv;
 	struct clk_hw *hw = &ctx->hw;
@@ -2218,8 +2258,95 @@ static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
 	clk_put(clk);
 }
 
+static void clk_leaf_mux_set_rate_parent_determine_rate_case4(struct kunit *test)
+{
+	struct clk_leaf_mux_ctx *ctx = test->priv;
+	struct clk_hw *hw = &ctx->hw;
+	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk_rate_request req;
+	unsigned long rate;
+	int ret;
+
+	rate = clk_get_rate(clk);
+	KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
+
+	clk_hw_init_rate_request(hw, &req, (DUMMY_CLOCK_RATE_1 + DUMMY_CLOCK_RATE_2) / 2);
+
+	ret = __clk_determine_rate(hw, &req);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_1);
+	KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_1);
+	KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
+
+	clk_put(clk);
+}
+
+static void clk_leaf_mux_set_rate_parent_determine_rate_case5(struct kunit *test)
+{
+	struct clk_leaf_mux_ctx *ctx = test->priv;
+	struct clk_hw *hw = &ctx->hw;
+	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk_rate_request req;
+	unsigned long rate;
+	int ret;
+
+	rate = clk_get_rate(clk);
+	KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
+
+	clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2 + 100000);
+
+	ret = __clk_determine_rate(hw, &req);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_2);
+	KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_2);
+	KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
+
+	clk_put(clk);
+}
+
+static void clk_leaf_mux_set_rate_parent_determine_rate_case6(struct kunit *test)
+{
+	struct clk_leaf_mux_ctx *ctx = test->priv;
+	struct clk_hw *hw = &ctx->hw;
+	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk_rate_request req;
+	unsigned long rate;
+	int ret;
+
+	rate = clk_get_rate(clk);
+	KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
+
+	clk_hw_init_rate_request(hw, &req, ULONG_MAX);
+
+	ret = __clk_determine_rate(hw, &req);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_2);
+	KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_2);
+	KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
+
+	clk_put(clk);
+}
+
+/* We test 6 cases here:
+ * 1. The requested rate is 0;
+ * 2. The requested rate is not 0 but lower than any rate that parents could offer;
+ * 3. The requested rate is exactly one of the parents' clock rate;
+ * 4. The requested rate is between the lowest clock rate and the highest clock rate that the parents could offer;
+ * 5. The requested rate is larger than all rates that parents could offer;
+ * 6. The requested rate is ULONG_MAX.
+ *
+ * Hopefully they covered all cases.
+ */
 static struct kunit_case clk_leaf_mux_set_rate_parent_test_cases[] = {
-	KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate),
+	KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case1),
+	KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case2),
+	KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case3),
+	KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case4),
+	KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case5),
+	KUNIT_CASE(clk_leaf_mux_set_rate_parent_determine_rate_case6),
 	{}
 };
 

-- 
2.39.2

