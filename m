Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405506EAE5C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjDUP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjDUP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6B712C87;
        Fri, 21 Apr 2023 08:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28F0C64EEE;
        Fri, 21 Apr 2023 15:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8977EC433EF;
        Fri, 21 Apr 2023 15:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682092602;
        bh=XU1f54RNsab+tDqSiS+rVrizLk0jrqbfUMef83cufsg=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=Selg5O2+RUBECvFqLlQohN+8XjmUmtjKxpt4N/aE+OJDKSVkhXoXgLEjop/Rn0uBU
         VoZ+QeJFK7biU3TxB0Jo1UhiC4bSyVYcIndBVDCptM9KAPCL5kputKxE0JGqeBNgFM
         0r+LoXgQtPi67fFXw4RrM7BgZ3HFr+VvGSpYklj5Rrb98FxEWfONRo7e2uUf1jM0qU
         EcWS2BA/fRvBP+ZBkxp8r6637cMh4R4J8SM/kInxJBqZxhDcVJEqHAyzJcptJzhDA1
         uc3VZF3QJs4oo+X90YLypB8pn2eKkyfEI2DtliTTFXqVsPc8tz9RJ+RyPwECVgO1Qk
         K4+LKDmxWSgHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 76BB4C77B61;
        Fri, 21 Apr 2023 15:56:42 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Fri, 21 Apr 2023 23:56:38 +0800
Subject: [PATCH] clk: use ULONG_MAX as the initial value for the iteration
 in clk_mux_determine_rate_flags()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-clk-v1-1-bb503f2f2cf3@outlook.com>
X-B4-Tracking: v=1; b=H4sIADWyQmQC/x2MQQqEMAwAvyI5W7BVevAryx7aNGpQu0siIoh/t
 3ocZpgTlIRJoa9OENpZ+ZcL2LoCnEIeyXAqDK5xbdM5a3CZje/QR0/OYopQyhiUTJSQcXraNeh
 G8oi/0MDHu/98r+sG21J/qm4AAAA=
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682092599; l=1447;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=ytvGjpTT/iD/YyNfNbs7xnF5FUQ/FGezwhki/7VVuk0=;
 b=x/5HVLQ6VewfSBPSIWtRlNHZMEnOYh3iOPFIDFCFysM+v7AJ4ZhdQ4kQumhDKGoJXg4En8/nb
 1PAI+QnHqkmD/rLNmamWa3YjAYVPYM+hJeAj7n+hBfdW3WkYUpkddvZ
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

Currently, clk_mux_determine_rate_flags() use 0 as the initial value for
selecting the best matching parent. However, this will choose a
non-existant rate(0) if the requested rate is closer to 0 than the
minimum rate the parents have.

Fix that by initializing the initial value to ULONG_MAX and treat it as a
magic number.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ae07685c7588b..ab8a2acfac8f3 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -541,6 +541,9 @@ EXPORT_SYMBOL_GPL(__clk_is_enabled);
 static bool mux_is_better_rate(unsigned long rate, unsigned long now,
 			   unsigned long best, unsigned long flags)
 {
+	if (best == ULONG_MAX)
+		return true;
+
 	if (flags & CLK_MUX_ROUND_CLOSEST)
 		return abs(now - rate) < abs(best - rate);
 
@@ -600,7 +603,7 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 {
 	struct clk_core *core = hw->core, *parent, *best_parent = NULL;
 	int i, num_parents, ret;
-	unsigned long best = 0;
+	unsigned long best = ULONG_MAX;
 
 	/* if NO_REPARENT flag set, pass through to current parent */
 	if (core->flags & CLK_SET_RATE_NO_REPARENT) {

---
base-commit: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8
change-id: 20230421-clk-64c6b6e21cdb

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

