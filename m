Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF56B918B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCNLWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCNLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBECF93E0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5FBBB818EE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6616FC433A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678792921;
        bh=WcmHdukAAWnKHyT1lmhk8rqdI01TwcKCJXLI5msFU+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bkPbngrVp5gYsluTdQdfvyyYImMJfk4GJcRKyu78v3VPa/T23esLe35kAr7fPDpNy
         ftwr5ufj5FWV/xzRKQHSGOE/sPoHR18N6O9iiahgQn8xe9bIJPeD/AZJ7THdLf89+a
         uQnm9dae4+l1PRj4sU/vnxFF31YInmjFejde01IUIs67wPwyny3YWdNajcaOzWUhOR
         5HCtH+mkbonjfDJ6tIZd8FG39jPiUHtNMcJeedENU/kxerYC1IO8RpltzQY1ZLJa5U
         n14D8HWKuuPpPNTgX209MNMmPyPcn9se2VJJ0awYkvo9OOR4rSLaVbJ1OBb6PbxD4H
         F2Z+bHRxksQmg==
Received: by mail-pf1-f173.google.com with SMTP id n16so3334466pfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:22:01 -0700 (PDT)
X-Gm-Message-State: AO0yUKWt3VJyr5SKDbeUp0D/95okUzM78dgAVHunhc8KG7iOr9RQSnyC
        xUoBp0v+4E891h+HXZxhI2nadUoVFdhLTuRQApFQiA==
X-Google-Smtp-Source: AK7set/VAfSsBsAfO1Xryc7MK9UHJ+TtCdwj7eGXE0kxOM9mZjM2PFSoEJLc5P0UJ68ciFAv8z+hs0WGeDIFE5U2kvA=
X-Received: by 2002:a62:1d04:0:b0:623:8a88:1bba with SMTP id
 d4-20020a621d04000000b006238a881bbamr2817951pfd.2.1678792920917; Tue, 14 Mar
 2023 04:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230314110043.2139111-1-treapking@chromium.org> <20230314110043.2139111-2-treapking@chromium.org>
In-Reply-To: <20230314110043.2139111-2-treapking@chromium.org>
From:   Robert Foss <rfoss@kernel.org>
Date:   Tue, 14 Mar 2023 12:21:50 +0100
X-Gmail-Original-Message-ID: <CAN6tsi5YT6Bb85GUn3+Cit=F2doh_up9nqDNQDyMUP9Ttxb09w@mail.gmail.com>
Message-ID: <CAN6tsi5YT6Bb85GUn3+Cit=F2doh_up9nqDNQDyMUP9Ttxb09w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: ps8640: Add a cache for EDID
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:01=E2=80=AFPM Pin-yen Lin <treapking@chromium.or=
g> wrote:
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
> +}
> +
>  static const struct of_device_id ps8640_match[] =3D {
>         { .compatible =3D "parade,ps8640" },
>         { }
> @@ -775,6 +787,7 @@ MODULE_DEVICE_TABLE(of, ps8640_match);
>
>  static struct i2c_driver ps8640_driver =3D {
>         .probe_new =3D ps8640_probe,
> +       .remove =3D ps8640_remove,
>         .driver =3D {
>                 .name =3D "ps8640",
>                 .of_match_table =3D ps8640_match,
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>


Reviewed-by: Robert Foss <rfoss@kernel.org>
