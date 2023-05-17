Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB88B705C15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 02:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjEQArZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 20:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEQArW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 20:47:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911D8EA;
        Tue, 16 May 2023 17:47:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51b33c72686so51839a12.1;
        Tue, 16 May 2023 17:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684284440; x=1686876440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HCGYpBpbGn/ilfv0rh6ui4ajGZWh3bYG9aZqlfUrka8=;
        b=U8CCerfzbvXFH3i370Zp3YPbVbc0LsTdyHwOvxsZxycEA3qA70E2CLQG7noNhkl723
         vd10RCnPW11I+nm8GU7NYmm/RkcCxQcQPPr9WkMe4N0DYMCenL0fjhgtnnFM3rdQmUnK
         3pB6Czix/X+ecOMZAtffY26HYIEYJpoMmTPIz8LlwAxZPSFv27OhzJJ7xgLl/jCiz6gy
         0Z8vSAgm2mYiQAVY8eWwiMyuWxoMx1eOsUrqrAq35fHoHKrDVGNrbU6HEpJMacCEtWoQ
         SWIOcvB0LBK4K4YmmB5StlUjHK2bxsODcJcOo7g0GlHDWogD5mFW7oYMvWqm6ZVcwUgy
         Qj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684284440; x=1686876440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCGYpBpbGn/ilfv0rh6ui4ajGZWh3bYG9aZqlfUrka8=;
        b=W94KNjhYbmFZE9wmC9qzevJyZ7XNppxrNN8HU+QT+4SPYJwqbqKyhOtE2VcAqXakXg
         J5xHHBdQP6tdHncp2do8Nsa4m4CN/B8jcAlJhF79Mm2jWZlGjhH4HbcbEoWm8dLcZyoI
         Fh7jDqBgpEzF7lUp5ts/U+rQ/v5pz1bCpXx/h/Zb0wjDYKpAvCtmY7gLxQ7WmOnUlI6m
         gvIjWJ0bqKUmRwLUsKeacDQg9aIMw6ZFVLZVHeaz+jSdZNkTpzECo3r8qaKCE/Q6O8bg
         GHR/bpZOlqm9Kz+VL6MnN+noqkAmJRPBLhi4Sg9jJtywU/bRrDbtxcA3tTblXGCfaqcQ
         ukQA==
X-Gm-Message-State: AC+VfDxM5BPEOy0qQsaDjNaueMaeYf48NXvBke5zkY/LwbXyx+i1FF2x
        MoiN7gBt7OBq9chPrhZwv7yIi7PZ2iE=
X-Google-Smtp-Source: ACHHUZ7oiSD3yVWYBG3+XtpIaQ04DaF+05pKIcXd5glalF8VW2jO7FrR573Makx4CDuIGQli1yFKIQ==
X-Received: by 2002:a05:6a20:9184:b0:106:dfc8:6f5b with SMTP id v4-20020a056a20918400b00106dfc86f5bmr5447943pzd.50.1684284439870;
        Tue, 16 May 2023 17:47:19 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id r19-20020a635d13000000b0052c3f0ae381sm14015374pgb.78.2023.05.16.17.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 17:47:19 -0700 (PDT)
Date:   Wed, 17 May 2023 08:47:13 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <ZGQkEdZ6DoJbgiFh@sol>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
 <ZGQH8/hH0Llx3rzZ@sol>
 <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a61415db-fa3f-2fce-9c21-08d8dd026960@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 11:50:42PM +0000, Chris Packham wrote:
> Hi Kent,
> 
> On 17/05/23 10:47, Kent Gibson wrote:
> > On Tue, May 16, 2023 at 10:19:14PM +0000, Chris Packham wrote:
> >> On 17/05/23 01:57, Linus Walleij wrote:
> >>> On Mon, May 15, 2023 at 12:27 AM Chris Packham
> >>> <Chris.Packham@alliedtelesis.co.nz> wrote:
> >>>
> >>>> In my original case which is a kernel module that exports a GPIO for
> >>>> userspace using gpiod_export()
> >>> We should not add new users for that API as it increase the usage
> >>> of the sysfs ABI but if it's an existing in-tree usecase I buy it.
> >>>
> >>>> The crux of the problem is that the irq_desc is created when it hasn't
> >>>> been requested.
> >>> The right solution to me seems to be to not use gpiod_export()
> >>> and not use sysfs TBH.
> >> That's not really a feasible solution. I'm dealing with application code
> >> that has been happily using the sysfs interface for many years.
> >>
> >> I actually did look at getting that code updated to use libgpio earlier
> >> this year but found the API was in a state of flux and I wasn't going to
> >> recommend re-writing the application code to use libgpio if I knew the
> >> API was going to change and we'd have to re-write it again.
> >>
> > Its 'libgpiod'.
> >
> >> Even now with the 2.0.1 libgpio there doesn't seem to be a way of asking
> >> about just GPIO lines in the system, application code would still need
> >> to open every /dev/gpiochipN device and ask what lines are on the chip
> >> and keep the fds open for the chips that have lines the application
> >> cares about but make sure to close the fd for the ones that don't. So
> >> now the application code has to care about GPIO chips in addition to the
> >> GPIO lines.
> >>
> > Trying to better understand your use case - how does your application
> > identify lines of interest - just whatever lines pop up in
> > /sys/class/gpio?
> 
> Thanks for taking an interest. We actually have 2 applications that make 
> use of this functionality
> 
> The first is a userspace driver for a Power Over Ethernet Controller+PSE 
> chipset (I'll refer to this as an MCU since the thing we talk to is 
> really a micro controller with a vendor supplied firmware on it that 
> does most of the PoE stuff). Communication to the MCU is based around 
> commands sent via i2c. But there are a few extra GPIOs that are used to 
> reset the MCU as well as provide a mechanism for quickly dropping power 
> on certain events (e.g. if the temperature monitoring detects a problem).
> 
> We do have a small kernel module that grabs the GPIOs based on the 
> device tree and exports them with a known names (e.g. "poe-reset", 
> "poe-dis") that the userspace driver can use. Back when that code was 
> written we did consider not exporting the GPIOs and instead having some 
> other sysfs/ioctl interface into this kernel module but that seemed more 
> work than just calling gpiod_export() for little gain. This is where 
> adding the gpio-names property in our .dts would allow libgpiod to do 
> something similar.
> 

Ah, so you use gpio_export_link() to provide the well known name?

> Having the GPIOs in sysfs is also convenient as we can have a systemd 
> ExecStopPost script that can drop power and/or reset the MCU if our 
> application crashes. I'm not sure if the GPIO chardev interface deals 
> with releasing the GPIO lines if the process that requested them exits 
> abnormally (I assume it does) and obviously our ExecStopPost script 
> would need updating to use some of the libgpiod applications to do what 
> it currently does with a simple 'echo 1 >.../poe-reset'
> 

Ironically, the usual complaint wrt power/reset lines is that users
don't want it to be reset back to default when their app crashes.

What happens when the line is released is driver dependent.
The uAPI can't make any guarantees, as it releases the line back to the
device driver. Typically is it set back to its default state, so that
might do exactly what you want out of the box - no ExecStopPost required.
But you would need to confirm on your hardware.

There was also some discussion on making the default state configurable
via dts[1], but I'm not sure what happened to that.

> The second application is a userspace driver for a L3 network switch 
> (actually two of them for different silicon vendors). Again this needs 
> to deal with resets for PHYs connected to the switch that the kernel has 
> no visibility of as well as the GPIOs for the SFP cages. Again we have a 
> slightly less simple kernel module that grabs all these GPIOs and 
> exports them with known names. This time there are considerably more of 
> these GPIOs (our largest system currently has 96 SFP+ ports with 4 GPIOs 
> per port) so we're much more reliant on being able to do things like 
> `for x in port*tx-dis; do echo 1 >$x; done`
> 

Given appropriate line names, that is already something you can do with
the libgpiod v2 tools.  Something like:

`for x in gpiochip*; do gpioset -c x tx-dis=1; done`

Behind the scenes gpioset is doing the name to offset mapping, which is
less efficent than identifying the line by offset, but given you are
calling from shell performance probably isn't an issue.

> I'm sure both of these applications could be re-written around libgpiod 
> but that would incur a significant amount of regression testing on 
> existing platforms. And I still consider dealing with GPIO chips an 
> extra headache that the applications don't need (particularly with the 
> sheer number of them the SFP case).
> 

Strictly speaking you have regression testing to deal with which ever
way you go. Though wouldn't regression testing for a kernel change be more
work than the app alone?

Cheers,
Kent.

[1] https://lore.kernel.org/linux-gpio/20220914151145.73253-1-brgl@bgdev.pl/
