Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4281635FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbiKWNbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbiKWNaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:30:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CF48C0A5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:11:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8F9B61CA5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B265C433B5;
        Wed, 23 Nov 2022 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669209092;
        bh=6N8VLx5XLFcx0UnyHnQhdCl3xgM1JMvEbDLVhm+Xgp0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XCvOXAKEmpGuWXt72Juj0FAFdXzQqY45WIRWmfGovvaAw/cEEaEYZ5nvSDhL/WWd0
         8oQHzo13m3WSgkq6A0uZOvEUAWyaoGRso7GNyGBEjM71qmcz1TBYrew1xeuYsdvX1J
         M7t2mrlc067PKgJQqQXJn+lipg9wlMWZJF+/bI6Lz0HM30aoZJbDT2dmGcSvTeVpZy
         zZBN8TJ5ajvWp00mxg+aeaMhLkEd4QO78wLQpTL1PM6XZy9/r33nIXXNVgtpgx2aQ8
         cwKodOtmxO08IdkEf4nrVGTgjRZfYmASjgex5LrqpH4mX6IQLQg1iA1+B1lgGWruku
         MbmqcgE3pw+CA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221104160252.166114-1-rf@opensource.cirrus.com>
References: <20221104160252.166114-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc-dai: Do not call snd_soc_link_be_hw_params_fixup() twice
Message-Id: <166920909090.125457.3717205173938547905.b4-ty@kernel.org>
Date:   Wed, 23 Nov 2022 13:11:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 16:02:52 +0000, Richard Fitzgerald wrote:
> For a BE link snd_soc_link_be_hw_params_fixup() is called by
> dpcm_be_dai_hw_params() to initialize the params before it passes them
> to __soc_pcm_hw_params(). Then __soc_pcm_hw_params() refines params to
> match the BE codec and passes that to snd_soc_dai_hw_params().
> 
> The second call of snd_soc_link_be_hw_params_fixup() within
> snd_soc_dai_hw_params() was overwriting the refined params with the
> original BE CPU DAI params. This would then lead to various problems,
> for example passing an invalid number of channels to the codec driver
> hw_params(), or enabling more AIF widgets on the codec than are actually
> mapped by TDM slots.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dai: Do not call snd_soc_link_be_hw_params_fixup() twice
      commit: 3115be55138afb9fb9ae1b4e99378da34bcfd164

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
