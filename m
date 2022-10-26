Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C803560E9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiJZUEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiJZUEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:04:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F5B110B10;
        Wed, 26 Oct 2022 13:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 413B462097;
        Wed, 26 Oct 2022 20:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5BFC433B5;
        Wed, 26 Oct 2022 20:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666814649;
        bh=nFv9CTw8y/qv9YpySBRdZ5qQVFKLubk9H3LBqzmqt5Y=;
        h=From:To:Cc:Subject:Date:From;
        b=IpmPRPMp5oxUuWF5J7r7OZXKBerz45hbXkRAS5CvWNX2efVw+EufnFN37vD3MjxW7
         8l69Sg2DlBzRD5huSy9UmEx4L6WEpfJ/4RGeSETjkg/LbKNKRxba6qlU81NLAdIlJE
         Ylk8GENyjSEqz9XcLLuQnVqeTR4ydcQzZhgcnLW1YHrSEVfnd9ilu5OdyZvLGCKADb
         +Ig/g1Z0ujJ2CV3GtXDrySrXy/bPNB7gmsPl7t/PDTgSSV0NTstGeZakb7jdiE64sn
         EE/X+h+cLz95EnriYRH47brTGFfJiy/PjnOcuZF6EooRB76G2/EIFC26AGHtHfkNmN
         wXKyXoDx4U3nA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.1-rc2
Date:   Wed, 26 Oct 2022 21:04:02 +0100
Message-Id: <20221026200409.4B5BFC433B5@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8e9204cddcc3fea9affcfa411715ba4f66e97587:

  spi: Ensure that sg_table won't be used after being freed (2022-09-30 12:56:29 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc2

for you to fetch changes up to f8aa6c895d482847c9b799dcdac8bbdb56cb8e04:

  spi: aspeed: Fix window offset of CE1 (2022-10-19 14:36:43 +0100)

----------------------------------------------------------------
spi: Fixes for v6.1

A collection of mostly unremarkable fixes for SPI that have built up
since the merge window, all driver specific.

The change to the qup adding support for GPIO chip selects is fixing a
regression due to the removal of legacy GPIO handling, the driver had
previously been silently relying on the legacy GPIO support in a
slightly broken way which worked well enough on some systems.  Fixing
it is simply a case of setting a couple of bits of information in the
driver description.

----------------------------------------------------------------
Bird, Tim (1):
      spi: spi-gxp: fix typo in SPDX identifier line

Chin-Ting Kuo (1):
      spi: aspeed: Fix typo in mode_bits field for AST2600 platform

Christophe Leroy (1):
      spi: mpc52xx: Replace NO_IRQ by 0

Cédric Le Goater (1):
      spi: aspeed: Fix window offset of CE1

Jonathan Neuschäfer (1):
      spi: spi-mem: Fix typo (of -> or)

Krishna Yarlagadda (1):
      spi: tegra210-quad: Fix combined sequence

Mauro Lima (1):
      spi: intel: Fix the offset to get the 64K erase opcode

Robert Marko (1):
      spi: qup: support using GPIO as chip select line

 drivers/spi/spi-aspeed-smc.c    | 6 +++---
 drivers/spi/spi-gxp.c           | 2 +-
 drivers/spi/spi-intel.c         | 2 +-
 drivers/spi/spi-mpc52xx.c       | 2 +-
 drivers/spi/spi-qup.c           | 2 ++
 drivers/spi/spi-tegra210-quad.c | 5 +++++
 include/linux/spi/spi-mem.h     | 2 +-
 7 files changed, 14 insertions(+), 7 deletions(-)
