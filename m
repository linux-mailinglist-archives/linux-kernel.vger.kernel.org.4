Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2185BD7E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiISXLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiISXLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C8A399CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:10:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1EBC620DA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEA3C433D6;
        Mon, 19 Sep 2022 23:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663629048;
        bh=cBqstNirVp3/LMuUXyvejfY8+hDyu9PM9y6tIN40Ns8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W8/NtMe9xnaROAp8gN8JdYtjSBMspTUF946nQawzwiMcwyDXI9gLP0NiKs8ZqL34b
         MBKiNnKZ/AT/CaDMjMqtb1MC7Dxz/mdodgJDB18yUBcHL93cf5mShwNoaR/0jx2inG
         s2vF+zxmCCesL8tgK8B9VPdlnTW+8bfNPI2N7oarlnw7v/QMaXsm0isK9LemyrI19H
         COWv4fqk3i7sAT7BSTMGX1OcKcmvXr57FWA+Bgzz+f2mhN5CnuKO0E6pixAyE9Ert7
         Pzt9ffOlj5YySWpMBlez7e+oSCFeHjiZEmHYSEnCFTUVN5k+UbFSlMnWPBUGjjS7ef
         6ietrQW7ZgPIg==
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Li Chen <lchen@ambarella.com>, Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220913212256.151799-1-mike.rudenko@gmail.com>
References: <YyCqC2EypxnoJFk7@sirena.org.uk> <20220913212256.151799-1-mike.rudenko@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: sunxi: sun4i-codec: silence misleading error in probe
Message-Id: <166362904468.3419825.3057946964587586588.b4-ty@kernel.org>
Date:   Tue, 20 Sep 2022 00:10:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 00:22:54 +0300, Mikhail Rudenko wrote:
> In the case when a codec device is probed before codec analog
> controls, snd_soc_register_card() returns -EPROBE_DEFER, resulting in
> a misleading error message
> 
>     sun4i-codec 1c22c00.codec: Failed to register our card
> 
> even if the device is probed successfully later. Use dev_err_probe()
> to demote the above error to a debug message.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: sunxi: sun4i-codec: silence misleading error in probe
      commit: 30248f618d30cf1ad9d5a72126799f2f0239860c
[2/2] ASoC: sunxi: sun4i-codec: set debugfs_prefix for CPU DAI component
      commit: 717a8ff20f32792d6a94f2883e771482c37d844b

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
