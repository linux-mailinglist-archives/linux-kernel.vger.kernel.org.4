Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D36FD95D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbjEJIa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbjEJIap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:30:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFEE6186;
        Wed, 10 May 2023 01:30:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24e25e2808fso6355130a91.0;
        Wed, 10 May 2023 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683707444; x=1686299444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gj4rNe9q8jSfWDp/ypQzgo3GKje+dWPaI3Tr4ZM2VU=;
        b=dEPAnIzT0WteEAlWgQg7YSoPFVzNp99Rl56DGMWH71YEGSZPGGPwPhPRh38UGT1Clb
         nsQsUc0wzyj3CBgFs37GGPG1AYVWQzKwpVolW3wqGbXZeSU/VcFnLbdOQMnXL1ak/jxt
         wNIj/cmrWKZKK7Qq4jg9z6PAOTCYfA+1QHw/7/6EoTc5vWEoE1NPKBsNqyA4p5PwwVfe
         H7ZMTk7LoVHXZp7DjisXYZwEANq+XJeiQ0ZCImSmICgHyJ9NxPVJZLvBtxEh4ofJqydj
         qeNjcXL+AvyBhmK+7jp88LDQjmYPtxbtxe27bBdomNNIeIWzSRPeCaOp0HuBLNlNRYaw
         Ly/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707444; x=1686299444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Gj4rNe9q8jSfWDp/ypQzgo3GKje+dWPaI3Tr4ZM2VU=;
        b=dTl5gIln20mHJ/qxj8r2imKooS8aCDXBsXtKUQ/5JMXjsHfa8FyFgSNT5njC61Ep53
         XvUXh9GsZ6U7InmX4Ktp8IVyHcx9jq8j8SmIlXUHdFaMndN3XTylC1TfguicdQYca5j0
         DUPfvcGgaYcNdKM87iZZKFYSmPMo9gAuNOGcGpW2gF/9IlFfNZH15pjv2Ve8N55Pl3Uj
         hyitoalb6KKVEnkSTc/SfdbFTgZgajtF0VXng8beMl7OkDdAO323Vra36T3X7Mto+aPs
         EZLrgLb+Jq8eCe0apfntGy0n76rm8f29fzM+t/dhQBrWZq4zod4KTADpKGztMNg+uzAP
         kJ4A==
X-Gm-Message-State: AC+VfDxCUvKOztY7D3pV42Zp4zYy8R7xch6FpXXMSSy1ODAfGvGcpj5s
        y8uuWz0QUzxlkrS+gtVgGXcQgQqHcJdLzgrIzNw=
X-Google-Smtp-Source: ACHHUZ4Br5vyvQv5lHgaPPiZAKCUUEir6+fEHPRg8sLb5SXW3EPjOff6aRIYLKC9Qq/A4C4xPbWuMDqOdu9mxWX2M5w=
X-Received: by 2002:a17:90b:1997:b0:250:2337:9b96 with SMTP id
 mv23-20020a17090b199700b0025023379b96mr17550693pjb.9.1683707443869; Wed, 10
 May 2023 01:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230508055740.635256-1-victor.liu@nxp.com> <20230508055740.635256-3-victor.liu@nxp.com>
 <05b44685-d6a7-5f6e-0f55-04c96e94a9e1@denx.de>
In-Reply-To: <05b44685-d6a7-5f6e-0f55-04c96e94a9e1@denx.de>
From:   Ying Liu <gnuiyl@gmail.com>
Date:   Wed, 10 May 2023 16:30:32 +0800
Message-ID: <CAOcKUNXjvOMXtf2FVwjhWNbdwQy82T+wz-QN7ukAOmQo5DKQ2w@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] drm: lcdif: Drop unnecessary NULL pointer check on lcdif->bridge
To:     Marek Vasut <marex@denx.de>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org,
        alexander.stein@ew.tq-group.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-imx@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        LW@karo-electronics.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 10:14=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 5/8/23 07:57, Liu Ying wrote:
>
> Hi,

Hi,

>
> > diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/=
lcdif_kms.c
> > index 262bc43b1079..e54200a9fcb9 100644
> > --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> > @@ -394,7 +394,7 @@ static void lcdif_crtc_mode_set_nofb(struct lcdif_d=
rm_private *lcdif,
> >       struct drm_display_mode *m =3D &lcdif->crtc.state->adjusted_mode;
> >       u32 bus_flags =3D 0;
> >
> > -     if (lcdif->bridge && lcdif->bridge->timings)
> > +     if (lcdif->bridge->timings)
> >               bus_flags =3D lcdif->bridge->timings->input_bus_flags;
> >       else if (bridge_state)
> >               bus_flags =3D bridge_state->input_bus_cfg.flags;
> > @@ -463,30 +463,21 @@ static void lcdif_crtc_atomic_enable(struct drm_c=
rtc *crtc,
> >       struct drm_display_mode *m =3D &lcdif->crtc.state->adjusted_mode;
> >       struct drm_bridge_state *bridge_state =3D NULL;
> >       struct drm_device *drm =3D lcdif->drm;
> > -     u32 bus_format =3D 0;
> > +     u32 bus_format;
> >       dma_addr_t paddr;
> >
> > -     /* If there is a bridge attached to the LCDIF, use its bus format=
 */
> > -     if (lcdif->bridge) {
> > -             bridge_state =3D
> > -                     drm_atomic_get_new_bridge_state(state,
> > -                                                     lcdif->bridge);
> > -             if (!bridge_state)
> > -                     bus_format =3D MEDIA_BUS_FMT_FIXED;
> > -             else
> > -                     bus_format =3D bridge_state->input_bus_cfg.format=
;
> > -
> > -             if (bus_format =3D=3D MEDIA_BUS_FMT_FIXED) {
> > -                     dev_warn_once(drm->dev,
> > -                                   "Bridge does not provide bus format=
, assuming MEDIA_BUS_FMT_RGB888_1X24.\n"
> > -                                   "Please fix bridge driver by handli=
ng atomic_get_input_bus_fmts.\n");
> > -                     bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
> > -             }
> > -     }
> > +     bridge_state =3D drm_atomic_get_new_bridge_state(state, lcdif->br=
idge);
> > +     if (!bridge_state)
> > +             bus_format =3D MEDIA_BUS_FMT_FIXED;
> > +     else
> > +             bus_format =3D bridge_state->input_bus_cfg.format;
>
> The code below seems to change the logic slightly.
>
> Could it happen that:
> - bridge_state is valid (i.e. non-NULL)
> - bridge_state->input_bus_cfg.format is set to 0 (i.e. not set) ?
>    (note that MEDIA_BUS_FMT_FIXED is defined as 0x0001)

Yes, bridge_state->input_bus_cfg.format could be zero.
Will keep the below default MEDIA_BUS_FMT_RGB888_1X24
bus format setting in next version.

Regards,
Liu Ying

>
> > -     /* If all else fails, default to RGB888_1X24 */
> > -     if (!bus_format)
> > +     if (bus_format =3D=3D MEDIA_BUS_FMT_FIXED) {
> > +             dev_warn_once(drm->dev,
> > +                           "Bridge does not provide bus format, assumi=
ng MEDIA_BUS_FMT_RGB888_1X24.\n"
> > +                           "Please fix bridge driver by handling atomi=
c_get_input_bus_fmts.\n");
> >               bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
> > +     }
> >
> >       clk_set_rate(lcdif->clk, m->crtc_clock * 1000);
>
> [...]
