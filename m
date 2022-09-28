Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435985EE317
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiI1R1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiI1R1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:27:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4219EEB64;
        Wed, 28 Sep 2022 10:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46EDCB82181;
        Wed, 28 Sep 2022 17:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F95C433C1;
        Wed, 28 Sep 2022 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664386027;
        bh=sEaAFlLGEgpXJHzFEUP5i9M3xMjSmcc2mK9p+3UtZfU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TLle9aOTJxrdCiCqpEW7yXpGm160UG+b2YIyLicLAXcoZ77hFvlka3sLMUH7yCnHh
         P70SOCzmt5UgGyH+DcAn0ubTLo2/MSHyp0Vcphfj3tJIgXY8UHJiZEPL7x0QXDBXEw
         lppqCH6KUQ+zlWuUH1It40qgzpDZdr0tJMAnRvCuRXMWvhhd8u5vcicjHihlJfo8Hj
         XjA4y3QNfsM1nWyJO8WWsrdTjIiQ3unf+m/n5BWqDpxXsWvDMnHSl3OH4LUnNIQQWy
         40XgRcjrKCdEfCcONjrfTbTPXFYlQg+KqgFPZ1PbuT4hjwNT9jJo2JhWejvPh4zT5V
         EgM+xcTX1TVFw==
From:   Mark Brown <broonie@kernel.org>
To:     andi@etezian.org, krzysztof.kozlowski@linaro.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, kernel@axis.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220927112117.77599-1-vincent.whitchurch@axis.com>
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 0/4] spi: Fix DMA bugs in (not only) spi-s3c64xx
Message-Id: <166438602538.235891.3502300542597147263.b4-ty@kernel.org>
Date:   Wed, 28 Sep 2022 18:27:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 13:21:13 +0200, Vincent Whitchurch wrote:
> v2:
> - Drop merged patch adding new test to spi-loopback-test
> - Fix compiler warning in !HAS_DMA builds
> - Add support to split transfers to core
> 
> This series fixes some bugs I found while running spi-loopback-test with
> spi-s3c64xx.  The first problem (which I actually noticed while trying to fix
> the second problem with transfers >64KiB) seems to be a generic issue which
> affects several drivers so I fixed it in the core.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: Save current RX and TX DMA devices
      commit: f25723dcef4a38f6a39e17afeabd1adf6402230e
[2/4] spi: Fix cache corruption due to DMA/PIO overlap
      commit: 0c17ba73c08ff2690c1eff8df374b6709eed55ce
[3/4] spi: Split transfers larger than max size
      commit: 8d699ff95534747e394e0830399b8d5dcf03e738
[4/4] spi: s3c64xx: Fix large transfers with DMA
      commit: 1224e29572f655facfcd850cf0f0a4784f36a903

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
