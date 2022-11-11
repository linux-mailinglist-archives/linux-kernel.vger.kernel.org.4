Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59EC626037
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiKKRPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiKKRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:15:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFE43C6CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:15:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56A5EB8267A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A124AC433D7;
        Fri, 11 Nov 2022 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668186908;
        bh=sRrcqdhjs5tdOOy/Xr2UWVJV5Rz1PelJ/qkJs9nCdDA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=egwJvE1ao56OyeCS9vLRbCQMQIPeqe3PdeRlk5JqGZhCOOhU7yfdKkN2kAPKCgYcR
         +IhINWqoF6KOwI7wKaGBttKzi/tGKXhrDbNhcQFt8hVjFkqYFXd687LLUV5zZCQ8eA
         c905apaWAldHEu7OgiVMev0rDjuAi5qQ2SUQaIsCx8r7NwAHJ4l7WGe/if28H3CHTY
         /qevDGUcIAWWbbPPFkIIMHSoY2Pgsnk5s+nxdHxYP/mqaDcAE60jvdvkpYZzYjNadc
         SAMaSLwCALeT0Vw8fn8uCI3dDjyQ1YeCEvNsPKmRq0FlDFd6iRvTWxse8puwdBaqGy
         2I3ir/RiwBQ9w==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     misael.lopez@ti.com, bcousson@baylibre.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        fparent@baylibre.com, linux-kernel@vger.kernel.org
In-Reply-To: <20221104132213.121847-1-rf@opensource.cirrus.com>
References: <20221104132213.121847-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Don't zero TDM masks in __soc_pcm_open()
Message-Id: <166818690633.487154.17424502068366763517.b4-ty@kernel.org>
Date:   Fri, 11 Nov 2022 17:15:06 +0000
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

On Fri, 4 Nov 2022 13:22:13 +0000, Richard Fitzgerald wrote:
> The DAI tx_mask and rx_mask are set by snd_soc_dai_set_tdm_slot()
> and used by later code that depends on the TDM settings. So
> __soc_pcm_open() should not be obliterating those mask values.
> 
> The code in __soc_pcm_hw_params() uses these masks to calculate the
> active channels so that only the AIF_IN/AIF_OUT widgets for the
> active TDM slots are enabled. The zeroing of the masks in
> __soc_pcm_open() disables this functionality so all AIF widgets
> were enabled even for channels that are not assigned to a TDM slot.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm: Don't zero TDM masks in __soc_pcm_open()
      commit: 39bd801d6908900e9ab0cdc2655150f95ddd4f1a

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
