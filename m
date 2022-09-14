Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8906E5B8548
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiINJlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiINJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:40:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3236D3C148
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 79E42CE13B7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F57C433D6;
        Wed, 14 Sep 2022 09:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663148415;
        bh=NON4s+poYWHm0+VBJ/uGgY91L7qbBPDPpCAWUeFl1lQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=klEq28NYTOqDeVhY2NdGRM0PlDlswUR5qIWh+2AWYNxJdn7RcOBnjqEnUi+RONow2
         WFdL1AeUbgwrXcS9+mMNx8q1f1g6141YjXiX6e9j2Jke5BWWE5im8tT1lnwDpcgWNr
         vIkviUNK34/7W6Bs9WL/J/fcvEtrLgfMkyo9bINmuzWG0et2ddXfKCPUoFO+gxfLwy
         Nla7cSqNNS33XLMVlsOCja3hJdBRTMzKFN2W9dr8L28gXBvD8JqGc6GBJrT5kl12RO
         f51sJmQjqJENyb2tDNlhOA4Yq8hCq69MRPZhSiiPNs6zkhhkb4SHaItJNRGF+BF8xV
         cvuHCLGYiSV0g==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220911145713.55199-1-mike.rudenko@gmail.com>
References: <20220911145713.55199-1-mike.rudenko@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: sunxi: sun4i-codec: silence misleading error in probe
Message-Id: <166314841203.314266.13063838088895693930.b4-ty@kernel.org>
Date:   Wed, 14 Sep 2022 10:40:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2022 17:57:11 +0300, Mikhail Rudenko wrote:
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
      (no commit info)

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
