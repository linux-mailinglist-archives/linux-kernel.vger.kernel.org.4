Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96707485A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjGEOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGEOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:07:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2254E57
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:07:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3094910b150so7619535f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688566054; x=1691158054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AU4Y7nxn9moTeBBiKE7ZanFY0pefA4riCcCyZ8JBU98=;
        b=ZzTLNwtGWeCGnixiUkB+Fh04qBn9O7QW6d9xvz/3NlQEureQD3sqSlyuVuimTv+PSW
         /51cQhitClXf2IZyEcKowFYfQVRHNXsGpKUVodcsr0Z7ppSF2+wSZPwRRYCTcaGRQzfZ
         FhIxaBU3LKA6Os+rtZz6v0wFpYDZwfuGLhYRVPtFQPsWRUT3rGldokdVtTUrzkBxRlx3
         Hjl2Zm9HcwLpKZWtrIqqbLPmBrkp/hTHln1gx0Rj3y950ZXMW4F0XJaBToPWFWeFmxBP
         nrbROTnQv4jDLj9pyTqZfUgk6XkxGP8f7GZv8HXX04Y/UjJFdKGzIKx3Lz4X1OkFk3XI
         Yvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688566054; x=1691158054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU4Y7nxn9moTeBBiKE7ZanFY0pefA4riCcCyZ8JBU98=;
        b=Xq7/Fi+7xYmeSMhW3Uw0Mxb//bNg2E1ndjRTyl1DHcYHEGaoT/DM7TKygwLZqXZ6Qd
         uliwQYf/vHpoXi1Os4InCKFEzFL+Vl0rXOE8SAswTqxAuVdcKoc29jNg8Is0GuiCpqzO
         NTye2gdGtHbfSuf8r6U7PxdHTQZnuQU+u1WViB85/zGPVfsamm+P/Fnj/F0jxWpZIR++
         UnCApmDf0JyaWm8OCcS7jIbKXtGOmXhhMuVE6JqBRgYAUMDyC/9sAX14hqEGB9MnrBbf
         qGI6cRmkBhAweA/ZjsqXuH7uKkQI1JntW1EJGewd0U3ykpttbEyQFO73SjtnGiC/2cBH
         2nhw==
X-Gm-Message-State: ABy/qLZK98f/orNPXfOwq2Q/lQ+EsAkJgEIBdOhb8c+HYmUOlncOlI7B
        J5lOnTiosJ4XqPqg8yKwapTcrA==
X-Google-Smtp-Source: APBJJlEnUvR0WUVjYcvCf+AnF9twxW7bci+6wQkHZaaSQhCGbaLChPiymZ+M6m58en6eNR6b0wqW3A==
X-Received: by 2002:a5d:4241:0:b0:314:824:3788 with SMTP id s1-20020a5d4241000000b0031408243788mr13057703wrr.27.1688566054110;
        Wed, 05 Jul 2023 07:07:34 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d50cd000000b003143b7449ffsm6437811wrt.25.2023.07.05.07.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:07:33 -0700 (PDT)
Date:   Wed, 5 Jul 2023 15:07:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Mans Rullgard <mans@mansr.com>, linux-fbdev@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] backlight: led_bl: fix initial power state
Message-ID: <20230705140731.GB6265@aspen.lan>
References: <20230704140750.25799-1-mans@mansr.com>
 <20230704150310.GA385243@aspen.lan>
 <20230704170731.GB940443@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704170731.GB940443@ravnborg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 07:07:31PM +0200, Sam Ravnborg wrote:
> Hi Daniel,
>
> > > @@ -200,8 +200,8 @@ static int led_bl_probe(struct platform_device *pdev)
> > >  	props.type = BACKLIGHT_RAW;
> > >  	props.max_brightness = priv->max_brightness;
> > >  	props.brightness = priv->default_brightness;
> > > -	props.power = (priv->default_brightness > 0) ? FB_BLANK_POWERDOWN :
> > > -		      FB_BLANK_UNBLANK;
> > > +	props.power = (priv->default_brightness > 0) ? FB_BLANK_UNBLANK :
> > > +		      FB_BLANK_POWERDOWN;
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
> The following code does the same using helpers:
>
> 	if (active_at_boot || !dev->node->phandle))
> 		backlight_enable(bd);
> 	else
> 		backlight_disable(bd);
>
> The code needs to execute after backlight_device_register() so maybe not
> so great an idea?!?

It would introduce a need for a bunch of new locks since userspace
could get in between device creation and the call to the helpers.

Additionally, it is even correct for a driver to forcefully set
fb_blank to powerdown during the probe? All current drivers set
fb_blank to unblank during the probe.


Daniel.
