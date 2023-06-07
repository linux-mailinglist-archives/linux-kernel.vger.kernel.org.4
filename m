Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1298D726212
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbjFGOEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjFGOEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:04:07 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D61BD9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:04:06 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33e55420745so2157485ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686146645; x=1688738645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5UbzVeA3KuVw0vrmVmOEU7zOkqX+n/eTuvBtyMAf0M=;
        b=Gd+LKl9o/yL/oEorKW0gDIZnwRRXR+jlPHJfMjC9D5wnddbpEE2zare5YF9lZztwOq
         ib5UNOnW7zdZ5SsUxy+z1E8/JDqOmz46vXSXJ5WpfIUEz9Ns34gdZaitEadLtUDNV/V4
         5R3HBwDZGC97DMPgxihOicOKSBURUfx66p16A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686146645; x=1688738645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5UbzVeA3KuVw0vrmVmOEU7zOkqX+n/eTuvBtyMAf0M=;
        b=GZ9pIyrUm4MLdPA5zeJBkNR2PzLg7hPVWxtjTfuHJRyZagVvBnF27Q1dbqPCsuXuwO
         Ir8hbIMD0DKCc6zrwsWyAvROH8y0DEvzL2dDeUVO1F3t4JYSYMcW7VIScBWWJPKBVlYX
         x8P01FrFdVfCuNtFFH6CCfsAjYDeLZX0w9sFjEI4G6LcjZV1Coav8XOwC9SLtLtNtGlA
         lnw61j+hk0enUSEsPNQwIvz7TJaGhOBZELFwVjLEb6jkuDVunJ02QBNfA7cTu8nYTvOr
         faOvU6uq/sXDmz5bk8bCTz5gMd/gs9Nh/3paEgfBqr7985EwX7O21nJ3TbtzDJ+6IAsp
         b0yg==
X-Gm-Message-State: AC+VfDyezjNYA4mJiBvCEkSR3on8mArdroEW77SeQlhbce4gOWTv4L8C
        L2x63TLsAyY/ymhxi1bmVNBprszn/P3hYkB/QsQ=
X-Google-Smtp-Source: ACHHUZ7aVCWTjvp2StH2S/XRHXC7ZiilI/+EfrIiL1LAd9OwYG4zW7XIjzJ9kA2m5kwL/UFIBS4pGA==
X-Received: by 2002:a92:ac11:0:b0:333:49f9:a5f3 with SMTP id r17-20020a92ac11000000b0033349f9a5f3mr3857935ilh.2.1686146645029;
        Wed, 07 Jun 2023 07:04:05 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id m26-20020a02c89a000000b00420bf02fc47sm680434jao.28.2023.06.07.07.04.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:04:04 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33d928a268eso136655ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:04:03 -0700 (PDT)
X-Received: by 2002:a05:6e02:174c:b0:338:1993:1194 with SMTP id
 y12-20020a056e02174c00b0033819931194mr224583ill.2.1686146641918; Wed, 07 Jun
 2023 07:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230607012355.442707-1-suhui@nfschina.com>
In-Reply-To: <20230607012355.442707-1-suhui@nfschina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 07:03:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UxzUoAPbKtX3Xvq=g8DNcatQ8-s-8rcGEeE+G40a9RhQ@mail.gmail.com>
Message-ID: <CAD=FV=UxzUoAPbKtX3Xvq=g8DNcatQ8-s-8rcGEeE+G40a9RhQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow
To:     Su Hui <suhui@nfschina.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, andersson@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 6, 2023 at 6:25=E2=80=AFPM Su Hui <suhui@nfschina.com> wrote:
>
> Smatch error:buffer overflow 'ti_sn_bridge_refclk_lut' 5 <=3D 5.
>
> Fixes: cea86c5bb442 ("drm/bridge: ti-sn65dsi86: Implement the pwm_chip")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 7a748785c545..bb88406495e9 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -305,7 +305,7 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn=
65dsi86 *pdata)
>          * The PWM refclk is based on the value written to SN_DPPLL_SRC_R=
EG,
>          * regardless of its actual sourcing.
>          */
> -       pdata->pwm_refclk_freq =3D ti_sn_bridge_refclk_lut[i];
> +       pdata->pwm_refclk_freq =3D ti_sn_bridge_refclk_lut[i < refclk_lut=
_size ? i : 1];

This looks more correct, but it really needs a comment since it's
totally not obviously what you're doing here. IMO the best solution
here is to update "i" right after the for loop and have a comment
about the datasheet saying that "1" is the default rate so we'll fall
back to that if we couldn't find a match. Moving it to right after the
for loop will change the value written into the registers, but that's
fine and makes it clearer what's happening.


-Doug

On Tue, Jun 6, 2023 at 6:25=E2=80=AFPM Su Hui <suhui@nfschina.com> wrote:
>
> Smatch error:buffer overflow 'ti_sn_bridge_refclk_lut' 5 <=3D 5.
>
> Fixes: cea86c5bb442 ("drm/bridge: ti-sn65dsi86: Implement the pwm_chip")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 7a748785c545..bb88406495e9 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -305,7 +305,7 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn=
65dsi86 *pdata)
>          * The PWM refclk is based on the value written to SN_DPPLL_SRC_R=
EG,
>          * regardless of its actual sourcing.
>          */
> -       pdata->pwm_refclk_freq =3D ti_sn_bridge_refclk_lut[i];
> +       pdata->pwm_refclk_freq =3D ti_sn_bridge_refclk_lut[i < refclk_lut=
_size ? i : 1];
>  }
>
>  static void ti_sn65dsi86_enable_comms(struct ti_sn65dsi86 *pdata)
> --
> 2.30.2
>
