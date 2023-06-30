Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0A8744265
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjF3Siv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjF3Sis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:38:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB4A107;
        Fri, 30 Jun 2023 11:38:47 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-211-174.ewe-ip-backbone.de [91.248.211.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E66F166057EC;
        Fri, 30 Jun 2023 19:38:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688150326;
        bh=LWbgAgL+0OeJkzIKUoalbJkby80mrv5r7CnJUPH2mrs=;
        h=From:To:Cc:Subject:Date:From;
        b=NCmbEp6ER6YWuWpoNCK2+86vlAbKNIPyJjilUJ9c0bYZcvFMnnHcb2fmB1TSEcJo/
         my3vEVqUZv9K81TYQun3aBqL0Q4k+kBln3s9ETbnKWuDpluF6HOrgH5XtHCPOgziJV
         MutuZ4OLC6B+3J/Ota9pXiDHYWV7+btslQL6QgJYz8iKkPTHAC3/U+aihunWonCuHE
         rvdQ6S6qmRrjkAn+6N1U/kXlmCUY/8qQ/Aql5W55Vcsy55Ocnr9CuVtf+AqUwbhzAr
         37xb0XoS46/tG3Qkbhmgmj05FBTbk5nXcps8CavJYfTaRztpijLw+nxkC/Sk0U76J6
         Hvgh0O4HiasNg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id A9EEC487A17; Fri, 30 Jun 2023 20:38:43 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 1/1] clk: divider: Fix divisor masking on 64 bit platforms
Date:   Fri, 30 Jun 2023 20:38:35 +0200
Message-Id: <20230630183835.464216-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
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

The current code casts the dividend to u64 on 32-bit to avoid a
potential overflow. For example DIV_ROUND_UP(3000000000, 1500000000)
= (3.0G + 1.5G - 1) / 1.5G = = OVERFLOW / 1.5G, which has been
introduced in commit 9556f9dad8f5 ("clk: divider: handle integer overflow
when dividing large clock rates").

On 64 bit platforms this masks the divisor, so that only the lower
32 bit are used. Thus requesting a frequency >= 4.3GHz results
in incorrect values. For example requesting 4300000000 (4.3 GHz) will
effectively request ca. 5 MHz. Requesting clk_round_rate(clk, ULONG_MAX)
is a bit of a special case, since that still returns correct values as
long as the parent clock is below 8.5 GHz.

Fix this by introducing a new helper, which avoids the overflow
by using a modulo operation instead of math tricks. This avoids
any requirements on the arguments (except that divisor should not
be 0 obviously).

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes since PATCHv2:
 * https://lore.kernel.org/all/20230526171057.66876-1-sebastian.reichel@collabora.com/
 * Drop first patch (applied)
 * Update second patch to use newly introduced DIV_ROUND_UP_NO_OVERFLOW

Changes since PATCHv1:
 * https://lore.kernel.org/linux-clk/20230519190522.194729-1-sebastian.reichel@collabora.com/
 * Add Christopher Obbard's Reviewed-by to the first patch
 * Update the second patch to use DIV_ROUND_UP instead of DIV64_U64_ROUND_UP
---
 drivers/clk/clk-divider.c |  6 +++---
 include/linux/math.h      | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a2c2b5203b0a..94b4fb66a60f 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -220,7 +220,7 @@ static int _div_round_up(const struct clk_div_table *table,
 			 unsigned long parent_rate, unsigned long rate,
 			 unsigned long flags)
 {
-	int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	int div = DIV_ROUND_UP_NO_OVERFLOW(parent_rate, rate);
 
 	if (flags & CLK_DIVIDER_POWER_OF_TWO)
 		div = __roundup_pow_of_two(div);
@@ -237,7 +237,7 @@ static int _div_round_closest(const struct clk_div_table *table,
 	int up, down;
 	unsigned long up_rate, down_rate;
 
-	up = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	up = DIV_ROUND_UP_NO_OVERFLOW(parent_rate, rate);
 	down = parent_rate / rate;
 
 	if (flags & CLK_DIVIDER_POWER_OF_TWO) {
@@ -473,7 +473,7 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
 {
 	unsigned int div, value;
 
-	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	div = DIV_ROUND_UP_NO_OVERFLOW(parent_rate, rate);
 
 	if (!_is_valid_div(table, div, flags))
 		return -EINVAL;
diff --git a/include/linux/math.h b/include/linux/math.h
index 2d388650c556..cf14d436fc2e 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -36,6 +36,17 @@
 
 #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
 
+/**
+ * DIV_ROUND_UP_NO_OVERFLOW - divide two numbers and always round up
+ * @n: numerator / dividend
+ * @d: denominator / divisor
+ *
+ * This functions does the same as DIV_ROUND_UP, but internally uses a
+ * division and a modulo operation instead of math tricks. This way it
+ * avoids overflowing when handling big numbers.
+ */
+#define DIV_ROUND_UP_NO_OVERFLOW(n, d) (((n) / (d)) + !!((n) % (d)))
+
 #define DIV_ROUND_DOWN_ULL(ll, d) \
 	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
 
-- 
2.40.1

