Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C61173E0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjFZNdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFZNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67870E7B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E84E560EAE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E761FC433C0;
        Mon, 26 Jun 2023 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687786389;
        bh=XzT/EwjQska4DR7hPVRY3Jw0O5roXyCdowtvSTtg+V4=;
        h=From:To:Cc:Subject:Date:From;
        b=YE1r55M42LS4HXEhEA2pzeAkqUuEbS1GqaRw9aFzzx20RhGHoGCFEH020Gtt1l3Gv
         wI/GqmDQNVSmG1jE5wI95vA9cggSC/5jZDT0rF2UlwID+zv4Xbh+nVQS71lwWNLX5k
         W4hKgj+bW3BnVFISP+CdhxIUb5kVTwS7fWBs1i7RMjKx7DzcIdntjDe0R9S85Q71QH
         tn8oVX8UKjz1qE6126cS5ZH9qhyxLXvyMkFr83LL21y/ZiTripT/co8FGRsB1clcfq
         S8zkTvgRETgzUuxzY8S+IJIsLGcTnovSZytbw5/vdmgino/37LM0WuuD2m7yjoioFc
         SI3QmDc32GzeA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.5
Date:   Mon, 26 Jun 2023 14:32:56 +0100
Message-Id: <20230626133308.E761FC433C0@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.5

for you to fetch changes up to d0c99ffe212679b338d12fe283964e6e43ce1501:

  regmap: Allow reads from write only registers with the flat cache (2023-06-19 12:59:41 +0100)

----------------------------------------------------------------
regmap: Updates for v6.5

Another busy release for regmap with the second half fo the maple tree
register cache implementation, there's some smaller optimisations that
could be done but this should now be able to replace the rbtree cache
for most devices.

We also had a followup from Aidan MacDonald's refactoring of some of the
regmap-irq interfaces, the conversion is complete so the old interfaces
are removed.  This means that even with the new features for the maple
tree cache we'd have a nice negative diffstat were it not for the
addition of a bunch more KUnit coverage.

There's one GPIO patch in here, it was a dependency for a cleanup of an
API in the regmap-irq code for which the gpio-104-dio-48e driver was the
only user.

Highlights:

 - The maple tree cache can now load in default values more efficiently,
   and is capabale of syncing multiple registers in a single write
   during cache sync.
 - More KUnit coverage, including some coverage for raw I/O and a dummy
   RAM backed cache to support it.
 - Removal of several old interfaces in regmap-irq now all the users
   have been modernised.

----------------------------------------------------------------
Aidan MacDonald (6):
      regmap-irq: Fix typo in documentation for .get_irq_reg()
      regmap-irq: Remove virtual registers
      regmap-irq: Remove type registers
      regmap-irq: Remove support for not_fixed_stride
      regmap-irq: Minor adjustments to .handle_mask_sync()
      regmap-irq: Drop backward compatibility for inverted mask/unmask

Charles Keepax (2):
      regmap: regmap-irq: Move handle_post_irq to before pm_runtime_put
      regmap: Add missing cache_only checks

Mark Brown (16):
      regmap-irq: Cleanups and remove unused
      regmap: Merge up v6.4-rc3
      regmap: Load register defaults in blocks rather than register by register
      regmap: Provide a ram backed regmap with raw support
      regmap: Provide basic KUnit coverage for the raw register I/O
      regmap: Merge up v6.4-rc6
      regmap: maple: Implement block sync for the maple tree cache
      regmap: Don't check for changes in regcache_set_val()
      regmap: Provide basic test coverage for raw I/O
      regmap: Add test that writes to write only registers are prevented
      regmap: Add a test case for write only registers
      regmap: Add test to make sure we don't sync to read only registers
      regmap: Check for register readability before checking cache during read
      regmap: Add KUnit tests for read/write checking
      regmap: Drop early readability check
      regmap: Allow reads from write only registers with the flat cache

Maxime Chevallier (1):
      regmap: mmio: Allow passing an empty config->reg_stride

Waqar Hameed (1):
      regmap: Add debugfs file for forcing field writes

William Breathitt Gray (2):
      gpio: 104-dio-48e: Implement struct dio48e_gpio
      regmap-irq: Drop map from handle_mask_sync() parameters

 drivers/base/regmap/Makefile         |   2 +-
 drivers/base/regmap/internal.h       |  15 +-
 drivers/base/regmap/regcache-maple.c | 140 ++++++++++-
 drivers/base/regmap/regcache.c       |  12 +-
 drivers/base/regmap/regmap-debugfs.c |  11 +
 drivers/base/regmap/regmap-irq.c     | 273 ++++-----------------
 drivers/base/regmap/regmap-kunit.c   | 451 +++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap-mmio.c    |   2 +-
 drivers/base/regmap/regmap-raw-ram.c | 133 +++++++++++
 drivers/base/regmap/regmap.c         |  28 ++-
 drivers/gpio/gpio-104-dio-48e.c      |  37 ++-
 include/linux/regmap.h               |  33 +--
 12 files changed, 835 insertions(+), 302 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-raw-ram.c
