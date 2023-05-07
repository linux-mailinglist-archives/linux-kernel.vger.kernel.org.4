Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADA6F952A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEGA1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGA1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7363C0F;
        Sat,  6 May 2023 17:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A08A60FA9;
        Sun,  7 May 2023 00:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC2CC433EF;
        Sun,  7 May 2023 00:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419255;
        bh=3sA6fVYsQ5VfKB6zhde8HJkPFYJoV5q35SOa6ou5yaY=;
        h=From:To:Cc:Subject:Date:From;
        b=DLn8G15WCNLQC4bOc9qdpmwoUq3MTthQVysmbAMT++uEDM9TyXzmz0BELNRDoyNe7
         uD8LgDhVyKKse6owSe+KL5Hf2cMOUqtUMem0JqESMZWInzH+KkQm3aEcFU/On+kUzZ
         647LpkGU+RCqteVGuuq948Btechp1+Fi7KiZN6SA2j4w4IQZfeA0D8YgIhwyw9UH1V
         UwtTTuhknOpaifZAHy2yE0dTkUaQIj5vNrL9V2b1O+lC58LV8ddbxOJrgAbAyvktdt
         JlaMOQmm0I5R2aYJ32w8HULrlKNBGbReSuqXwgf0F3yUJrPb7LoBdacwogGnoX0Lvd
         QW08pjIRqcMfQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Sat,  6 May 2023 17:27:34 -0700
Message-ID: <20230507002734.1674632-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a9863979fbc25838bbe7c5badf538cedfc802f60:

  Merge branch 'clk-imx' into clk-next (2023-04-25 11:52:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 31c6ed4e89187beef8fe2f979c8881ca94839427:

  clk: starfive: Fix RESET_STARFIVE_JH7110 can't be selected in a specified case (2023-05-02 18:34:49 -0700)

----------------------------------------------------------------
A couple more patches that would be good to get into -rc1.

 - Revert an i.MX patch that's causing video failures because division
   math goes sideways
 - Fix a clang + W=1 build isue where FIELD_PREP() is taking a 32-bit
   variable instead of the usual u64 type
 - Fix a Kconfig bug in the StarFive JH7110 clk config that selects a
   reset controller when it can't be selected

----------------------------------------------------------------
Adam Ford (1):
      Revert "clk: imx: composite-8m: Add support to determine_rate"

Hal Feng (1):
      clk: starfive: Fix RESET_STARFIVE_JH7110 can't be selected in a specified case

Nathan Chancellor (1):
      clk: sp7021: Adjust width of _m in HWM_FIELD_PREP()

 drivers/clk/clk-sp7021.c           | 2 +-
 drivers/clk/imx/clk-composite-8m.c | 7 -------
 drivers/clk/starfive/Kconfig       | 5 +----
 3 files changed, 2 insertions(+), 12 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
