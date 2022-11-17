Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8397262DDEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiKQOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbiKQOYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:24:34 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7EFD02;
        Thu, 17 Nov 2022 06:24:34 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ovfoW-0004mp-6f; Thu, 17 Nov 2022 15:24:24 +0100
Date:   Thu, 17 Nov 2022 14:23:02 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sam Shih <sam.shih@mediatek.com>, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] pwm: mediatek: Add support for MT7986
Message-ID: <Y3ZDxqLT3YdLzTiU@makrotopia.org>
References: <Y1K5ym1EL8kwzQEt@makrotopia.org>
 <b5ab84b4d595713588f1d8a68a1585ca3ae5521e.camel@mediatek.com>
 <20221117115624.t2kbwscxvkvffo7x@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117115624.t2kbwscxvkvffo7x@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:56:24PM +0100, Uwe Kleine-König wrote:
> On Tue, Oct 25, 2022 at 02:35:43PM +0800, Sam Shih wrote:
> > Hi Daniel:
> > 
> > On Fri, 2022-10-21 at 16:24 +0100, Daniel Golle wrote:
> > > Add support for PWM on MT7986 which has 2 PWM channels, one of them
> > > is
> > > typically used for a temperature controlled fan.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  drivers/pwm/pwm-mediatek.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > > index 6901a44dc428de..2219cba033e348 100644
> > > --- a/drivers/pwm/pwm-mediatek.c
> > > +++ b/drivers/pwm/pwm-mediatek.c
> > > @@ -329,6 +329,12 @@ static const struct pwm_mediatek_of_data
> > > mt8365_pwm_data = {
> > >  	.has_ck_26m_sel = true,
> > >  };
> > >  
> > > +static const struct pwm_mediatek_of_data mt7986_pwm_data = {
> > > +	.num_pwms = 2,
> > > +	.pwm45_fixup = false,
> > > +	.has_ck_26m_sel = true,
> > 
> > For MT7986 SoC, I think the value of "has_ck_26m_sel" should be 'false' 
> 
> The status of the discussion isn't clear to me. You didn't visibly agree
> which value is right now. Will there be a v2 of this patch? Or is it
> expected to be picked up as is.

The patch has been tested thoroughly and works well as-is.
The CK_26M_SEL register does exist on MT7986 and, at least according to
the datasheet[1], is set to the wrong value (selecting 26M clock) on
reset (but probably then already set to 0 to select the bus clock, e.g.
by the bootloader). So in the worst case, this is a no-op.

[1]: MT7986 Reference Manual, version 1.0 released 2022-05-29, page 428
     available at https://wiki.banana-pi.org/Banana_Pi_BPI-R3#Documents

> 
> From my side (i.e. not having checked the hw details just judging with
> the PWM hat on) the patch is fine.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

/
