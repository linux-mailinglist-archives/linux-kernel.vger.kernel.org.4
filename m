Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D2F5F1495
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiI3VNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiI3VNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:13:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949B6BE2EA;
        Fri, 30 Sep 2022 14:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56A75B82A30;
        Fri, 30 Sep 2022 21:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3A9C433D6;
        Fri, 30 Sep 2022 21:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664572420;
        bh=27fx3NXWYi+Dk8Zgc8alfuEsNewmiw7SI2h6CwlCEI4=;
        h=From:To:Cc:Subject:Date:From;
        b=TQJPzIROm44NMg/32z81jq5fnKG/TZXKw3h0JKM/n364cd9f7WdtoM5IIn1bhVbIV
         WXlYNWAdoUkNE8wdh3K1zdHMUsUqEbNPi0fLxrEdJfa3cn+arFy7XQuesqTtfSNRSm
         RtDD41NnC7iC6InG+ri9gapM/2KvuE8SD33K9eYCmH+YibsZVRFukzYaBMp+gulT/o
         sUYd2M3PzXrNAjmKt6gTVdhPluk4wATJxohDMKlBFoB0vOoVIoBfEwRIOh5HBOwosX
         NpIgl8f0zfoT1mSy1zafQKa4zDlIdil8OfWSElv8U6OVjkF23T/eqZ1/9lEt7KN2JH
         fHLvThYrRWmCg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.0-rc7
Date:   Fri, 30 Sep 2022 14:13:39 -0700
Message-Id: <20220930211339.2945387-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit abb5f3f4b1f5f0ad50eb067a00051d3587dec9fb:

  Revert "clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops" (2022-08-31 12:06:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to daaa2fbe678efdaced53d1c635f4d326751addf8:

  clk: imx93: drop of_match_ptr (2022-09-28 18:37:36 -0700)

----------------------------------------------------------------
Here's the last batch of clk driver fixes for this release. These
patches fix serious problems, for example, i.MX has an issue where
changing the NAND clk frequency hangs the system. On Allwinner H6 the
GPU is being overclocked which could lead to long term hardware damage.
And finally on some Broadcom SoCs the serial console stopped working
because the clk tree hierarchy description got broken by an inadvertant
DT node name change. That's fixed by using 'clock-output-names' to
generate a stable and unique name for clks so the framework can properly
link things up.

There's also a couple build fixes in here. One to fix CONFIG_OF=n builds
and one to avoid an array out of bounds bug that happens during clk
registration on microchip. I hope that KASAN would have found that OOB
problem, but probably KASAN wasn't attempted. Instead LLVM/clang
compilation caused an oops, while GCC didn't.

----------------------------------------------------------------
Aidan MacDonald (1):
      clk: ingenic-tcu: Properly enable registers before accessing timers

Conor Dooley (2):
      clk: microchip: mpfs: fix clk_cfg array bounds violation
      clk: microchip: mpfs: make the rtc's ahb clock critical

Florian Fainelli (1):
      clk: iproc: Do not rely on node name for correct PLL setup

Han Xu (1):
      clk: imx: imx6sx: remove the SET_RATE_PARENT flag for QSPI clocks

Jernej Skrabec (1):
      clk: sunxi-ng: h6: Fix default PLL GPU rate

Peng Fan (1):
      clk: imx93: drop of_match_ptr

Stephen Boyd (1):
      Merge tag 'clk-microchip-fixes-6.0' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-fixes

 drivers/clk/bcm/clk-iproc-pll.c      | 12 ++++++++----
 drivers/clk/imx/clk-imx6sx.c         |  4 ++--
 drivers/clk/imx/clk-imx93.c          |  2 +-
 drivers/clk/ingenic/tcu.c            | 15 +++++----------
 drivers/clk/microchip/clk-mpfs.c     | 11 +++++++++--
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c |  8 ++++++--
 6 files changed, 31 insertions(+), 21 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
