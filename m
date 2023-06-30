Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847D47439E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjF3KwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjF3KwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB48358A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688122271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uyqtfh/uO+c59eeqAPwfK8ApK34k3U13F7I83iFK+cU=;
        b=CRBf8E0Qxr9ZIqedptmeoMzbFl6R08GUGH6R39whIwuWfhHEjmd963xa+0d1cTPCrpFZrg
        4yONJLN8Ps31Gpfi5hpZI6FHWAAqv6VrFFxwphbN0wV3NPfgIXF8wauGT+ZqMKQ9hvPyNh
        IMou0UJ9uXMpQSBImvJVTM2Hzq94uUQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-S6ZfXkBpOMmforeNwfdK4Q-1; Fri, 30 Jun 2023 06:51:10 -0400
X-MC-Unique: S6ZfXkBpOMmforeNwfdK4Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fb40d0623bso8366985e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688122269; x=1690714269;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyqtfh/uO+c59eeqAPwfK8ApK34k3U13F7I83iFK+cU=;
        b=jGbLygOMS+wEIbdilr1zV2jDlwEkYOFVfZo2JwSAdNH4OURCJCHBEovDSea6NQP1N5
         Zi1vn9LrB+eIU2FolGeaGnrpU03H3LfgIZRQpauSvNM2hZcNe0T0cF6vz8Rt4qwGNLpT
         R+6Vb86fk46GlesigE72mV5qhpBju/V93dXjKUCgAo7ZgHz0Zpb4ztY4xvabI8AHOYRI
         cfRRFHZ5/gQ7gtlp29yhmDH0QPxf6YmkNjAmlB8JkzCxsfQQt1fptpqhwIJ2IullV/GP
         /Rtte7h0OI6flQb9hayKFiM7xDyf1JtfAOkjA20HYAAhhhw7Uf9X+JOP2HEN2lJsnENi
         e/ag==
X-Gm-Message-State: AC+VfDylTsLLs4jEM7bNzF37mCmhZA4PUeZEWJHueu3zvLZ2OmJNYoML
        +qwqZ+4xuMNAmFqczRL9E4GxyZUgJGdzxeqH9P02BpG8fknm6O6LcP6G2ucpJczJwN32B6c+BfY
        6swwdGDsOdhtfjlP9DZVanYKD
X-Received: by 2002:a05:600c:2259:b0:3f7:aee8:c23a with SMTP id a25-20020a05600c225900b003f7aee8c23amr6742589wmm.19.1688122269270;
        Fri, 30 Jun 2023 03:51:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ar/tTtvUE+lxD/WKHTgCoVCq4pBAcO5fMERH2qhCP0DM6uF+75yi5jYVG8xRfdHUuTfLWAQ==
X-Received: by 2002:a05:600c:2259:b0:3f7:aee8:c23a with SMTP id a25-20020a05600c225900b003f7aee8c23amr6742572wmm.19.1688122268942;
        Fri, 30 Jun 2023 03:51:08 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a10-20020a05600c224a00b003faef96ee78sm12491386wmm.33.2023.06.30.03.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 03:51:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
Subject: Re: [PATCH 1/2] fbdev: Split frame buffer support in FB and FB_CORE
 symbols
In-Reply-To: <723a3c51-7997-46d0-9262-68f33384a9e7@app.fastmail.com>
References: <20230629225113.297512-1-javierm@redhat.com>
 <20230629225113.297512-2-javierm@redhat.com>
 <723a3c51-7997-46d0-9262-68f33384a9e7@app.fastmail.com>
Date:   Fri, 30 Jun 2023 12:51:07 +0200
Message-ID: <87h6qpdy04.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

Hello Arnd,

Thanks for your review!

> On Fri, Jun 30, 2023, at 00:51, Javier Martinez Canillas wrote:
>> Currently the CONFIG_FB option has to be enabled even if no legacy fbdev
>> drivers are needed (e.g: only to have support for framebuffer consoles).
>>
>> The DRM subsystem has a fbdev emulation layer, but depends on CONFIG_FB
>> and so it can only be enabled if that dependency is enabled as well.
>>
>> That means fbdev drivers have to be explicitly disabled if users want to
>> enable CONFIG_FB, only to use fbcon and/or the DRM fbdev emulation layer.
>>
>> This patch introduces a CONFIG_FB_CORE option that could be enabled just
>> to have the core support needed for CONFIG_DRM_FBDEV_EMULATION, allowing
>> CONFIG_FB to be disabled (and automatically disabling all fbdev drivers).
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>
> This looks really nice!
>
> I tried to do something like this a few years ago, but failed as

Yes, I also tried to do this before some time ago [0]:

[0]: https://lore.kernel.org/lkml/20210827100027.1577561-1-javierm@redhat.com/t/#mc8bb6cda8c2d795673618049b6c834b34bf86162

and at the time required some code refactoring but now thanks to all the
cleanups that Thomas has been doing over, I could just do it with Kconfig.

> I did too much at once by attempting to cut out msot of the fb core
> support that is not actually used by DRM at the same time.
>
> Doing just the Kconfig bits as you do here is probably better
> anyway, cutting out unneeded bits into separate modules or #ifdef
> sections can come later.
>

Exactly, that was my thought too. Glad that you agree with the approach.

>> @@ -59,7 +71,7 @@ config FIRMWARE_EDID
>> 
>>  config FB_DEVICE
>>  	bool "Provide legacy /dev/fb* device"
>> -	depends on FB
>> +	depends on FB_CORE
>>  	default y
>>  	help
>>  	  Say Y here if you want the legacy /dev/fb* device file and
>
> I don't see this symbol in linux-next yet, what tree are you using
> as a base?
>

It's now in the drm-misc/drm-misc-next branch [1]. It's not in -next yet
because it just landed a few days ago [2].

[1]: https://cgit.freedesktop.org/drm/drm-misc/log/?h=drm-misc-next
[2]: https://cgit.freedesktop.org/drm/drm-misc/commit/?id=701d2054fa3

In fact, that's the reason why I rebased my previous attempt [0].

>> @@ -69,13 +81,13 @@ config FB_DEVICE
>> 
>>  config FB_DDC
>>  	tristate
>> -	depends on FB
>> +	depends on FB_CORE
>>  	select I2C_ALGOBIT
>>  	select I2C
>
> This seems to only be used by actual fbdev drivers, so maybe
> don't change the dependency here.
>

Indeed.

>> @@ -162,22 +174,22 @@ endchoice
>> 
>>  config FB_SYS_FOPS
>>  	tristate
>> -	depends on FB
>> +	depends on FB_CORE
>
> Same for this one
>

Ok.

>>  config FB_HECUBA
>>  	tristate
>> -	depends on FB
>> +	depends on FB_CORE
>>  	depends on FB_DEFERRED_IO
>> 
>>  config FB_SVGALIB
>>  	tristate
>> -	depends on FB
>> +	depends on FB_CORE
>>  	help
>>  	  Common utility functions useful to fbdev drivers of VGA-based
>>  	  cards.
>>  config FB_MACMODES
>>  	tristate
>> -	depends on FB
>> +	depends on FB_CORE
>> 
>
> These three seem to actually be part of fbdev drivers rather
> than the core, and it may be best to move them into
> drviers/video/fbdev/ as standalone modules. That would be a
> separate patch of course.
>

Agreed. I'll then also don't change the dependency on these ones.

>>  config FB_BACKLIGHT
>>  	tristate
>> -	depends on FB
>> +	depends on FB_CORE
>>  	select BACKLIGHT_CLASS_DEVICE
>
> Separating this one from FB_CORE would help avoid circular dependencies,
> this one keeps causing issues.
>

You mean separating from FB or should I keep the existing depends on FB?

It seems this is only used by fbdev drivers so probably the latter?

>> @@ -1,22 +1,22 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
>> -obj-$(CONFIG_FB)                  += fb.o
>> -fb-y                              := fb_backlight.o \
>> +obj-$(CONFIG_FB_CORE)             += fb_core.o
>> +fb_core-y                         := fb_backlight.o \
>>                                       fb_info.o \
>>                                       fbmem.o fbmon.o fbcmap.o \
>>                                       modedb.o fbcvt.o fb_cmdline.o 
>
> I would not bother renaming the module itself here, that
> might cause problems if anything relies on loading the
> module by name or a named module parameter.
>

I was actually not sure about this, but then thought that someone could
had complained that the Kconfig symbol and module name wouldn't match :)

I'll just keep the existing module name then and drop the rename.

>       Arnd
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

