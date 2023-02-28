Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933646A5E85
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjB1SBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjB1SBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:01:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F253A33461;
        Tue, 28 Feb 2023 10:00:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F88961048;
        Tue, 28 Feb 2023 18:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7776EC4339E;
        Tue, 28 Feb 2023 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677607243;
        bh=CtORROMymsMyJjQe4L+MRP/NQSor1pQ4vG0KnQv8Nu8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D+JDrM7FFnr/CvTJVGPeOgFY/29a3BcR0x84d8f0v6NZ17C+65XFbkz60WJZMJkEz
         wukmGW2QnBQK5LhuXGrv7SXN5XHH9Le6Az2gvntrB7mybr2Qr6FxgDnGRQu7TxEH6k
         +XMLlUo+/Adf6119+ddW2QeQde1D9LvD6d9NhIzDLSHAFHqadUaTJgqiK6u4k6yc1B
         ZAw4LvykSyyorog4Iy9WvSrrxueaM9coeMFBylf8bSp+BRhic7hFn8IpbiUiMIwuKG
         6iXccpgSoYn1R9yy+f2ka/CXNGSATfJrH00lBFkSjfwBNpRGjRYuQccMMd+7xAUSQb
         mlXIO8jTlJm5A==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230228110145.3770525-1-claudiu.beznea@microchip.com>
References: <20230228110145.3770525-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v3 0/3] ASoC: mchp-pdmc: fix poc noises when starting
 capture
Message-Id: <167760724120.68866.4932993791399800136.b4-ty@kernel.org>
Date:   Tue, 28 Feb 2023 18:00:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 13:01:42 +0200, Claudiu Beznea wrote:
> To start capture on Microchip PDMC the enable bits for each supported
> microphone need to be set. After this bit is set the PDMC starts to
> receive data from microphones and it considers this data as valid data.
> Thus if microphones are not ready the PDMC captures anyway data from its
> lines. This data is interpreted by the human ear as poc noises.
> 
> To avoid this the following software workaround need to be applied when
> starting capture:
> 1/ enable PDMC channel
> 2/ wait 150ms
> 3/ execute 16 dummy reads from RHR
> 4/ clear interrupts
> 5/ enable interrupts
> 6/ enable DMA channel
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: soc-pcm: add option to start DMA after DAI
      commit: 54fc4b72b630e1cb92a21140084c6852babbb234
[2/3] ASoC: dt-bindings: sama7g5-pdmc: add microchip,startup-delay-us binding
      commit: 143a2f011c4471511887807822d3fd71f25f5169
[3/3] ASoC: mchp-pdmc: fix poc noise at capture startup
      commit: c5682e2ba1327d08987a7cabc7b5b40bf3bc131f

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

