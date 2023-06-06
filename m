Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66C67247B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbjFFP3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjFFP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:29:13 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3009E100
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:29:12 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33b1e83e204so23086035ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686065350; x=1688657350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FicGEFlUfAYOIaGezdZ6xTGOhAj3FNMamu1kcWTnkk0=;
        b=NWdCKKaKcWDFHE4Xl7VH86XdpglNK2tGXeALuGF5t78kWhFjo/8CDZlspJkskaYOdk
         13+HG4as72mv19XP87BJe7ZMrE4r0xgK8oOzsXnoCBnHc8EpXf3etKKZRE66NTHV3NeT
         pJv6NQwsN84PGQ8dhqX8xNVOnKljQaXXfAuMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686065350; x=1688657350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FicGEFlUfAYOIaGezdZ6xTGOhAj3FNMamu1kcWTnkk0=;
        b=QoLW0CGyctx2ztBu1qtbMPicf4J8oruOd3tuPfkRSThHnwQhiHl3SR98xVEGAC74ff
         veToUbtp0Rz3pC7D5d+TSSn/RJ0ZNtox2kSJptfUCGBf3FdNQbpj3ID4se+wD/RI9mdy
         JENs3j7u9jPyPM5MIuIH3PeTBFgtoEJ7KWfOJb0LNzu+X2Nx+aacUSeCqUtVuKq0jv/A
         wLLV8YVXrdDrA3tjzeaVLvx3Kn+I8xANOvSRBFPMM+30G5pC/smXkme6kaZzK4C/v12+
         WkqffsyALh3bI2GhDHz9yjpN2zJH20xE46lhfhP4hPL8OI7NOIsKvTIXfWo3yPLzKnvy
         f62w==
X-Gm-Message-State: AC+VfDyDoBs5bvF48p5CvEGnH1kljqBDq1RJQ+KqC9COKM2JGkLVq+UX
        Y/vxlVolh26qpl0R53Ka90U1P9I4gOcCI574tvM=
X-Google-Smtp-Source: ACHHUZ6pgx+lyBy4w/HKBX8pF0d+yKXTPoSJeQBRqwQYXmhGYKLb6QgCzZIZsRbgKpge24ooHFcjyQ==
X-Received: by 2002:a92:cec6:0:b0:335:8dd:cf16 with SMTP id z6-20020a92cec6000000b0033508ddcf16mr2960024ilq.9.1686065350695;
        Tue, 06 Jun 2023 08:29:10 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id b16-20020a92ce10000000b003358f4eb209sm3140243ilo.60.2023.06.06.08.29.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:29:08 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so186255ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:29:08 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a02:b0:33d:67c9:a486 with SMTP id
 s2-20020a056e021a0200b0033d67c9a486mr229492ild.26.1686065347967; Tue, 06 Jun
 2023 08:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230606075527.155346-1-suhui@nfschina.com>
In-Reply-To: <20230606075527.155346-1-suhui@nfschina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Jun 2023 08:28:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_n4Si3k4iQ0yRJZRqX2DuhGF2pjPqEzbiKqBY3ZCNHg@mail.gmail.com>
Message-ID: <CAD=FV=X_n4Si3k4iQ0yRJZRqX2DuhGF2pjPqEzbiKqBY3ZCNHg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Avoid possible buffer overflow
To:     Su Hui <suhui@nfschina.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, andersson@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        u.kleine-koenig@pengutronix.de
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

On Tue, Jun 6, 2023 at 12:56=E2=80=AFAM Su Hui <suhui@nfschina.com> wrote:
>
> Smatch error:buffer overflow 'ti_sn_bridge_refclk_lut' 5 <=3D 5.
>
> Fixes: cea86c5bb442 ("drm/bridge: ti-sn65dsi86: Implement the pwm_chip")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 7a748785c545..952aae4221e7 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -305,7 +305,8 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn=
65dsi86 *pdata)
>          * The PWM refclk is based on the value written to SN_DPPLL_SRC_R=
EG,
>          * regardless of its actual sourcing.
>          */
> -       pdata->pwm_refclk_freq =3D ti_sn_bridge_refclk_lut[i];
> +       if (i < refclk_lut_size)
> +               pdata->pwm_refclk_freq =3D ti_sn_bridge_refclk_lut[i];

I don't think this is quite the right fix. I don't think we can just
skip assigning "pdata->pwm_refclk_freq". In general I think we're in
pretty bad shape if we ever fail to match a refclk from the table and
I'm not quite sure how the bridge chip could work at all in this case.
Probably that at least deserves a warning message in the logs. There's
no place to return an error though, so I guess the warning is the best
we can do and then we can do our best to do something reasonable.

In this case, I think "reasonable" might be that if the for loop exits
and "i =3D=3D refclk_lut_size" that we should set "i" to 1. According to
the datasheet [1] setting a value of 5 (which the existing code does)
is the same as setting a value of 1 (the default) and if it's 1 then
we'll be able to look this up in the table.


[1] https://www.ti.com/lit/gpn/sn65dsi86

-Doug
