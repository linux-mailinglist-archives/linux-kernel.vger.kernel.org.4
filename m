Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4523D7440DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjF3RHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjF3RHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:07:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D21B0;
        Fri, 30 Jun 2023 10:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71616617C5;
        Fri, 30 Jun 2023 17:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F0AC433C9;
        Fri, 30 Jun 2023 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688144865;
        bh=mCCqTczvbpDnqWTAvLPO/6kWxxjHeQDe26aZLtloYdE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UM4iaIMNjeGFHSr6jpk65rhBWYTWOBGR9ga+vIaTLbDwgbBLIS7zZHW+6IUdDu2YE
         Hli3gQlcyH6RGMyGTETWeh7ViiIPrETDFBDcz93hKpwcXwtulf3S6/1FwCjpTl/L7o
         m8HWagxcqZzoL2XNxBkE7FggT0+MfFitq5vBAfTPEVg7/Y9MU43iU025uu/X4rTJZM
         n3ecGBMeSR/VLeWdlxbCF6xAtRuGgc/rCbWUUGav694pIwR9ZOj9I6jUZ3j/6Vs8tL
         NS+xyMr9/4McfRMoGF6q2OjWhlddMXgs83dyl01jAGiEZ8fQINJwsbG5PuhXFXmopM
         Iluq0yWQoX3cg==
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20230630120318.6571-1-johan+linaro@kernel.org>
References: <20230630120318.6571-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix codec initialisation race
Message-Id: <168814486382.50974.15112012461000088627.b4-ty@kernel.org>
Date:   Fri, 30 Jun 2023 18:07:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 14:03:18 +0200, Johan Hovold wrote:
> Make sure to resume the codec and soundwire device before trying to read
> the codec variant and configure the device during component probe.
> 
> This specifically avoids interpreting (a masked and shifted) -EBUSY
> errno as the variant:
> 
> 	wcd938x_codec audio-codec: ASoC: error at soc_component_read_no_lock on audio-codec for register: [0x000034b0] -16
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: fix codec initialisation race
      commit: 85a61b1ce461a3f62f1019e5e6423c393c542bff

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

