Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343B073401C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 12:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346170AbjFQK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 06:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbjFQK3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 06:29:42 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314741FFE;
        Sat, 17 Jun 2023 03:29:40 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Qjshw1bbRz9skk;
        Sat, 17 Jun 2023 12:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686997776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K5wyhgjHKxMK2UvxF9fHePQ3wWFGU8riLfzYADKKQ7w=;
        b=jVNb4i6S+RfjnA2Ucr3rrz1VKTNbDFjsM2au3KKHy6p1vZyQGFUCDdr0hVxUF5BJGu1/fj
        FjxseDFXiX1CCx8snkYz3t20VD3RYuit4UnTeiq92Q4RkzXEPh95gku2uWRW0J1Y+s+cm7
        wbRnCXqrymdIzPGU/AyM6cXi/YITQWhDVmwJwKzbSlhs2f7ALPIp9Wryl3rFDiBDeDnonh
        yoRNcBFRCGu3bJ2SGp0Bv9nxGUCRRRNPgfJwGRepABfJVYZC0ThxNwcB6zRNLUjnyXeleC
        S2twfTK902N9R2ok8O8/77wsuyPcP9c3i8HtLwTxkU2MakLAtBjDBgPjle/8og==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v4 0/2] clk: fractional-divider: Improve approximation when zero based and export
Date:   Sat, 17 Jun 2023 12:29:17 +0200
Message-ID: <20230617102919.27564-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Qjshw1bbRz9skk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fractional divider approximation does not utilize the full available
range for clocks that are flagged CLK_FRAC_DIVIDER_ZERO_BASED. This
patchset aims to fix that.

It also adds test cases for the edge cases of fractional divider clocks
with and without the CLK_FRAC_DIVIDER_ZERO_BASED flag to highlight the
changes.

Finally, it also exports clk_fractional_divider_general_approximation so
that the test cases (but also other users like rockchip clk driver) can
be compiled as a module.

Unfortunately, I have no boards to test this patch. So all we have are
the unit tests. It seems the only user of this flag in mainline is
drivers/clk/imx/clk-composite-7ulp.c, therefore I'm cc-ing
get_maintainers.pl --git-blame -f drivers/clk/imx/clk-composite-7ulp.c
in the hopes of a wider audience.

Thank you for considering this contribution,
  Frank

V3: https://lore.kernel.org/all/20230614185521.477924-1-frank@oltmanns.dev/
V2: https://lore.kernel.org/lkml/20230613083626.227476-1-frank@oltmanns.dev/
V1: https://lore.kernel.org/lkml/20230529133433.56215-1-frank@oltmanns.dev/

Changes in V4 (since V3):
 - Export clk_fractional_divider_general_approximation so that users
   (e.g., the testcases) can be compiled as modules.
 - Change test cases so that they test
   clk_fractional_divider_general_approximation again (like in V2)
   instead of clk_fd_round_rate (like in V3), but keeping the structure
   of V3 with separate file and individual test cases for each edge
   case.

Changes in V3 (since V2):
 - Completely reworked the test cases
   - Moved tests to separate file as per Stephen's request
   - Move each edge case into their individual test case as per
     Stephen's request
   - Test clk_fd_round_rate instead of
     clk_fractional_divider_general_approximation as testing the latter
     broke builds

Changes in V2 (since V1):
 - Added test case as requested by Stephen Boyd
 - Fixed commit message as the Cc: was missing a closing bracket, so that the
   original mail unfortunately did not go out to A. s. Dong.

Frank Oltmanns (2):
  clk: fractional-divider: Improve approximation when zero based and
    export
  clk: fractional-divider: tests: Add test suite for edge cases

 drivers/clk/.kunitconfig                  |   1 +
 drivers/clk/Kconfig                       |   7 +
 drivers/clk/Makefile                      |   1 +
 drivers/clk/clk-fractional-divider.c      |  27 +++-
 drivers/clk/clk-fractional-divider_test.c | 161 ++++++++++++++++++++++
 5 files changed, 190 insertions(+), 7 deletions(-)
 create mode 100644 drivers/clk/clk-fractional-divider_test.c

-- 
2.41.0

