Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A035E7134F9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjE0N2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 09:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjE0N2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 09:28:20 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C88A6;
        Sat, 27 May 2023 06:28:18 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QT2fc5X1Cz9sjD;
        Sat, 27 May 2023 15:28:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685194088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kAyuiYKxcOsDPYn8J7+22xTQEqCLXxVio4CMAPjFVu4=;
        b=K5iz7QYp5ex0Cwa0rC4vw6obr1zLGTOIBLIkf8BWadDS2CYk6je4It0aKiqgtPz+9ipwmw
        ioYzBFIwYm8VY260NVUH9czW9S0Ifd/IE7I0TP/Y/bh/EGdj/0jDxHViWOR+zlSEkP7HE2
        mdoAwYibq9TUuEyHchPGFFYwbKk135+hf3zhNF81UeYWatiySf6fVCM1WLtj9FW8fmQQ2u
        OOFE8v6bSXgayd1sZUk62kKMwUi057t5mbUaBuyaH4Y7ap/J64TKc61iyB1Gypb0L+GfiQ
        ggGWBD9/uVnG2Vpm4svyq+au+C+sw0bJ8b3dXKf0yNQL+zpH/JPVbYh4TVhckA==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH 0/3] clk: sunxi-ng: Optimize rate selection for NKM clocks
Date:   Sat, 27 May 2023 15:27:44 +0200
Message-Id: <20230527132747.83196-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4QT2fc5X1Cz9sjD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to bring your attention to the current process of setting the rate
of an NKM clock. As it stands, when setting the rate of an NKM clock, the rate
nearest but less than or equal to the requested rate is found, instead of the
nearest rate. Moreover, ccu_nkm_find_best() is called multiple times (footnote
[1]) when setting a rate, each time iterating over all combinations of n, k, and
m.

In response to this, I propose the following refinements to optimize the NKM
clock setting:
 a. when finding the best rate use the nearest rate, even if it is greater than
    the requested rate (PATCH 1)
 b. utilize binary search to find the best rate by going through a
    precalculated, ordered list of all meaningful combinations of n, k, and m
    (PATCH 2)

To illustrate, consider an NKM clock with min_n = 1, max_n = 16, min_k = 2,
max_k = 4, min_m = 1, and max_m = 16. With the current approach, we have to go
through 1024 combinations, of which only 275 are actually meaningful (the
remaining 749 are combinations that result in the same frequency as other
combinations). So, when selecting from these sorted 275 combinations we find the
closest rate after 9 instead of 1024 steps.

As an example, I calculated the table off-line for the pll-mipi clock of
sun50i-a64 (PATCH 3). However, I have identified two other potential strategies:
 2. calculate before first use and persist for subsequent uses (i.e. never free,
    see footnote [2])
 3. calculate before first use and free after setting the rate.

Each approach carries its own merits. The one I implemented is the most
efficient in terms of computation time but consumes the most memory. The second
saves compute time after the initial use, while the third minimizes memory usage
at the cost of additional computation.

The motivation for these proposed changes lies in the current behavior of rate
selection for NKM clocks, which doesn't observe the CLK_SET_RATE_PARENT flag.
I.e. it does not select a different rate for the parent clock to find the
optimal rate. I believe this is likely due to the fact that selecting a new rate
is quite compute intense, as it would involve iterating or calculating rates for
the parent clock and then testing each rate with different n, k, and m
combinations.

As an example, if the parent is an NM clock, we would have to work through the
combinations of the parent's factors (the parent's n) and divisor (the parent's
m). This results in five nested loops to evaluate all possible rates, an effort
that escalates if the parent could also influence the grandparent's rate. In my
example case (sun50i-a64) the pll-mipi's parent (pll-video0) has 2048
combinations of n and m, of which 1266 are meaningful because the others result
in the same frequency for pll-video0.

If we can come up with a way to iterate over the possible rates of a parent,
this would eventually allow us to make NKM clocks obey the CLK_SET_RATE_PARENT
flag. Because it would only require 11,349 (9 * 1,266) steps instead of
2,097,152 (1,024 * 2,048).

Things I considered but don't have a clear answer to:
 - Is there a specific reason, why currently only clock rates less than the
   requested rate are considered when setting a new rate?
 - Do you think it is worth the memory and increased complexity to be able to
   change the parent's clock rate?

I look forward to hearing your thoughts on these proposed changes. Thank you for
your time and consideration.

Footnotes:
[1] Multiple times because ccu_nkm_find_best is (indirectly) called from clk.c
in
 - clk_core_req_round_rate_nolock()
 - clk_calc_new_rates() (which in turn is called three times for reasons that
   currently elude me)
 - clk_change_rate

[2] Actually, we could free the memory in a new ccu_nkm_terminate() function,
which could become part of ccu_nkm_ops. But if my code searching skills don't
betray me, there is currently no other clock that implements the terminate
function.

Frank Oltmanns (3):
  clk: sunxi-ng: nkm: Minimize difference when finding rate
  clk: sunxi-ng: Implement precalculated NKM rate selection
  clk: sunxi-ng: sun50i-a64: Precalculate NKM combinations for pll-mipi

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 281 ++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_mux.c        |   2 +-
 drivers/clk/sunxi-ng/ccu_nkm.c        |  97 +++++++--
 drivers/clk/sunxi-ng/ccu_nkm.h        |  26 +++
 4 files changed, 385 insertions(+), 21 deletions(-)

-- 
2.40.1

