Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4873411C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346239AbjFQNLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjFQNLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:11:02 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A711F3;
        Sat, 17 Jun 2023 06:11:00 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QjxH40VN0z9sTL;
        Sat, 17 Jun 2023 15:10:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1687007456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zWr8+hmYK9XR2zX5ZGQSRHnHAbE1gsOnsSQTQWrON+s=;
        b=N4pbsOyqfAtDGzK6fEw/iUFKAfeYIVYHe5a2yp/ABkopdXkThidwX7010bmtQSGC+hAkgh
        xJq9YX82UrR6XtYSSBGKQwMfxWSMgq/TgOmSwHK927W64QPLNCcqi5bQ3O1pknnTOgVfr1
        G+yotgs0SByLxLLdRURbXzL06vPrzBobUUO3pdw0kL4VH3VmvZuDQviRKxr102Yr25Iy9N
        tGO8geR+D1ma1stbsvQfMe8V0pVnaFQVm2SKSXuTjNXrrGCGn45NU6Wz2NHdNc7qaa+ZkV
        SL1gguMjt4Y755lKwACloB3mtaz8OuFtQq0A8AIlmQ1ykveMat0Qu+weUBdpvw==
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
Subject: [PATCH v5 0/2] clk: fractional-divider: Improve approximation when zero based and export
Date:   Sat, 17 Jun 2023 15:10:39 +0200
Message-ID: <20230617131041.18313-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

P.S.: V4 was short-lived, because it triggered a compiler warning on
clang. I'm sorry for the noise. -- Frank

V4: https://lore.kernel.org/all/20230617102919.27564-1-frank@oltmanns.dev/
V3: https://lore.kernel.org/all/20230614185521.477924-1-frank@oltmanns.dev/
V2: https://lore.kernel.org/lkml/20230613083626.227476-1-frank@oltmanns.dev/
V1: https://lore.kernel.org/lkml/20230529133433.56215-1-frank@oltmanns.dev/

Changes in V5 (since V4):
 - Fix compiler warnings on clang by removing superfluous variable max_m
   in the test cases for the maximum denominator (n) and max_n in the
   test cases for max numerator (m).
   Thank you, Intel, for your kernel test robot!

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
 drivers/clk/clk-fractional-divider_test.c | 157 ++++++++++++++++++++++
 5 files changed, 186 insertions(+), 7 deletions(-)
 create mode 100644 drivers/clk/clk-fractional-divider_test.c

-- 
2.41.0

