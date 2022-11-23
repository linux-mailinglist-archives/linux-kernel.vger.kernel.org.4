Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25188636545
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiKWQF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbiKWQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:05:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078AD1FCDA;
        Wed, 23 Nov 2022 08:05:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9966C61DD6;
        Wed, 23 Nov 2022 16:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4687C433C1;
        Wed, 23 Nov 2022 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669219525;
        bh=wumT2s5vcbQLnC2Ie1QxkdtZxlwX79xhxHYlH5r//Qs=;
        h=From:To:Cc:Subject:Date:From;
        b=iwA3yUXdDRK22J7A76qBE8VD+CsXQ7ytMFW8cGuF/F0lqabGHieU2qeDccVuKXdhk
         sS35HnA7gHiLSRGgWPSl4kSKm9xGIgrtxE9b/oYIfB19CwRpjDHH76XM24JsEC/vMv
         +s4i6gZr8larNS8WQ+HnKsM90OXLBSgWg5KnUKNPtqN5O32PhJs0qTXB1sdxkc6TUT
         f9URkC26B4FH5z0hhe83piA8r8mcexBL8q+XSvbjrGtgjuVakuOiJ+3rRLOUqqFcWl
         oRcsuI4lWIdBW6WelVIc7Y+5uk9q0yTS0qPdUi1eZnaYwAVcIDajzfiHZti1n8gOmp
         v66zQVKJnL58A==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.1-rc6
Date:   Wed, 23 Nov 2022 16:04:59 +0000
Message-Id: <20221123160524.A4687C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bff6bef701db784bb159a659e99c785b4594fc96:

  spi: amd: Fix SPI_SPD7 value (2022-11-04 12:25:03 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc6

for you to fetch changes up to e85e9e0d8cb759013d6474011c227f92e442d746:

  spi: spi-imx: spi_imx_transfer_one(): check for DMA transfer first (2022-11-18 11:39:50 +0000)

----------------------------------------------------------------
spi: Fixes for v6.1

A few fixes, all device specific.  The most important ones are for the
i.MX driver which had a couple of nasty data corruption inducing errors
appear after the change to support PIO mode in the last merge window
(one introduced by the change and one latent one which the PIO changes
exposed), thanks to Frieder, Fabio, Marc and Marek for jumping on that
and resolving the issues quickly once they were found.

----------------------------------------------------------------
Frieder Schrempf (1):
      spi: spi-imx: Fix spi_bus_clk if requested clock is higher than input clock

Krishna Yarlagadda (1):
      spi: tegra210-quad: Fix duplicate resource error

Marc Kleine-Budde (1):
      spi: spi-imx: spi_imx_transfer_one(): check for DMA transfer first

Xiongfeng Wang (1):
      spi: dw-dma: decrease reference count in dw_spi_dma_init_mfld()

Zhichao Liu (1):
      spi: mediatek: Fix DEVAPC Violation at KO Remove

 drivers/spi/spi-dw-dma.c        |  3 +++
 drivers/spi/spi-imx.c           | 13 ++++++++-----
 drivers/spi/spi-mt65xx.c        |  8 +++++++-
 drivers/spi/spi-tegra210-quad.c |  3 ++-
 4 files changed, 20 insertions(+), 7 deletions(-)
