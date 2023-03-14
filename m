Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548386BA175
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCNVaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCNVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:30:21 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3051F92F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:30:20 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id 4so9355058ilz.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678829418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsMceCqob1v/eZx8VljwvrzXfHSSxRsvo6NsNcMmoXs=;
        b=bnLAcAb45oqt2qYPf6nAybs38nR7U2n76pgqYycg2+MD2EdRQgUOgVH4SbraH5LB74
         Yrdbe35Jvz0fVUUdcD79C+pDQ2MB6MvRuBW0RnHfO3Nd8pAc5TzAkblnuaBRmfbC0Bdc
         zfLs+pZogwNO7kKt8HmAxkolq2Mgd0o779GXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678829418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsMceCqob1v/eZx8VljwvrzXfHSSxRsvo6NsNcMmoXs=;
        b=dG7XjGa0HN7xTWRBuUmBcCUzzYs0FSXG/X+/MwQfIFhqg/+sdpVfP/p2dlFx0JWuNu
         IAJhI3NoU7PKinkhLOcaAxhgp+cCGvXRFMREqkFYksIkcUvIiZD+Mg1cdsiOyz0ihoNK
         rK6SP0zfVyzOJy3sI7EoHw+m+RapLwsW0dFqFmdjBQuso8cq5OImD6UAuoP3h/ZNA2hw
         vMxTSClL/Y6shoaB/eKGBItzEsFfE2iamb9MRnsWeWbcaZ9dzqUCaNAmeRN7t+ES3kCZ
         SKUJdGMJHfypRnrtib1pVZ1RcTPexQ48IxfUPj5bj8ZBXt0SQCqYBCCoQoWhHaSdKxVU
         dYgA==
X-Gm-Message-State: AO0yUKVEMTAfST2uN0YfPbEy9rBnY3DR+cTP/zJbORIhygbwJmF+/Hh0
        9kUr6FlzGEHx1Hjbh6K+t6mTZrJpv4P7zZo1pQ4=
X-Google-Smtp-Source: AK7set8gBurZmvzS/PfOMaaQBGCMxfm6Tu1rrSC/vdlisT3fuw2eEAZOVVGGDWmKR+0+XIPR/KiMlA==
X-Received: by 2002:a92:5210:0:b0:323:359:d492 with SMTP id g16-20020a925210000000b003230359d492mr2397699ilb.13.1678829418064;
        Tue, 14 Mar 2023 14:30:18 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id v13-20020a02b90d000000b004007a5f29eesm1120338jan.7.2023.03.14.14.30.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 14:30:16 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id b5so7016750iow.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:30:15 -0700 (PDT)
X-Received: by 2002:a6b:6811:0:b0:752:dd73:efde with SMTP id
 d17-20020a6b6811000000b00752dd73efdemr755170ioc.1.1678829415242; Tue, 14 Mar
 2023 14:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230314110043.2139111-1-treapking@chromium.org> <20230314110043.2139111-2-treapking@chromium.org>
In-Reply-To: <20230314110043.2139111-2-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Mar 2023 14:30:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VuK8vK7gaur7Srv9JFOaYbi=wkNs3f4sgrcLvjZahfjw@mail.gmail.com>
Message-ID: <CAD=FV=VuK8vK7gaur7Srv9JFOaYbi=wkNs3f4sgrcLvjZahfjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: ps8640: Add a cache for EDID
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 14, 2023 at 4:00=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> When there are multiple EDID reads, the bridge will be repeatedly
> enabled and disabled. Add a cache for EDID to speed this up.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 61 ++++++++++++++++----------
>  1 file changed, 37 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index 08de501c436e..4d594be8b89c 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -105,6 +105,7 @@ struct ps8640 {
>         struct gpio_desc *gpio_reset;
>         struct gpio_desc *gpio_powerdown;
>         struct device_link *link;
> +       struct edid *edid;
>         bool pre_enabled;
>         bool need_post_hpd_delay;
>  };
> @@ -543,34 +544,37 @@ static struct edid *ps8640_bridge_get_edid(struct d=
rm_bridge *bridge,
>  {
>         struct ps8640 *ps_bridge =3D bridge_to_ps8640(bridge);
>         bool poweroff =3D !ps_bridge->pre_enabled;
> -       struct edid *edid;
>
> -       /*
> -        * When we end calling get_edid() triggered by an ioctl, i.e
> -        *
> -        *   drm_mode_getconnector (ioctl)
> -        *     -> drm_helper_probe_single_connector_modes
> -        *        -> drm_bridge_connector_get_modes
> -        *           -> ps8640_bridge_get_edid
> -        *
> -        * We need to make sure that what we need is enabled before readi=
ng
> -        * EDID, for this chip, we need to do a full poweron, otherwise i=
t will
> -        * fail.
> -        */
> -       if (poweroff)
> -               drm_atomic_bridge_chain_pre_enable(bridge, connector->sta=
te->state);
> +       if (!ps_bridge->edid) {
> +               /*
> +                * When we end calling get_edid() triggered by an ioctl, =
i.e
> +                *
> +                *   drm_mode_getconnector (ioctl)
> +                *     -> drm_helper_probe_single_connector_modes
> +                *        -> drm_bridge_connector_get_modes
> +                *           -> ps8640_bridge_get_edid
> +                *
> +                * We need to make sure that what we need is enabled befo=
re
> +                * reading EDID, for this chip, we need to do a full powe=
ron,
> +                * otherwise it will fail.
> +                */
> +               if (poweroff)
> +                       drm_atomic_bridge_chain_pre_enable(bridge,
> +                                                          connector->sta=
te->state);
>
> -       edid =3D drm_get_edid(connector,
> -                           ps_bridge->page[PAGE0_DP_CNTL]->adapter);
> +               ps_bridge->edid =3D drm_get_edid(connector,
> +                                              ps_bridge->page[PAGE0_DP_C=
NTL]->adapter);
>
> -       /*
> -        * If we call the get_edid() function without having enabled the =
chip
> -        * before, return the chip to its original power state.
> -        */
> -       if (poweroff)
> -               drm_atomic_bridge_chain_post_disable(bridge, connector->s=
tate->state);
> +               /*
> +                * If we call the get_edid() function without having enab=
led the
> +                * chip before, return the chip to its original power sta=
te.
> +                */
> +               if (poweroff)
> +                       drm_atomic_bridge_chain_post_disable(bridge,
> +                                                            connector->s=
tate->state);
> +       }
>
> -       return edid;
> +       return drm_edid_duplicate(ps_bridge->edid);
>  }
>
>  static void ps8640_runtime_disable(void *data)
> @@ -767,6 +771,14 @@ static int ps8640_probe(struct i2c_client *client)
>         return ret;
>  }
>
> +static void ps8640_remove(struct i2c_client *client)
> +{
> +       struct ps8640 *ps_bridge =3D i2c_get_clientdata(client);
> +
> +       kfree(ps_bridge->edid);
> +       ps_bridge->edid =3D NULL;

nit: no need to clear this to NULL since the driver is exiting.

Other than the small nit:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
