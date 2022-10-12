Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDFD5FCB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJLTaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJLTaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:30:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36804FE924;
        Wed, 12 Oct 2022 12:30:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x6so17150953pll.11;
        Wed, 12 Oct 2022 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxt2JTmbxIKVdkMYFt9/ONvv5YvSMeJM2eRX93YFbIw=;
        b=Ul2psV50cU2ofB/C6Qm7Adhj1tGnGeRzI7ui3NqnnsniS7kcIgSv183t7OqvGWSJVd
         mHUSDWWGrg9EkoQDQp5/YIEUA1rcEtx2jxVxDtXoH7/5lf83ZSnDGYZD08HSd1qwOjC6
         eHVQYKf0nEtMMorQKYjRslQc3zm9v7wludWBpF2KGdKphZUZbV9arQasCyKuwOG+cBCP
         DOkoY29xD7TsDxLWfus5QijAljIIGimuKH6psnPGwTWfUbXEZ5wDJzBpnH8+IeFxEvk7
         t/y2J/lxgEpMA/2gqLABUGgt67mKtWlBGdnJ+uwwGw1aZVX1z65Me2XKIRqxz1a4oRLu
         hsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pxt2JTmbxIKVdkMYFt9/ONvv5YvSMeJM2eRX93YFbIw=;
        b=Dexj1yo+53VjiM0iq8k24n6LC4v1ZUdexSRNJAme2IJ4fRE21tdihlr7WrQ2j3FYjQ
         89Cn6DNF6+DH1oi2Nj2vuZQ0XYO9OB5DATebjKgwS4mWVpIEz7ctQuSC3ZiZgh4jzueG
         Fj3bkT7Z0aI4Vdx52eybJnEEoUEkcU72ZFgFToHgpYN9vYcr3mrksAOhIhJrIhw7KUjf
         ewUmkKmjXF1MJHmPXO1erMwJAyd8gb+Z44rTZcFzQOpQX2JDWYUbnyVrJqlLQXCwRy7a
         EugtChvbK20DPGz4iAohGXRl1bI7/rpFlqNn7E6Vf7x669q2YJOtnoDgNcxjl3ntaI64
         n5qA==
X-Gm-Message-State: ACrzQf2+C0/kutvlQLkxmwSsZf4PpLzWIp8hwggtcXI76saqJMotlmz2
        kyy9ztsdiZxHb2sFTJbLF1s=
X-Google-Smtp-Source: AMsMyM6fVzSv2QEw11L3zNJYh/zLufFUZH7Rwsmhl/Gbxj6Qi86V8uvniQII3IreSwhUwbAcO0cS9A==
X-Received: by 2002:a17:90b:1d11:b0:20d:4c69:6886 with SMTP id on17-20020a17090b1d1100b0020d4c696886mr6768544pjb.14.1665603015451;
        Wed, 12 Oct 2022 12:30:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d4c1:686c:5489:5df9])
        by smtp.gmail.com with ESMTPSA id f15-20020a17090a664f00b0020d3662cc77sm1741056pjm.48.2022.10.12.12.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:30:14 -0700 (PDT)
Date:   Wed, 12 Oct 2022 12:30:11 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: omap3-n900: fix LCD reset line polarity
Message-ID: <Y0cVw63d3+pAVbd2@google.com>
References: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
 <Y0UDEtQlN5Y9h7BU@atomide.com>
 <20221011123726.elsr53ue7nxzhvww@mercury.elektranox.org>
 <Y0V4cLGbYe4j+ls6@google.com>
 <Y0V99Agad6Ma+yTC@atomide.com>
 <Y0V/82JsRVZh6PlL@google.com>
 <Y0WCCw8k+KTuvdWX@atomide.com>
 <41373c20-3b97-ac47-81c8-75bf1bbe3a38@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41373c20-3b97-ac47-81c8-75bf1bbe3a38@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 01:58:15PM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> On 11/10/2022 17:47, Tony Lindgren wrote:
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221011 14:30]:
> > > On Tue, Oct 11, 2022 at 05:30:12PM +0300, Tony Lindgren wrote:
> > > > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221011 13:57]:
> > > > > Hi Sebastian,
> > > > > 
> > > > > On Tue, Oct 11, 2022 at 02:37:26PM +0200, Sebastian Reichel wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Tue, Oct 11, 2022 at 08:45:54AM +0300, Tony Lindgren wrote:
> > > > > > > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221004 21:26]:
> > > > > > > > The LCD driver (panel-sony-acx565akm), when probing, starts with line
> > > > > > > > driven low, and then toggles it to high and keeps it there. Also, the
> > > > > > > > line is driven low when powering off the device, and ls released when
> > > > > > > > powering it back on. This means that the reset line should be described
> > > > > > > > as "active low" in DTS. This will be important when the driver is
> > > > > > > > converted to gpiod API which respects the polarity declared in DTS.
> > > > > > > 
> > > > > > > We should ensure these patches get merged together with the driver
> > > > > > > change to avoid breaking LCD for booting. Probably no need to have
> > > > > > > the driver quirk handling for inverted polartity in this case.
> > > > > > > 
> > > > > > > It's probably easiest to have an immutable branch for the driver
> > > > > > > changes I can base the dts changes on. Or I can ack the dts changes
> > > > > > > if they get merged with the driver.
> > > > > > 
> > > > > > Both drivers are already using gpiod API:
> > > > > > 
> > > > > > drivers/gpu/drm/panel/panel-sony-acx565akm.c
> > > > > > drivers/gpu/drm/panel/panel-dsi-cm.c
> > > > > 
> > > > > I was looking at
> > > > > 
> > > > > drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> > > > > drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> > > > 
> > > > Ah OK that explains :)
> > > > 
> > > > > which are not using gpiod. Should they be retired?
> > > > 
> > > > Yes we should just get rid of them with omapdrm working just fine.
> > > 
> > > Will you be submitting such patches? I'd like to get rid of
> > > of_get_named_gpio() and friends if I can...
> > 
> > Adding Tomi to Cc, my guess is he already has such patches and knows
> > better which ones can go :)
> 
> To be honest, I haven't really even had a glance towards fbdev for a long
> time.
> 
> There is one thing that omapdrm doesn't support, which is VRFB rotation. I
> cannot say if the users of those above-mentioned panels require VRFB.
> 
> > > > > > So this just breaks things.
> > > > > 
> > > > > I missed the drivers in drivers/gpu/... and I see that they essentially
> > > > > abuse gpiod API as gpiod_set_value() operates on logical level
> > > > > (active/inactive) and not absolute (high/low). They should either use
> > > > > the gpiod_*_raw() variants, or they should be adjusted to do the proper
> > > > > thing together with the accompanying DTS change.
> > > > > 
> > > > > What are your preferences?
> > > > 
> > > > Seems like high/low at the connected device end is what we should use,
> > > > right? Otherwise things will misbehave if the panel is connected to
> > > > some other SoC possibly.
> > > 
> > > It is exactly because of this case the driver should use active/inactive
> > > and follow polarity described in DTS. If the driver does:
> > > 
> > > 	gpiod_set_value_cansleep(d->reset, 1);
> > > 
> > > then if DTS is saying that the reset line is active low, under the wraps
> > > the line will be driven to "0", but if DTS is saying that the line is
> > > active high, then the very same call will drive the line to "1".
> > > 
> > > This allows accommodating different designs without having to change the
> > > driver code.
> 
> Isn't breaking an old dts file quite a bad thing? Why not just add a comment
> to the .dts and to the driver about the situation. I don't quite see that
> the fixing the dts (And, if done properly, adding a boot time fixup for old
> dtbs) and changing the drivers is worth the hassle.
> 
> Unless we see new users for these drivers, which would require the new users
> to write broken dts files.

Or maybe there are devices with fixed DTSes and fixed up kernels but the
fixes have not been contributed upstream. I don't know...

My personal opinion is that we pay too much attention to DTS
compatibility in cases when it is not totally clear if there are devices
that use DTSes that are not bundled with the kernel and also have a
chance to have their kernel updated (and be lucky enough for the
upstream kernel to work on such device without extensive work).

Anyway, my goal is to stop exposing of_get_named_gpio() and its
derivatives, so please let me know your preference. Should I:

- mirror in omapfb drivers what gpu drivers do and use inverted
  polarity
- use gpiod_set_value_raw() and essentially ignore polarity described
  in DTS
- continue pushing polarity fixes throughout
- something else?

Thanks!

-- 
Dmitry
