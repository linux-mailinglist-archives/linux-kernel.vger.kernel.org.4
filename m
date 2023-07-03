Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE3174578B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGCIon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGCIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07399E56
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688373831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zp5g9NpYfxNAKr8x3hzhFJpQgOx/itKdI6XRa55tcZ4=;
        b=IsYFA+sGcEB9QREBthJrAxtlzMD7//07UB7xguL29B5Kl5yfkGk5b92ncOtg9K9rzAalHc
        BBJF0GURq10U2/tEFBGwGKBFb0ATiUE4pppz185l1Z0CnkglHQoHczdVF2g5FMWspc32gf
        Q9LBD8EKuXrHFyz1XDOAxCgS7B7XQas=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427--uFzpSOWOTqZOHvFW4HkMw-1; Mon, 03 Jul 2023 04:43:49 -0400
X-MC-Unique: -uFzpSOWOTqZOHvFW4HkMw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31400956ce8so2371344f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688373828; x=1690965828;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp5g9NpYfxNAKr8x3hzhFJpQgOx/itKdI6XRa55tcZ4=;
        b=M3nQVcIKhI8FKROT/tkrwL+LpyJL0v9YAlVvd+UbS1eBmuc95extS+iBuWqLIFX64q
         UZSDKh4pG+ifX5QZ0Eqb8exQ3saaqQ3zf5QoiFFPh5UQwdillP9ygKe7m3jgd0BaOU8w
         dzTgz4omaV/YRvobQWdJYp+jc8bbat/o3nU86wN2s11TyKLs74s68AsGigbFeJThx317
         q3GUAv9900YKUnsRt0I4CUOnsaGzaB684u5ZUN8u801Xyio+rj1vjytGDtpWoDMKl3+o
         MALhpEnQE54asonVUsS8ZlOOIBreHbNFTRinYrY+IlcEmRfGLr3iO1UHyNKwxJqO/Lwv
         QBDw==
X-Gm-Message-State: ABy/qLYQ0VlsoKqeQTE5mwmAKff8EfPbE/SzS/sTY85EsB6gIlCqUNqU
        4YcYdg6fsgoKz5frqGo9LoNXjoO44tXURx93JbQzBpu6VB2WXtwW1klYHEwND2tR0r7g7QbTIps
        pW9mHAEzlCaVwh9dYspWi9vAf
X-Received: by 2002:a5d:4143:0:b0:313:f94b:54e6 with SMTP id c3-20020a5d4143000000b00313f94b54e6mr7345896wrq.71.1688373827947;
        Mon, 03 Jul 2023 01:43:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8Sgct2ZKOCxkKDgyrN07WyPQuy43UZE9MgiqZYPp0ju4sHwD649De1/MCHiwbo3Wl8IAHIA==
X-Received: by 2002:a5d:4143:0:b0:313:f94b:54e6 with SMTP id c3-20020a5d4143000000b00313f94b54e6mr7345872wrq.71.1688373827611;
        Mon, 03 Jul 2023 01:43:47 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d17-20020adffbd1000000b002fb60c7995esm24990543wrs.8.2023.07.03.01.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 01:43:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/2] Allow disabling all native fbdev drivers and only
 keeping DRM emulation
In-Reply-To: <ZKKFDECBXfQF+n8Z@smile.fi.intel.com>
References: <20230629225113.297512-1-javierm@redhat.com>
 <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
 <878rc0etqe.fsf@minerva.mail-host-address-is-not-set>
 <ZJ8T/Fexkr9wEZoP@smile.fi.intel.com>
 <875y74elsv.fsf@minerva.mail-host-address-is-not-set>
 <ZKKFDECBXfQF+n8Z@smile.fi.intel.com>
Date:   Mon, 03 Jul 2023 10:43:46 +0200
Message-ID: <87zg4dcrlp.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, Jun 30, 2023 at 10:29:20PM +0200, Javier Martinez Canillas wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Fri, Jun 30, 2023 at 07:38:01PM +0200, Javier Martinez Canillas wrote:
>> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> >> > On Fri, Jun 30, 2023 at 12:51:02AM +0200, Javier Martinez Canillas wrote:
>> >> >> This patch series splits the fbdev core support in two different Kconfig
>> >> >> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>> >> >> be disabled, while still having the the core fbdev support needed for the
>> >> >> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
>> >> >> disabling all fbdev drivers instead of having to be disabled individually.
>> >> >> 
>> >> >> The reason for doing this is that now with simpledrm, there's no need for
>> >> >> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
>> >> >
>> >> > How does simpledrm works with earlycon=efi?
>> >> >
>> >> 
>> >> simpledrm isn't for earlycon. For that you use a different driver (i.e:
>> >> drivers/firmware/efi/earlycon.c). I'm just talking about fbdev drivers
>> >> here that could be replaced by simpledrm.
>> >
>> > So, efifb can't be replaced. Please, fix your cover letter to reduce false
>> > impression of the scope of usage of the simpledrm.
>> >
>> 
>> Nothing to fixup.
>> 
>> You are conflating the efifb fbdev driver (drivers/video/fbdev/efifb.c)
>> with the efifb earlycon driver (drivers/firmware/efi/earlycon.c). I'm
>> talking about the former (which can be replaced by simpledrm) while you
>> are talking about the latter.
>
> Ah, this makes sense!
>
> I remember now that it was (still is?) an attempt to move from efifb to
> simpledrm, but have no idea what the status of that series is.
>

Indeed. And there was were also some patches IIRC to attempt porting the
earlycon efifb to a fbdev or DRM driver, can't remember now.

> -- 
> With Best Regards,
> Andy Shevchenko
>
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

