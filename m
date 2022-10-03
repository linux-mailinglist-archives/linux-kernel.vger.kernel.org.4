Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC435F3069
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJCMqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJCMqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:46:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE2312E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 05:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 929FAB81094
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E723CC433D6;
        Mon,  3 Oct 2022 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664801200;
        bh=3SojJqQbHQl/G1WXWLJyFIuXJHLjoGLizcKPf0MdSbc=;
        h=From:To:Cc:Subject:Date:From;
        b=PeVjOB0YzQyrQhosuQR2ObikWEK4Lavtz1PoBDdRRwpR+8CA9A9qRsycDL5sR5n/f
         qb0AVxIUOX1radtmO47XWqvoPm2rZSDGeMH4XFEEy5SHben3SZd6LWPL03YgWTVjgt
         aJZ0+5PaCoJ1J1qc3TKIN6AUx7sXSNbOcPthRxXhH82dUuuu2LPtMNb59+JvwZ5Ymr
         vl13DDLcvuhlc1/PzMCDv3YWXthWZW4m5yyCxS82AT0rR6C9nSd1c9ikZ2rLpyzIPb
         dMM6BAW7I1xEJYjxwJ4OUMDF9qvv0qazCtqGL2ZiLFO2syB+gSgGhkW7kLusFWsu/5
         dTxZE3q/1BHjw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.1
Date:   Mon, 03 Oct 2022 13:46:22 +0100
Message-Id: <20221003124639.E723CC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.1

for you to fetch changes up to 01ed230761e51f0403b3f3845c11cb67014487e2:

  regmap: mmio: replace return 0 with break in switch statement (2022-09-22 12:33:18 +0100)

----------------------------------------------------------------
regmap: Updates for v6.1

This has been a busy release for regmap with one thing and other,
there's been an especially large interest in MMIO regmaps for some
reason.  The bulk of the changes are cleanups but there are several user
visible changes too:

 - Support for I/O ports in regmap-mmio.
 - Support for accelerated noinc operations in regmap-mmio.
 - Support for tracing the register values in bulk operations.

----------------------------------------------------------------
Andy Shevchenko (11):
      regmap: mmio: Remove mmio_relaxed member from context
      regmap: mmio: Get rid of broken 64-bit IO
      regmap: mmio: Introduce IO accessors that can talk to IO port
      regmap: mmio: Fix MMIO accessors to avoid talking to IO port
      regmap: Make use of get_unaligned_be24(), put_unaligned_be24()
      regmap: trace: Remove useless check for NULL for bulk ops
      regmap: trace: Remove explicit castings
      regmap: trace: Remove unneeded blank lines
      swab: Add array operations
      regmap: mmio: Use swabXX_array() helpers
      regmap: spi-avmm: Use swabXX_array() helpers

Colin Ian King (1):
      regmap: mmio: replace return 0 with break in switch statement

Dmitry Rokosov (1):
      regmap: introduce value tracing for regmap bulk operations

Linus Walleij (5):
      regmap: Support accelerated noinc operations
      regmap: mmio: Support accelerared noinc operations
      regmap/hexagon: Properly fix the generic IO helpers
      regmap: check right noinc bounds in debug print
      regmap: mmio: Fix rebase error

Mark Brown (1):
      regmap: mmio: Extending to support IO ports

 arch/hexagon/include/asm/io.h         |  25 +++
 drivers/base/regmap/regmap-mmio.c     | 289 +++++++++++++++++++++++++++-------
 drivers/base/regmap/regmap-spi-avmm.c |  14 +-
 drivers/base/regmap/regmap.c          | 167 +++++++++++++++++---
 drivers/base/regmap/trace.h           |  61 +++++--
 include/linux/regmap.h                |  11 ++
 include/linux/swab.h                  |  25 +++
 7 files changed, 489 insertions(+), 103 deletions(-)
