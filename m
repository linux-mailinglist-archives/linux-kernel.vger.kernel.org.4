Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CB8744F77
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGBRzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjGBRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:55:53 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D17DE67;
        Sun,  2 Jul 2023 10:55:46 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QvGtm1xHLz9sbW;
        Sun,  2 Jul 2023 19:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688320544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j8zz4KA5SELSjikiaFA0s5ffeNsoFIxXaP7N7linXrM=;
        b=j0G6ksnUYRGGBW2kOZsQKK4CH37QWDGKiTf6h2pVUkTiapmDOfIq1cWRFERLGg7UHCaMpH
        wLBKccWUsCfbMZwGk/2zYQhNTGLdwLypM206dlcYxasAX8qBjIBj12v9D3hTpdwiqoKown
        7xMWdv5gjwpHXFNPTKofWMfojrNKfukgeiHUKmTYrELJR3ZHh5ln0HRCsGqfS9UnzSEeRo
        TK4514DZm+YkLItbgKE642EZUCJPS7DbgUFe3rQ+hRz5+cxcSQqt2kGIHeH9/dGUaKK9Ua
        Qop23j5XzkCp6iF4JCkc4BH1qbqTxnurOhyPOgXIMs4vvqyO0vnr5fUY4W4Evw==
From:   Frank Oltmanns <frank@oltmanns.dev>
Subject: [PATCH v3 0/8] clk: sunxi-ng: Consider alternative parent rates
 when determining NKM clock rate
Date:   Sun, 02 Jul 2023 19:55:19 +0200
Message-Id: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAe6oWQC/43OSw6CMBSF4a2Qjr2kDynBkfswhFS4lUYo5LYhG
 sLeLYx05vAfnC9nZQHJYWCXbGWEiwtu8inUKWNtb/wDwXWpmeRScS01zMMAo5tdEzA2ZCI2syH
 0EZTSyra806gtS/OZ0LrXQd/q1JamEWJPaL5AIXjFxVnlQklZlCDAkvHP6zTE0Xgf8g6XHetdi
 BO9j5uL3Mk/Hi0SOOhSVRXei0p38pett237ABsC4FYAAQAA
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8468; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=1+0JmHxvMgAWx7Y8SneN1X+BTy6q7aqf1B6RjY+gAGI=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkoboaDI1obfpjIfryp3nBP1MWIDxE14N4dp6Mb
 ohlgSuPmtWJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZKG6GgAKCRCaaaIIlErT
 x7HYDACFV5zX/eTF0lj/9vqYDkcs90uZTWXxTTknaTR2IG6jgqsvweX+ahw4tBV8YdPNPzm/AIK
 IdPbdqplyVL7ufeqxriBtjo3oqeP0Pf9nTpwzL5R7PBpqfgABxSdwctPoQ8ruouhjJNYiiqKTns
 BE4jnkBmf3V/GNN5rJE5jAL6FaCjekZ7XGw2Qb9LkDTY4VgpuO93G/JCxze8elsfcQfcRoGFp/E
 INfuC1qx0GWYIqr0bgqG4JZPB75irf36gB+e6nSV3Et1fXGnVpCrPNjH3fD/1B6MC2rnjIwUf3C
 huXR0KCFHzvf8mmfgt/aIkjEmEsZ6jO6LI5M+QNqN5Sb6F9mB4OH6fjBW3SyaYAbyb/ixfNch+q
 Ioysx0GO87PZIwOqGMQaJ6EzTaxUvjGy21zEb3fPf3O/T/NiZxd2AW5yILPT+IP9ZsymkAflUI/
 psc9DvM0k1fvcd2zhQ8HQey4NY3mMa/DrCdN456kogcBR+vFoDL8M/Xhr7f4iXQ8vGxDM=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables NKM clocks to consider alternative parent rates
and utilize this new feature to adjust the pll-video0 clock on Allwinner
A64 (PATCH 1 and 2).

Furthermore, with this patchset pll-video0 considers rates that are
higher than the requested rate when finding the closest rate. In
consequence, higher rates are also considered by pll-video0's
descandents (PATCH 3 et. seq.).

This allows us to achieve an optimal rate for driving the board's panel.

To provide some context, the clock structure involved in this process is
as follows:
    clock                       clock type
    --------------------------------------
    pll-video0                  ccu_nm
       pll-mipi                 ccu_nkm
          tcon0                 ccu_mux
             tcon-data-clock    sun4i_dclk

The divider between tcon0 and tcon-data-clock is fixed at 4. Therefore,
in order to achieve a rate that closely matches the desired rate of the
panel, pll-mipi needs to operate at a specific rate.

Tests
=====
So far, this has been successfully tested on the A64-based Pinephone
using three different panel rates:

 1. A panel rate that can be matched exactly by pll-video0.
 2. A panel rate that requires pll-video0 to undershoot to get the
    closest rate.
 3. A panel rate that requires pll-video0 to overshoot to get the
    closest rate.

Test records:

Re 1:
-----
Panel requests tcon-data-clock of 103500000 Hz, i.e., pll-mipi needs to
run at 414000000 Hz. This results in the following clock rates:
   clock                            rate
----------------------------------------
    pll-video0                 207000000
       hdmi-phy-clk             51750000
       hdmi                    207000000
       tcon1                   207000000
       pll-mipi                414000000
          tcon0                414000000
             tcon-data-clock   103500000

The results of the find_best calls:
[   12.345862] ccu_nkm_find_best_with_parent_adj: rate=414000000, best_rate=414000000, best_parent_rate=207000000, n=1, k=2, m=1
[   12.346111] ccu_nkm_find_best_with_parent_adj: rate=414000000, best_rate=414000000, best_parent_rate=207000000, n=1, k=2, m=1
[   12.346291] ccu_nkm_find_best_with_parent_adj: rate=414000000, best_rate=414000000, best_parent_rate=207000000, n=1, k=2, m=1
[   12.346471] ccu_nkm_find_best_with_parent_adj: rate=414000000, best_rate=414000000, best_parent_rate=207000000, n=1, k=2, m=1
[   12.346867] ccu_nkm_find_best: rate=414000000, best_rate=414000000, parent_rate=207000000, n=1, k=2, m=1

Re 2:
-----
Panel requests tcon-data-clock of 103650000 Hz, i.e., pll-mipi needs to
run at 414600000 Hz. This results in the following clock rates:
   clock                            rate
----------------------------------------
    pll-video0                 282666666
       hdmi-phy-clk             70666666
       hdmi                    282666666
       tcon1                   282666666
       pll-mipi                414577776
          tcon0                414577776
             tcon-data-clock   103644444

The results of the find_best calls:
[   13.638954] ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
[   13.639212] ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
[   13.639395] ccu_nkm_find_best_with_parent_adj: rate=414577776, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
[   13.639577] ccu_nkm_find_best_with_parent_adj: rate=414577776, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
[   13.639913] ccu_nkm_find_best: rate=414577776, best_rate=414577776, parent_rate=282666666, n=11, k=2, m=15

Here, we consistently ask the pll-video0 for a rate that it can't
provide exactly:
 - rate=414600000: We ask the parent for 282681818 (rate * m / (n * k)),
   it returns 282666666. Here the parent undershoots.
 - rate=414577776: We ask the parent for 282666665 (rate * m / (n * k)),
   it returns 282666666. Here the parent overshoots.

So, in both cases it rounds to the nearest rate (first down, then up),
which is the intended behaviour.

Re 3:
-----
Panel requests tcon-data-clock of 112266000 Hz, i.e., pll-mipi needs to
run at 449064000 Hz. This results in the following clock rates:
   clock                            rate
----------------------------------------
    pll-video0                 207272727
       hdmi-phy-clk             51818181
       hdmi                    207272727
       tcon1                   207272727
       pll-mipi                449090908
          tcon0                449090908
             tcon-data-clock   112272727

The results of the find_best calls:
[   13.871022] ccu_nkm_find_best_with_parent_adj: rate=449064000, best_rate=449090908, best_parent_rate=207272727, n=13, k=2, m=12
[   13.871277] ccu_nkm_find_best_with_parent_adj: rate=449064000, best_rate=449090908, best_parent_rate=207272727, n=13, k=2, m=12
[   13.871461] ccu_nkm_find_best_with_parent_adj: rate=449090908, best_rate=449090908, best_parent_rate=207272727, n=13, k=2, m=12
[   13.871646] ccu_nkm_find_best_with_parent_adj: rate=449090908, best_rate=449090908, best_parent_rate=207272727, n=13, k=2, m=12
[   13.872050] ccu_nkm_find_best: rate=449090908, best_rate=449090908, parent_rate=207272727, n=13, k=2, m=12

Here, we consistently ask the pll-video0 for a rate that it can't
provide exactly:
 - rate=449064000: We ask the parent for 207260307 (rate * m / (n * k)),
   it returns 207272727.
 - rate=449090908: We ask the parent for 207272726 (rate * m / (n * k)),
   it returns 207272727.

So, in both cases, it rounds up to the nearest rate, which is the
intended behavior.

Changes in v3:
 - Use dedicated function for finding the best rate in cases where an
   nkm clock supports setting its parent's rate, streamlining it with
   the structure that is used in other sunxi-ng ccus such as ccu_mp
   (PATCH 1).
 - Therefore, remove the now obsolete comments that were introduced in
   v2 (PATCH 1).
 - Remove the dedicated function for calculating the optimal parent rate
   for nkm clocks that was introduced in v2. Instead use a simple
   calculation and require the parent clock to select the closest rate to
   achieve optimal results (PATCH 1).
 - Therefore, add support to set the closest rate for nm clocks (because
   pll-mipi's parent pll-video0 is an nm clock) and all clock types that
   are descendants of a64's pll-video0, i.e., nkm, mux, and div (PATCH 3
   et. seq.).
 - Link to v2: https://lore.kernel.org/all/20230611090143.132257-1-frank@oltmanns.dev/

Changes in V2:
 - Move optimal parent rate calculation to dedicated function
 - Choose a parent rate that does not to overshoot requested rate
 - Add comments to ccu_nkm_find_best
 - Make sure that best_parent_rate stays at original parent rate in the unlikely
   case that all combinations overshoot.

Link to V1:
https://lore.kernel.org/lkml/20230605190745.366882-1-frank@oltmanns.dev/

---
Frank Oltmanns (8):
      clk: sunxi-ng: nkm: consider alternative parent rates when determining rate
      clk: sunxi-ng: a64: allow pll-mipi to set parent's rate
      clk: sunxi-ng: Add feature to find closest rate
      clk: sunxi-ng: nm: Support finding closest rate
      clk: sunxi-ng: nkm: Support finding closest rate
      clk: sunxi-ng: mux: Support finding closest rate
      clk: sunxi-ng: div: Support finding closest rate
      clk: sunxi-ng: a64: select closest rate for pll-video0

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 25 ++++++-----
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c   |  3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c  |  6 ++-
 drivers/clk/sunxi-ng/ccu_common.h     |  1 +
 drivers/clk/sunxi-ng/ccu_div.h        | 30 +++++++++++++
 drivers/clk/sunxi-ng/ccu_mux.c        | 36 +++++++++++++---
 drivers/clk/sunxi-ng/ccu_mux.h        | 17 ++++++++
 drivers/clk/sunxi-ng/ccu_nkm.c        | 80 ++++++++++++++++++++++++++++++++---
 drivers/clk/sunxi-ng/ccu_nm.c         | 23 +++++++++-
 drivers/clk/sunxi-ng/ccu_nm.h         |  6 ++-
 10 files changed, 198 insertions(+), 29 deletions(-)
---
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230626-pll-mipi_set_rate_parent-3363fc0d6e6f

Best regards,
-- 
Frank Oltmanns <frank@oltmanns.dev>

