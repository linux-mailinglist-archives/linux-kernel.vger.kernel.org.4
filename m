Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408DA63913B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiKYVyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYVyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:54:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605CA286F2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:54:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E015160ECF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 21:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D942CC433C1;
        Fri, 25 Nov 2022 21:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669413250;
        bh=qB9w0640kae1kXq1AmRpw3zQDEMsNvt1fBtJ1iDnqMs=;
        h=From:To:Cc:Subject:Date:From;
        b=CvN/1oVBIrEPpI5MS7bEyZIbB4TzXev8NIPn8L/WiiPq1UjNCw2CG1xTFp+EJlVle
         BL9Z8NwVqMMFreqqUsp35TZk3koaQMnpOCXVzxYZIO4e/fY63crbKscJxjbWlevbEx
         my63rVL/TUTTomp4qZJr6tcztDuMVonBUXjm+KEbU+/S7avSpgPKJwDQZQ3xi7qdP/
         egiH7bB3k/v0RFd7VtyeXKmUopE39ek0Kz6HkPwwr3f3GGp7MFdxWc4nyry2TGUa2i
         T/jJV++PPgbUu5rfkFgov2z4gu3y7afnHQMm0bRHEqWN5ClQzcd6XdAehuZM5qwmCQ
         E5dyUORzKsEFw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.1-rc6
Date:   Fri, 25 Nov 2022 21:54:00 +0000
Message-Id: <20221125215409.D942CC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 392cc0a4a0c4b25534f3148b192f18be468f67bd:

  dt-bindings: gpio-regulator: add vin-supply property support (2022-09-29 15:20:15 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.1-rc6

for you to fetch changes up to 31a6297b89aabc81b274c093a308a7f5b55081a7:

  regulator: twl6030: fix get status of twl6032 regulators (2022-11-22 12:23:06 +0000)

----------------------------------------------------------------
regulator: Late fixes for v6.1

This is more changes than I'd like this late although the diffstat is
still fairly small, I kept on holding off as new fixes came in to give
things time to soak in -next but should probably have tagged and sent an
additional pull request earlier.

There's some relatively large fixes to the twl6030 driver to fix issues
with the TWL6032 variant which resulted from some work on the core
TWL6030 driver, a couple of fixes for error handling paths (mostly in
the core), and a nice stability fix for the sgl51000 driver that's been
pulled out of a BSP.

----------------------------------------------------------------
Andreas Kemnade (2):
      regulator: twl6030: re-add TWL6032_SUBCLASS
      regulator: twl6030: fix get status of twl6032 regulators

Konrad Dybcio (1):
      regulator: slg51000: Wait after asserting CS pin

Yang Yingliang (2):
      regulator: rt5759: fix OOB in validate_desc()
      regulator: core: fix UAF in destroy_regulator()

Zeng Heng (1):
      regulator: core: fix kobject release warning and memory leak in regulator_register()

 drivers/regulator/core.c               |  8 ++++++--
 drivers/regulator/rt5759-regulator.c   |  1 +
 drivers/regulator/slg51000-regulator.c |  2 ++
 drivers/regulator/twl6030-regulator.c  | 17 +++++++++++++----
 4 files changed, 22 insertions(+), 6 deletions(-)
