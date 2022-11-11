Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C1F625B11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiKKNQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiKKNQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:16:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B967B38;
        Fri, 11 Nov 2022 05:16:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 281C561FCE;
        Fri, 11 Nov 2022 13:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A437C433C1;
        Fri, 11 Nov 2022 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668172595;
        bh=vShm4FbEZfLrSTZTdoHe8BVjL2FSxUzzg1DEBmpt/N8=;
        h=From:To:Cc:Subject:Date:From;
        b=lBLzNJwxA7YTlCf1RvNGPP8l6mh7wItwq9q7gAVAwX6W5FlZpaE9K822Tj5ajPUGf
         oVaqQv5OO1now3pI1IfXNAmNkdQOY97wLLkiqYy8Z9MmHKe6R0fDvO+L9XjkFZfgSP
         1kjWVbvTY+eJl7Ra1+hAaN/LBel/l8M/4XZRh+gh1aePibCjxl5LwFsNJLbH+twsyN
         wbucubm+YqjOXhB/Z67rjSC1CMjuXUHUHi6X7G/XaBpFO6S+mvv6HXJvy3Nj7gMHf9
         rAKh7kw5ho/IWqFuk2QuJJUH10FFNhfb0C9BZWb62RFaQd4+OXF+Pj3fNKbnzbGpBH
         C2ozc3apmV/sw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.1-rc4
Date:   Fri, 11 Nov 2022 13:16:16 +0000
Message-Id: <20221111131635.0A437C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f8aa6c895d482847c9b799dcdac8bbdb56cb8e04:

  spi: aspeed: Fix window offset of CE1 (2022-10-19 14:36:43 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc4

for you to fetch changes up to bff6bef701db784bb159a659e99c785b4594fc96:

  spi: amd: Fix SPI_SPD7 value (2022-11-04 12:25:03 +0000)

----------------------------------------------------------------
spi: Fixes for v6.1

A relatively large batch of fixes here but all device specific, plus an
update to MAINTAINERS.  The summary print change to the STM32 driver is
fixing an issue where the driver could easily end up spamming the logs
with something that should be a debug message.

----------------------------------------------------------------
Jay Fang (1):
      MAINTAINERS: Update HiSilicon SFC Driver maintainer

Jon Hunter (1):
      spi: tegra210-quad: Don't initialise DMA if not supported

Marek Vasut (1):
      spi: stm32: Print summary 'callbacks suppressed' message

Mika Westerberg (1):
      spi: intel: Use correct mask for flash and protected regions

Neil Armstrong (2):
      spi: meson-spicc: move wait completion in driver to take bursts delay in account
      spi: meson-spicc: fix do_div build error on non-arm64

Sean Nyekjaer (1):
      spi: stm32: fix stm32_spi_prepare_mbr() that halves spi clk for every run

Vitaly Rodionov (1):
      spi: amd: Fix SPI_SPD7 value

zhichao.liu (1):
      spi: mediatek: Fix package division error

 MAINTAINERS                     |  2 +-
 drivers/spi/spi-amd.c           |  2 +-
 drivers/spi/spi-intel.c         |  8 ++++----
 drivers/spi/spi-meson-spicc.c   | 24 ++++++++++++++++++++++--
 drivers/spi/spi-mt65xx.c        | 23 +++++++++++++----------
 drivers/spi/spi-stm32.c         |  3 ++-
 drivers/spi/spi-tegra210-quad.c |  6 ++++++
 7 files changed, 49 insertions(+), 19 deletions(-)
