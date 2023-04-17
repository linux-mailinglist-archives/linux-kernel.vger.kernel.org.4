Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA76E46EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDQL5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDQL5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:57:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFB26A6A;
        Mon, 17 Apr 2023 04:55:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k36-20020a17090a4ca700b0024770df9897so4503256pjh.4;
        Mon, 17 Apr 2023 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681732542; x=1684324542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rqDdbdrZCzvlXd4a22A9799gLzxZLsBm6lXLdNfBVE=;
        b=a14fK1OGxrvNNDA/XUSfo1+sVGVXYCltmoxv1yGssHviautywCV9WIy8qTBrTOtwn7
         Bn2b+w2y8sJF+MbAiVBakeGlHzDTRSyUhq1Lez6MAwiV5uDMYqtz1O8CRMa1/g8pxTVw
         7E+Eg26pEm6b/uyldi4np+5N0pR5ZwEJlObtzDE/YTuu3lidY1n3bykdyA0D9C33DmIF
         ljVsKTyojP9PXRGmGZOl1DoqAH7giwirLU/FGBeayEe39/7tTZbpYbG5TRXaN0m1lIWu
         2YUn3CjNG9F5lvjLZ3Hw/rocILl37UFJDLF21qXtJlNia8WjQqkLmeiMkF1Hg4c7l0eU
         Qtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681732542; x=1684324542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rqDdbdrZCzvlXd4a22A9799gLzxZLsBm6lXLdNfBVE=;
        b=ADiWr783ZftzfxBS4MHPl0qyNfHwdQX4a/XEA3rchM/E+erIP6f3g+4GAq9CGTquV+
         whQK5HeJQhbohm+AyF2FYUDb7oWf8H7oFKpfCxx5xK356m2Jbtdxf4QP0lw9AlEvV/0f
         FeKFHbPa56J2LzDR9eWkLZYE1oJwPNarPvZm3w2l1lDcCKel0vl4cdEb0c1WUgjItekM
         YclvZXQ1ifjbStGTs+D1cxX4MfT6IoOHVRAX9u33U+4KXYf8cs76SUksV2fcYtx2pSFE
         ORC7+ZLk46DCErtzyKyzNoUVltqUUzXexVcdb0oDM6vNtkReH166aWWpYPDcCAz2v8bA
         ouHw==
X-Gm-Message-State: AAQBX9daTiYocfN3UjNPZSgn2vlO+jw5WfCjkPBrhnJCZl8tSboaS+ZP
        Bi2doPRZFmavd5DjdTJsHSbEMPjjqU1HoicvmIw=
X-Google-Smtp-Source: AKy350baawu9bmwbhWT2eXLVvgeX/QhHTudbit/tukXKk/4Q7k7cnZy8r0cfM5NMDYYtOv0q48q2L9MYdT2Pere3xho=
X-Received: by 2002:a17:902:7793:b0:1a6:54c6:9428 with SMTP id
 o19-20020a170902779300b001a654c69428mr3352631pll.3.1681732541765; Mon, 17 Apr
 2023 04:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <3e47f0d1017fe4c9f71a5de65f32c6ba1662efe2.camel@pengutronix.de>
In-Reply-To: <3e47f0d1017fe4c9f71a5de65f32c6ba1662efe2.camel@pengutronix.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 17 Apr 2023 06:55:30 -0500
Message-ID: <CAHCN7xL4+9NogrnXA1PEWorwY7JpSGBozDtHT83JvzjfinmS+A@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm: bridge: samsung-dsim: Support multi-lane calculations
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        aford@beaconembedded.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Fabio Estevam <festevam@gmail.com>, m.szyprowski@samsung.com,
        marex@denx.de, Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 3:43=E2=80=AFAM Lucas Stach <l.stach@pengutronix.de=
> wrote:
>
> Hi Adam,
>
> Am Samstag, dem 15.04.2023 um 05:40 -0500 schrieb Adam Ford:
> > If there is more than one lane, the HFP, HBP, and HSA is calculated in
> > bytes/pixel, then they are divided amongst the different lanes with som=
e
> > additional overhead. This is necessary to achieve higher resolutions wh=
ile
> > keeping the pixel clocks lower as the number of lanes increase.
> >
>
> In the testing I did to come up with my patch "drm: bridge: samsung-
> dsim: fix blanking packet size calculation" the number of lanes didn't
> make any difference. My testing might be flawed, as I could only
> measure the blanking after translation from MIPI DSI to DPI, so I'm
> interested to know what others did here. How did you validate the
> blanking with your patch? Would you have a chance to test my patch and
> see if it works or breaks in your setup?

Mine was purely by trial and error.  I don't have a scope, nor do I
have a copy of the MIPI DSI spec, so if the image sync'd with my
monitor, I treated it as successful.

I can give yours a try, but it might be a few days since I've only
been working on this stuff a bit in my spare time.

adam

>
> Regards,
> Lucas
>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/samsung-dsim.c | 40 +++++++++++++++++++++++----
> >  1 file changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index e0a402a85787..1ccbad4ea577 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -215,6 +215,7 @@
> >  #define DSI_RX_FIFO_SIZE             256
> >  #define DSI_XFER_TIMEOUT_MS          100
> >  #define DSI_RX_FIFO_EMPTY            0x30800002
> > +#define DSI_HSYNC_PKT_OVERHEAD       6
> >
> >  #define OLD_SCLK_MIPI_CLK_NAME               "pll_clk"
> >
> > @@ -879,13 +880,40 @@ static void samsung_dsim_set_display_mode(struct =
samsung_dsim *dsi)
> >                       | DSIM_MAIN_VBP(m->vtotal - m->vsync_end);
> >               samsung_dsim_write(dsi, DSIM_MVPORCH_REG, reg);
> >
> > -             reg =3D DSIM_MAIN_HFP(m->hsync_start - m->hdisplay)
> > -                     | DSIM_MAIN_HBP(m->htotal - m->hsync_end);
> > -             samsung_dsim_write(dsi, DSIM_MHPORCH_REG, reg);
> > +             /*
> > +              * If there is more than one lane, the HFP, HBP, and HSA
> > +              * is calculated in bytes/pixel, then they are divided
> > +              * amongst the different lanes with some additional
> > +              * overhead correction
> > +              */
> > +             if (dsi->lanes > 1) {
> > +                     u32 hfp, hbp, hsa;
> > +                     int bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->for=
mat) / 8;
> > +
> > +                     hfp =3D ((m->hsync_start - m->hdisplay) * bpp) / =
dsi->lanes;
> > +                     hfp -=3D (hfp > DSI_HSYNC_PKT_OVERHEAD) ? DSI_HSY=
NC_PKT_OVERHEAD : 0;
> > +
> > +                     hbp =3D ((m->htotal - m->hsync_end) * bpp) / dsi-=
>lanes;
> > +                     hbp -=3D (hbp > DSI_HSYNC_PKT_OVERHEAD) ? DSI_HSY=
NC_PKT_OVERHEAD : 0;
> >
> > -             reg =3D DSIM_MAIN_VSA(m->vsync_end - m->vsync_start)
> > -                     | DSIM_MAIN_HSA(m->hsync_end - m->hsync_start);
> > -             samsung_dsim_write(dsi, DSIM_MSYNC_REG, reg);
> > +                     hsa =3D ((m->hsync_end - m->hsync_start) * bpp) /=
 dsi->lanes;
> > +                     hsa -=3D (hsa > DSI_HSYNC_PKT_OVERHEAD) ? DSI_HSY=
NC_PKT_OVERHEAD : 0;
> > +
> > +                     reg =3D DSIM_MAIN_HFP(hfp) | DSIM_MAIN_HBP(hbp);
> > +                     samsung_dsim_write(dsi, DSIM_MHPORCH_REG, reg);
> > +
> > +                     reg =3D DSIM_MAIN_VSA(m->vsync_end - m->vsync_sta=
rt)
> > +                             | DSIM_MAIN_HSA(hsa);
> > +                     samsung_dsim_write(dsi, DSIM_MSYNC_REG, reg);
> > +             } else {
> > +                     reg =3D DSIM_MAIN_HFP(m->hsync_start - m->hdispla=
y)
> > +                             | DSIM_MAIN_HBP(m->htotal - m->hsync_end)=
;
> > +                     samsung_dsim_write(dsi, DSIM_MHPORCH_REG, reg);
> > +
> > +                     reg =3D DSIM_MAIN_VSA(m->vsync_end - m->vsync_sta=
rt)
> > +                             | DSIM_MAIN_HSA(m->hsync_end - m->hsync_s=
tart);
> > +                     samsung_dsim_write(dsi, DSIM_MSYNC_REG, reg);
> > +             }
> >       }
> >       reg =3D  DSIM_MAIN_HRESOL(m->hdisplay, num_bits_resol) |
> >               DSIM_MAIN_VRESOL(m->vdisplay, num_bits_resol);
>
