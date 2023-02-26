Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6835D6A32F0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBZQzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBZQzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:55:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7D3BB8A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:55:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so3248143pjg.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql+yDfRUjhQ1hgNI3xy6n4GGh0K0UVaI2xpdn33H+Ic=;
        b=gYQzSACEKh0zs4gFPgAXB6ArGX6MaqkokPlAQwWBJU2qG0PfuRW1zF3JRjMg7Y0Dya
         VuEcDJnPQrsh+Lj0/NiS5IB3blBUckTujvo0LDKo+s5WDq0HYlXoGnf9Ve1jqbCtzt9g
         6hrZx6WPgWklW2tx/3/MDT3SZDhnQvZOolf0ZRGxovUUp10oswne1b0C08XNOayUnSGC
         JDhWT5Litp5NOPJ3WE4z8qaGdx1yFxOZMu4Xag+gzcDDA37rwM6KYp3/AnY6ViC3Q6ZW
         3txK+vUt1zYlwUiP7haY6GZSX2TnrL4CiWIlruwDAhscf0NlaBE349I6yMNTILQrCs3H
         ga0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql+yDfRUjhQ1hgNI3xy6n4GGh0K0UVaI2xpdn33H+Ic=;
        b=cM2dAjkksSWPGJDA0P6TF9jQdEheNeZuQtf0/DeL7BQkpIxitwVa31i8+jkN/su8lb
         C1JQrWCrlDsD9TGVPeGtGjSyL9VTUCB1ghFjUrVuYTlts/7ohuw+SaObMZog7WQ8rXKV
         xepm3fVFKW0wleBUSnt+8r0H7Gk9PXFhIO4zENmnB+oM3/s6gSkvmhHPMr0H7S0y5Qh+
         xuKODnuPkKnUIj+ZrzTx3xN0g9F96+7Pp5TwPo1LoQnHVBgD6UQip7Wb1LOZqsuNzlJz
         bQEQyz+5uqwknjaaxViPyig48oleCVoHhKIzbWtXZyGRQtNTK8X1cg8EriRUX53xKyuS
         LHHA==
X-Gm-Message-State: AO0yUKVjpS6/APeCJIg66ufg1cilB6OiRUt4gb3mC6K0sD41FE1MBXXa
        uPwzEdIpMexa7+4vmEZnM90qCR/JkWLcz2YDougwQw==
X-Google-Smtp-Source: AK7set9Ikfshxz47YPGsMc6LSpX5SxueLD5B/mdGwn7HOn3xfGsl1Yx4OcF4JUNskEbnN2Ww16qkz8sXhfGraHOUlng=
X-Received: by 2002:a17:903:2404:b0:19c:9fa5:b68a with SMTP id
 e4-20020a170903240400b0019c9fa5b68amr4699738plo.11.1677430508330; Sun, 26 Feb
 2023 08:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20230219114553.288057-1-frank@oltmanns.dev> <20230219114553.288057-2-frank@oltmanns.dev>
In-Reply-To: <20230219114553.288057-2-frank@oltmanns.dev>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Sun, 26 Feb 2023 11:54:57 -0500
Message-ID: <CA+pv=HPY1HCDJ=sHeg_S7ZusS1RqiYvGOUf2bPVZK7Rq_EfHUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/panel: st7703: Fix vertical refresh rate of XBD599
To:     frank@oltmanns.dev
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 6:46=E2=80=AFAM Frank Oltmanns <frank@oltmanns.dev>=
 wrote:
>
> Fix the XBD599 panel's slight visual stutter by correcting the pixel
> clock speed so that the panel's 60Hz vertical refresh rate is met.
>
> Set the clock speed using the underlying formula instead of a magic
> number. To have a consistent procedure for both panels, set the JH057N
> panel's clock also as a formula.
> ---

Hi Frank,
Just wanted to let you know that this appears to be missing your Signed-off=
-by:.

Thanks,
-- Slade

>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/=
drm/panel/panel-sitronix-st7703.c
> index 6747ca237ced..cd7d631f7573 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -139,7 +139,7 @@ static const struct drm_display_mode jh057n00900_mode=
 =3D {
>         .vsync_start =3D 1440 + 20,
>         .vsync_end   =3D 1440 + 20 + 4,
>         .vtotal      =3D 1440 + 20 + 4 + 12,
> -       .clock       =3D 75276,
> +       .clock       =3D (720 + 90 + 20 + 20) * (1440 + 20 + 4 + 12) * 60=
 / 1000,
>         .flags       =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>         .width_mm    =3D 65,
>         .height_mm   =3D 130,
> @@ -324,7 +324,7 @@ static const struct drm_display_mode xbd599_mode =3D =
{
>         .vsync_start =3D 1440 + 18,
>         .vsync_end   =3D 1440 + 18 + 10,
>         .vtotal      =3D 1440 + 18 + 10 + 17,
> -       .clock       =3D 69000,
> +       .clock       =3D (720 + 40 + 40 + 40) * (1440 + 18 + 10 + 17) * 6=
0 / 1000,
>         .flags       =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>         .width_mm    =3D 68,
>         .height_mm   =3D 136,
> --
> 2.39.1
>
