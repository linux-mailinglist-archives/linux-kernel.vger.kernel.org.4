Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C431170E746
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbjEWVWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjEWVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:22:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859312B;
        Tue, 23 May 2023 14:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 041E763646;
        Tue, 23 May 2023 21:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60482C433D2;
        Tue, 23 May 2023 21:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684876923;
        bh=ab/mJcRjDZjxkoFOx8TsCJOjWPYFfs2gBZXGaXMAaiA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BHYeowlpySnhXuOZQrmmiv6ygMyQiU+vshS+1s4jTXiL/+XUaqbZQVtNFywMQx930
         xDns9Ik5Y3xo2XQWbhOWUd7aF5cR6/szHobOe+4XMH8x3qujE/X4HBZHGiD6hKfuDO
         Zm5LSS7hWMPO7Eet8ArXF5N/2mSKOG6PVbvDrEs6vUe/XZisHSclMLBlSnwPyOM8Yj
         4QlvEFb2MBF6PjoGGKvvUJ7lgsajol9erJXzxxJrQX5d+CisaKffIhiVG9HWLE/We5
         GPk4Mc+01sGnvYTels88usWvLUnYQ8VsaPl2yCYBVt0tvuSbSCLtq1qpw8YyjVZwck
         7c0MDQ/Rnf+SA==
From:   Mark Brown <broonie@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
In-Reply-To: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 0/3] spi: spi-imx: fix use of more than four chip
 selects
Message-Id: <168487692110.292681.7586719186720354823.b4-ty@kernel.org>
Date:   Tue, 23 May 2023 22:22:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 15:45:24 +0200, Rasmus Villemoes wrote:
> The current spi-imx driver completely fails when used with more than
> four (gpio) chip-selects, since the chip select number is used
> unconditionally as shift amount when updating the control and
> configuration registers, so the code ends up modifying random bits
> outside the intended fields.
> 
> This fixes it by making use of the unused_native_cs variable filled in
> by the spi core, and use that as the "channel number" for all gpiod
> chip selects.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-imx: use "controller" variable consistently in spi_imx_probe()
      commit: d9032b304541e1f560349e461611f25d67f44a49
[2/3] spi: spi-imx: set max_native_cs for imx51/imx53/imx6 variants
      commit: 8ce1bb9a5935385e9ef65bda1e8ca923c7fbb887
[3/3] spi: spi-imx: fix use of more than four chipselects
      (no commit info)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

