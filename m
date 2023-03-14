Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C478E6B98B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjCNPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjCNPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B2AF2BE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35D0A617E0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37261C4339B;
        Tue, 14 Mar 2023 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678806752;
        bh=HYGfl2nv/L/zNAt09zcNi7tEiIXFZVfStqNB2ZQJs78=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=s/E/MIf0GLDV6n+oz0kIR4lHk3t8lSPBjj87apXdPREeNbyogHtT3tC2i9+gVWANR
         MUM4dcrHVynn3BLeiYhm2GZF/Dc3rVz3GB34q9QE9QPZLC5llfrkA5J7cxLZ/M+PmZ
         tcIRFGHfId0VYJEmPf0/gSlM/6OWSE5DBV2M/vcPs9n2h+gDeknKNmYCRmu6bSQlYq
         rjlPxtR2VSQN+YG6/L+g6h/n5kHnR3oJkAu4yQERrJjc1QL/ZKZJ1w1jxGP+D+PpuJ
         D0ViDzm836zkXso3N5AJQSW58aSdN3o0B1MkVeaTefjNUrl79SvMxXbD8GnaiWtx5H
         fgHDDuKywK98Q==
From:   Mark Brown <broonie@kernel.org>
To:     shengjiu.wang@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1678346017-3660-1-git-send-email-shengjiu.wang@nxp.com>
References: <1678346017-3660-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: soc-pcm: fix hw->formats cleared by
 soc_pcm_hw_init() for dpcm
Message-Id: <167880675094.43040.10172504832541716184.b4-ty@kernel.org>
Date:   Tue, 14 Mar 2023 15:12:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2023 15:13:37 +0800, Shengjiu Wang wrote:
> The hw->formats may be set by snd_dmaengine_pcm_refine_runtime_hwparams()
> in component's startup()/open(), but soc_pcm_hw_init() will init
> hw->formats in dpcm_runtime_setup_fe() after component's startup()/open(),
> which causes the valuable hw->formats to be cleared.
> 
> So need to store the hw->formats before initialization, then restore
> it after initialization.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm: fix hw->formats cleared by soc_pcm_hw_init() for dpcm
      commit: 083a25b18d6ad9f1f540e629909aa3eaaaf01823

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

