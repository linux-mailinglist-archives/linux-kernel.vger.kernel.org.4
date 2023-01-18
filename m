Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90462671D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjARNQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjARNPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:15:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEC54A1DC;
        Wed, 18 Jan 2023 04:39:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 7-20020a17090a098700b002298931e366so2022050pjo.2;
        Wed, 18 Jan 2023 04:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYG3PM5RJMJyyv83YwSPRPszMIsiOkHwGjTk5F+x3hI=;
        b=V/6gy0vAY6rs5ZoX2PKaS+BLtElA3Tzu8J+tJGH23+t7xTHjV/kGfVUrG+mlwDZ3wj
         kpKHpnkuWJ9W2QHRwut2HOWG+m5v8GbIRocWcioHSjpfuhiaZ0vTwYNZ1d+e9mO1wBwf
         cvwonDmy7Oys+sckyuNoft6byufISKANUQ8hBqRoGGmMNpyS/rJHIIuChrrvkWpMTvsF
         +1ejMpwEtt+QUbkQEHMckG9/nnN+3wmE2XE5zAvpGJJ0qw/zud7n71USfikNAqayYEnQ
         rat5rzPRj/qpczXRN0NVJqyql3xz8LvrJqc8s5hsU7gDIAdVqxivWpW/+delx8WSNDyN
         3qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYG3PM5RJMJyyv83YwSPRPszMIsiOkHwGjTk5F+x3hI=;
        b=RuRKCYTzCJ4J60fDMlVpYmPsqb++Yn6fWztZ1ej6nyXBAQQlYywgdmwZ7kPLTfbLSy
         XqRyA6V9YpDPSEtH+NBX+7Fy+ZOcUnV4oGlr4sE6mTRsRLGTPwpzDVChm0w8Of50RyKs
         SPLk9bVl9phzL4FuxPzYUiZb+MrgU6DtshX8a2p1/1ycr28+ZFg3OheS//8yRRUZfSGv
         7AUTRLiAvNhrVxyhXJ2l5f7f4AXpR6mbYgx6slPyWxYkETuFmYUnBW54jt0hAXnnCaIM
         5o9e/G8X3Rs+MD9wmeVfA7xk+eINxIP3y3Xt5xC+4xigIsYLCTOWqw0Wou2DVJ7usKmg
         rVrw==
X-Gm-Message-State: AFqh2kpG98U0vJfFZo3ZdayEnE6cW5Jf6sxR9c2mwWknoMJnLtASgHDT
        DankkKYZSaz1MqtqfxJfYck=
X-Google-Smtp-Source: AMrXdXv7LGzYFfELU1BJ9EM/sUYOtOCS3XbRpfI8EAKUyZ6nehcAbf5QyoQEurcYAEulalkYn1duRQ==
X-Received: by 2002:a17:903:449:b0:189:6ab3:9e75 with SMTP id iw9-20020a170903044900b001896ab39e75mr6508172plb.15.1674045577143;
        Wed, 18 Jan 2023 04:39:37 -0800 (PST)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b00186b69157ecsm22889182pln.202.2023.01.18.04.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:39:36 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:39:28 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 2/2] backlight: ktz8866: Add support for Kinetic
 KTZ8866 backlight
Message-ID: <Y8fogDsf9vpI5F5z@Gentoo>
References: <20230117154408.1882-1-lujianhua000@gmail.com>
 <20230117154408.1882-2-lujianhua000@gmail.com>
 <Y8fhIVRbgEok29t1@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8fhIVRbgEok29t1@aspen.lan>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:08:01PM +0000, Daniel Thompson wrote:
> On Tue, Jan 17, 2023 at 11:44:08PM +0800, Jianhua Lu wrote:
> > Add support for Kinetic KTZ8866 backlight, which is used in
> > Xiaomi tablet, Mi Pad 5 series. This driver lightly based on
> > downstream implementation [1].
> > [1] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/elish-r-oss/drivers/video/backlight/ktz8866.c
> >
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > Changes in v2:
> >   - Add missing staitc modifier to ktz8866_write function.
> >
> > Changes in v3:
> >   - Add 2022 to Copyright line.
> >   - Sort headers.
> >   - Remove meaningless comment.
> >   - Use definitions instead of hardcoding.
> >   - Add missing maintainer info.
> >
> > Changes in v4:
> >   - Change 2022 to 2023.
> >   - Remove useless macro and enum.
> >   - Describe settings by devicetree.
> >   - Move header file to C file.
> > Changes in v5:
> >   - Change "2023" to "2022, 2023" in Copyright line.
> >   - Set scale property for backlight.
> >
> >  MAINTAINERS                       |   6 +
> >  drivers/video/backlight/Kconfig   |   8 ++
> >  drivers/video/backlight/Makefile  |   1 +
> >  drivers/video/backlight/ktz8866.c | 201 ++++++++++++++++++++++++++++++
> >  4 files changed, 216 insertions(+)
> >  create mode 100644 drivers/video/backlight/ktz8866.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 42fc47c6edfd..2084e74e1b58 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11674,6 +11674,12 @@ M:	John Hawley <warthog9@eaglescrag.net>
> >  S:	Maintained
> >  F:	tools/testing/ktest
> >
> > +KTZ8866 BACKLIGHT DRIVER
> > +M:	Jianhua Lu <lujianhua000@gmail.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
> > +F:	drivers/video/backlight/ktz8866.c
> > +
> >  L3MDEV
> >  M:	David Ahern <dsahern@kernel.org>
> >  L:	netdev@vger.kernel.org
> > diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> > index 936ba1e4d35e..2845fd7e33ad 100644
> > --- a/drivers/video/backlight/Kconfig
> > +++ b/drivers/video/backlight/Kconfig
> > @@ -190,6 +190,14 @@ config BACKLIGHT_KTD253
> >  	  which is a 1-wire GPIO-controlled backlight found in some mobile
> >  	  phones.
> >
> > +config BACKLIGHT_KTZ8866
> > +	tristate "Backlight Driver for Kinetic KTZ8866"
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	help
> > +		Say Y to enabled the backlight driver for the Kinetic KTZ8866
> > +		found in Xiaomi Mi Pad 5 series.
> 
> s/enabled/enable/ (and sorry for spotting this one so late)
Get it.
> 
> 
> > +++ b/drivers/video/backlight/ktz8866.c
> > @@ -0,0 +1,201 @@
> > [...]
> > +static void ktz8866_init(struct ktz8866 *ktz)
> > +{
> > +	unsigned int val;
> > +
> > +	if(of_property_read_u32(ktz->client->dev.of_node, "current-num-sinks", &val))
> > +		ktz8866_write(ktz, BL_EN, BIT(val) - 1);
> > +	else
> > +		/* Enable all 6 current sinks if the number of current sinks isn't specifed. */
> > +		ktz8866_write(ktz, BL_EN, BIT(6) - 1);
> > +
> > +	if(of_property_read_u32(ktz->client->dev.of_node, "current-ramping-time-us", &val)) {
> > +		if(val <= 128) {
> > +			ktz8866_write(ktz, BL_CFG2, BIT(7) | (ilog2(val) << 3) | PWM_HYST);
> > +		} else {
> > +			ktz8866_write(ktz, BL_CFG2, BIT(7) | ((5 + val / 64) << 3) | PWM_HYST);
> > +		}
> 
> This code is interpreting current-ramping-time-us as milliseconds rather
> than microseconds!
> 
> I know I used microseconds in the example I proposed in the feedback for
> v4 DT bindings but "something like" means I am merely providing an
> example (mostly I was intending to show that the units should be
> included both in the property name *and* description).
> 
> It is up to you whether you fix the mismatch by changing the DT bindings
> document to current-ramping-time-ms or change this code to accept
> values in microseconds.
This is my mistake, sorry.
> 
> 
> > +	}
> > +
> > +	if(of_property_read_u32(ktz->client->dev.of_node, "led-ramping-time-us", &val)) {
> > +		unsigned int ramp_off_time = ilog2(val) + 1;
> > +		unsigned int ramp_on_time = ramp_off_time << 4;
> > +		ktz8866_write(ktz, BL_DIMMING, ramp_on_time | ramp_off_time);
> > +	}
> 
> Similarly, this code has not adopted the units specified in the
> bindings documentation.
> 
> In this case 0 would map to 512us so if you decided to use milliseconds
> you will need to add comment in the description saying that 0 will map
> to 512us because the hardware cannot ramp faster than this!
Get it, thank you very much.
> 
> 
> Daniel.
