Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FCD747578
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGDPk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDPk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:40:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAB2E42
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:40:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so56329535e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688485253; x=1691077253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dETgL6aN2zUTbUFg9iSwg8ejNwrd0bWe6o9LAE1dT5I=;
        b=J2qE6//r39TaBSH1KbiE1TIqH0WGur8hFgV+NsAXGceRzRytpyUoQEnWPq7O7iM2i5
         XCezzp9pWxTI2EvHkCTGwaTg6AidfN9Ig54m2M/KUNFSzOt2APlJ0CVFyfSiKC5uQBIY
         O2Hr95lpg8ZWt7ErOZLe34Zt59EpDyCP3Bl+4xYBjNw3bc2mGqRA5PaGI1HhQYIez9Ql
         wU2QA2cRvxKlc5I5mvPOTJpnKIxmAS6uLZ8P7RRULyNpRlaCQ8CqRsewlDFn1DwutleX
         PCqgvF97jifPV6zaDvZFDRdKy7eAJLlNCcSOnNoy/t4bvplC9uVR7eYtjF7l+dFgTJpX
         gHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485253; x=1691077253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dETgL6aN2zUTbUFg9iSwg8ejNwrd0bWe6o9LAE1dT5I=;
        b=CQ9aY6sf/lPxf8HqywZR+j4cGFm0h1pQC3gp0z4zj47RwwK/Sn56QnX4nU/XeCOczE
         qbkTvl5bPvWGfbf9L1XW3XjEYzHG/K2lWrfvRJmzIBbbHiiIAz99JlBTwAPTMFFLtCVS
         SQmHZRmv2WsMktEkU+yWnlByeKODIkOMiNCW6MG3i/+e58wW3BpxMVeV4c02SoeKE33w
         w3O0Gx3lB1u64Jp76t0Ww1mL1dy6ECOq0zPftdFEG4iv57XYKhgLTp3QVCK/XjQHlwJr
         QkSJwOIymFd98VSTjnLg9KkCcfu4Qb9uXSsM4Q5L7V8+YMcMaq7GcOHLq5q1TPS0oPD0
         VP5w==
X-Gm-Message-State: AC+VfDxFOBh/3aLboLpQWO5X/wcqk9faJIrcdmes+lZYqZSNxe2GRleT
        UuFfx/rnJ69hIzYrtUSFDjsBhg==
X-Google-Smtp-Source: ACHHUZ5/+GjNc3y08OaN0unpphSTEbHVkt9PK6i+z80YL2bJvVkOutHzeXGXyxPs5woWSj5oQdQKug==
X-Received: by 2002:a1c:7c05:0:b0:3f6:2ae:230e with SMTP id x5-20020a1c7c05000000b003f602ae230emr11643583wmc.3.1688485253234;
        Tue, 04 Jul 2023 08:40:53 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bcd0a000000b003fa99969e61sm24767384wmj.45.2023.07.04.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:40:52 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:40:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: led_bl: fix initial power state
Message-ID: <20230704154051.GC385243@aspen.lan>
References: <20230704140750.25799-1-mans@mansr.com>
 <20230704150310.GA385243@aspen.lan>
 <yw1xo7krzo9k.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xo7krzo9k.fsf@mansr.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 04:31:51PM +0100, Måns Rullgård wrote:
> Daniel Thompson <daniel.thompson@linaro.org> writes:
>
> > On Tue, Jul 04, 2023 at 03:07:50PM +0100, Mans Rullgard wrote:
> >> The condition for the initial power state based on the default
> >> brightness value is reversed.  Fix it.
> >>
> >> Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> ---
> >>  drivers/video/backlight/led_bl.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> >> index 3259292fda76..28e83618a296 100644
> >> --- a/drivers/video/backlight/led_bl.c
> >> +++ b/drivers/video/backlight/led_bl.c
> >> @@ -200,8 +200,8 @@ static int led_bl_probe(struct platform_device *pdev)
> >>  	props.type = BACKLIGHT_RAW;
> >>  	props.max_brightness = priv->max_brightness;
> >>  	props.brightness = priv->default_brightness;
> >> -	props.power = (priv->default_brightness > 0) ? FB_BLANK_POWERDOWN :
> >> -		      FB_BLANK_UNBLANK;
> >> +	props.power = (priv->default_brightness > 0) ? FB_BLANK_UNBLANK :
> >> +		      FB_BLANK_POWERDOWN;
> >
> > The logic was wrong before but I think will still be wrong after the
> > change too (e.g. the bogus logic is probably avoiding backlight flicker
> > in some use cases).
> >
> > The logic here needs to be similar to what pwm_bl.c implements in
> > pwm_backlight_initial_power_state(). Whilst it might be better
> > to implement this in led_bl_get_leds() let me show what I mean
> > in code that fits in the current line:
> >
> > 	/*
> > 	 * Activate the backlight if the LEDs are already lit *or*
> > 	 * there is no phandle link (meaning the backlight power
> > 	 * state cannot be synced with the display state).
> > 	 */
> > 	props.power = (active_at_boot || !dev->node->phandle) ?
> > 			FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
> >
> > Note that active_at_boot is not the same as (priv->default_brightness > 0)
> > since the value read by led_bl_get_leds() can be clobbered when we
> > parse the properties.
>
> Am I understanding correctly that the code should be using the
> default_brightness value as set by led_bl_get_leds() to determine the
> initial power state, not whatever default value the devicetree provides?

Yes.

The devicetree allows us to specify a default brightness but the DT
value cannot not be used to decide if the backlight has already been
lit up.


Daniel.
