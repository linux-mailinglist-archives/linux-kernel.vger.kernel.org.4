Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044F268B769
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBFIdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBFIdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:33:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF8E1A963;
        Mon,  6 Feb 2023 00:33:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so10168140wmb.2;
        Mon, 06 Feb 2023 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOx2/4K0b63ARwObYvrzcCP9XRW9IFsQlY4VWTcOG5U=;
        b=pKXkHmDHCjcb0/s1uFpOROx/vVhdipvmXjnN8puTvbY4HH4HDcyRQqnmYvTIR6I/6v
         xCDfT+YVgcdwI4zEe+4bE1GBQlneI7CB3PIB3UVAq1YaI36d+Z1IYZmwTXbqQH3JZsNm
         37AowBzkmdnCuo4oEtryjP78layCg48IEiWFBp/0SSEe9s7iepcEhyzXWrNcNDOtCc4+
         D3b4FO8gziOZFWDHkGIYHoa1GpeISzeZe1Cou6EGZxg0GaQ/YC3U/qFae/vm1HNak/Wf
         8BO2yWJzgdDJiFT0TJPVlVfrgIilQjVVFvBJN1WvGCOZDffg47bJmKx91q1qR5f7ra5A
         DfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOx2/4K0b63ARwObYvrzcCP9XRW9IFsQlY4VWTcOG5U=;
        b=K0eiKaNaFMzk3dsaxCr3LEsU5zLbH7YeuYAz5yXYoVlGDrHWI6eS0i/vDalW6nVBPu
         sOKGNrKdz83QWE7OpWPahBs4X0DmStOqNJw/PC6n9kCdLsmPApsDBMMtLQ8lwgfW6i82
         2sNEpEBRIAIcQ54F4EJhhVngWBL7XZQUd/eRmbJqCxRjK0qbtFg23NTjwXJ0LesU3HqJ
         zgfN98wpZEACMgJyFTsU+xnXXVS8SBQIwg2uie95B1flwcf9Mbk5RK9qgrwSlZY7p7A+
         kFKAaup+u7QpiEvZD7ci6QSXj50qay04wgQehWkmDfFoB7RDkZ0w8az82IjcWHkPt3gz
         Vlpg==
X-Gm-Message-State: AO0yUKVi7YGgVDGYyI1JB0shapjiw4xm9WYE5eOsSEkUOI1e3Wto31hy
        y54AScmgltE3RKwI29NilBK/vtII85k=
X-Google-Smtp-Source: AK7set8zAb9HWB02uYReYweoYi7TDcerNXTAZGjycqUNfBrCvfWB2bU1gtIdQkLxrxHMLnPdY6O13Q==
X-Received: by 2002:a05:600c:601b:b0:3dc:443e:4212 with SMTP id az27-20020a05600c601b00b003dc443e4212mr18964751wmb.1.1675672387276;
        Mon, 06 Feb 2023 00:33:07 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id g42-20020a05600c4caa00b003de664d4c14sm10138862wmp.36.2023.02.06.00.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 00:33:06 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com
Subject: [PATCH] clk: ralink: fix 'mt7621_gate_is_enabled()' function
Date:   Mon,  6 Feb 2023 09:33:05 +0100
Message-Id: <20230206083305.147582-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling clock driver with CONFIG_UBSAN enabled shows the following trace:

UBSAN: shift-out-of-bounds in drivers/clk/ralink/clk-mt7621.c:121:15
shift exponent 131072 is too large for 32-bit type 'long unsigned int'
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.15.86 #0
Stack : ...

Call Trace:
[<80009a58>] show_stack+0x38/0x118
[<8045ce04>] dump_stack_lvl+0x60/0x80
[<80458868>] ubsan_epilogue+0x10/0x54
[<804590e0>] __ubsan_handle_shift_out_of_bounds+0x118/0x190
[<804c9a10>] mt7621_gate_is_enabled+0x98/0xa0
[<804bb774>] clk_core_is_enabled+0x34/0x90
[<80aad73c>] clk_disable_unused_subtree+0x98/0x1e4
[<80aad6d4>] clk_disable_unused_subtree+0x30/0x1e4
[<80aad6d4>] clk_disable_unused_subtree+0x30/0x1e4
[<80aad900>] clk_disable_unused+0x78/0x120
[<80002030>] do_one_initcall+0x54/0x1f0
[<80a922a4>] kernel_init_freeable+0x280/0x31c
[<808047c4>] kernel_init+0x20/0x118
[<80003e58>] ret_from_kernel_thread+0x14/0x1c

Shifting a value (131032) larger than the type (32 bit unsigned integer)
is undefined behaviour in C.

The problem is in 'mt7621_gate_is_enabled()' function which is using the
'BIT()' kernel macro with the bit index for the clock gate to check if the
bit is set. When the clock gates structure is created driver is already
setting 'bit_idx' using 'BIT()' macro, so we are wrongly applying an extra
'BIT()' mask here. Removing it solve the problem and makes this function
correct. However when clock gating is correctly working, the kernel starts
disabling those clocks that are not requested. Some drivers for this SoC
are older than this clock driver itself. So to avoid the kernel to disable
clocks that have been enabled until now, we must apply 'CLK_IS_CRITICAL'
flag on gates initialization code.

Fixes: 48df7a26f470 ("clk: ralink: add clock driver for mt7621 SoC")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/clk-mt7621.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ralink/clk-mt7621.c b/drivers/clk/ralink/clk-mt7621.c
index 99256659dd96..d95a33293b0a 100644
--- a/drivers/clk/ralink/clk-mt7621.c
+++ b/drivers/clk/ralink/clk-mt7621.c
@@ -121,7 +121,7 @@ static int mt7621_gate_is_enabled(struct clk_hw *hw)
 	if (regmap_read(sysc, SYSC_REG_CLKCFG1, &val))
 		return 0;
 
-	return val & BIT(clk_gate->bit_idx);
+	return val & clk_gate->bit_idx;
 }
 
 static const struct clk_ops mt7621_gate_ops = {
@@ -133,8 +133,14 @@ static const struct clk_ops mt7621_gate_ops = {
 static int mt7621_gate_ops_init(struct device *dev,
 				struct mt7621_gate *sclk)
 {
+	/*
+	 * There are drivers for this SoC that are older
+	 * than clock driver and are not prepared for the clock.
+	 * We don't want the kernel to disable anything so we
+	 * add CLK_IS_CRITICAL flag here.
+	 */
 	struct clk_init_data init = {
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 		.num_parents = 1,
 		.parent_names = &sclk->parent_name,
 		.ops = &mt7621_gate_ops,
-- 
2.25.1

