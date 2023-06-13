Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D572E64D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbjFMOwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbjFMOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:52:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F8810FC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:52:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977d0ee1736so798263266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686667947; x=1689259947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFhCpdPvurTrFPKgPmFt8+QcF+4GExHDsuu6/kU2tGo=;
        b=rJfY6khakkCcjLrkOBOLEN5jvJ/ZWcfTP0mYmealr9tzzIOFitpHJgdODVW0JWXrUe
         nvrT+NJQAqA23L3yJRes/kELb3Z4sXNXuA9Y1JZat6bvMXVKfA1OoLmSW3k7KCzT4V0q
         hLZuXqRTJvhGxLMi2oAkyoXB2NUunjEVL3OAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686667947; x=1689259947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFhCpdPvurTrFPKgPmFt8+QcF+4GExHDsuu6/kU2tGo=;
        b=dn1JKaJlc66yI3NeMC1ws4BnL9TVzYQluquo9wRsmv0TlrbHJUj3rqZbsUACbxtDat
         CKdUcn+7HYeuJ+NqY8AKXfAoDSrW11BWhM1S4keNqNVld8SWGRWHwfWs7g96m2BkQDr0
         +0VCoNtR/uW/5fbpLcPIKS+Sobmb6PMwk1J/fp9YAcUC7VBYcaKuDvA34UoLk+fgT7vX
         QZceRkF6wxlQs29a5c5/MwQAH8l4NKX21m3nCxYQtJ8GYyGj+1A/YKm2EfchGaX4dyDA
         G84AXb6K6+zA8/YSX+dzDIpbm6vi3LvcKYwusGP+2NPj/1ZaRKFwn9zfIk2qWP4nPSPl
         P4wQ==
X-Gm-Message-State: AC+VfDwKsIKZSec43B6nSvGWcs8t9M1S8n9kz3oZg+vYGlktoFPP5ghF
        UA+LugqapwKP9CAhwMHxkWISoG+lOWuKduJvjEbCHQ==
X-Google-Smtp-Source: ACHHUZ58hojL5RiV0RaxLfiHLOIkvZMvcRGhgnaQ2b6hHAYY5+XTiYIhvar1ClxhS/9K8rpRZFSX4eHhuLQBl13DGtg=
X-Received: by 2002:a17:906:da82:b0:979:7624:1f71 with SMTP id
 xh2-20020a170906da8200b0097976241f71mr11633694ejb.26.1686667947447; Tue, 13
 Jun 2023 07:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230609062050.2107143-1-dario.binacchi@amarulasolutions.com>
 <20230609062050.2107143-5-dario.binacchi@amarulasolutions.com> <376dc16d-8896-0a47-b8dd-3f919c1e50bf@foss.st.com>
In-Reply-To: <376dc16d-8896-0a47-b8dd-3f919c1e50bf@foss.st.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Tue, 13 Jun 2023 16:52:16 +0200
Message-ID: <CAOf5uwmpAZeO=w-+cQNfy4VHS80NK-_HpDv5koZfTB8cRHOECQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/stm: add an option to change FB bpp
To:     Philippe CORNU <philippe.cornu@foss.st.com>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Jun 13, 2023 at 4:41=E2=80=AFPM Philippe CORNU
<philippe.cornu@foss.st.com> wrote:
>
>
>
> On 6/9/23 08:20, Dario Binacchi wrote:
> > Boards that use the STM32F{4,7} series have limited amounts of RAM. The
> > added parameter allows users to size, within certain limits, the memory
> > footprint required by the framebuffer.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >
> > ---
> >
> > Changes in v3:
> > - drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
> >    Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm=
-misc-next):
> >    https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3Dc42a37a27c777=
d63961dd634a30f7c887949491a
> > - drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H pan=
el
> >    Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm=
-misc-next)
> >    https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D13cdd12a9f934=
158f4ec817cf048fcb4384aa9dc
> >
> >   drivers/gpu/drm/stm/drv.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> > index 422220df7d8c..65be2b442a6a 100644
> > --- a/drivers/gpu/drm/stm/drv.c
> > +++ b/drivers/gpu/drm/stm/drv.c
> > @@ -30,6 +30,11 @@
> >   #define STM_MAX_FB_WIDTH    2048
> >   #define STM_MAX_FB_HEIGHT   2048 /* same as width to handle orientati=
on */
> >
> > +static uint stm_bpp =3D 16;
> > +
> > +MODULE_PARM_DESC(bpp, "bits-per-pixel (default: 16)");
> > +module_param_named(bpp, stm_bpp, uint, 0644);
> > +
> >   static const struct drm_mode_config_funcs drv_mode_config_funcs =3D {
> >       .fb_create =3D drm_gem_fb_create,
> >       .atomic_check =3D drm_atomic_helper_check,
> > @@ -93,6 +98,7 @@ static int drv_load(struct drm_device *ddev)
> >       ddev->mode_config.min_height =3D 0;
> >       ddev->mode_config.max_width =3D STM_MAX_FB_WIDTH;
> >       ddev->mode_config.max_height =3D STM_MAX_FB_HEIGHT;
> > +     ddev->mode_config.preferred_depth =3D stm_bpp;
> >       ddev->mode_config.funcs =3D &drv_mode_config_funcs;
> >       ddev->mode_config.normalize_zpos =3D true;
> >
> > @@ -203,7 +209,7 @@ static int stm_drm_platform_probe(struct platform_d=
evice *pdev)
> >       if (ret)
> >               goto err_put;
> >
> > -     drm_fbdev_dma_setup(ddev, 16);
> > +     drm_fbdev_dma_setup(ddev, stm_bpp);
> >
> >       return 0;
> >
>
> Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
> Many thanks,
> Philippe :-)
>

According to the latest review on usb patchset: "Please do not add new
module parameters, this is not the 1990's anymore.
We have per-device settings everywhere, this makes that impossible.
Just use a DT value, if it is wrong, then fix the DT value!  No need to
have the kernel override it, that's not what DT files are for."

I think it makes more sense to have dts parameters. Should maybe apply here=
 too

Michael
