Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000D46BD5A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCPQbK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Mar 2023 12:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCPQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:31:08 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBBBDDF29
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:31:05 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-544787916d9so41850737b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678984264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onE1BSa8siKq3creWSMcSkNL7lBSXVXcbw9MfjVIBVY=;
        b=G9cfY8kyKnm9zrjQs7dFwcW9j92E5uODjNP4NBNRXR7KaHR+i5dlBnSM6+/0X/gM7F
         T6xuy43rQuFwLv1M/zVqOasKtgkheZ8nc4fuEtPcBVwnCw3D/iQFrWOTC2YacKlel4ux
         YuUs1q4ZhhRAoUij3WJgOUyWwAJ9wiwpwTOdpJSdEr2kI0og46Yiu0EUBeWi0WfG68fy
         fA8uH0J+IF1BS3fPKXKexQetWJ+ihIH73cc13DEBf0vVMfVT3lVX6fPcQ20b9U2+vR2/
         hqhcQ9TcWqQAhWQkOo1FASNLp8kOUUFr+iWa3ImxoJ3nYlTPvMfdwiTjdNBj6c0QQouS
         2Dyg==
X-Gm-Message-State: AO0yUKXGeKaEgBdHN4S3wQlydUjRGEt7OjJ1gKn9sVaZLlogXi6dBhgd
        IYb6unLZtn6fYD02w+u+L+y5siQislVDIw==
X-Google-Smtp-Source: AK7set+uy5lK+XufkTap+Cws+xL4nYfNiIb7UPgVOY4Uc55RHbu37iFhZk6LqtvN/h4OGX8N9PSJ+g==
X-Received: by 2002:a05:7508:104e:b0:4d:1821:f929 with SMTP id i14-20020a057508104e00b0004d1821f929mr846322gbi.12.1678984264411;
        Thu, 16 Mar 2023 09:31:04 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id q9-20020a37f709000000b0073d873df3fesm6099526qkj.30.2023.03.16.09.31.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 09:31:03 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id y5so2605337ybu.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:31:03 -0700 (PDT)
X-Received: by 2002:a05:6902:145:b0:ac2:a7a7:23c3 with SMTP id
 p5-20020a056902014500b00ac2a7a723c3mr21898287ybh.12.1678984262946; Thu, 16
 Mar 2023 09:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230307215039.346863-1-javierm@redhat.com>
In-Reply-To: <20230307215039.346863-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Mar 2023 17:30:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUs0bXz1T41=bW0D1NwVYZyKUsrjCkF2hGsRPSt5+qvMA@mail.gmail.com>
Message-ID: <CAMuHMdUs0bXz1T41=bW0D1NwVYZyKUsrjCkF2hGsRPSt5+qvMA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/format-helper: Make conversion_buf_size() support
 sub-byte pixel fmts
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Arthur Grillo <arthurgrillo@riseup.net>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Gow <davidgow@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Mar 7, 2023 at 10:54 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> There are DRM fourcc formats that have pixels smaller than a byte, but the
> conversion_buf_size() function assumes that pixels are a multiple of bytes
> and use the struct drm_format_info .cpp field to calculate the dst_pitch.
>
> Instead, calculate it by using the bits per pixel (bpp) and divide it by 8
> to account for formats that have sub-byte pixels.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> Tested by making sure that the following command still succeeds:
>
> ./tools/testing/kunit/kunit.py run \
> --kunitconfig=drivers/gpu/drm/tests/.kunitconfig
>
> Changes in v2:
> - Drop an unused variable, that was pointed out by the kernel robot.

Thanks for your patch!

> --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> @@ -409,12 +409,15 @@ static size_t conversion_buf_size(u32 dst_format, unsigned int dst_pitch,
>                                   const struct drm_rect *clip)
>  {
>         const struct drm_format_info *dst_fi = drm_format_info(dst_format);
> +       unsigned int bpp;
>
>         if (!dst_fi)
>                 return -EINVAL;
>
> -       if (!dst_pitch)
> -               dst_pitch = drm_rect_width(clip) * dst_fi->cpp[0];
> +       if (!dst_pitch) {
> +               bpp = drm_format_info_bpp(dst_fi, 0);
> +               dst_pitch = DIV_ROUND_UP(drm_rect_width(clip) * bpp, 8);

I know I'm a bit late to the party,  but here's actually a helper for that:

    dst_pitch = drm_format_info_min_pitch(info, 0, drm_rect_width(clip));

> +       }
>
>         return dst_pitch * drm_rect_height(clip);
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
