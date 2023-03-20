Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9C6C0E35
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCTKHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCTKGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:06:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEFFBB9E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:06:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 339DFB80DB5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7589C433A0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679306755;
        bh=EJED1ShfWKQvBJNubHm1lrg1azTOoYBqPX7dOmP91rg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CfVbS1PLNVSHYdWsW0GjW6QNasm92Wzzyzc8sMxnnCnwLXBkvwZTWQSUMQg0xUbEc
         FpxdL+RdnQNHoPMUTco3dtzAyeiIM48cqmOdXj9Rwbqnu/2l3Mp2chNZ7dK6GPKYYS
         Dh2DAkbv3PhihrlhiXrd4xeCLcNxOLKlmVTdVgqRdMfGHaCTSxvpkeTEeULLK9yduY
         yQBbJUq7+HdRnTXbffwRwXUs2ubJrCUV1zLwHuGxZF0jMYbF032tff8EWFp2oNttCI
         iQxjc6bgqpHKSpjVLoQ30Rgu0Ra0upXDGqfrFcqwF4IA+eL93FXEWkY9iqyVe+KCR7
         HPI54uW54YsZg==
Received: by mail-pj1-f44.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso13107145pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:05:55 -0700 (PDT)
X-Gm-Message-State: AO0yUKWLEK1XH3+HOroj5E1WRxz9RMkcgh6lzWH2OwuPGYtTFEtZddNZ
        rdqrm4YxAffzKM6UVS7IMteuJWLZPnEwlvzv+LsqFg==
X-Google-Smtp-Source: AK7set+odoSEkgb1pU4bOMstbyrx2MxwMOCCFrUYV7wcccsQVKE0mnOPywKSDxeE+ihHDdvuO+hjlPxA1gzBo5MF26g=
X-Received: by 2002:a17:902:aa86:b0:19f:39f8:88c4 with SMTP id
 d6-20020a170902aa8600b0019f39f888c4mr3741745plr.2.1679306755195; Mon, 20 Mar
 2023 03:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230319125524.58803-1-aford173@gmail.com>
In-Reply-To: <20230319125524.58803-1-aford173@gmail.com>
From:   Robert Foss <rfoss@kernel.org>
Date:   Mon, 20 Mar 2023 11:05:44 +0100
X-Gmail-Original-Message-ID: <CAN6tsi5N8iir-nNH2SV6-jJizgg92cJEPb-0BoSdprsjWQfG7A@mail.gmail.com>
Message-ID: <CAN6tsi5N8iir-nNH2SV6-jJizgg92cJEPb-0BoSdprsjWQfG7A@mail.gmail.com>
Subject: Re: [PATCH V2] drm/bridge: adv7533: Fix adv7533_mode_valid for
 adv7533 and adv7535
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, dmitry.baryshkov@linaro.org,
        aford@beaconembedded.com, Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org
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

On Sun, Mar 19, 2023 at 1:55=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> When dynamically switching lanes was removed, the intent of the code
> was to check to make sure that higher speed items used 4 lanes, but
> it had the unintended consequence of removing the slower speeds for
> 4-lane users.
>
> This attempts to remedy this by doing a check to see that the
> max frequency doesn't exceed the chip limit, and a second
> check to make sure that the max bit-rate doesn't exceed the
> number of lanes * max bit rate / lane.
>
> Fixes: 9a0cdcd6649b ("drm/bridge: adv7533: remove dynamic lane switching =
from adv7533 bridge")
> Reviewed-by: Robert Foss <rfoss@kernel.org>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>
> V2:  Fix whitespace in comment
>      Remove TODO comment
>      Add R-B from Robert.
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/b=
ridge/adv7511/adv7533.c
> index fdfeadcefe80..7e3e56441aed 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
> @@ -103,22 +103,19 @@ void adv7533_dsi_power_off(struct adv7511 *adv)
>  enum drm_mode_status adv7533_mode_valid(struct adv7511 *adv,
>                                         const struct drm_display_mode *mo=
de)
>  {
> -       int lanes;
> +       unsigned long max_lane_freq;
>         struct mipi_dsi_device *dsi =3D adv->dsi;
> +       u8 bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
>
> -       if (mode->clock > 80000)
> -               lanes =3D 4;
> -       else
> -               lanes =3D 3;
> -
> -       /*
> -        * TODO: add support for dynamic switching of lanes
> -        * by using the bridge pre_enable() op . Till then filter
> -        * out the modes which shall need different number of lanes
> -        * than what was configured in the device tree.
> -        */
> -       if (lanes !=3D dsi->lanes)
> -               return MODE_BAD;
> +       /* Check max clock for either 7533 or 7535 */
> +       if (mode->clock > (adv->type =3D=3D ADV7533 ? 80000 : 148500))
> +               return MODE_CLOCK_HIGH;
> +
> +       /* Check max clock for each lane */
> +       max_lane_freq =3D (adv->type =3D=3D ADV7533 ? 800000 : 891000);
> +
> +       if (mode->clock * bpp > max_lane_freq * adv->num_dsi_lanes)
> +               return MODE_CLOCK_HIGH;
>
>         return MODE_OK;
>  }
> --
> 2.34.1
>

Applied, thanks!

Repo: https://cgit.freedesktop.org/drm/drm-misc/


Rob.
