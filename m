Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4B669D28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjAMQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjAMQFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:05:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3421A8;
        Fri, 13 Jan 2023 07:57:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86B7E6216E;
        Fri, 13 Jan 2023 15:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ADEC433D2;
        Fri, 13 Jan 2023 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673625449;
        bh=RgE8Fj7iLHFPKGSsXzQDcEmsYGxZ0rV3hVEWaEMDJr4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SO7NS2P4DPwFr/A1++KqO020SxXyW1XnTE9vxLY8j3xLOBS0Df9wfDocbp3xZRVEz
         kCphu1x3II9PfiO9B7cmpkegKuxK+ybMlSQyqVLR2zuXMGeAIBGmKvRDRQCjXyFONX
         wE6PFzd7SzVE7xvGI2loOIMh5c7hv8w78t7XEhPPm7tHUSxfL3Lsme6/dY6jcCt8iK
         o4q+qC1GsAsB36/Rx6ZGmEpt7ptRSPKGgTIYhefXLmcABSvTVCYenDcev+dr7j9VNi
         oBXtNqKFTD5HbZmtrioaJP8M9sj5CgIfRmTAfvz/PKISJN5L5JQxJw/b6T9Bow5nMD
         2tkgJxa/kSQjg==
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20230113102309.18308-1-marcan@marcan.st>
References: <20230113102309.18308-1-marcan@marcan.st>
Subject: Re: [PATCH v2 0/3] SPI core CS delay fixes and additions
Message-Id: <167362544665.163457.10878671229075890152.b4-ty@kernel.org>
Date:   Fri, 13 Jan 2023 15:57:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 19:23:07 +0900, Hector Martin wrote:
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

[1/3] spi: Use a 32-bit DT property for spi-cs-setup-delay-ns
      commit: f276aacf5d2f7fb57e400db44c807ea3b9525fd6
[2/3] spi: dt-bindings: Add hold/inactive CS delay peripheral properties
      commit: 34f89f238c545d4fd0166e37c201d96c10443953
[3/3] spi: Parse hold/inactive CS delay values from the DT
      commit: 5827b31d858e399e0ba9fbd33da7a39b31769e11

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
