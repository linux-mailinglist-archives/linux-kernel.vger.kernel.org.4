Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB266462EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLGVFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGVFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:05:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A5E5E3E6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 13:05:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E86CB82050
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 21:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2AEC433D7;
        Wed,  7 Dec 2022 21:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670447101;
        bh=ySSPPoq/swi2WcD6kgQKifwpywyuBetdwyVhpvcCEuc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Co9391eI+6Omj/U8d4PJXsrphkgH8y3rMt+I0NK97CbNqHv4KFHZl87uNJQSaNEhq
         xHeZLN9ZqTSZdHi0KB0OdHHuMckPEoyGhcRVg5enip8RfQTre1pb6rSbS3aT7FWV0f
         qTc4jsuKgXj9o2yeL5+HTttMxjT+rOA9wY/vc9YBUScvxP/0BPbWIeBUplGSNSDIVK
         LXxXuw+NDucRvCWc2FCChHxLOtrMfxZGrxTa1U9tyJ2+kmYqqavjLOoS8Mu0DJxfSL
         h8S7FwrQphAmCWPQ28L/LEMJN7x+2q7SwuhQiSplpiOfzv25cNmU0FBUqDz5b5b6tg
         svAHm2DGZobBQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20221128060950.3540845-1-chancel.liu@nxp.com>
References: <20221128060950.3540845-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: soc-pcm.c: Clear DAIs parameters after
 stream_active is updated
Message-Id: <167044709968.572887.4310845274377067555.b4-ty@kernel.org>
Date:   Wed, 07 Dec 2022 21:04:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-b77ec
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 14:09:50 +0800, Chancel Liu wrote:
> DAIs parameters should be cleared if there's no active stream. Before,
> we implemented it in soc_pcm_hw_free() by detecting stream_active. If
> the running stream is the last active stream, we're going to clear
> parameters.
> 
> However it will cause DAIs parameters never be cleared if there're
> more than one stream. For example, we have stream1 and stream2 about
> to stop. stream2 executes soc_pcm_hw_free() before stream1 executes
> soc_pcm_close(). At the moment, stream2 should clear DAIs parameters.
> Since stream_active is not yet updated by stream1 in soc_pcm_close(),
> stream2 will not clear DAIs parameters. In result both stream1 and
> stream2 don't clear the parameters.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm.c: Clear DAIs parameters after stream_active is updated
      commit: 1da681e52853f0abfbfff8c69833d31e538ff9c0

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
