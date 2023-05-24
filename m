Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA93D70F3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjEXKOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjEXKOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A2E65;
        Wed, 24 May 2023 03:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D1BD629C8;
        Wed, 24 May 2023 10:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD94C4339B;
        Wed, 24 May 2023 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684923210;
        bh=YBiQZnn3UE4CseHaGnob9PKsAhVchxOdPP8AumSzB48=;
        h=From:To:Cc:Subject:Date:From;
        b=kK6Io4A318tO+M6jmuKFkonmmbgrosqEmC3p82hxD7GbkMs4d0x+j/5oZ9VbZfAmY
         gogGbYl1IgncgeZ/uG1tcDSX/6An+eKCYyj3pl5As/uh7wRjwOxZ5v6GrioHuWInWl
         xVLfw/1n65LCiXkavZ6aND+GVMmaN6rdQ9q9+pobaE2DZ9l7zs4hK+u+bYrCyx72q1
         5DNo5p8XFiTUTQ5F1Uzz9BCmfjd6ms5XBmr84QWH4o+3L91Q1Zei72gjXdAyDdAXlv
         ZNz2/C9+WJLxNKNNQjYTLRVSF6GDLkm+C69gIEZGXRS91OQG4yDsVxzMEUhZ8Ue73H
         7oISuu+2ptM2g==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.4-rc3
Date:   Wed, 24 May 2023 11:13:17 +0100
Message-Id: <20230524101329.ACD94C4339B@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc3

for you to fetch changes up to 6afe2ae8dc48e643cb9f52e86494b96942440bc6:

  spi: spi-cadence: Interleave write of TX and read of RX FIFO (2023-05-22 11:41:05 +0100)

----------------------------------------------------------------
spi: Fixes for v6.4

A collection of fixes that came in since the merge window, plus an
update to MAINTAINERS.  The Cadence fixes are coming from the addition
of device mode support, they required a couple of incremental updates in
order to get something that works robustly for both device and
controller modes.

----------------------------------------------------------------
Amit Kumar Mahapatra (1):
      spi: dw: Replace spi->chip_select references with function calls

Charles Keepax (3):
      spi: spi-cadence: Avoid read of RX FIFO before its ready
      spi: spi-cadence: Only overlap FIFO transactions in slave mode
      spi: spi-cadence: Interleave write of TX and read of RX FIFO

Krzysztof Kozlowski (1):
      spi: MAINTAINERS: drop Krzysztof Kozlowski from Samsung SPI

Vijaya Krishna Nivarthi (1):
      spi: spi-geni-qcom: Select FIFO mode for chip select

 MAINTAINERS                 |   1 -
 drivers/spi/spi-cadence.c   | 105 +++++++++++++++++++-------------------------
 drivers/spi/spi-dw-mmio.c   |   8 ++--
 drivers/spi/spi-geni-qcom.c |   2 +
 4 files changed, 51 insertions(+), 65 deletions(-)
