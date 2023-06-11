Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB0D72B0F5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 11:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjFKJCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 05:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjFKJCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 05:02:02 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D4C136;
        Sun, 11 Jun 2023 02:02:00 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Qf82Y0Fglz9sVy;
        Sun, 11 Jun 2023 11:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686474117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zmHROG1BFGQTfzARMhb2o7aJ1gmtB/DTkUZB08H5fEQ=;
        b=fYvtfYc1kj/ZC/3w74wnGHGNHOhdrjt9AXfQtb0mlXT1/0m48xzxOYH+DO/OkFIegb0+cB
        uQVRJ1IwSqhkEFxcGdY5dDsJ/yR0/bPtXHX6M5MSuQMyuxKCyS4cQkMvT447MDsD15XFrk
        /cfdzIpHKXGxM/01ybtEu4J11oMA2Vk30FWJtywLH/EN1EkssHG1B/uG+Yf+cs3lpMKkme
        0Hz0/G74PJ9zrzBzZFQAD8WARIO6nma9DzVG+j0tOhrtDle3I39MODj3/7I/Aam+x+JMoI
        p9hHVrarwWlBKyB7B/2MF0ZdAdx+K3xTPUUqAuBYCq5DyRlR9V6rwhOqyBwYwA==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/2] clk: sunxi-ng: Consider alternative parent rates when determining NKM clock rate
Date:   Sun, 11 Jun 2023 11:01:41 +0200
Message-ID: <20230611090143.132257-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is V2 of a patchset that enables NKM clocks to consider alternative parent
rates and utilize this new feature to adjust the pll-video0 clock on Allwinner
A64.

This allows to achieve an optimal rate for driving the board's panel.

To provide some context, the clock structure involved in this process is as follows:
    clock                       clock type
    --------------------------------------
    pll-video0                  ccu_nm
       pll-mipi                 ccu_nkm
          tcon0                 ccu_mux
             tcon-data-clock    sun4i_dclk

The divider between tcon0 and tcon-data-clock is fixed at 4. Therefore, in order
to achieve a rate that closely matches the desired rate of the panel, pll-mipi
needs to operate at a specific rate.

Changes in V2:
 - Move optimal parent rate calculation to dedicated function
 - Choose a parent rate that does not to overshoot requested rate
 - Add comments to ccu_nkm_find_best
 - Make sure that best_parent_rate stays at original parent rate in the unlikely
   case that all combinations overshoot.

Link to V1:
https://lore.kernel.org/lkml/20230605190745.366882-1-frank@oltmanns.dev/

Frank Oltmanns (2):
  clk: sunxi-ng: nkm: consider alternative parent rates when finding
    rate
  clk: sunxi-ng: a64: allow pll-mipi to set parent's rate

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c |  3 +-
 drivers/clk/sunxi-ng/ccu_nkm.c        | 66 +++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 9 deletions(-)

-- 
2.41.0

