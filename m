Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4548618E01
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiKDCJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKDCJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:09:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12826114B;
        Thu,  3 Nov 2022 19:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FAEF62066;
        Fri,  4 Nov 2022 02:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA27C433D6;
        Fri,  4 Nov 2022 02:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667527733;
        bh=6vcgZO9W5PulT8vcY4daa97zjmOPRCCRD6o+HsQZiGI=;
        h=From:To:Cc:Subject:Date:From;
        b=Br4KxHHf+N0Uvd7wSlx5zdFjo+uWjO5VwuJ5g3kNoc6HeKrvuK55cJUGIt0YwMObz
         FiAgYAuMoUZczaYjVrxP2bzwT4OzL2Os7P21UbNnsZSA1q8kfxLTL7w7D26NaIcn06
         zt60zdzV3T+5jJVCSlARbp4JEi+/y2JTTbwpzDzKZoTRSZY6SZ5Bgnj1X+wH6KZ26Y
         o4iU0cku6W6G78EqU8ZBacXgmpaIJ8j27OmwAAqTLcj/Lsi8H0g3/yILvqCYZnUawL
         wh2QzybirTH8juOFI7eu35Fv/wPCXhXN1JVI41DewQPUU39St9XnBW9rUSnaqex2qO
         1zvPwYeBNnaGA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.1-rc3
Date:   Thu,  3 Nov 2022 19:08:52 -0700
Message-Id: <20221104020852.3958600-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to ffa20aa581cf5377fc397b0d0ff9d67ea823629b:

  clk: qcom: Update the force mem core bit for GPU clocks (2022-10-27 17:23:29 -0700)

----------------------------------------------------------------
Fixes in clk drivers and some clk rate range fixes in the core as well.

 - Make sure the struct clk_rate_request is more sane.

 - Remove a WARN_ON that was triggering for clks with no parents
   that can change frequency.

 - Fix bad i2c bus transactions on Renesas rs9.

 - Actually return an error in clk_mt8195_topck_probe() on an error
   path.

 - Keep the GPU memories powered while the clk isn't enabled on
   Qualcomm's sc7280 SoC.

 - Fix the parent clk for HSCIF modules on Renesas' R-Car V4H SoC.

----------------------------------------------------------------
Conor Dooley (1):
      clk: sifive: select by default if SOC_SIFIVE

Geert Uytterhoeven (2):
      clk: renesas: r8a779g0: Add SASYNCPER clocks
      clk: renesas: r8a779g0: Fix HSCIF parent clocks

Marek Vasut (1):
      clk: rs9: Fix I2C accessors

Maxime Ripard (3):
      clk: Remove WARN_ON NULL parent in clk_core_init_rate_req()
      clk: Initialize the clk_rate_request even if clk_core is NULL
      clk: Initialize max_rate in struct clk_rate_request

Stephen Boyd (1):
      Merge tag 'renesas-clk-fixes-for-v6.1-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-fixes

Taniya Das (1):
      clk: qcom: Update the force mem core bit for GPU clocks

Yang Yingliang (1):
      clk: mediatek: clk-mt8195-topckgen: Fix error return code in clk_mt8195_topck_probe()

 drivers/clk/clk-renesas-pcie.c             | 65 ++++++++++++++++++++++++++++--
 drivers/clk/clk.c                          |  6 ++-
 drivers/clk/mediatek/clk-mt8195-topckgen.c |  4 +-
 drivers/clk/qcom/gcc-sc7280.c              |  1 +
 drivers/clk/qcom/gpucc-sc7280.c            |  1 +
 drivers/clk/renesas/r8a779g0-cpg-mssr.c    | 13 ++++--
 drivers/clk/sifive/Kconfig                 |  4 +-
 7 files changed, 84 insertions(+), 10 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
