Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1BC6EDD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDYHrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjDYHqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E94C1B;
        Tue, 25 Apr 2023 00:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EFA662C2E;
        Tue, 25 Apr 2023 07:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA484C433EF;
        Tue, 25 Apr 2023 07:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682408807;
        bh=6Pnug/27whDytkmeiic0CYbvDPeiXSI2PUOdTUfzKUc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=rw97KsIWbn3SzxXCuHcnoGrLTib62W+Qs0kkcmNIZhd5JZmsaYBISB3W01kKqQ6th
         xoVKvhk+/fhHGQNmMWrL5HxKEagDGZGPwuyhBF4mKFv6p+LvFblQS4uQrUec6gqbRZ
         kROIyXFCVkgUHxZmjjGuYXZoncaXFEl4FBn8OqilrA37ZtIh5VW+sc+NWKcXx0U1di
         joyCE1U6RegKyF98/0mb/bI6a5zU9baVwWcft9ZPKEYlDrhxFoQR1hybgDmk03+j9U
         D0OEOoun+sUGBMxRgl4LNGotleUoCVxKypUyEI7ewYedhePDx4q7XPjK1PXvhlOKhW
         NY5maXrLYljDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id AD4B8C77B76;
        Tue, 25 Apr 2023 07:46:47 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Tue, 25 Apr 2023 15:46:40 +0800
Subject: [PATCH v2 2/2] clk: tests: Add missing test case for mux
 determine_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-clk-v2-2-74c6cc2214d1@outlook.com>
References: <20230421-clk-v2-0-74c6cc2214d1@outlook.com>
In-Reply-To: <20230421-clk-v2-0-74c6cc2214d1@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682408804; l=1148;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=9OLnZFueJynRZ3/SvtdA921aQdEuKJhzY8cmJ1y5r2Y=;
 b=pdXVz8zXO1kXbFfAdJ/F15BBHF/1kAn2fhFbi8+/zSxB0PPgyE7tRm3SSeQEjMvI/zH4HDqAQ
 /LWxPZfpgvADWcbrp4mevnApifX4nH2eR+d3HP1k0vnov5Tg2gcRW9J
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Xiwen <forbidden405@outlook.com>

Add a missing test case for determine_rate implemented by mux. It tests
the behavior of determine_rate when requesting a rate that none of the
parents could give.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk_test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index f9a5c2964c65d..9b1c90de90454 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -2215,6 +2215,15 @@ static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_2);
 	KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
 
+	// Test a non-existant rate which none of the parents could give
+	clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_INIT_RATE);
+
+	ret = __clk_determine_rate(hw, &req);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_1);
+	KUNIT_EXPECT_EQ(test, req.best_parent_rate, DUMMY_CLOCK_RATE_1);
+	KUNIT_EXPECT_PTR_EQ(test, req.best_parent_hw, &ctx->mux_ctx.hw);
 	clk_put(clk);
 }
 

-- 
2.39.2

