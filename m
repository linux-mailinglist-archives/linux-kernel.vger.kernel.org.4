Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D516B0D38
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCHPpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjCHPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:44:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AECF7AA7;
        Wed,  8 Mar 2023 07:43:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3075160FCF;
        Wed,  8 Mar 2023 15:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B33C433EF;
        Wed,  8 Mar 2023 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678290208;
        bh=kYutHpejNtmmeokplIU5qESykQhQfmRXB0B3UcVHJ/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTEH+9+A2VlNt/UDNUfumfNn78n4Ayb3ttC8+3prI+UMqUH008tp6mbaFrNOs/srD
         L1ZAJ/t4+FGpDhT0uxetSddfLKNg2ESCG1ofsXlnnUoERbqSc72SIrgZx3pPPF7uuN
         oEoNQrrCXRczlB4Pj61yTWNqjNHnLvd/m9JjeT+w=
Date:   Wed, 8 Mar 2023 16:43:25 +0100
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
Message-ID: <ZAitHYRCUHsIvZMk@kroah.com>
References: <20230123160615.375969-1-angelogioacchino.delregno@collabora.com>
 <06918fde-64ea-37b2-da1a-1c8316457223@collabora.com>
 <06909bd8-3da2-1cf0-82ac-3ed4f3e63def@collabora.com>
 <ZAigsHAgqkLlBD1y@kroah.com>
 <28142704-d82d-d533-d2a8-b1061182f1f6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28142704-d82d-d533-d2a8-b1061182f1f6@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 03:55:59PM +0100, AngeloGioacchino Del Regno wrote:
> Il 08/03/23 15:50, Greg Kroah-Hartman ha scritto:
> > On Wed, Mar 08, 2023 at 12:46:07PM +0100, AngeloGioacchino Del Regno wrote:
> > > Il 23/02/23 15:16, AngeloGioacchino Del Regno ha scritto:
> > > > Il 23/01/23 17:06, AngeloGioacchino Del Regno ha scritto:
> > > > > Since the pwm-mtk-disp driver was fixed to get PWM_EN state from the
> > > > > right register, an old two-wrongs-make-one-right issue emerged: as a
> > > > > result, MT8192 Asurada Spherion got no backlight at boot unless a
> > > > > suspend/resume cycle was performed.
> > > > > Also, the backlight would sometimes not get updated with the requested
> > > > > value, requiring the user to change it back and forth until it worked.
> > > > > 
> > > > > This series fixes both of the aforementioned issues found on MT8192.
> > > > > 
> > > > > AngeloGioacchino Del Regno (2):
> > > > >     pwm: mtk-disp: Disable shadow registers before setting backlight
> > > > >       values
> > > > >     pwm: mtk-disp: Configure double buffering before reading in
> > > > >       .get_state()
> > > > > 
> > > > >    drivers/pwm/pwm-mtk-disp.c | 34 +++++++++++++++++++++++-----------
> > > > >    1 file changed, 23 insertions(+), 11 deletions(-)
> > > > > 
> > > > 
> > > > Gentle ping for this one: this is fixing backlight issues on multiple MediaTek
> > > > SoCs and was well tested.
> > > > 
> > > > Thanks,
> > > > Angelo
> > > 
> > > Since this series was sent more than one month ago, and since this fixes broken
> > > backlight on a number of Chromebooks with MT8183 and MT8192 SoCs, and seen the
> > > urgency of getting these fixes in, I'm adding Greg to the loop.
> > 
> > $ ./scripts/get_maintainer.pl drivers/pwm/pwm-mtk-disp.c
> > Thierry Reding <thierry.reding@gmail.com> (maintainer:PWM SUBSYSTEM)
> > "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de> (reviewer:PWM SUBSYSTEM)
> > Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC support)
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> (reviewer:ARM/Mediatek SoC support)
> > linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM)
> > linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support)
> > linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
> > linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
> > 
> > I don't see my name in there, did I become the PWM maintainer somehow?
> > 
> > What's wrong with Thierry taking this like normal?
> > 
> 
> Nothing wrong with that. I felt like this series got ignored as I've never
> received any reply from Thierry, even though it's a Fixes series that I deem
> to be moderately urgent; that's why I added you to the loop.

Then ask Thierry and Uwe, what would you want to have happen if you were
the maintainer of a subsystem?

> If that created unnecessary noise, I'm extremely sorry and won't happen again.

Not noise, just confusion on my part.  I'm glad to take patches that
have no obvious maintainers, or maintainers that have disappeared, but
that doesn't seem to be the case here.

Also remember that we had the merge window, which is 2 weeks of us not
being able to take any new code at all, even for fixes.

And finally, to make it easier for your code to be accepted, please take
the time to review other's code for the subsystems you care about to
make the maintainer's load easier.  If you do that, you will often find
your patches getting faster response just by virtue of there being less
work to do on the subsystem overall.  Why not do that right now to help
out with other PWM patches?

thanks,

greg k-h
