Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A615716DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjE3Tm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjE3Tmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842DA10D;
        Tue, 30 May 2023 12:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E4C2630C9;
        Tue, 30 May 2023 19:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2055C433EF;
        Tue, 30 May 2023 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685475733;
        bh=C/ZCDt9dxkFqBdenxsotP/gQkEWd0TJC2yhywFPrxlU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=K93thLG6dvDqETIhFEajld3t2N4JSaO+9Xro4KcquZXq1aN8xBW+sXicFMELWgaLN
         pH7eC573JWpTDi9D957EgYNr4EObZ099H9tylABVhlNPWiginmSVtQalMUMe7LzTSg
         B+My6btPtnLo87e2Akm6IJ4pUY5VJ7eWcfWTemfBXPUkOKZUb+uzyjw5+5yZdIgVrq
         x9X35u5rfa/oLL3HeFZY9F3/sj2eOg3MarOTrLMKtgJFhyW3oSNdhqpR80NrGqe2Md
         0Olhr1iNLouKS4XBHXt74Mw4/0YZWyVOU/f7YG+9R5Zo8OoYcVIdLUP997A/59oh4H
         54LZ17CBqO6AQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Ning <zhuning0077@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@collabora.com
In-Reply-To: <20230530181140.483936-1-cristian.ciocaltea@collabora.com>
References: <20230530181140.483936-1-cristian.ciocaltea@collabora.com>
Subject: Re: (subset) [PATCH v2 0/3] ES8316 audio codec fixes on Rock5B
Message-Id: <168547572955.1446927.6113726229906083649.b4-ty@kernel.org>
Date:   Tue, 30 May 2023 20:42:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 21:11:37 +0300, Cristian Ciocaltea wrote:
> This patch series handles a few issues related to the ES8316 audio
> codec, discovered while doing some testing on the Rock 5B board.
> 
> Changes in v2:
>  - Preserved original dB gain range in PATCH 1
>  - Rewrote PATCH 2 conditional statement, per Mark's review
>  - Rebased series onto next-20230530
>  - v1: https://lore.kernel.org/all/20230524074156.147387-1-cristian.ciocaltea@collabora.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: es8316: Increment max value for ALC Capture Target Volume control
      commit: 6f073429037cd79d7311cd8236311c53f5ea8f01
[2/3] ASoC: es8316: Do not set rate constraints for unsupported MCLKs
      commit: 60413129ee2b38a80347489270af7f6e1c1de4d0

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

