Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21AC7307A7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjFNSzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjFNSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:55:41 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495701A2;
        Wed, 14 Jun 2023 11:55:39 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QhF450lFYz9sSN;
        Wed, 14 Jun 2023 20:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686768933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z3zE80Axoqx9I3Z6OPP9RKn3Hf32SECyjRv60EIg2KE=;
        b=nW8+zhnIcN/WNBFCHMU1xRQdRR0uUyx+IqnE+6q3HUBtkiAIePwbFrwX1/97rs9J6Rh/At
        rtiO0F5HhXcKA9kNGo/wxBJ0xg0DgOIJUFJ3Ru91j9zLCfiqOv/QKsiNKKSPAItedxdR7r
        V5r17URgikI7v63ZbocdM9nHj6DzHqDOU89yJZwdKliM3S9dd6oLudMCsSyhvq3i6Zr9E8
        yq50x0saXn6v633zoDVvsBABGtmWLdaL4NHA7Inmn5aKg/1pkwWb+xQYNflbcFPtKBTWE7
        jEX/ZVzTbyW0Bgc9daav/7O08cFS2OgPaJNfOOtSwxAT1NDXSdYuuE5UE0lXUQ==
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
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 0/2] clk: fractional-divider: Improve approximation when zero based
Date:   Wed, 14 Jun 2023 20:55:19 +0200
Message-ID: <20230614185521.477924-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4QhF450lFYz9sSN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I stumpled upon this, when familiarizing myself with clk drivers.
Unfortunately, I have no boards to test this patch. It seems the only
user of this flag in mainline is drivers/clk/imx/clk-composite-7ulp.c,
therefore I'm cc-ing
get_maintainers.pl --git-blame -f drivers/clk/imx/clk-composite-7ulp.c
in the hopes of a wider audience.

V2: https://lore.kernel.org/lkml/20230613083626.227476-1-frank@oltmanns.dev/
V1: https://lore.kernel.org/lkml/20230529133433.56215-1-frank@oltmanns.dev/

Changes since V2:
 - Completely reworked the test cases
   - Moved tests to separate file as per Stephen's request
   - Move each edge case into their individual test case as per
     Stephen's request
   - Test clk_fd_round_rate instead of
     clk_fractional_divider_general_approximation as testing the latter
     broke builds

Changes since V1:
 - Added test case as requested by Stephen Boyd
 - Fixed commit message as the Cc: was missing a closing bracket, so that the
   original mail unfortunately did not go out to A. s. Dong.

Thank you for considering this contribution,
  Frank

Frank Oltmanns (2):
  clk: fractional-divider: Improve approximation when zero based
  clk: fractional-divider: tests: Add test suite for edge cases

 drivers/clk/.kunitconfig                  |   1 +
 drivers/clk/Kconfig                       |   7 +
 drivers/clk/Makefile                      |   1 +
 drivers/clk/clk-fractional-divider.c      |  26 ++-
 drivers/clk/clk-fractional-divider_test.c | 196 ++++++++++++++++++++++
 5 files changed, 224 insertions(+), 7 deletions(-)
 create mode 100644 drivers/clk/clk-fractional-divider_test.c

-- 
2.41.0

