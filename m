Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71ED73ADEF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjFWAth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFWAtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:49:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A52105
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEBAF6192B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 00:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F266C433C8;
        Fri, 23 Jun 2023 00:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687481373;
        bh=OSob7AZNa0yiovatn5YGZLvbuyg9+sUnjPVSOCgqHwU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BDdAcJ6/JgVlkYa0dB1TVJmiuf1ww4imr0Y9xiAgN/kWoh7ntmNvo2mE4S0yiDvGK
         rXgXlP9Eb9aVlJdLSw3+YYLUs/qqHqsWnUJq3pV4+Ua06szKXPAgnzE1IjSbUCs+D6
         dybWgNuhF92ZIdux7qSr6g8DfkK1oyHU8/Etjkg034ggoTywusZO6tawqzQp+cigSM
         P81T/zEYVw7FsGHju+TmneuZUOa7OLHEoT7Osr9Afpi0Z5jDn47DWR6Cv5AdU4Mma8
         2PJ2Vw3uhyqRr2tKHm72uJ3NUph0fUN3neQQ8jLLmvdq/lV66ev+AZyRBxJmYbVvkD
         tdwPObq71sqEA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Shenghao Ding <13916275206@139.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230622101205.3180938-1-arnd@kernel.org>
References: <20230622101205.3180938-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: tas2781: fix Kconfig dependencies
Message-Id: <168748136977.337790.15740637969171393451.b4-ty@kernel.org>
Date:   Fri, 23 Jun 2023 01:49:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 12:11:23 +0200, Arnd Bergmann wrote:
> The new driver has two modules that both get enabled for build testing
> when all codecs are selected. The comlib part has an i2c dependency,
> so this remains disabled on builds without i2c, but then the other
> one fails to link:
> 
> ERROR: modpost: "tasdevice_dev_bulk_write" [sound/soc/codecs/snd-soc-tas2781-fmwlib.ko] undefined!
> ERROR: modpost: "tasdevice_dev_update_bits" [sound/soc/codecs/snd-soc-tas2781-fmwlib.ko] undefined!
> ERROR: modpost: "tasdevice_dev_bulk_read" [sound/soc/codecs/snd-soc-tas2781-fmwlib.ko] undefined!
> ERROR: modpost: "tasdevice_dev_read" [sound/soc/codecs/snd-soc-tas2781-fmwlib.ko] undefined!
> ERROR: modpost: "tasdevice_dev_write" [sound/soc/codecs/snd-soc-tas2781-fmwlib.ko] undefined!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: fix Kconfig dependencies
      commit: fcb66ee8d16aa0f88efcc9cb41083c0412e9db8a

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

