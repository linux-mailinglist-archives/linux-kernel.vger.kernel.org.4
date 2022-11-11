Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B394C62628E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiKKUJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiKKUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:09:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4CF4D5C1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19DD5B8260C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 20:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E74C4347C;
        Fri, 11 Nov 2022 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668197385;
        bh=ldAYlErMXxSDvX7PgibGsmXAVUAab9FUHEviKO69Pww=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TvAzMBvw+7pqMaw76pvdDAJFa8J14riKoIBBcuULFCuDgcHMntPeQNaHi1/vuZxpo
         dGHDkc90IsyrIAM/yBdmXAXoalY23d5KREt2KGKnyo6vylFEs2h8Cjo3lyAjoXYwzm
         2TRrH6nshedPE+VLx20LQ1yBEGwooiFbqXe+Ye68v2+r2QIDxbCKO9nXEHUiIQYA5e
         kfe58LFa0yQTcoMTne92EKcweqN2wEJqEnpXswX1HQLIIKKRHLMj3ZckXkcUtcAiJs
         1Y82te4gDFRW/dEtstkk9VX9wpsYRKr2JO1c2t78g0WpiDxdwvFl+4mHy8X9yu5wvN
         er0azwE47Y0Xw==
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel test robot <lkp@intel.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20221108001829.5100-1-rdunlap@infradead.org>
References: <20221108001829.5100-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] ASoC: codecs: wsa883x: use correct header file
Message-Id: <166819738332.635730.5845715184483403230.b4-ty@kernel.org>
Date:   Fri, 11 Nov 2022 20:09:43 +0000
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

On Mon, 7 Nov 2022 16:18:29 -0800, Randy Dunlap wrote:
> Fix build errors when GPIOLIB is not set/enabled:
> 
> ../sound/soc/codecs/wsa883x.c: In function 'wsa883x_probe':
> ../sound/soc/codecs/wsa883x.c:1394:25: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
>          wsa883x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
> ../sound/soc/codecs/wsa883x.c:1395:49: error: 'GPIOD_FLAGS_BIT_NONEXCLUSIVE' undeclared (first use in this function)
>          GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> ../sound/soc/codecs/wsa883x.c:1414:9: error: implicit declaration of function 'gpiod_direction_output'; did you mean 'gpio_direction_output'? [-Werror=implicit-function-declaration]
>          gpiod_direction_output(wsa883x->sd_n, 1);
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa883x: use correct header file
      commit: 5f52ceddc40cd61b1dd2ecf735624deaf05f779f

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
