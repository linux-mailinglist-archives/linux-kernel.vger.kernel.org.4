Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA3744CDC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGBJIJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Jul 2023 05:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:08:07 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01161AC;
        Sun,  2 Jul 2023 02:08:06 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-579ed2829a8so5466977b3.1;
        Sun, 02 Jul 2023 02:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688288885; x=1690880885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OBtu7Z4+GE6q0l8ikA7nuhp09YCEyCrOF7iEJtpDP4=;
        b=ko56/etOz/98NHqsuAD5G8XKmyJ1FEdD+DPKRXLSDq7UA9OLXmtn145xq75CF07aea
         Y0jxDEkhUlZHlgLCQYRSQZYzXzlcuj2qnsnU7kAfnH8gz/sgB1t+InAJeb/Ud2BV8QAI
         js6hSOxEBdSlvkLw0utwWuev0+pt55BczexZNB4aRVqollcJUka6YrvRvrF4dcjs01RT
         lotEIDjeotDDz+WSNBWJot8cdXs3QuJUn4WW1CymU8J5/rT8E3OFKhk9DzDIZlaDuuea
         n/CVeEPJufR7nPVG11JVehsHllzZdFJvfJPVxgumftBsfuuNmGVd2THrsn0g6ZF1el9L
         j7Eg==
X-Gm-Message-State: ABy/qLYHdFfUdpVDGkUsCgCneUjmsOS3A+fA7QX9ooiJe8Z8SOmk2FJN
        lcNUskOKdjx/j6Z8d0r2lKhUnrqHhlGkNoeh
X-Google-Smtp-Source: APBJJlFHohJ3A9y5XwEOe1lswJoZMXLBEJsfI6Q9pVf+182NwTbV/XNJKvlW8IwvWk7ggGkBmWyInA==
X-Received: by 2002:a81:6e03:0:b0:577:3663:e478 with SMTP id j3-20020a816e03000000b005773663e478mr7881854ywc.8.1688288885516;
        Sun, 02 Jul 2023 02:08:05 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id l189-20020a0dfbc6000000b0055a931afe48sm4424990ywf.8.2023.07.02.02.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 02:08:05 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-c4d04d50c4cso492228276.1;
        Sun, 02 Jul 2023 02:08:05 -0700 (PDT)
X-Received: by 2002:a25:26c4:0:b0:c40:f090:98bf with SMTP id
 m187-20020a2526c4000000b00c40f09098bfmr6398754ybm.28.1688288884964; Sun, 02
 Jul 2023 02:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230701214503.550549-1-javierm@redhat.com> <20230701214503.550549-2-javierm@redhat.com>
 <393ca142-5226-4779-a963-c34fb0464c59@app.fastmail.com>
In-Reply-To: <393ca142-5226-4779-a963-c34fb0464c59@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Jul 2023 11:07:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLRBePox24kBHBMhzKWZX2ncXCD_8JBZrWcbwo0eBZ1Q@mail.gmail.com>
Message-ID: <CAMuHMdWLRBePox24kBHBMhzKWZX2ncXCD_8JBZrWcbwo0eBZ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fbdev: Split frame buffer support in FB and
 FB_CORE symbols
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Sun, Jul 2, 2023 at 12:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Jul 1, 2023, at 23:44, Javier Martinez Canillas wrote:
> > Currently the CONFIG_FB option has to be enabled even if no legacy fbdev
> > drivers are needed (e.g: only to have support for framebuffer consoles).
> >
> > The DRM subsystem has a fbdev emulation layer, but depends on CONFIG_FB
> > and so it can only be enabled if that dependency is enabled as well.
> >
> > That means fbdev drivers have to be explicitly disabled if users want to
> > enable CONFIG_FB, only to use fbcon and/or the DRM fbdev emulation layer.
> >
> > This patch introduces a non-visible CONFIG_FB_CORE symbol that could be
> > enabled just to have core support needed for CONFIG_DRM_FBDEV_EMULATION,
> > allowing CONFIG_FB to be disabled (and automatically disabling all the
> > fbdev drivers).
> >
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

> > @@ -59,7 +69,7 @@ config FIRMWARE_EDID
> >
> >  config FB_DEVICE
> >       bool "Provide legacy /dev/fb* device"
> > -     depends on FB
> > +     select FB_CORE
> >       default y
> >       help
> >         Say Y here if you want the legacy /dev/fb* device file and
>
> These are now the only user visible sub-options when CONFIG_FB is
> disabled. I missed FIRMWARE_EDID earlier, but this also looks like
> it can clearly be left as depending on FB since nothing else calls
> fb_firmware_edid. In fact, it looks like all of fbmon.c could be
> left out since none of its exported symbols are needed for DRM.
>
> That would leave CONFIG_FB_DEVICE as the only user visible option
> for DRM-only configs, which is slightly odd for the menuconfig,
> so I still wonder if that could be done differently.
>
> Is there actually a point in configurations for kernels with FB=y,
> DRM=n and FB_DEVICE=n? If we don't expect that to be a useful
> configuration, an easier way would be to have CONFIG_FB turn it
> on implicitly and instead have a user-visible Kconfig option
> below CONFIG_DRM_FBDEV_EMULATION that allows controlling the
> creation of /dev/fb*.

Such a combination would allow the user to still have a text console
on a legacy fbdev, while not having to worry about possible security
ramifications of providing fbdev userspace access.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
