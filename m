Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FAE6DFF96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDLUWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDLUWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:22:22 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364A87289
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:22:21 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54c061acbc9so381033777b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681330938; x=1683922938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvarXsiUW5PBuCRvwerC9nemBFftbn3zJXSqzBEP1bw=;
        b=kNTHnIjTjuyxCWlfAZflGtN3mh9BDwsKqOfYyAWh2JwUUg6KFCqnS8AalcgDQWrtcv
         bKwqeEWxiDXW1+CM8NoPSXiWbkCh5BSu9OAhFNFMe/qgGfw6L0S1Q07qnOBmXdG2WO9s
         QYOZXKCkptsBn0YyUOWVNPRTRG5oVQtKbVxkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681330938; x=1683922938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvarXsiUW5PBuCRvwerC9nemBFftbn3zJXSqzBEP1bw=;
        b=Y9PM2/EQrjtWqFy5B3w7xMzQAPieJEUwSYrpxekJVUxSlK1BRjRpM2ctxo77ev4hij
         0nI7t+TgK6Nx6toCCXPQBYFjgKuryqHtC1i1zC24Lj0o5fpIhLm8+QtXcOL2ryC4VdST
         XPTBBJYOdAwXlwTrQb044HBOSUcqgwgiQsGSVa8XVeN2l3DJBDWdHALUlGWfh87Q6wuc
         FZZrJgJMyMFCYdDvXi7tRTRccih/ukKEAjPmF/DSv0S2dL6z/dMA4k0uhvqRjbCQHozP
         3FjTIYpAt9jJOU7N91c0LWwXpj2CJlVGNnpzwdcUEsxDsP90ycinGc2myG6dMlP5NFBH
         iEng==
X-Gm-Message-State: AAQBX9etBNuw5+v28CUlTw2PwZAK9v3qm05l0lCXgsE443rRRt4l5Z4S
        tRWq5SKOjD2UjPfotrVyR0O+PyqkPgq6uG7UmEY=
X-Google-Smtp-Source: AKy350aY7YHc+xIcl/upilK54BXkVWgZCERMcpvXDHnrWAseqpCda3NkWwQnhBRAMv7pqOCfBXJECw==
X-Received: by 2002:a0d:e2cf:0:b0:549:2623:6f65 with SMTP id l198-20020a0de2cf000000b0054926236f65mr3376930ywe.33.1681330938666;
        Wed, 12 Apr 2023 13:22:18 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id p191-20020a8198c8000000b0054eff2f2bdesm2792459ywg.10.2023.04.12.13.22.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 13:22:17 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id t16so281687ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:22:17 -0700 (PDT)
X-Received: by 2002:a25:7382:0:b0:b8b:eea7:525b with SMTP id
 o124-20020a257382000000b00b8beea7525bmr4892457ybc.7.1681330937165; Wed, 12
 Apr 2023 13:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230408082014.235425-1-nikita@trvn.ru>
In-Reply-To: <20230408082014.235425-1-nikita@trvn.ru>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Apr 2023 13:22:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XEQS9MB4e52B4yLjiP8ksYmeos_emiH4=-adCOwzfGUA@mail.gmail.com>
Message-ID: <CAD=FV=XEQS9MB4e52B4yLjiP8ksYmeos_emiH4=-adCOwzfGUA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Implement wait_hpd_asserted
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Sat, Apr 8, 2023 at 1:20=E2=80=AFAM Nikita Travkin <nikita@trvn.ru> wrot=
e:
>
> This bridge doesn't actually implement HPD due to it being way too slow
> but instead expects the panel driver to wait enough to assume HPD is
> asserted. However some panels (such as the generic 'edp-panel') expect
> the bridge to deal with the delay and pass maximum delay to the aux
> instead.
>
> In order to support such panels, add a dummy implementation of wait
> that would just sleep the maximum delay and assume no failure has
> happened.
>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> This was suggested in [1] to make sure DT users can be semantically
> correct (not adding no-hpd when the line is actually there) while
> still using a hard delay to be faster than waiting the long debounce
> time.
>
> [1] - https://lore.kernel.org/all/CAD=3DFV=3DVR7sKsquE25eF7joc7gPApu-vqwd=
uZzjE=3DwFCoXjMYnQ@mail.gmail.com/
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 7a748785c545..260cad1fd1da 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -618,6 +618,24 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux =
*aux,
>         return len;
>  }
>
> +static int ti_sn_aux_wait_hpd_asserted(struct drm_dp_aux *aux, unsigned =
long wait_us)
> +{
> +       /*
> +        * The HPD in this chip is a bit useless (See comment in
> +        * ti_sn65dsi86_enable_comms) so if our driver is expected to wai=
t
> +        * for HPD, we just assume it's asserted after the wait_us delay.
> +        *
> +        * In case we are asked to wait forever (wait_us=3D0) take conser=
vative
> +        * 500ms delay.
> +        */
> +       if (wait_us =3D=3D 0)
> +               wait_us =3D 500000;
> +
> +       usleep_range(wait_us, wait_us + 1000);
> +
> +       return 0;
> +}
> +
>  static int ti_sn_aux_probe(struct auxiliary_device *adev,
>                            const struct auxiliary_device_id *id)
>  {
> @@ -627,6 +645,7 @@ static int ti_sn_aux_probe(struct auxiliary_device *a=
dev,
>         pdata->aux.name =3D "ti-sn65dsi86-aux";
>         pdata->aux.dev =3D &adev->dev;
>         pdata->aux.transfer =3D ti_sn_aux_transfer;
> +       pdata->aux.wait_hpd_asserted =3D ti_sn_aux_wait_hpd_asserted;

This looks reasonable to me, but I think you only want this
implementation if the "no-hpd" property _isn't_ present. In other
words:

if (!of_property_read_bool(np, "no-hpd"))
  pdata->aux.wait_hpd_asserted =3D ti_sn_aux_wait_hpd_asserted;

Essentially:

* If "no-hpd" is present in ti-sn65dsi86 then we'll assume that HPD is
handled by the panel driver via a GPIO or a "no-hpd" there (which will
cause the panel driver to wait the maximum duration).

* If "no-hpd" isn't present in ti-sn65dsi86 then HPD is actually
hooked up and thus the panel driver _won't_ handle it.

Does that seem right? Presumably this should be explained by comments.

-Doug
