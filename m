Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B863A6D2970
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCaU33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaU31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:29:27 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9759DB76E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:29:26 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id dc30so19691840vsb.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680294565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgY7ioG8j1aHH/GlwYCmuWvPm8w3+ppWkBC1qAdYysc=;
        b=YX/bRjznJ8xD5/mresCU7N/d7uXrhY+Hsb3XEYAwhTMnItg8/QlitFXqoi+ZR+iwa6
         xadNEXj7hI0PDvQDcSaZyCnz9iTK1h2Pya+3RiE79EMgjCuUpG6meWWtcWilcDpy5jwf
         PlsTDSWcHS4oPM46X+COaHpr+wUuGTe9z25C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgY7ioG8j1aHH/GlwYCmuWvPm8w3+ppWkBC1qAdYysc=;
        b=WPBADGYtdSxSxEz9bqkdMsHb4Zrbv0CHsf+UdJkWUXO5gHYcGGgmVguvAk4eTQPd1D
         9LyRuidc6rKHjIAtkyaysDnOqcNhg6HGtRjbrMK9wjsysIejcOlf1FUBQVsLTybgS3TT
         AnI9MLTnmApAnCBehqTTwAdBUtManXGv6r/bYu4gSkm+jFqGAUaVygtZxWt1k7WO9otI
         TrXHs3oFfETK4w8+Gyx+Myp6Ybu0JoMrSVKQZWSLCBSEsUaD3zsV8SyRaO6jE6//Wtoh
         XntjKVTkDQdLhEI5G0wrdKlTK4kh7YJ//SxBU3+zPlDGE2qEZL7Sqz4rUYA1ShbHzcEq
         g6Yg==
X-Gm-Message-State: AAQBX9dH40NTUc4D7COjB4biFYzU2vHelKNypurlkPVj6ElVkvZUG2ox
        2mAS90i4Ixm0AJC95qx+AIeAKOr6hf89oC5I5hc=
X-Google-Smtp-Source: AKy350bCRWmf8u+p0I1BinTtQiFjdPEvzTszRoEHOca7TzaVCrZgITG40IGyReCVQEjMATq8bjcLpQ==
X-Received: by 2002:a67:f5cd:0:b0:416:adb3:5caf with SMTP id t13-20020a67f5cd000000b00416adb35cafmr10477511vso.28.1680294564749;
        Fri, 31 Mar 2023 13:29:24 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id t17-20020ab04ad1000000b006902fab627bsm620088uae.24.2023.03.31.13.29.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 13:29:23 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id g9so16958678uam.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:29:23 -0700 (PDT)
X-Received: by 2002:ab0:318c:0:b0:765:c225:c914 with SMTP id
 d12-20020ab0318c000000b00765c225c914mr8048524uan.1.1680294563053; Fri, 31 Mar
 2023 13:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230331030204.1179524-1-treapking@chromium.org>
In-Reply-To: <20230331030204.1179524-1-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 31 Mar 2023 13:29:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XdthxVh=wTR5hLj3sy=X__nYQge5=SBXB=eAENe0bd1g@mail.gmail.com>
Message-ID: <CAD=FV=XdthxVh=wTR5hLj3sy=X__nYQge5=SBXB=eAENe0bd1g@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Use constant sleep time for polling hpd
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 30, 2023 at 8:02=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> The default hpd_wait_us in panel_edp.c is 2 seconds. This makes the
> sleep time in the polling of _ps8640_wait_hpd_asserted become 200ms.
> Change it to a constant 20ms to speed up the function.

Ah, I see why I never ran into this. All the panels I worked with
specified "hpd_absent" of 200 and thus I've always been using 20.


> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index b823e55650b1..c3eb45179405 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -184,7 +184,7 @@ static int _ps8640_wait_hpd_asserted(struct ps8640 *p=
s_bridge, unsigned long wai
>          * actually connected to GPIO9).
>          */
>         ret =3D regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
> -                                      status & PS_GPIO9, wait_us / 10, w=
ait_us);
> +                                      status & PS_GPIO9, 20000, wait_us)=
;

I'd have been tempted to go even lower at 10ms. Waiting for HPD isn't
something that we do all the time during a normal running system and
thus it's not something we have to optimize every last bit of power
out of. The user would generally rather have the system boot up or
switch modes 10ms faster. ;-)

In any case, either at 10ms or 20ms:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
