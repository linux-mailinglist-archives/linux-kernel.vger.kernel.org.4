Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E8E649FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiLLNQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiLLNQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:16:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E3B13CE4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:15:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA6A61043
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBBAC433EF;
        Mon, 12 Dec 2022 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670850948;
        bh=4OJ3Lf44TP0zqYiNvcLuJ1d1j2wpIh68PwBL/ghnjyo=;
        h=From:To:Cc:Subject:Date:From;
        b=pnYzut7QDp23CII5Ms7fk9L3C1WxtEkVaEoLzB4ZppQs3gcOZwog2OtdAhYfpHMTb
         eO+BrWZPm0MAzmo5d3SP9HrsyTJ63PdwZM6UzVhUE/+7fGMQaSefT0XgdTCFZO7H7K
         SzmoPyoQNsO8O9/wy0Yex4lhqaZHc533k4X0LrpyiGZM73W39EZ5x7/cruShgEizeU
         o98M2g6Edmw74XxBbWfo62SWBfWVNI5Hnq4C2KtfnOG+hBXOu/Bx6GdZcw+Bza+98T
         5qL1FNRHHOaIEls+a46GfMNnq8xX7WEFEVOwux7tfmgNuSkgxM5xS4eiu3hEaGnz2M
         FuH0BBwKu33sg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.2
Date:   Mon, 12 Dec 2022 13:15:38 +0000
Message-Id: <20221212131547.9FBBAC433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.2

for you to fetch changes up to 22250dbaba99f87574095af894610e9801d74419:

  regmap: Merge fix for where we get the number of registers from (2022-12-12 11:50:58 +0000)

----------------------------------------------------------------
regmap: Updates for v6.2

A few new APIs here, support for the FSI bus (which is used in some
PowerPC systems) plus a couple of new APIs, one allowing abstractions
built on top of regmap to tell if the regmap can be used in an atomic
context and one providing a callback for an in flight device which can't
do interrupt masking very well.

There's also a fix that I never got round to sending because it really
should be fixed better but that's not happened yet and it does avoid the
problem, the fix was in -next for a long time.

----------------------------------------------------------------
Eddie James (1):
      regmap: Add FSI bus support

Mark Brown (2):
      fsi: Add regmap and refactor sbefifo
      regmap: Merge fix for where we get the number of registers from

Michael Walle (1):
      regmap: add regmap_might_sleep()

William Breathitt Gray (1):
      regmap-irq: Add handle_mask_sync() callback

Yassine Oudjana (1):
      regmap-irq: Use the new num_config_regs property in regmap_add_irq_chip_fwnode

 drivers/base/regmap/Kconfig      |   6 +-
 drivers/base/regmap/Makefile     |   1 +
 drivers/base/regmap/regmap-fsi.c | 231 +++++++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap-irq.c |  59 +++++++---
 drivers/base/regmap/regmap.c     |  13 +++
 include/linux/regmap.h           |  49 +++++++++
 6 files changed, 341 insertions(+), 18 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-fsi.c
