Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E279E6B0BDD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjCHOvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCHOvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:51:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9C9B744;
        Wed,  8 Mar 2023 06:50:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE8C8B81D17;
        Wed,  8 Mar 2023 14:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ABAC433EF;
        Wed,  8 Mar 2023 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678287029;
        bh=k9CLjWy5LWSWIB8cQjG++VGjuzyrJmcSHzOfzGCShqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TntO7ahg63zljF8Crhsm2K5w+vTvTTXZqa9CQWD0fz28JGAVrwfPJYpl83vsj4Uy3
         7zzBuqM2MIDnOmgvp1nztTy3gGMdeNaPZ2D1r+cAEghYw1R2iP2TSML3+tk6EtbtF4
         UvN4LzpBPIi0ExCW15UCqCUsztrAbZjP4Y7o/nwk=
Date:   Wed, 8 Mar 2023 15:50:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        matthias.bgg@gmail.com, weiqing.kong@mediatek.com,
        jitao.shi@mediatek.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 0/2] pwm: mtk-disp: Fix backlight configuration at boot
Message-ID: <ZAigsHAgqkLlBD1y@kroah.com>
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
 <06918fde-64ea-37b2-da1a-1c8316457223@collabora.com>
 <06909bd8-3da2-1cf0-82ac-3ed4f3e63def@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06909bd8-3da2-1cf0-82ac-3ed4f3e63def@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 12:46:07PM +0100, AngeloGioacchino Del Regno wrote:
> Il 23/02/23 15:16, AngeloGioacchino Del Regno ha scritto:
> > Il 23/01/23 17:06, AngeloGioacchino Del Regno ha scritto:
> > > Since the pwm-mtk-disp driver was fixed to get PWM_EN state from the
> > > right register, an old two-wrongs-make-one-right issue emerged: as a
> > > result, MT8192 Asurada Spherion got no backlight at boot unless a
> > > suspend/resume cycle was performed.
> > > Also, the backlight would sometimes not get updated with the requested
> > > value, requiring the user to change it back and forth until it worked.
> > > 
> > > This series fixes both of the aforementioned issues found on MT8192.
> > > 
> > > AngeloGioacchino Del Regno (2):
> > >    pwm: mtk-disp: Disable shadow registers before setting backlight
> > >      values
> > >    pwm: mtk-disp: Configure double buffering before reading in
> > >      .get_state()
> > > 
> > >   drivers/pwm/pwm-mtk-disp.c | 34 +++++++++++++++++++++++-----------
> > >   1 file changed, 23 insertions(+), 11 deletions(-)
> > > 
> > 
> > Gentle ping for this one: this is fixing backlight issues on multiple MediaTek
> > SoCs and was well tested.
> > 
> > Thanks,
> > Angelo
> 
> Since this series was sent more than one month ago, and since this fixes broken
> backlight on a number of Chromebooks with MT8183 and MT8192 SoCs, and seen the
> urgency of getting these fixes in, I'm adding Greg to the loop.

$ ./scripts/get_maintainer.pl drivers/pwm/pwm-mtk-disp.c
Thierry Reding <thierry.reding@gmail.com> (maintainer:PWM SUBSYSTEM)
"Uwe Kleine-König" <u.kleine-koenig@pengutronix.de> (reviewer:PWM SUBSYSTEM)
Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC support)
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> (reviewer:ARM/Mediatek SoC support)
linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM)
linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support)
linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)

I don't see my name in there, did I become the PWM maintainer somehow?

What's wrong with Thierry taking this like normal?

thanks,

greg k-h
