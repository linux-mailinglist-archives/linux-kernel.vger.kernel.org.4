Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E7C66044D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjAFQdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjAFQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:33:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB61876EFB;
        Fri,  6 Jan 2023 08:33:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7F66B81E05;
        Fri,  6 Jan 2023 16:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB3AC433EF;
        Fri,  6 Jan 2023 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673022792;
        bh=dIyjAVQ4zC1CK3pgE3nLqfcLv9FRSRVsJPB2VsHT/I4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B04hPGSdBRClWe7Xv41li5rL1cWZY7ANkHf/Mg8AHmSb0o2LuEq5XJ2uJbJtRMJL5
         aYiLSS49PR0iAU9PvqLRfEwN2ULjI8w8A0qF3mHU83y4/CXwkbYiOX8QU/GXZ8ElbG
         gq7t11gSV88v6vbjNQ1f9aG4DdZOw1s3wbOBBapc07157xwcNBToWyA5D8UmF4jX4i
         atyG8ufzbwpQb5xLnWS+HI2TylMMkLZCUhs8q8SUojEI/vd45vlVb8E8nccu+thA/F
         jR8lOvucJmUjXys9fwzMQbgOU+epVISYLs1gU1DYlIzLhaGYJGLGoXXIglAEn+V7oQ
         xMpSrxvx1+kiQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20230104093631.15611-1-marcan@marcan.st>
References: <20230104093631.15611-1-marcan@marcan.st>
Subject: Re: [PATCH 0/5] SPI core CS delay fixes and additions
Message-Id: <167302278905.177027.5835777381294854019.b4-ty@kernel.org>
Date:   Fri, 06 Jan 2023 16:33:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-214b3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2023 18:36:26 +0900, Hector Martin wrote:
> Commits f6c911f3308c ("spi: dt-bindings: Introduce
> spi-cs-setup-ns property") and 33a2fde5f77b ("spi: Introduce
> spi-cs-setup-ns property") introduced a new property to represent the
> CS setup delay in the device tree, but they have some issues:
> 
> - The property is only parsed as a 16-bit integer number of nanoseconds,
>   which limits the maximum value to ~65us. This is not a reasonable
>   upper limit, as some devices might need a lot more.
> - The property name is inconsistent with other delay properties, which
>   use a "*-delay-ns" naming scheme.
> - Only the setup delay is introduced, but not the related hold and
>   inactive delay times.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: dt-bindings: Rename spi-cs-setup-ns to spi-cs-setup-delay-ns
      commit: 38892ea4cefbb6ed3a91e76d3af84a1f8077d2d4
[2/5] spi: Rename spi-cs-setup-ns property to spi-cs-setup-delay-ns
      commit: e0fe6a31cac84735939c29d1e05055d58325c6c0
[3/5] spi: Use a 32-bit DT property for spi-cs-setup-delay-ns
      (no commit info)
[4/5] spi: dt-bindings: Add hold/inactive CS delay peripheral properties
      (no commit info)
[5/5] spi: Parse hold/inactive CS delay values from the DT
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
