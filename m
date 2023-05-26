Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35B2712B76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242266AbjEZRLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjEZRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:11:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA0F3;
        Fri, 26 May 2023 10:11:00 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-132-021.ewe-ip-backbone.de [91.248.132.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 918536606E95;
        Fri, 26 May 2023 18:10:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685121059;
        bh=T4lpsRVLH6x7IReX3htoV7ctOeRMnG2Z8G+kSXW+NWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQMmdb+lt47Nfyk60vuz43mxBRGxAFCuth1e7EdEYjEs4yei18dyATChn8dt2sqYz
         mTXJthprnnFujc8KXNsnukL+v6lc7oOLF1EH5FWqiCCNsILbqkBG82sQAlOGNiTFRU
         iGZ37UJspuNS561holzqTqRltGh7PCKgwi7lfznv7aS8LDOQhfH6tohw5YhezK1UzG
         kU/ifwIaMRaWzDU432gRJTscGZZpQXOkmRjlp5B1R/Bq/js+2gjnwLC2hUXzEVub70
         pmxTBTJTW42CuKlTRDs5pRSyQR/ez5QtzAZK1kqx83gUfFLY0iDBfSIIaIuilxB7xw
         fy1IZcNMojGdA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id D41714807E3; Fri, 26 May 2023 19:10:57 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 2/2] clk: divider: Fix divisions
Date:   Fri, 26 May 2023 19:10:57 +0200
Message-Id: <20230526171057.66876-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526171057.66876-1-sebastian.reichel@collabora.com>
References: <20230526171057.66876-1-sebastian.reichel@collabora.com>
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

The clock framework handles clock rates as "unsigned long", so u32 on
32-bit architectures and u64 on 64-bit architectures.

The current code pointlessly casts the dividend to u64 on 32-bit
architectures and thus pointlessly reducing the performance.

On the other hand on 64-bit architectures the divisor is masked and only
the lower 32-bit are used. Thus requesting a frequency >= 4.3GHz results
in incorrect values. For example requesting 4300000000 (4.3 GHz) will
effectively request ca. 5 MHz. Requesting clk_round_rate(clk, ULONG_MAX)
is a bit of a special case, since that still returns correct values as
long as the parent clock is below 8.5 GHz.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/clk-divider.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a2c2b5203b0a..c38e8aa60e54 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -220,7 +220,7 @@ static int _div_round_up(const struct clk_div_table *table,
 			 unsigned long parent_rate, unsigned long rate,
 			 unsigned long flags)
 {
-	int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	int div = DIV_ROUND_UP(parent_rate, rate);
 
 	if (flags & CLK_DIVIDER_POWER_OF_TWO)
 		div = __roundup_pow_of_two(div);
@@ -237,7 +237,7 @@ static int _div_round_closest(const struct clk_div_table *table,
 	int up, down;
 	unsigned long up_rate, down_rate;
 
-	up = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	up = DIV_ROUND_UP(parent_rate, rate);
 	down = parent_rate / rate;
 
 	if (flags & CLK_DIVIDER_POWER_OF_TWO) {
@@ -473,7 +473,7 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
 {
 	unsigned int div, value;
 
-	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	div = DIV_ROUND_UP(parent_rate, rate);
 
 	if (!_is_valid_div(table, div, flags))
 		return -EINVAL;
-- 
2.39.2

