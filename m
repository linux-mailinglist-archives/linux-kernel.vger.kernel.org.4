Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0D63E3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiK3W50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 17:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiK3W5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:57:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36792A0A;
        Wed, 30 Nov 2022 14:57:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64E4161E36;
        Wed, 30 Nov 2022 22:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BB9C433C1;
        Wed, 30 Nov 2022 22:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669849041;
        bh=pybQYKi2gR0IlbnVuLeDx89kUYolz4gTT5Rd9aKijSI=;
        h=From:To:Cc:Subject:Date:From;
        b=bZkPwGIbaM8iGj5LhDqvrwo985+pfYojiKg05qNp3H3XmjAI1tyYdQGTgYaLlYmAl
         371OvfRJ0itE5oFguAUTc/0x3b9vzWrSD2c9otXF/isS9n/dB1M+eo+10shBliDh5t
         5P+u2kMCSeXkiCebeThs7tLYcmeJ3N1SOVkesNQclP1iGtgRHIwRBCFtKA44dQRFWx
         VsQcSjH2PE7lCSkkIT2Jvg8qBpVQuNdPOqohyTHdy+UFrnU7YR0HkrgUlHDwWNFrnR
         /90zev+LSTn5LuRBL8i2g+pox+i6iayu7Oo1dgUrZjaTjhxAYMjMObOCu5MGgEg2Kx
         FvsJKRceafadw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.1-rc7
Date:   Wed, 30 Nov 2022 14:57:20 -0800
Message-Id: <20221130225720.1615026-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
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

The following changes since commit ffa20aa581cf5377fc397b0d0ff9d67ea823629b:

  clk: qcom: Update the force mem core bit for GPU clocks (2022-10-27 17:23:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to f6abcc21d94393801937aed808b8f055ffec8579:

  clk: qcom: gcc-sc8280xp: add cxo as parent for three ufs ref clks (2022-11-22 18:27:07 -0800)

----------------------------------------------------------------
A set of clk driver fixes that resolve issues for various SoCs. Most of
these are incorrect clk data, like bad parent descriptions. When the clk
tree is improperly described things don't work, like USB and UFS
controllers, because clk frequencies are wonky. Here are the extra
details:

 - Fix the parent of UFS reference clks on Qualcomm SC8280XP so that UFS
   works properly.
 - Fix the clk ID for USB on AT91 RM9200 so the USB driver continues to
   probe.
 - Stop using of_device_get_match_data() on the wrong device for a
   Samsung Exynos driver so it gets the proper clk data.
 - Fix ExynosAutov9 binding.
 - Fix the parent of the div4 clk on Exynos7885.
 - Stop calling runtime PM APIs from the Qualcomm GDSC driver directly
   as it leads to a lockdep splat and is just plain wrong because it
   violates runtime PM semantics by calling runtime PM APIs when the
   device has been runtime PM disabled.

----------------------------------------------------------------
David Virag (1):
      clk: samsung: exynos7885: Correct "div4" clock parents

Inbaraj E (1):
      dt-bindings: clock: exynosautov9: fix reference to CMU_FSYS1

Marek Szyprowski (1):
      clk: samsung: Revert "clk: samsung: exynos-clkout: Use of_device_get_match_data()"

Michael Grzeschik (1):
      ARM: at91: rm9200: fix usb device clock id

Shazad Hussain (1):
      clk: qcom: gcc-sc8280xp: add cxo as parent for three ufs ref clks

Stephen Boyd (3):
      clk: qcom: gdsc: Remove direct runtime PM calls
      Merge tag 'samsung-clk-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-fixes
      Merge tag 'clk-microchip-fixes-6.1' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-fixes

 .../bindings/clock/samsung,exynosautov9-clock.yaml |  2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |  2 +-
 drivers/clk/at91/at91rm9200.c                      |  2 +-
 drivers/clk/qcom/gcc-sc8280xp.c                    |  6 +++
 drivers/clk/qcom/gdsc.c                            | 61 +++-------------------
 drivers/clk/qcom/gdsc.h                            |  2 -
 drivers/clk/samsung/clk-exynos-clkout.c            |  6 ++-
 drivers/clk/samsung/clk-exynos7885.c               |  4 +-
 8 files changed, 21 insertions(+), 64 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
