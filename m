Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097F5744CDA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGBJE5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Jul 2023 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:04:56 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BBD1A2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 02:04:54 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so3709807276.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 02:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688288693; x=1690880693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0rKPpyZ8Vpl4zrPLQreT82vhpL2lp3WXuUoTDayFbI=;
        b=l7w7iSmwlSqjesxgJ1uci5nV+Jds0YC91PSXyuddGLO2xQpku+SE9t1trR5RsT8Y+s
         iJnD5AXQBXOJSU2rHPB1UiBnN6h25ilVuRZTLMSNB0f5N+64CxoPPeDMNAmm2Ndy8YOf
         D4aVdBGAEgSfUSUO/DAfmNUf269CNMyt6xSR7L+ALDIpfg6ukvH6rXFWZRh0t00+Kjv1
         aIohCqwCbVk6GoMuSIAD0AAG39jLABrPEK8i/lQQsr9yY/grYnAlaG7Jj5+OHS7oX7lq
         M7sYnhkoD0cSTt5Eme/S5W38twJosG9lK/hwOqCGaJ4GlRy2hfM4i6QnUZP9pdmyHlZB
         hpWQ==
X-Gm-Message-State: ABy/qLYPgCFNyFSd+ApNNrUGkqvnDl5usrygcLsbkif3uYZqErns11sg
        4qTZLqaXQNUpDSr3oETrrsj3JcT9K8sN6t2T
X-Google-Smtp-Source: APBJJlEHtDoQBhh+t7X5wpNp3LInGZiGaqHbjrM1Cak0uXhkVKlASKotxanR159RY2/IdTQNLMHqRw==
X-Received: by 2002:a25:ccd6:0:b0:bc6:cf90:a286 with SMTP id l205-20020a25ccd6000000b00bc6cf90a286mr7061667ybf.36.1688288693103;
        Sun, 02 Jul 2023 02:04:53 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 127-20020a250b85000000b00be8e8772025sm3772516ybl.45.2023.07.02.02.04.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 02:04:52 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5776312eaddso23157987b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 02:04:52 -0700 (PDT)
X-Received: by 2002:a0d:d649:0:b0:570:65df:21dc with SMTP id
 y70-20020a0dd649000000b0057065df21dcmr7384264ywd.3.1688288692547; Sun, 02 Jul
 2023 02:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230701214503.550549-1-javierm@redhat.com> <20230701214503.550549-3-javierm@redhat.com>
 <2e1af219-a31c-4284-b50a-662f65c8a736@app.fastmail.com>
In-Reply-To: <2e1af219-a31c-4284-b50a-662f65c8a736@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Jul 2023 11:04:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQ3FcmyCd-mWOWVAXzgoOX8wBD8-LbRwjNkC=sz3y27g@mail.gmail.com>
Message-ID: <CAMuHMdWQ3FcmyCd-mWOWVAXzgoOX8wBD8-LbRwjNkC=sz3y27g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm: Make fbdev emulation select FB_CORE instead
 of depends on FB
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
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

On Sun, Jul 2, 2023 at 12:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Jul 1, 2023, at 23:44, Javier Martinez Canillas wrote:
> > Now that the fbdev core has been split in FB_CORE and FB, make DRM fbdev
> > emulation layer to just select the former.
> >
> > This allows to disable the CONFIG_FB option if is not needed, which will
> > avoid the need to explicitly disable each of the legacy fbdev drivers.
> >
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> >
> > Changes in v2:
> > - Make CONFIG_DRM_FBDEV_EMULATION to select FB_CORE (Thomas Zimmermann).
> >
> >  drivers/gpu/drm/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index afb3b2f5f425..d9b1710e3ad0 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -132,7 +132,7 @@ config DRM_DEBUG_MODESET_LOCK
> >  config DRM_FBDEV_EMULATION
> >       bool "Enable legacy fbdev support for your modesetting driver"
> >       depends on DRM_KMS_HELPER
> > -     depends on FB=y || FB=DRM_KMS_HELPER
> > +     select FB_CORE
>
> This will unfortunately force FB_CORE=y even with DRM=m, it would be nice
> to allow both to be loadable modules. Any of these should work:
>
> a) Add another hidden symbol like
>
> config DRM_FB_CORE
>       def_tristate DRM && DRM_FBDEV_EMULATION
>       select FB_CORE

More complexity to keep track of...

>
> b) move the 'select' to DRM
>
> config DRM
>       tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
>       select FB_CORE if DRM_FBDEV_EMULATION

I prefer this one, as it keeps the select close to the user.

BTW, the tristate help text can use some overhaul ;-)

> c) Remove the 'select' and instead use the default
>
> config FB_CORE
>      def_tristate FB || (DRM && DRM_FBDEV_EMULATION)

Adding it here means this patch would touch two subsystems.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
