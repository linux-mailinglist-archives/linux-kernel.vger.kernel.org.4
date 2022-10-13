Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5865FDB31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJMNly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJMNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:41:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD313DD6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C128AB81E23
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5739C433C1;
        Thu, 13 Oct 2022 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665668503;
        bh=5RucPzasjZAZP0l3hS+Jt8c2WIjoMrxKXDryqmzXx3c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ioMqYGsMebFmkTKp3SgC+rTybO58zD6GQD+jrSCOCoC4zYMZADhKzyN43eCWrv7to
         gaTYpDCm1KIKqqao/un9wCgI7AvHLLK57VH+xBVF//iwKpG2Z7xz2zE7vQlunAADab
         psfewraMVlW1271JEkLpWf+dOofyiALWlt6vd6VtFTBy16E+AqvV9B5tqs3sg7VAnI
         Ur63JSJ1fbBM5K2sL6w8vFFlMPoVmx7zUjZfa+1e3F8pAytazNLLKFb9+AVIyabCZB
         BiZwndbQuaUt0cfTA2LOpNYLKU7FyWeT7SmMDI4q74bToJdWdKF9STlRsSZNrIVXM2
         Qnl8snXE+ibmw==
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ricard Wanderlof <ricardw@axis.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20221006235822.30074-1-rdunlap@infradead.org>
References: <20221006235822.30074-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] ASoC: codec: tlv320adc3xxx: add GPIOLIB dependency
Message-Id: <166566850165.143340.13619454921265513543.b4-ty@kernel.org>
Date:   Thu, 13 Oct 2022 14:41:41 +0100
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

On Thu, 6 Oct 2022 16:58:22 -0700, Randy Dunlap wrote:
> Fix build errors when CONFIG_GPIOLIB is not enabled:
> 
> ../sound/soc/codecs/tlv320adc3xxx.c: In function 'adc3xxx_i2c_probe':
> ../sound/soc/codecs/tlv320adc3xxx.c:1352:28: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
>  1352 |         adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> ../sound/soc/codecs/tlv320adc3xxx.c:1352:57: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
>  1352 |         adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>   CC      lib/dynamic_debug.o
> ../sound/soc/codecs/tlv320adc3xxx.c:1400:9: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
>  1400 |         gpiod_set_value_cansleep(adc3xxx->rst_pin, 1);
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: tlv320adc3xxx: add GPIOLIB dependency
      commit: 551f2994b8ccdbe296e239278531e345d6e94d4d

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
