Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA57667128
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjALLnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjALLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:41:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4A834D4D;
        Thu, 12 Jan 2023 03:33:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D054061FBF;
        Thu, 12 Jan 2023 11:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC00AC433D2;
        Thu, 12 Jan 2023 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673523214;
        bh=mt2MZNarf8ITQomlqjpySLSnCzEue6nMwDfSAmg/OPs=;
        h=From:To:Cc:Subject:Date:From;
        b=tt3TSorrAy61aD5GrSA0A0YzfPuvli5dKPEduiBJWTZrw2oedK3p6T8VS0feDjSeL
         gOgolVMkcfL0iFSo2v8mGiyNDUJaROnD2xu+R+Fn3tQBrXnveYpInV4wqBJNCQ2Nqw
         tE6q3mwgnB2VFc8S4OalliMYTJu75onr5Ccun6J/pg852Fftyal9ItJ6LGcb6F3hYs
         tOp2uSSkv+ahJogO7cfoDARSoJsP8TI5L3W+6go/GkJsVV3LPPKv70pqjPx4HTMTMa
         uKe0k+60noWWBRWQ/qjhEnZ26nGEe1b1M/V/NGXyFy0tvQumFQs1IhPPSbpdiJY80q
         71Uj/ZPI+aQRg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.2-rc3
Date:   Thu, 12 Jan 2023 11:33:19 +0000
Message-Id: <20230112113333.DC00AC433D2@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.2-rc3

for you to fetch changes up to b442990d244ba2ffe926c6603c42deb6fcc3b0db:

  spi: Merge rename of spi-cs-setup-ns DT property (2023-01-11 14:15:22 +0000)

----------------------------------------------------------------
spi: Fixes for v6.2

There's several things in this pull request:

 - Fixes for long standing issues with accesses to spidev->spi during
   teardown in the spidev userspace driver.
 - Rename the newly added spi-cs-setup-ns DT property to be more in line
   with our other delay properties before it becomes ABI.
 - A few driver specific fixes.

----------------------------------------------------------------
Bartosz Golaszewski (2):
      spi: spidev: fix a race condition when accessing spidev->spi
      spi: spidev: remove debug messages that access spidev->spi without locking

Hector Martin (2):
      spi: dt-bindings: Rename spi-cs-setup-ns to spi-cs-setup-delay-ns
      spi: Rename spi-cs-setup-ns property to spi-cs-setup-delay-ns

Mark Brown (1):
      spi: Merge rename of spi-cs-setup-ns DT property

Ricardo Ribalda (1):
      spi: mediatek: Enable irq before the spi registration

Witold Sadowski (1):
      spi: cadence: Fix busy cycles calculation

 .../bindings/spi/spi-peripheral-props.yaml         |  4 +--
 drivers/spi/spi-cadence-xspi.c                     |  5 ++-
 drivers/spi/spi-mt65xx.c                           | 12 +++-----
 drivers/spi/spi.c                                  |  2 +-
 drivers/spi/spidev.c                               | 36 +++++++++++-----------
 5 files changed, 30 insertions(+), 29 deletions(-)
