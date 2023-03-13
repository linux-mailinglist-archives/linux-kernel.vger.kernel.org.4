Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A955C6B8603
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCMXTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCMXTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:19:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2DB298C2;
        Mon, 13 Mar 2023 16:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB2E361541;
        Mon, 13 Mar 2023 23:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45B0C433EF;
        Mon, 13 Mar 2023 23:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678749560;
        bh=C1akAhs4JCBJ3FejFWSYsBe4XahMeSnJ+p2ZorfamJo=;
        h=From:To:Cc:Subject:Date:From;
        b=TO/b53OxFOcIPniMEba8eUcEUaok+zOaRze2vPKjG6GFTSjKhh8KwjeFqxF3i/CvL
         sd+uLiBSXsfcq/YYiN3VaxZL6xAuNLcO3Qkm6b43FAPEluwIPeHpGUkInA4CGDAb1K
         YVyzrRy9IwUroLfKiiC6LqCa3922Sw7InjB7eXVoE+b5qdVeWZQ3Sd/ZAGA6rT7J7a
         qOkQc9564jqjmFnzcCTIEYxYgjBBQe/zrmTWo9OEpkJgbZKZcpw75RpAr1oqj3WSMg
         ZLzUnFvKN0ljt7A4whYuHC3AltRGi/Ri1+RZ+mETEdf4+Zj8x0WW/IfCxcdMEGpZ2X
         0EOkwAv5hIUpQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.3-rc2
Date:   Mon, 13 Mar 2023 16:19:18 -0700
Message-Id: <20230313231919.66868-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
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

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 5cf9d015be160e2d90d29ae74ef1364390e8fce8:

  clk: Avoid invalid function names in CLK_OF_DECLARE() (2023-03-09 15:40:49 -0800)

----------------------------------------------------------------
The collection of clk driver fixes, and a couple OF clk patches to fix
regressions seen in the last few weeks. The fwnode patch broke the build
for one driver that isn't always compiled, so I waited over the weekend
to be certain no more build issues came up.

[Note: I'm looking at the module license patches in here after gregkh
questioned them on the list. They're coming into my inbox in dribbles,
and I thought they were necessary to fix some build issue but that
doesn't seem to be the case so I stopped applying any more. They're
still potentially useful because it slightly speeds up builds if we
don't need to include module.h for module macros. If you're flat out
opposed I'll rewind this branch and send a new pull request. Please let
me know.]

 - Mark the firmware node (fwnode) that matches the compatible in
   CLK_OF_DECLARE() as initialized to fix a regression on u8500 SoCs
   after fw_devlink stopped checking parent nodes in
   of_link_to_phandle()
 - Remove a couple MODULE_LICENSE macros in non-modules
 - Update the maintainers file for Microchip clk drivers
 - Select instead of depend on the REGMAP config to fix Kconfig issues
 - Use div_u64() for portable 64-bit division in K210 clk driver

----------------------------------------------------------------
Conor Dooley (2):
      MAINTAINERS: add missing clock driver coverage for Microchip FPGAs
      clk: k210: remove an implicit 64-bit division

Nathan Chancellor (1):
      clk: Avoid invalid function names in CLK_OF_DECLARE()

Nick Alcock (2):
      kbuild, clk: bcm2835: remove MODULE_LICENSE in non-modules
      kbuild, clk: remove MODULE_LICENSE in non-modules

Randy Dunlap (1):
      clk: HI655X: select REGMAP instead of depending on it

Saravana Kannan (1):
      clk: Mark a fwnode as initialized when using CLK_OF_DECLARE() macro

 MAINTAINERS                          | 2 +-
 drivers/clk/Kconfig                  | 2 +-
 drivers/clk/bcm/clk-bcm2835-aux.c    | 1 -
 drivers/clk/bcm/clk-bcm2835.c        | 1 -
 drivers/clk/clk-fixed-mmio.c         | 1 -
 drivers/clk/clk-fsl-sai.c            | 1 -
 drivers/clk/clk-k210.c               | 2 +-
 drivers/clk/hisilicon/clk-hi3559a.c  | 1 -
 drivers/clk/microchip/clk-mpfs-ccc.c | 1 -
 include/linux/clk-provider.h         | 8 +++++++-
 10 files changed, 10 insertions(+), 10 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
