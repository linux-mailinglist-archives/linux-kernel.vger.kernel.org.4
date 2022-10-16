Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513405FFD32
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 05:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJPDyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 23:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJPDyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 23:54:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBA12AA8;
        Sat, 15 Oct 2022 20:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4178DB80B65;
        Sun, 16 Oct 2022 03:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32C9C433B5;
        Sun, 16 Oct 2022 03:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665892471;
        bh=CCMcYvDvx2j9vakUqK/5yej/KPtrtwMxznnAswrNg8I=;
        h=From:To:Cc:Subject:Date:From;
        b=XHKDzsVzYWvKRkEbpGiKK0abjeHJMfGyD9j6kCWIGhsN94CzaqHJ6KTF7lIZMxr4s
         9Pr6viLEYUOdHZokorS52XnzB6Af3rNsmt3mIgqSgIu4KcKbiHyR//RTVeCuGMDR3T
         Fb003Ro+ZitpzAAN2HiGnQBi5ncmgMK2K13hKx2lEQ/0faOUBomr6QbZDYqUevEc+f
         VBn/w2FhbkpjAs+A+rLu0Jo/wZ2MWG7ZfQugBX7LUi5lZCcXdIBEPuJVSQzgNGkSGe
         eVZ+Dy0UpCmfbXYGBms94fb4+JhHYU3UzlZWVLdN+0UwGo1YXz2oNW9Sg145RPb3t0
         Dp7miXIGR4fPg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] More clk changes for the merge window
Date:   Sat, 15 Oct 2022 20:54:30 -0700
Message-Id: <20221016035430.560083-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f9efefdba95a5110a1346bb03acdd8ff3cdf557f:

  Merge branches 'clk-baikal', 'clk-broadcom', 'clk-vc5' and 'clk-versaclock' into clk-next (2022-10-04 10:54:34 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to a7b78befbce2e79425224d57c05275083cf7ed61:

  Merge branch 'clk-rate-range' into clk-next (2022-10-14 13:44:44 -0700)

----------------------------------------------------------------
This is the final part of the clk patches for this merge window.

The clk rate range series needed another week to fully bake. Maxime
fixed the bug that broke clk notifiers and prevented this from being
included in the first pull request. He also added a unit test on top to
make sure it doesn't break so easily again. The majority of the series
fixes up how the clk_set_rate_*() APIs work, particularly around when
the rate constraints are dropped and how they move around when
reparenting clks. Overall it's a much needed improvement to the clk rate
range APIs that used to be pretty broken if you looked sideways.

Beyond the core changes there are a few driver fixes for a compilation
issue or improper data causing clks to fail to register or have the
wrong parents. These are good to get in before the first -rc so that the
system actually boots on the affected devices.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      clk: mediatek: clk-mux: Add .determine_rate() callback

Jon Hunter (1):
      clk: tegra: Fix Tegra PWM parent clock

Kefeng Wang (1):
      clk: at91: fix the build with binutils 2.27

Linus Walleij (1):
      clk: qcom: gcc-msm8660: Drop hardcoded fixed board clocks

Maxime Ripard (27):
      clk: test: Switch to clk_hw_get_clk
      clk: Drop the rate range on clk_put()
      clk: Skip clamping when rounding if there's no boundaries
      clk: Mention that .recalc_rate can return 0 on error
      clk: Clarify clk_get_rate() expectations
      clk: tests: Add test suites description
      clk: tests: Add reference to the orphan mux bug report
      clk: tests: Add tests for uncached clock
      clk: tests: Add tests for single parent mux
      clk: tests: Add tests for mux with multiple parents
      clk: tests: Add some tests for orphan with multiple parents
      clk: Take into account uncached clocks in clk_set_rate_range()
      clk: Set req_rate on reparenting
      clk: Change clk_core_init_rate_req prototype
      clk: Move clk_core_init_rate_req() from clk_core_round_rate_nolock() to its caller
      clk: Introduce clk_hw_init_rate_request()
      clk: Add our request boundaries in clk_core_init_rate_req
      clk: Switch from __clk_determine_rate to clk_core_round_rate_nolock
      clk: Introduce clk_core_has_parent()
      clk: Constify clk_has_parent()
      clk: Stop forwarding clk_rate_requests to the parent
      clk: Zero the clk_rate_request structure
      clk: Introduce the clk_hw_get_rate_range function
      clk: qcom: clk-rcg2: Take clock boundaries into consideration for gfx3d
      clk: tests: Add missing test case for ranges
      clk: Update req_rate on __clk_recalc_rates()
      clk: tests: Add tests for notifiers

Stephen Boyd (1):
      Merge branch 'clk-rate-range' into clk-next

 drivers/clk/at91/clk-generated.c  |    5 +-
 drivers/clk/at91/clk-master.c     |    9 +-
 drivers/clk/at91/clk-peripheral.c |    4 +-
 drivers/clk/clk-composite.c       |    6 +-
 drivers/clk/clk-divider.c         |   20 +-
 drivers/clk/clk.c                 |  286 +++++--
 drivers/clk/clk_test.c            | 1637 +++++++++++++++++++++++++++++++++++--
 drivers/clk/mediatek/clk-mux.c    |   10 +
 drivers/clk/qcom/clk-rcg2.c       |    9 +
 drivers/clk/qcom/gcc-msm8660.c    |   11 -
 drivers/clk/tegra/clk-tegra114.c  |    1 +
 drivers/clk/tegra/clk-tegra124.c  |    1 +
 drivers/clk/tegra/clk-tegra20.c   |    1 +
 drivers/clk/tegra/clk-tegra210.c  |    1 +
 drivers/clk/tegra/clk-tegra30.c   |    1 +
 include/linux/clk-provider.h      |   18 +-
 include/linux/clk.h               |    2 +-
 include/linux/clk/at91_pmc.h      |    6 +-
 18 files changed, 1865 insertions(+), 163 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
