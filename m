Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D174D709F96
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjESTFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjESTF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:05:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5251EE42;
        Fri, 19 May 2023 12:05:27 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-213-050.ewe-ip-backbone.de [91.248.213.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D518B6606D84;
        Fri, 19 May 2023 20:05:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684523126;
        bh=3br9jMPdLximgNSwU45gpN9yCInDxEnrw64nWZDC0d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRTL7+n84p45iSl7ihgnzrfpW2k4HYQQxs4UZJKTaVIOL0OGRixvA6UeGthKXNVtg
         lDGS70nBxDL7xzmPf3iOy3yoJFB8vFQ2T5IKPoLY81uj/MnB8tEHUIo4wr+pjlm/9Z
         x90+tQekFA8Z8GGQbx0AxaTXGH00rWi2d2dSX/bbkEnZSfe78Fp2MpfLgxgWYsHJ/m
         SjuAeqKXWz1j1p0CZ6mzLncZxHD88OiVSB8yjCdJcVcsdvlZsVGvhPXHdbQvsgkDYz
         MztxhM69HXoE9o7U6QBa85oDf8vapJ0kQCVauFVsZ7PjNctSXP9fHDN3kljOZZMceL
         6bn7OqiYBIyRg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 89E984807E1; Fri, 19 May 2023 21:05:23 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 2/2] clk: divider: Properly handle rates exceeding UINT_MAX
Date:   Fri, 19 May 2023 21:05:22 +0200
Message-Id: <20230519190522.194729-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519190522.194729-1-sebastian.reichel@collabora.com>
References: <20230519190522.194729-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requesting rates exceeding UINT_MAX (so roughly 4.3 GHz) results
in very small rate being chosen instead of very high ones, since
DIV_ROUND_UP_ULL takes a 32 bit integer as second argument.

Correct this by using DIV64_U64_ROUND_UP instead, which takes proper
64 bit values for dividend and divisor.

Note, that this is usually not an issue. ULONG_MAX sets the lower
32 bits and thus effectively requests UINT_MAX. On most platforms
that is good enough. To trigger a real bug one of the following
conditions must be met:

 * A parent clock with more than 8.5 GHz is available
 * Instead of ULONG_MAX a specific frequency like 4.3 GHz is
   requested. That would end up becoming 5 MHz instead :)

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/clk-divider.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a2c2b5203b0a..dddaaf0f9d25 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -220,7 +220,7 @@ static int _div_round_up(const struct clk_div_table *table,
 			 unsigned long parent_rate, unsigned long rate,
 			 unsigned long flags)
 {
-	int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	int div = DIV64_U64_ROUND_UP(parent_rate, rate);
 
 	if (flags & CLK_DIVIDER_POWER_OF_TWO)
 		div = __roundup_pow_of_two(div);
@@ -237,7 +237,7 @@ static int _div_round_closest(const struct clk_div_table *table,
 	int up, down;
 	unsigned long up_rate, down_rate;
 
-	up = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	up = DIV64_U64_ROUND_UP(parent_rate, rate);
 	down = parent_rate / rate;
 
 	if (flags & CLK_DIVIDER_POWER_OF_TWO) {
@@ -473,7 +473,7 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
 {
 	unsigned int div, value;
 
-	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	div = DIV64_U64_ROUND_UP(parent_rate, rate);
 
 	if (!_is_valid_div(table, div, flags))
 		return -EINVAL;
-- 
2.39.2

