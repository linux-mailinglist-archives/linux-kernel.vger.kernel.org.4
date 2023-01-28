Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EE667F9C8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjA1RTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjA1RTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:19:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F12A99C;
        Sat, 28 Jan 2023 09:19:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 579C160C33;
        Sat, 28 Jan 2023 17:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DF1C4339C;
        Sat, 28 Jan 2023 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674926339;
        bh=Sf8e39xlrlBgctvAjNmyaVJ8lTKFI4W3ruclNnksOWQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qlXG48eQCOe3z8Urz+wDffxl9GdN0pgqSbrDxcIex7q6Hqmy33aeIetLf/n5jEiJF
         uans6w2v3EkhTjky0H+k3K2LM6E6k3q+j78XU1WgDlV9QSZzBhCpqg7wmYhjpZWRe0
         tg9RIYRlPcCP5vmdjYuxaTlzUxsCRixOwBvPXAX382RNGXYjsvY6OkLm4MfXYFJbRw
         RBl1/leHXfhzCzbYXtpns/ZQF7X8PaiidX1amryL0fV2afygTusdcpLbqpJVMT2Whc
         0oZ5otwv8jNpNqz19KyoWx4cZLtHJKMbGOwUWdJ/cQyetJ7dwGllEZudVZlcE0EOq4
         ERourzK8scoyg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20230127224128.never.410-kees@kernel.org>
References: <20230127224128.never.410-kees@kernel.org>
Subject: Re: [PATCH] ASoC: kirkwood: Iterate over array indexes instead of
 using pointer math
Message-Id: <167492633694.2479102.1677977069431569775.b4-ty@kernel.org>
Date:   Sat, 28 Jan 2023 17:18:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 14:41:29 -0800, Kees Cook wrote:
> Walking the dram->cs array was seen as accesses beyond the first array
> item by the compiler. Instead, use the array index directly. This allows
> for run-time bounds checking under CONFIG_UBSAN_BOUNDS as well. Seen
> with GCC 13 with -fstrict-flex-arrays:
> 
> ../sound/soc/kirkwood/kirkwood-dma.c: In function
> 'kirkwood_dma_conf_mbus_windows.constprop':
> ../sound/soc/kirkwood/kirkwood-dma.c:90:24: warning: array subscript 0 is outside array bounds of 'const struct mbus_dram_window[0]' [-Warray-bounds=]
>    90 |                 if ((cs->base & 0xffff0000) < (dma & 0xffff0000)) {
>       |                      ~~^~~~~~
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: kirkwood: Iterate over array indexes instead of using pointer math
      commit: b3bcedc0402fcdc5c8624c433562d9d1882749d8

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

