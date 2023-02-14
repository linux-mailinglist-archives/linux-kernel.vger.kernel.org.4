Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37BD696C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjBNSB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjBNSBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:01:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6768A2E0D4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:01:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A230B81E96
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A228AC433D2;
        Tue, 14 Feb 2023 18:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676397709;
        bh=34Nen5m82Ih5JAA2jFki5nFMtCWBQprb7z0xjZpbw0U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eezYBiv1MXt1L3ERpQTVuTfDqimOqvfrVnfHMSV2RvSb3ibvEqO7EzXysP5n8m84G
         ya7oY0ndAThsRPkTf7wX9T0qI+uAujdxE6moVP0Ajo+pSKsTQxyOzmqohKN25u484C
         QoLmyjsRsGgJg78u+r421MWqMgvda4WeAaGICkWur1TO/e+cPzYu+HVmQv3gUzc3Tn
         pLWg87hWWKuH0b5x2AKoXqhp8Ht9waSv4Xqb/5+OXHjBic2SUS4bW3je6QhOHqW81O
         /wt65NCDWNtslA7eJQM2li/tnRqCfbJddhZYfIoGOv3sVFkDBVmyeuYnJB+IPmqMyP
         +0iGgNc67K2CA==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     alsa-devel@alsa-project.org,
        Douglas Anderson <dianders@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230209012002.1.Ib4d6481f1d38a6e7b8c9e04913c02ca88c216cf6@changeid>
References: <20230209012002.1.Ib4d6481f1d38a6e7b8c9e04913c02ca88c216cf6@changeid>
Subject: Re: [PATCH] SoC: rt5682s: Disable jack detection interrupt during
 suspend
Message-Id: <167639770737.3067697.4910964647967248815.b4-ty@kernel.org>
Date:   Tue, 14 Feb 2023 18:01:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Feb 2023 01:20:23 +0000, Matthias Kaehlcke wrote:
> The rt5682s driver switches its regmap to cache-only when the
> device suspends and back to regular mode on resume. When the
> jack detect interrupt fires rt5682s_irq() schedules the jack
> detect work. This can result in invalid reads from the regmap
> in cache-only mode if the work runs before the device has
> resumed:
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] SoC: rt5682s: Disable jack detection interrupt during suspend
      commit: f7d00a9be147d9c6feeb19591b39f8102f70cc45

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

