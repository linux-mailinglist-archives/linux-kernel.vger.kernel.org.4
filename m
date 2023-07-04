Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6905F74777A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjGDRHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGDRHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:07:35 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011AEE72
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=R1ftX/nJ28RCUlvCxqfDZHT0ym06Es3SsEj3om09Vrs=;
        b=mFMBx5NkiSByK1HMjoIkzQWNmb/ecgu4OOhkDtUvQth7NKdDRhm3aIp5s8eso3WdLAB+9xiBPbmSt
         PA3WhzFS9ZgVq2RloHgeFfgZ/NFVjPtgR+YEMQeC/6OM40w1LuQTKek+MlpIRwyDxL6tWPQAs6ZJgE
         VPloanifqZ0Kpn16QDQRettF7Yffput5jWae6HWTFbdQJ0O7HJCiR9EAWZAg2OvcA0CJtCElPD/h2c
         IEuuVxok7/fSaC2Krc7/yMkaLKGY5KaKVOIdBcI2Qckntdn8h5ZUiZFJLdCzZxdE9fXzXeToS5HZt1
         2A8rIjpoUk4iTafFGT1fxcFbgp045ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=R1ftX/nJ28RCUlvCxqfDZHT0ym06Es3SsEj3om09Vrs=;
        b=toRiw7qMpH7Z7h0WvXiLqGcMRtSWVEuTV0dLMJp/Y5OSdD/HkZxSQEK+aO01h63/4SliBFN0BR4Ib
         6F8dl2YAw==
X-HalOne-ID: 428b86cc-1a8d-11ee-8bd0-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 428b86cc-1a8d-11ee-8bd0-b90637070a9d;
        Tue, 04 Jul 2023 17:07:32 +0000 (UTC)
Date:   Tue, 4 Jul 2023 19:07:31 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Mans Rullgard <mans@mansr.com>, linux-fbdev@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] backlight: led_bl: fix initial power state
Message-ID: <20230704170731.GB940443@ravnborg.org>
References: <20230704140750.25799-1-mans@mansr.com>
 <20230704150310.GA385243@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704150310.GA385243@aspen.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

> > @@ -200,8 +200,8 @@ static int led_bl_probe(struct platform_device *pdev)
> >  	props.type = BACKLIGHT_RAW;
> >  	props.max_brightness = priv->max_brightness;
> >  	props.brightness = priv->default_brightness;
> > -	props.power = (priv->default_brightness > 0) ? FB_BLANK_POWERDOWN :
> > -		      FB_BLANK_UNBLANK;
> > +	props.power = (priv->default_brightness > 0) ? FB_BLANK_UNBLANK :
> > +		      FB_BLANK_POWERDOWN;
> 
> The logic was wrong before but I think will still be wrong after the
> change too (e.g. the bogus logic is probably avoiding backlight flicker
> in some use cases).
> 
> The logic here needs to be similar to what pwm_bl.c implements in
> pwm_backlight_initial_power_state(). Whilst it might be better
> to implement this in led_bl_get_leds() let me show what I mean
> in code that fits in the current line:
> 
> 	/*
> 	 * Activate the backlight if the LEDs are already lit *or*
> 	 * there is no phandle link (meaning the backlight power
> 	 * state cannot be synced with the display state).
> 	 */
> 	props.power = (active_at_boot || !dev->node->phandle) ?
> 			FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
> 
The following code does the same using helpers:

	if (active_at_boot || !dev->node->phandle))
		backlight_enable(bd);
	else
		backlight_disable(bd);

The code needs to execute after backlight_device_register() so maybe not
so great an idea?!?

	Sam
