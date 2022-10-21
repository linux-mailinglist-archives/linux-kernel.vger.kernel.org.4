Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5577C607BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiJUQPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJUQPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D439E0FE;
        Fri, 21 Oct 2022 09:15:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF3D761F15;
        Fri, 21 Oct 2022 16:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816BFC433C1;
        Fri, 21 Oct 2022 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666368915;
        bh=iCewE/mUxFUwxBVTnDRE81TzLYGC1UfmkQxqs8i3xdI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UgOkjA0vCyTWZOEVc0oZ4JGwhq2kdluMgDqvKxBto23HIa/+qVg2HuTj8IPoirRh3
         kwSGgDINHoE4fvG4RsW1tyq6DKMjNxwLoFuxE5TEs+CkhZp592InEZ1VXE9MlCcd7f
         xXHc10Ha5fwttkEuWsvAKBs4se4DMNTdEo9Jrhw4Qo5zOlAjuKj+sQnfF3BbtWQs0Y
         35bFprox0Lar/dETz922Q3AwU1CJR+R2NHNAI2r8v3rsaD84Aa9z9MuMll1moy9O73
         0XYEhGoJG/nBTTXQQNNo4C88G7tEdm42dZKyJ5F6NR2atupQfzH6ESO7qyk3gueFhb
         fwVEKgbbEn5lQ==
From:   Mark Brown <broonie@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
References: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
Subject: Re: (subset) [PATCH v4 0/4] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle
Message-Id: <166636891222.378315.9501642129883885314.b4-ty@kernel.org>
Date:   Fri, 21 Oct 2022 17:15:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 15:31:24 +0200, Amjad Ouled-Ameur wrote:
> Between SPI transactions, all SPI pins are in HiZ state. When using the SS
> signal from the SPICC controller it's not an issue because when the
> transaction resumes all pins come back to the right state at the same time
> as SS.
> 
> The problem is when we use CS as a GPIO. In fact, between the GPIO CS
> state change and SPI pins state change from idle, you can have a missing or
> spurious clock transition.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
      commit: 031837826886e254fefff7d8b849dc63b6a7e2b9
[2/4] spi: meson-spicc: Use pinctrl to drive CLK line when idle
      commit: f4567b28fdd4bede7cab0810200d567a1f03ec5e

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
