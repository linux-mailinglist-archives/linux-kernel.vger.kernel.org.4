Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46640702B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbjEOLKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241190AbjEOLJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:09:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A4172B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A29E16227B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A94DC4339B;
        Mon, 15 May 2023 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148985;
        bh=KEaOEqbRtYhzunYdC2/oNS4bINLreQCjokum/W9ombs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I8kWKmCNSXJxEyQqVg5SyQHpH0m6kt/oPeTkr5WHFdQibKL4IrlR3tVsoEkyccdS9
         8nrWB5hkWxU88g7ywkEs0FmweXvOOmYIrxmKx0nFNmwOmrGWISiXh4EWzwz/faVwZN
         8Bcu2ODWp6SpfNfFz9zecTt9GpgH4UsaeCfnPELleQ6vxk6U1USEF2iyPONES74/H4
         wGyixTNp+Qw561VRilHClaTznFAI7OnuwH6kKJpgsy0pNkR7ooAUHK3knKZuizycvL
         m2JM3R6KYK7mbf49YcYkNa1pgwjp7HKnNMin0wMojjXsIUxDcgv+q8clEc5dCZ4k9F
         ddeTkSqy3XADA==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20230511092437.1.I31cceffc8c45bb1af16eb613e197b3df92cdc19e@changeid>
References: <20230511092437.1.I31cceffc8c45bb1af16eb613e197b3df92cdc19e@changeid>
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Fix use-after-free in driver
 remove path
Message-Id: <168414898289.394037.12962945078412931473.b4-ty@kernel.org>
Date:   Mon, 15 May 2023 20:09:42 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 09:25:12 -0700, Douglas Anderson wrote:
> When devm runs function in the "remove" path for a device it runs them
> in the reverse order. That means that if you have parts of your driver
> that aren't using devm or are using "roll your own" devm w/
> devm_add_action_or_reset() you need to keep that in mind.
> 
> The mt8186 audio driver didn't quite get this right. Specifically, in
> mt8186_init_clock() it called mt8186_audsys_clk_register() and then
> went on to call a bunch of other devm function. The caller of
> mt8186_init_clock() used devm_add_action_or_reset() to call
> mt8186_deinit_clock() but, because of the intervening devm functions,
> the order was wrong.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: Fix use-after-free in driver remove path
      commit: a93d2afd3f77a7331271a0f25c6a11003db69b3c

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

