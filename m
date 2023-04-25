Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777D96EDD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjDYHrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjDYHqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D268D4C13;
        Tue, 25 Apr 2023 00:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D1D362C2B;
        Tue, 25 Apr 2023 07:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3510C4339C;
        Tue, 25 Apr 2023 07:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682408807;
        bh=n0uLaqzrXaL0Pzdh4MV4LgrtNsHLsll3avYApfkg/5k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=iChgVoSbidf99KrJZuNo5w8j0kCaiXSkHWMCDQyI0zo+4ZCIKpsLADS1/St3upxf7
         Gjo7oru1SBs1lPBEZKhNyycsXgQ/nI7ZQ1XlSr5rT4f/K0PV0f84gljX//2fNfX5ku
         o53rqgpS+X4ASsB3CGmi5sn9xwIbGfGVxNM9RDU8fLOS2mNgK+npnhxbmPXjq6256a
         rB1Wfl3ht32RQ7qioUtCrJ+NWSUhXyTdS+XvCS+HC+NsE3+4AOFYNp3lEs6yUrxUWu
         Aq8s5xk2B31e5uRivlaLyqCjtD+VtYQkpu+npb8ntLaXwWDPSUBsvT5uMCfDU8tXY6
         5bmL8ikuYzdGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 9D894C6FD18;
        Tue, 25 Apr 2023 07:46:47 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Date:   Tue, 25 Apr 2023 15:46:39 +0800
Subject: [PATCH v2 1/2] clk: use ULONG_MAX as the initial value for the
 iteration in clk_mux_determine_rate_flags()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-clk-v2-1-74c6cc2214d1@outlook.com>
References: <20230421-clk-v2-0-74c6cc2214d1@outlook.com>
In-Reply-To: <20230421-clk-v2-0-74c6cc2214d1@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682408804; l=1301;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=RtgdZyRNyL73Uk7aVZnLxu+b/Md7l1lfROZ/ueMsp+s=;
 b=awpu1dTnuZNRuDSJV4+H8qKX39whCHYqk53e5OCPtlAUqeIpYXfNYqPv0SypQYFzbZO/jG8bk
 RjNzFGo8ueOCDeKFIkfFr4iaoFitMCcPL38Cd/k5tI6NqhpryiJ3zFY
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

-- 
2.39.2

