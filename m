Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617536DFE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjDLTAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjDLTAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:00:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC49113
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1668562CA3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 19:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6691DC433D2;
        Wed, 12 Apr 2023 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681326007;
        bh=a04AmJjKGcxoyVDJd74YDQ+REyxz8IYcBkZ14KBATpY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qW4ctxIw4LXiFrqcqLO1DNio5eUB2j9DYUKwnZ6WDR7yvOCFzRYiBV/ieTb/r5key
         CDmflt5kNd/i9XrUzzJjy+NBIS+93iYk2fVx5cdD+UiOVjDNV2+DmimorolTeCfcFZ
         p72k6Sckpi8O7OoHfG0E5v/EeWRvR4e8bhXlggqZ7U4aIQrhq2Er3cIjFLMummZRSr
         BIsHiiq97l0bUzED97k1W841505HtACcw8ySMkoJBhFxijYNnAtNO+bWwLT0XATjiY
         fAO0rqHuqYS7F09RfuW3UKcUK0Mv1ZCQA8TIiTgSFbKWNSoYCltaPbJdN+i0oOSaoh
         dV1gtJ6yHS7tw==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20230411152528.329803-1-rf@opensource.cirrus.com>
References: <20230411152528.329803-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/6] ASoC: cs35l56: Add system suspend handling
Message-Id: <168132600593.137613.12135823880163549738.b4-ty@kernel.org>
Date:   Wed, 12 Apr 2023 20:00:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 16:25:22 +0100, Richard Fitzgerald wrote:
> This set of patches adds handling for system suspend.
> Patches 1..4 make some code changes that simplify the
> suspend implementation, mainly to avoid race conditions.
> 
> There are two seperate aspects to suspend, and these have
> been done as two patches:
> - the main suspend-resume handling,
> - re-loading the firmware if necessary after resume.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: cs35l56: Remove quick-cancelling of dsp_work()
      commit: 39a594dc0b4ac949edf221db33c7061c45e2c90b
[2/6] ASoC: cs35l56: Use DAPM widget for firmware PLAY/PAUSE
      commit: 7b98a1efbabfd729441f46823b24432f2c32deeb
[3/6] ASoC: cs35l56: Skip first init_completion wait in dsp_work if init_done
      commit: 7816e3407110d887726687740aa18c9ce8eeb0d2
[4/6] ASoC: cs35l56: Always wait for firmware boot in runtime-resume
      commit: f00abaddf0300bd9ca87918148a26bdb748129db
[5/6] ASoC: cs35l56: Add basic system suspend handling
      commit: f9dc6b875ec0a6a6d4091cd9603d193ec98c75a2
[6/6] ASoC: cs35l56: Re-patch firmware after system suspend
      commit: 59322d35179987e85b593e504fd334de8683c835

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

