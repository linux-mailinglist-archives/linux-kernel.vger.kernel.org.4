Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25A76EFB29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjDZTe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjDZTeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E69D114;
        Wed, 26 Apr 2023 12:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3803D63879;
        Wed, 26 Apr 2023 19:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91E61C433D2;
        Wed, 26 Apr 2023 19:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682537660;
        bh=YCfUs0UZXG+W/RHbEi44EHFGC1R0rtzyXGPsV82SBsE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=vLNeOUWMxgeXE13ZJifZteuNQbONBLaQf9zClcXhXaJ/VTrLRayrYvN0hOlo4z7do
         gjqKWn0iUoqQGSRBxdZy9thcaxgSlGtjSSLpLgB+xr7FQGY0J/1vKQ7ILYGGA6evD6
         zDkK7kpPcB6uHTq5/04EhLKaEt6KI1QRSs9CEsQbQdcdNfJkgw3+YcCQDYNWT8ii3c
         CmEC3vz10ERoRyyoCCc3U5slRhgdFjg1sy8+VWJAtCUey0vZZqoPojuRDlrYHjbD+v
         dlljIYpRK67CaCdYwa60VAp/J1/Ke7OguxTd3tQVHWISEtB5SYWpqLBecjvB26XY1u
         p3UoWhUeHt+rA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 794FBC7618E;
        Wed, 26 Apr 2023 19:34:20 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Thu, 27 Apr 2023 03:34:16 +0800
Subject: [PATCH v3 1/2] clk: use ULONG_MAX as the initial value for the
 iteration in clk_mux_determine_rate_flags()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-clk-v3-1-9ff79e7e7fed@outlook.com>
References: <20230421-clk-v3-0-9ff79e7e7fed@outlook.com>
In-Reply-To: <20230421-clk-v3-0-9ff79e7e7fed@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682537658; l=1478;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=Iu0E0q+m/ABmoRJdE8XwPzuxx9jb5jEc73TdhQk/cwU=;
 b=lp6Wlz34BkiBEGirNzXxZ4uIqmEe8WkQ7rtxd06Gw/mE8ROkS5KmsbZezY6429bqJEzGkcBS3
 0v4ZInnmIhqDGo+5HmSxUMr3njgcI+rASch/8W1a6GgkcCvu7XT62Qh
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
 drivers/clk/clk.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ae07685c7588b..6184d4aa88193 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -541,6 +541,17 @@ EXPORT_SYMBOL_GPL(__clk_is_enabled);
 static bool mux_is_better_rate(unsigned long rate, unsigned long now,
 			   unsigned long best, unsigned long flags)
 {
+	if (rate == ULONG_MAX) {
+		// select the highest clock rate
+		if (best == ULONG_MAX)
+			return true;
+		else
+			return now > best;
+	}
+
+	if (best == ULONG_MAX && now <= rate)
+		return true;
+
 	if (flags & CLK_MUX_ROUND_CLOSEST)
 		return abs(now - rate) < abs(best - rate);
 
@@ -600,7 +611,7 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 {
 	struct clk_core *core = hw->core, *parent, *best_parent = NULL;
 	int i, num_parents, ret;
-	unsigned long best = 0;
+	unsigned long best = ULONG_MAX;
 
 	/* if NO_REPARENT flag set, pass through to current parent */
 	if (core->flags & CLK_SET_RATE_NO_REPARENT) {

-- 
2.39.2

