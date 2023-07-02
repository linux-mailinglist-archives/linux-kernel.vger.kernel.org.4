Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E627744D33
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGBKSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 06:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGBKSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F501B0
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688293054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Rc7GObebSLsl0SfAjmT8VMbjzHyCrfzHw94P9chOzQ=;
        b=Ve8/Q9+uRrvxBt5ZtoetZjCzXCQfwWqo/Z4ZuXxIew4cCw2kXzGDaUFsL7Q0vt6XeRjQ7B
        vzmRRWXcCiTdcI6xFPj1XU3ptSaBWrttCNtv7CREKbv+LMv1u6d45X79LPwl1oiuzQg66A
        ux4ccF6GG+wOjWSw/zlOjSmZmBXuLN8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-JoFewDFJNquYLfSVnhbhsg-1; Sun, 02 Jul 2023 06:17:33 -0400
X-MC-Unique: JoFewDFJNquYLfSVnhbhsg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31273e0507dso1945907f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 03:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688293052; x=1690885052;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Rc7GObebSLsl0SfAjmT8VMbjzHyCrfzHw94P9chOzQ=;
        b=ClstoG3+Xuau3OXqO5qkUlY1kYt0IeWyYQUwnOpsbC1pJAdlx7xtuoUQmIGwp4iZ3p
         tPMO4qLvBkdi+9LYwUE9/JpGGIu7k2mLZY8McH3WhZZppZtn/gFZwM9XHzWxNjthRPAf
         E9gyy0ILlZCUfATvZEMcBFJ37xPhzmsGBTyXmPmzPv0aw2SKzWq9HsxGL0hFodA6I8lX
         yyagXdY50xX/2eeK2G18YFFoMZRx3+xTf92rdzvbxGNTepvIZh48RB6goJiYp429MpXF
         z0UgpmSJCFTpRasIfwCviavvCIOJ2mF+77W1wKwjED81AMQJxiPCv4BwtZMVIOOg9bkg
         SktA==
X-Gm-Message-State: ABy/qLag8SnYJ46p0oz2NNBe3glvLuLL676uowHYK9aggOmjocmLO3hY
        38ExKolY4wIbu13E7ZQCrf9NscCMGNxUnRzwx9tHU8Rt6Cb8Gi4ym75EXXRJGoQHpjSC7kaS6rS
        sfed/Du2tT3Pf0gLFICKxVoNc
X-Received: by 2002:a5d:4241:0:b0:314:824:3788 with SMTP id s1-20020a5d4241000000b0031408243788mr5810508wrr.27.1688293052281;
        Sun, 02 Jul 2023 03:17:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFBCAOu7OFCNVzqZx1EnJFwPsYWJLgCib6uWdV2rObYQHRV8UfoOTb9ppNV4eEbFaDED779ww==
X-Received: by 2002:a5d:4241:0:b0:314:824:3788 with SMTP id s1-20020a5d4241000000b0031408243788mr5810498wrr.27.1688293051928;
        Sun, 02 Jul 2023 03:17:31 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b0030ae53550f5sm22677128wrz.51.2023.07.02.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 03:17:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm: Make fbdev emulation select FB_CORE instead
 of depends on FB
In-Reply-To: <CAMuHMdWQ3FcmyCd-mWOWVAXzgoOX8wBD8-LbRwjNkC=sz3y27g@mail.gmail.com>
References: <20230701214503.550549-1-javierm@redhat.com>
 <20230701214503.550549-3-javierm@redhat.com>
 <2e1af219-a31c-4284-b50a-662f65c8a736@app.fastmail.com>
 <CAMuHMdWQ3FcmyCd-mWOWVAXzgoOX8wBD8-LbRwjNkC=sz3y27g@mail.gmail.com>
Date:   Sun, 02 Jul 2023 12:17:30 +0200
Message-ID: <87sfa6aa85.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Arnd,
>
> On Sun, Jul 2, 2023 at 12:07=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wro=
te:
>> On Sat, Jul 1, 2023, at 23:44, Javier Martinez Canillas wrote:
>> > Now that the fbdev core has been split in FB_CORE and FB, make DRM fbd=
ev
>> > emulation layer to just select the former.
>> >
>> > This allows to disable the CONFIG_FB option if is not needed, which wi=
ll
>> > avoid the need to explicitly disable each of the legacy fbdev drivers.
>> >
>> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> > ---
>> >
>> > Changes in v2:
>> > - Make CONFIG_DRM_FBDEV_EMULATION to select FB_CORE (Thomas Zimmermann=
).
>> >
>> >  drivers/gpu/drm/Kconfig | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> > index afb3b2f5f425..d9b1710e3ad0 100644
>> > --- a/drivers/gpu/drm/Kconfig
>> > +++ b/drivers/gpu/drm/Kconfig
>> > @@ -132,7 +132,7 @@ config DRM_DEBUG_MODESET_LOCK
>> >  config DRM_FBDEV_EMULATION
>> >       bool "Enable legacy fbdev support for your modesetting driver"
>> >       depends on DRM_KMS_HELPER
>> > -     depends on FB=3Dy || FB=3DDRM_KMS_HELPER
>> > +     select FB_CORE
>>
>> This will unfortunately force FB_CORE=3Dy even with DRM=3Dm, it would be=
 nice
>> to allow both to be loadable modules. Any of these should work:
>>

Right, I missed that. Thanks for pointing that out.

>> a) Add another hidden symbol like
>>
>> config DRM_FB_CORE
>>       def_tristate DRM && DRM_FBDEV_EMULATION
>>       select FB_CORE
>
> More complexity to keep track of...
>

Yes, I would avoid this option as well.

>>
>> b) move the 'select' to DRM
>>
>> config DRM
>>       tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI s=
upport)"
>>       select FB_CORE if DRM_FBDEV_EMULATION
>
> I prefer this one, as it keeps the select close to the user.
>

Agreed with Geert that this is the best option.

> BTW, the tristate help text can use some overhaul ;-)
>

Indeed :) I will add a preparatory patch to this series improving that
prompt text.

>> c) Remove the 'select' and instead use the default
>>
>> config FB_CORE
>>      def_tristate FB || (DRM && DRM_FBDEV_EMULATION)
>
> Adding it here means this patch would touch two subsystems.
>

Yeah. Even when in practice we push changes for drivers/video and
drivers/gpu/drm in drm-misc, I agree that option (b) is better.

> Gr{oetje,eeting}s,
>
>                         Geert
>
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

