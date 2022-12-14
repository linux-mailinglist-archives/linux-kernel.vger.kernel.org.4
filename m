Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B8764CB61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiLNNch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiLNNcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:32:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194672529D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:32:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE201B81626
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF190C433F1;
        Wed, 14 Dec 2022 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671024721;
        bh=Gjncl+uo/rvrBzyT+YEpr2GJ5y0nLCp+mO+ilIuCaAM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nfp3a0NLHLUAjc1NYIewzZlt2nv824P+0xzuyMxDNHJLSKUnIcnKeNBkHO360CFva
         GlsBQjlGqIJd8hmM/ZbYEFRgUVoJp9UeGkMAUcn6po5UYLffIvScwdYKq1dvx/6Hky
         D3CJXzf+7W8YBT8g/IYmEUj/jaIjbDQE6OY5BzYtqp8sKeJvs2fTYKirU+HaBPskxj
         jUf1UehVoaNMsPjWWh4AkrBJ68UuG6bZyD0tOCAGKT6gfmmA6qKGjHwzzSE5ohFeDr
         /CzST+k5zVfpLerbExy/gS5xMCDe2HMoywbEKa5uC78tJTf7Rm7NxLCy05gPe1JmcC
         aFWKDJWftpl+w==
From:   Mark Brown <broonie@kernel.org>
To:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20221209091657.1183-1-m.szyprowski@samsung.com>
References: =?utf-8?q?=3CCGME20221209091928eucas1p1cfc768d888a6e6c57fcaa0fe3?=
 =?utf-8?q?20cfced=40eucas1p1=2Esamsung=2Ecom=3E?=
 <20221209091657.1183-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH] ASoC: wm8994: Fix potential deadlock
Message-Id: <167102471963.27755.7459442612107772910.b4-ty@kernel.org>
Date:   Wed, 14 Dec 2022 13:31:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-7e003
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Dec 2022 10:16:57 +0100, Marek Szyprowski wrote:
> Fix this by dropping wm8994->accdet_lock while calling
> cancel_delayed_work_sync(&wm8994->mic_work) in wm1811_jackdet_irq().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8994: Fix potential deadlock
      commit: 9529dc167ffcdfd201b9f0eda71015f174095f7e

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
