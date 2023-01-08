Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFDC661952
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjAHU3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjAHU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:29:49 -0500
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A59C38B7
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=C5L2b3E9pjVq6LXYYYeAK09arnLn+mXAFAusyTiLYtM=;
        b=nTKn+n4lgiTjfD2VKToU6axN8gPcd5e73M4vSy/k1XU2CvufB5JON0iGZJvaIYarKXKqjIrRjLqPT
         fgO+lP1o7WNzsgCVM1gX/vf8p3Srt1Sy3jrhbqWPbZmGwoPa6enaJUadZx/d2EVJwwnZgtYp8Hhzag
         HBk4z0Ezz5oy2Z/j535u3Ai9X21x1KWD+8aabzfZO1aWEJAnGqoYNq+GpslWX1UI0w+EmgO0ZIL3z6
         vNqUzPb5/3oxTINHKsqnHYrd59yl/g1SHxW7toatY4pDAonTch+LEuU2IWjH2taSfaXx9gAPrtdtCp
         O7cGm8wZ/D/5tQcp0iKSqHuJJcYCvgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=C5L2b3E9pjVq6LXYYYeAK09arnLn+mXAFAusyTiLYtM=;
        b=HWVUdLyZ5eUHvE79ubttUHLptrX9PXLmdILJ58ckRRwFt+J10zuBzp9HvE4mc7C2KbULY7jBKFPz7
         LChrDvIDA==
X-HalOne-ID: 2f2d9a54-8f93-11ed-9409-ede074c87fad
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 2f2d9a54-8f93-11ed-9409-ede074c87fad;
        Sun, 08 Jan 2023 20:29:45 +0000 (UTC)
Date:   Sun, 8 Jan 2023 21:29:43 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-staging@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Helge Deller <deller@gmx.de>, Lee Jones <lee@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Antonino Daplas <adaplas@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robin van der Gracht <robin@protonic.nl>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 09/15] staging: fbtft: fb_ssd1351.c: Introduce
 backlight_is_blank()
Message-ID: <Y7sntztwrNqw41+i@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-9-1bd9bafb351f@ravnborg.org>
 <20230108202817.7890f85c@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108202817.7890f85c@heffalump.sk2.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sun, Jan 08, 2023 at 08:28:17PM +0100, Stephen Kitt wrote:
> On Sat, 07 Jan 2023 19:26:23 +0100, Sam Ravnborg via B4 Submission Endpoint
> <devnull+sam.ravnborg.org@kernel.org> wrote:
> 
> > From: Sam Ravnborg <sam@ravnborg.org>
> > 
> > Avoiding direct access to backlight_properties.props.
> > 
> > Access to the deprecated props.fb_blank replaced by backlight_is_blank().
> > Access to props.power is dropped - it was only used for debug.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Stephen Kitt <steve@sk2.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: linux-fbdev@vger.kernel.org
> > ---
> >  drivers/staging/fbtft/fb_ssd1351.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/fbtft/fb_ssd1351.c
> > b/drivers/staging/fbtft/fb_ssd1351.c index b8d55aa8c5c7..995fbd2f3dc6 100644
> > --- a/drivers/staging/fbtft/fb_ssd1351.c
> > +++ b/drivers/staging/fbtft/fb_ssd1351.c
> > @@ -190,15 +190,12 @@ static struct fbtft_display display = {
> >  static int update_onboard_backlight(struct backlight_device *bd)
> >  {
> >  	struct fbtft_par *par = bl_get_data(bd);
> > -	bool on;
> > +	bool blank = backlight_is_blank(bd);
> >  
> > -	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
> > -		      "%s: power=%d, fb_blank=%d\n",
> > -		      __func__, bd->props.power, bd->props.fb_blank);
> > +	fbtft_par_dbg(DEBUG_BACKLIGHT, par, "%s: blank=%d\n", __func__,
> > blank); 
> > -	on = !backlight_is_blank(bd);
> >  	/* Onboard backlight connected to GPIO0 on SSD1351, GPIO1 unused */
> > -	write_reg(par, 0xB5, on ? 0x03 : 0x02);
> > +	write_reg(par, 0xB5, !blank ? 0x03 : 0x02);
> >  
> >  	return 0;
> >  }
> > 
> > -- 
> > 2.34.1
> 
> For debugging purposes here, would there be any point in logging props.state?
> As in
> 
>         fbtft_par_dbg(DEBUG_BACKLIGHT, par,
> -                     "%s: power=%d, fb_blank=%d\n",
> -                     __func__, bd->props.power, bd->props.fb_blank);
> +                     "%s: power=%d, state=%u\n",
> +                     __func__, bd->props.power, bd->props.state);

Thanks for the suggestion - and the reviews!

I was tempted to just remove the debugging.
If we require debugging, then this could be added in the backlight core,
thus everyone would benefit from it.

The solution above avoid any direct use of backlight_properties
which I consider a layer violation outside the backlight core.
(We cannot avoid it today with the current interface - but we can
minimize it).

	Sam
