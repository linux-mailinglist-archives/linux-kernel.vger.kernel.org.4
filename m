Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738956C2022
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCTSkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjCTSkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E2434C07;
        Mon, 20 Mar 2023 11:32:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C00561796;
        Mon, 20 Mar 2023 18:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47034C4339E;
        Mon, 20 Mar 2023 18:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679337111;
        bh=1k2HdZd7GXcK9Rf8Iw4VOgSYsoDP5B0+bCp15WVe8Ss=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Tm7liQ/nAFkV3CyP8a5RNECtveLtuaotxTZ21TXsgIzjk1jw7OqCcVuv5NSZClLep
         A+YM+EoDWvAq/odu/8f8PeyGDE0GTZ7mII3jhBhwbOwFwfve8X9bPGiPxOZYoicIRJ
         20oCl/tDXbBYel8S0o+06wWKtlPcbSkhLyu5fEfx2owYwn11EaGWcMfhLn5S7E4/+M
         eqQBsPmIEofHdZei6aya7XgzWnYrNqKzbu9V9UWiKA/U6KKAnVB4hg8gyW270SN6hT
         105QGLl+bxcHLDrriY5dCPHD1av/R5D9e7OdcgqJJYlemAvgytJV6awT6gwaLTENb6
         zrw/M/zLSUxFA==
From:   Mark Brown <broonie@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
Subject: Re: (subset) [PATCH 00/11] Enable I2S support for RK3588/RK3588S
 SoCs
Message-Id: <167933710700.198283.8153226214101331490.b4-ty@kernel.org>
Date:   Mon, 20 Mar 2023 18:31:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 13:47:55 +0200, Cristian Ciocaltea wrote:
> There are five I2S/PCM/TDM controllers and two I2S/PCM controllers embedded
> in the RK3588 and RK3588S SoCs. Furthermore, RK3588 provides four additional
> I2S/PCM/TDM controllers.
> 
> This patch series adds the required device tree nodes to support all the above.
> 
> Additionally, it enables analog audio support for the Rock 5B SBC, which has
> been used to test both audio playback and recording.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[03/11] ASoC: dt-bindings: everest,es8316: Document audio graph port
        commit: 2f43ef99ac623b6d9154c26d4f6785df18b4d8e4
[04/11] ASoC: dt-bindings: rockchip: Document audio graph port
        commit: bf4062b7420d01b4fafd7211fd2dc68b916591bd
[05/11] ASoC: dt-bindings: rockchip: i2s-tdm: Document audio graph port
        commit: bfbae373c55e3b1c15a6ba656211dbbe7c390aa1
[06/11] ASoC: dt-bindings: rockchip: i2s-tdm: Document power-domains
        commit: 9971f3358338950d9d3345184fb2c0cfc6fc8552
[07/11] ASoC: dt-bindings: rockchip: Add compatible for RK3588
        commit: b0fe6a91fa9d5599ba3cace2748906e086c5a56e
[08/11] ASoC: rockchip: i2s: Add compatible for RK3588
        commit: 0e6c37610934e9b91f6f5f2599de5e2f1ab59e72

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

