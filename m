Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69B63F188
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiLANYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiLANYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:24:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3387A895C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:24:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7130BB81F46
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCCEC433C1;
        Thu,  1 Dec 2022 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669901069;
        bh=AMDMfVNL3QllttuNsq6hMXAwaGbTMCAQCAHdWUroH0I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nTWQvP8gql5krlZmsLlgw/IJHo8p3/ibFeb4DjFeHrw40aa0os0/AtLRzwVWuP9F/
         TaWpl9LfnMUSXyWk/uD9eBM9Y78NNUn6l/IJ12cKGrrkM9ijBOWwkCXAA//SWRU3DO
         FV/26SS8UQrTjHOoTu+m/IwECxJiT4qRY+TbNs6koM8aS1D7zMUCgMTGrncopEqkpf
         B3S2OInvPxlWKKFEVjKnmYqtTqdm8WfuMMjTPMTesYK7wpq1A4+fVoQiDH3I+iIjSK
         lZWoeruenQ5Bu2CX+YPwUqgZH85Hcq3OIPghnhotxu8f+TjMgomK3FLM5LvJ6zKy7C
         /sPZHoIvMGlGw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rui Zhang <zr.zhang@vivo.com>
Cc:     kernel@vivo.com
In-Reply-To: <20221122103251.13064-1-zr.zhang@vivo.com>
References: <20221122103251.13064-1-zr.zhang@vivo.com>
Subject: Re: [PATCH] regulator: core: fix use_count leakage when handling boot-on
Message-Id: <166990106807.78829.5258698655691570775.b4-ty@kernel.org>
Date:   Thu, 01 Dec 2022 13:24:28 +0000
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

On Tue, 22 Nov 2022 18:32:51 +0800, Rui Zhang wrote:
> I found a use_count leakage towards supply regulator of rdev with
> boot-on option.
> 
> ┌───────────────────┐           ┌───────────────────┐
> │  regulator_dev A  │           │  regulator_dev B  │
> │     (boot-on)     │           │     (boot-on)     │
> │    use_count=0    │◀──supply──│    use_count=1    │
> │                   │           │                   │
> └───────────────────┘           └───────────────────┘
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: fix use_count leakage when handling boot-on
      commit: 0591b14ce0398125439c759f889647369aa616a0

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
