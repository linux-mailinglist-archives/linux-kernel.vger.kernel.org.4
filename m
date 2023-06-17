Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316C0733E05
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 06:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjFQEgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 00:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQEg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 00:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BAD35AD;
        Fri, 16 Jun 2023 21:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46D7960BD4;
        Sat, 17 Jun 2023 04:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9B0C433C0;
        Sat, 17 Jun 2023 04:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686976585;
        bh=OKFlrVcr8JO5imMZjskPBYyT2e9wwxpgnHDmugLd/OM=;
        h=From:To:Cc:Subject:Date:From;
        b=pG2KDixZAmhTp7k5AHPjC84RnT5jz7KcbQkNullO09O8vZHTe0iMvdgVGvz2Ejy71
         EqA4Jqz61D9zaKANiTCxXOH0wHzhoEaa8+at3UT0hpo+OG1wszP7BvHG1cF1mQ2Kbd
         Aup4m/FUOEqxP0brQ1PCkFMZlCuuBrr5bS15Ejde/xsHB9P6rz2mPf0T4um2qko7HI
         biGZ93xHk76fwS0YdOR6PL3WY2FG3YoOzumC1B1CvmwMFyq24NDMbzbK1EpE4psnQf
         w5/0834D4gqu0RWI5wDqmJQRrrBqTwp0HyaIze2KSxcN6K41+fFy7n2jdFU0OuxKBz
         PmJchfFlI+yuw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.4-rc6
Date:   Fri, 16 Jun 2023 21:36:23 -0700
Message-ID: <20230617043624.831750-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 23200a4c8ac284f8b4263d7cecaefecaa3ad6732:

  clk: pxa: fix NULL pointer dereference in pxa3xx_clk_update_accr (2023-06-14 17:22:17 -0700)

----------------------------------------------------------------
A handful of clk driver fixes

 - Fix an OOB issue in the Mediatek mt8365 driver where arrays of clks
   are mismatched in size

 - Use the proper clk_ops for a few clks in the Mediatek mt8365 driver

 - Stop using abs() in clk_composite_determine_rate() because 64-bit
   math goes wrong on large unsigned long numbers that are subtracted
   and passed into abs()

 - Zero initialize a struct clk_init_data in clk-loongson2 to avoid
   stack junk confusing clk_hw_register()

 - Actually use a pointer to __iomem for writel() in
   pxa3xx_clk_update_accr() so we don't oops

----------------------------------------------------------------
Alexandre Mergnat (1):
      clk: mediatek: mt8365: Fix index issue

Arnd Bergmann (1):
      clk: pxa: fix NULL pointer dereference in pxa3xx_clk_update_accr

Binbin Zhou (1):
      clk: clk-loongson2: Zero init clk_init_data

Markus Schneider-Pargmann (1):
      clk: mediatek: mt8365: Fix inverted topclk operations

Sebastian Reichel (1):
      clk: composite: Fix handling of high clock rates

 drivers/clk/clk-composite.c       |  5 ++++-
 drivers/clk/clk-loongson2.c       |  2 +-
 drivers/clk/mediatek/clk-mt8365.c | 18 +++++++++++++++---
 drivers/clk/pxa/clk-pxa3xx.c      |  2 +-
 4 files changed, 21 insertions(+), 6 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
