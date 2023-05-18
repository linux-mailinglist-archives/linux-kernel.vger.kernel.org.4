Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3DE7086ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjERRbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjERRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:31:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D33410CF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AB7E60C82
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9E0C4339C;
        Thu, 18 May 2023 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431069;
        bh=WfV7ZgvpIey0LYxW06z/T5cWU/5jL9R1xH3vlu9ii8A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=az9TF+/KVLHKlYUouCys4Vph9kfks1mbLHq2Y5GlKi2+APOVJ4wnc28oUxZiY4uPj
         J/+Vj3YVtrBuwTUuLo/a3mVsLzY89KP3b4QNMmmc0QvliiMIr0sPWQkfrbVSzotDX8
         aKnajMuO4g40ohcFtvKHPh+DlYwflEXYZ3Ta9Qg0iiGaTEpu6S7OLOo1xnRZQ7uDAd
         QwXrZi5OU6Ukd86B94oRSxpEdJ4JsfTWC69VlYbTxXkvrAzsAQgT0HFFrYbf3B7Lr4
         7JheKv/0vSxWWKmmWs9u/mpNtWxPm1CgxDhds9QQ7SOYCcCeu/f5IsW5qtgeNg9N2Z
         Bl2LIHNWSoy+A==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Stephen Boyd <swboyd@chromium.org>, stable@kernel.org
In-Reply-To: <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
References: <20230516164629.1.Ibf79e94b3442eecc0054d2b478779cc512d967fc@changeid>
Subject: Re: [PATCH] SoC: rt5682: Disable jack detection interrupt during
 suspend
Message-Id: <168443106667.480335.17640741139485759385.b4-ty@kernel.org>
Date:   Fri, 19 May 2023 02:31:06 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 16:46:30 +0000, Matthias Kaehlcke wrote:
> The rt5682 driver switches its regmap to cache-only when the
> device suspends and back to regular mode on resume. When the
> jack detect interrupt fires rt5682_irq() schedules the jack
> detect work. This can result in invalid reads from the regmap
> in cache-only mode if the work runs before the device has
> resumed:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] SoC: rt5682: Disable jack detection interrupt during suspend
      commit: 8b271370e963370703819bd9795a54d658071bed

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

