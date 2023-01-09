Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568FD662331
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjAIK1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbjAIK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:27:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A1BCE39
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:27:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay40so5909255wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SR4xg/8vRGqoBJiSpvGD2Rl2ghk9VGEtuelbvA5hJfk=;
        b=aT3ss8O+Gsu9jCN8YuL3TDXjKyNWf4nB21P7RR9Th1b+8mZp8kz3LPZ9G8Ug/9sSbr
         JmeDD4GvprLSePBUp4a0A5MB7ZzURamGMbAjnAq7iF3USgE9Kv0+e28Kt3qHCsN8NGN9
         21WASmcnew4Cd/TZS+qup11illvEBYs18hjBTbG+EVySqrihxge0+iZqjKyWIaMKb59I
         zqRx0kU5xQvogoAUaleQhVB/eG0XEIup+csXL5dIT9wK1/BTQlL7L98iLAVNHJSRJWbt
         SVLxKaJrSs6/0qwW/Fo7d9ghv0DVJMQsmZOj6b13qqG7Uh25bJyFTyQH2iKv0bt8jP9I
         uSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR4xg/8vRGqoBJiSpvGD2Rl2ghk9VGEtuelbvA5hJfk=;
        b=PleSJ4irCM+MANu8vljT/QPirQtpOtJB5cN81zT+FGv3QFATzFiRsZNtfQ5eepa6n8
         I3IOputj+bn+8b3oMHu7YUjS9iXYWqnq1f3+NPLx4qo1B7wlNyFovVzNWMZSALaKcqJJ
         hyPWjuzJolxE7HvN8yRJmX7nnRC9XUDuL5hmskTKRh+vAShKMgEK8XBxWPOfK70vhpgM
         zsFHc+xoXnMUuwIPmAXncasw8pe+BvMMepSzcVpZ3bMr/Dq8/ZFrza/rx3VKg7jcapA5
         ldOZxae7AQgCMnMqEFLzYEGyOvtSfXLr41d9sMF87JmUfHSv2jrPClcT1d4mq3laGfim
         /YtA==
X-Gm-Message-State: AFqh2ko/hkwfKpDLS40JsfBOkE/5ro81k8ZKRIh+7Z8vgpfAEM4rVQmH
        HX8EcVvdcfX6Ok87ZlXxTvvAfQ==
X-Google-Smtp-Source: AMrXdXvlCiyiCuzHJg/WG8LUCp3wL2rzbSPwtjvrHVXTysfocLK7IGL9XmfsmXW4Llcem1k1rdDJBA==
X-Received: by 2002:a05:600c:4e90:b0:3cf:894f:964b with SMTP id f16-20020a05600c4e9000b003cf894f964bmr47444559wmq.16.1673260036605;
        Mon, 09 Jan 2023 02:27:16 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b003d9b87296a9sm16796137wmo.25.2023.01.09.02.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:27:15 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:27:13 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH RESEND 1/4] backlight: aat2870: Use backlight helper
Message-ID: <Y7vsAdMqGNgYS/m9@aspen.lan>
References: <20230106164856.1453819-2-steve@sk2.org>
 <Y7hdyPAKBYv+gAzf@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7hdyPAKBYv+gAzf@phenom.ffwll.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 06:43:36PM +0100, Daniel Vetter wrote:
> On Fri, Jan 06, 2023 at 05:48:52PM +0100, Stephen Kitt wrote:
> > Instead of retrieving the backlight brightness in struct
> > backlight_properties manually, and then checking whether the backlight
> > should be on at all, use backlight_get_brightness() which does all
> > this and insulates this from future changes.
> >
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
>
> Lee/Daniel, will you pick these up, or should I smash them all into
> drm-misc-next for 6.3?

Outside of holiday, Lee usually hoovers up the backlight patches (and
negotiates about who merges what).


Daniel.


> > ---
> >  drivers/video/backlight/aat2870_bl.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
> > index a7af9adafad6..1cbb303e9c88 100644
> > --- a/drivers/video/backlight/aat2870_bl.c
> > +++ b/drivers/video/backlight/aat2870_bl.c
> > @@ -59,7 +59,7 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
> >  	struct aat2870_bl_driver_data *aat2870_bl = bl_get_data(bd);
> >  	struct aat2870_data *aat2870 =
> >  			dev_get_drvdata(aat2870_bl->pdev->dev.parent);
> > -	int brightness = bd->props.brightness;
> > +	int brightness = backlight_get_brightness(bd);
> >  	int ret;
> >
> >  	if ((brightness < 0) || (bd->props.max_brightness < brightness)) {
> > @@ -70,11 +70,6 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
> >  	dev_dbg(&bd->dev, "brightness=%d, power=%d, state=%d\n",
> >  		 bd->props.brightness, bd->props.power, bd->props.state);
> >
> > -	if ((bd->props.power != FB_BLANK_UNBLANK) ||
> > -			(bd->props.state & BL_CORE_FBBLANK) ||
> > -			(bd->props.state & BL_CORE_SUSPENDED))
> > -		brightness = 0;
> > -
> >  	ret = aat2870->write(aat2870, AAT2870_BLM,
> >  			     (u8)aat2870_brightness(aat2870_bl, brightness));
> >  	if (ret < 0)
> > --
> > 2.30.2
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
