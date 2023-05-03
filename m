Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FBD6F5C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjECQgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjECQg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:36:26 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E4E7A8F
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:36:09 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55d2e87048cso10826167b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1683131768; x=1685723768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/907v6qlrO+vgCs3WjNzG1/NauBMPopzZK9UTvbynU=;
        b=XEyEzVkiiwnZJGFsWnGM0c/KJmcFHp95byWnjRbnn0ITkTswKKM1EeLk4gbaC9+5Ar
         hoGVxxwdsEXXLqLugJmBz2VErtyAwfCVrY9Z4qIzixocOjKuxCCc90jizXWXs0BY731D
         iCaBKRBHSTtSaIeTcGHmWOhljisey60vgTuik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131768; x=1685723768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/907v6qlrO+vgCs3WjNzG1/NauBMPopzZK9UTvbynU=;
        b=g1BYjXEcmKfw+ihVJJqY/HfW1DKhnQJbg+WVYuPaFgo1x+WbelPcGAlw1yAtC66xAf
         onCJTZQsgWi310Jdq3OHJdXRVOGqpiCs59Q89ALz+G/4+1D8z9h5bjMzROVyMrL68uFw
         JDZx1lO37TKMaikL89TdnKf4Io2x/LsSNCijC6FmPPb/IdIe5EHBvcmqNWVM+dG/PMix
         NT/F8UWqkYtWQ5Z6td43wjUlMic5yQxfsUkeqTegw6oDU4E2nzvI0OusvQHSMKwsiy45
         RpyFfcdWbLE5kK+WT/oxQjpEoeoosQm0ZMU+ObamyOponorpO0097l3rsafb1MZokv13
         SAKw==
X-Gm-Message-State: AC+VfDwAIosbllYGXCZ1TOYof0/Bs6FMMyIPopbzvq0k1CX2dfPChXNn
        5PFu37ncWA7tTw0qokwYlKZmhaglJ13XcSHvjmTsnQ==
X-Google-Smtp-Source: ACHHUZ4jy6BhscYAIyIWZXUqVR7LWYFy1QquV9iIbGTx9DTE26ZPw/idXmwHZ+h1dD3KFj1uYuT3oWq9sY/rIdshzdA=
X-Received: by 2002:a81:a007:0:b0:55a:4117:a8f2 with SMTP id
 x7-20020a81a007000000b0055a4117a8f2mr11909110ywg.4.1683131768294; Wed, 03 May
 2023 09:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230423121232.1345909-1-aford173@gmail.com> <20230423121232.1345909-2-aford173@gmail.com>
 <CAMty3ZCn9_AT8SOfFD-MYox16ZcqOEezt_0x6aES6LWQFj8Kpg@mail.gmail.com> <CAHCN7xLYfEO9Pxq91vZSDG0QXjnx3BEKYdsTXgQ1BTbtuTbLGQ@mail.gmail.com>
In-Reply-To: <CAHCN7xLYfEO9Pxq91vZSDG0QXjnx3BEKYdsTXgQ1BTbtuTbLGQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 3 May 2023 22:05:56 +0530
Message-ID: <CAMty3ZB0q7MLRyu4TgcV20rX7c8d2SMbvBr39XRru5_Ry6q1Ug@mail.gmail.com>
Subject: Re: [PATCH V2 1/6] drm: bridge: samsung-dsim: fix blanking packet
 size calculation
To:     Adam Ford <aford173@gmail.com>
Cc:     l.stach@pengutronix.de, dri-devel@lists.freedesktop.org,
        m.szyprowski@samsung.com, aford@beaconembedded.com,
        dario.binacchi@amarulasolutions.com,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
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

On Mon, Apr 24, 2023 at 3:17=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Mon, Apr 24, 2023 at 4:03=E2=80=AFAM Jagan Teki <jagan@amarulasolution=
s.com> wrote:
> >
> > On Sun, Apr 23, 2023 at 5:42=E2=80=AFPM Adam Ford <aford173@gmail.com> =
wrote:
> > >
> > > From: Lucas Stach <l.stach@pengutronix.de>
> > >
> > > Scale the blanking packet sizes to match the ratio between HS clock
> > > and DPI interface clock. The controller seems to do internal scaling
> > > to the number of active lanes, so we don't take those into account.
> > >
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > >  drivers/gpu/drm/bridge/samsung-dsim.c | 18 +++++++++++++++---
> > >  1 file changed, 15 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/=
bridge/samsung-dsim.c
> > > index e0a402a85787..2be3b58624c3 100644
> > > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > @@ -874,17 +874,29 @@ static void samsung_dsim_set_display_mode(struc=
t samsung_dsim *dsi)
> > >         u32 reg;
> > >
> > >         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> > > +               int byte_clk_khz =3D dsi->burst_clk_rate / 1000 / 8;
> > > +               int hfp =3D (m->hsync_start - m->hdisplay) * byte_clk=
_khz / m->clock;
> >
> > I do not quite understand why it depends on burst_clk_rate, would you
> > please explain? does it depends on bpp something like this
> >
> > mipi_dsi_pixel_format_to_bpp(format) / 8
>
> The pixel clock is currently set to the burst clock rate.  Dividing
> the clock by 1000 gets the pixel clock in KHz, and dividing by 8
> converts bits to bytes.
> Later in the series, I change the clock from the burst clock to the
> cached value returned from samsung_dsim_set_pll.

Okay.

>
> >
> > > +               int hbp =3D (m->htotal - m->hsync_end) * byte_clk_khz=
 / m->clock;
> > > +               int hsa =3D (m->hsync_end - m->hsync_start) * byte_cl=
k_khz / m->clock;
> > > +
> > > +               /* remove packet overhead when possible */
> > > +               hfp =3D max(hfp - 6, 0);
> > > +               hbp =3D max(hbp - 6, 0);
> > > +               hsa =3D max(hsa - 6, 0);
> >
> > 6 blanking packet overhead here means, 4 bytes + payload + 2 bytes
> > format? does this packet overhead depends on the respective porch's
> > like hpf, hbp and hsa has different packet overheads?
>
> Lucas might be able to explain this better.  However, it does match
> the values of the downstream NXP kernel, and I tried playing with
> these values manually, and 6 appeared to be the only number that
> seemed to work for me too.  I abandoned my approach for Lucas'
> implementation, because it seemed more clear than mine.
> Maybe Lucas can chime in, since this is really his patch.

Lucan, any inputs?

Jagan.
