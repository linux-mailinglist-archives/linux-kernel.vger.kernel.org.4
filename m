Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A602360CB68
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiJYL6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJYL6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:58:21 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF50318DD79;
        Tue, 25 Oct 2022 04:57:43 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1onIYs-000088-7U; Tue, 25 Oct 2022 13:57:38 +0200
Date:   Tue, 25 Oct 2022 12:57:35 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] pwm: mediatek: Add support for MT7986
Message-ID: <Y1fPLzwUz/E9C3I1@makrotopia.org>
References: <Y1K5ym1EL8kwzQEt@makrotopia.org>
 <b5ab84b4d595713588f1d8a68a1585ca3ae5521e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ab84b4d595713588f1d8a68a1585ca3ae5521e.camel@mediatek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 02:35:43PM +0800, Sam Shih wrote:
> Hi Daniel:
> 
> On Fri, 2022-10-21 at 16:24 +0100, Daniel Golle wrote:
> > Add support for PWM on MT7986 which has 2 PWM channels, one of them
> > is
> > typically used for a temperature controlled fan.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/pwm/pwm-mediatek.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index 6901a44dc428de..2219cba033e348 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -329,6 +329,12 @@ static const struct pwm_mediatek_of_data
> > mt8365_pwm_data = {
> >  	.has_ck_26m_sel = true,
> >  };
> >  
> > +static const struct pwm_mediatek_of_data mt7986_pwm_data = {
> > +	.num_pwms = 2,
> > +	.pwm45_fixup = false,
> > +	.has_ck_26m_sel = true,
> 
> For MT7986 SoC, I think the value of "has_ck_26m_sel" should be 'false'

That's a bit surprising, please explain why.

Reading the commit adding .has_ck_26m_sel field:
> commit 0c0ead76235db0bcfaab83f04db546995449d002
> Author: Fabien Parent <fparent@baylibre.com>
> Date:   Mon Oct 19 16:07:02 2020 +0200
> 
> pwm: mediatek: Always use bus clock
> 
> The MediaTek PWM IP can sometimes use the 26 MHz source clock to
> generate the PWM signal, but the driver currently assumes that we always
> use the PWM bus clock to generate the PWM signal.
> 
> This commit modifies the PWM driver in order to force the PWM IP to
> always use the bus clock as source clock.
> 
> I do not have the datasheet of all the MediaTek SoC, so I don't know if
> the register to choose the source clock is present in all the SoCs or
> only in subset. As a consequence I made this change optional by using a
> platform data paremeter to says whether this register is supported or
> not. On all the SoCs I don't have the datasheet (MT2712, MT7622, MT7623,
> MT7628, MT7629) I kept the behavior to be the same as before this
> change.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

From MT7986 datasheet:
> 0x10048210 PWM_CK_26M_SEL PWM BCLK Selection
> Reset value 0x00000001
> Description
> 0: Select bus CLK as BCLK
> 1: Select 26M fix CLK as BCLK

So after reset, the 26M clock is selected by default.

In pwm-mediatek.c I read:
> #define PWM_CK_26M_SEL          0x210
> ...
>         /* Make sure we use the bus clock and not the 26MHz clock */
>         if (pc->soc->has_ck_26m_sel)
>                 writel(0, pc->regs + PWM_CK_26M_SEL);

So this PWM_CK_26M_SEL register does exist on MT7986 and has the
same address as expected by the driver ($PWM_BASE + 0x210).
The default value selected after reset (0x00000001) matches the
problem and solution described in the commit description
"pwm: mediatek: Always use bus clock".

Sidenode: I've tried with both, .has_ck_26m_sel = true as well as
.has_ck_26m_sel = false. Both do work, but the behavior is slightly
different, again matching the commit description above.

> 
> > +};
> > +
> >  static const struct pwm_mediatek_of_data mt8516_pwm_data = {
> >  	.num_pwms = 5,
> >  	.pwm45_fixup = false,
> > @@ -342,6 +348,7 @@ static const struct of_device_id
> > pwm_mediatek_of_match[] = {
> >  	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data
> > },
> >  	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data
> > },
> >  	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data
> > },
> > +	{ .compatible = "mediatek,mt7986-pwm", .data = &mt7986_pwm_data
> > },
> >  	{ .compatible = "mediatek,mt8183-pwm", .data = &mt8183_pwm_data
> > },
> >  	{ .compatible = "mediatek,mt8365-pwm", .data = &mt8365_pwm_data
> > },
> >  	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data
> > },
> 
> Regards,
> Sam
> 
