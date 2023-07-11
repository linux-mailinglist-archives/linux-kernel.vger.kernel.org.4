Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A571474E8F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGKIYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGKIYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:24:22 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3D691
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:24:21 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4435508cff9so1489524137.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689063860; x=1691655860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrU6Xsa0V1WqXVV3JvJ4wrZDM66k/gtoRFytP7Ma7bo=;
        b=Zn90hdmXUldF2ronB05z91XulUpY5khDBEA+ng1+csphiBZUG6o8nkV8Udqrdd6HNL
         pMxpmS/REWgMsBl1VTfAQFp84IRHmByxf9Cf66w2CcNcfAAAmVqlO29jnIW1opWKa5Cj
         OGkTd/bw976/iDBA3woknN+6uo23kLw+XzmGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689063860; x=1691655860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrU6Xsa0V1WqXVV3JvJ4wrZDM66k/gtoRFytP7Ma7bo=;
        b=aZlq3YWREELZ4M6bWKrjYH63jsJ6x9HnEdVxvi0brhk/JOz4MforuGIX1AoiCTNi2K
         ruBrz/IYm2N1SnZO2czTb40SHEyu0R2plT5R+WUGnm4yAXWzukRNyCO6ot9h1BRd9HvB
         sjCwfyUFk+p0soqlos1YR43Mn53HvEw6WQ6G/tryXXCyg9/8Tq2XJSru7E25SQTh2dke
         Qrbpl87jLR+giL68UN3hIPlYGRwZIK5zwekjrgKbW7+VH2eE4N5zMdoWv4nEPhebp2HC
         IknmAzh91gDqMv3Aahjbs0e7DNivGmgL4tfVm6hEzzOmpR/fNh8qXL0em3rtpa8Ot/Nq
         GU6A==
X-Gm-Message-State: ABy/qLYNCb1C/+pdmKhfYrJZqYD6R2LI27Ohk7x9v86OXPqT4iHkV4p0
        c+DPCMk3uj73LecKFuwGqFAflpREVLxhc1BuZQYVAQ==
X-Google-Smtp-Source: APBJJlGOAQTq/vj1kFR6kgaTzRdb1DuZFGS44SFaTUtxEdPu90Dcdy9xdEtT0Q8SqXK2puCM5yU8nHcI26PaLZQkh5M=
X-Received: by 2002:a67:ffca:0:b0:443:6052:43a4 with SMTP id
 w10-20020a67ffca000000b00443605243a4mr6816204vsq.20.1689063860537; Tue, 11
 Jul 2023 01:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230710090929.1873646-1-wenst@chromium.org> <87edlgjbvg.fsf@intel.com>
 <CAGXv+5HPaJf_M0nAgaGsUZ3mG=BFhTkS-ASbMwjL4K8CRkxChA@mail.gmail.com> <87lefmj4iu.fsf@intel.com>
In-Reply-To: <87lefmj4iu.fsf@intel.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 11 Jul 2023 16:24:09 +0800
Message-ID: <CAGXv+5HBVuVPCaFii07PNvzoDJwyULMdkydku1=vCnTC6uZduw@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/bridge: anx7625: Use common macros for DP
 power sequencing commands
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 3:23=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Tue, 11 Jul 2023, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > On Mon, Jul 10, 2023 at 6:32=E2=80=AFPM Jani Nikula <jani.nikula@linux.=
intel.com> wrote:
> >>
> >> On Mon, 10 Jul 2023, Chen-Yu Tsai <wenst@chromium.org> wrote:
> >> > The DRM DP code has macros for the DP power sequencing commands. Use
> >> > them in the anx7625 driver instead of raw numbers.
> >> >
> >> > Fixes: 548b512e144f ("drm/bridge: anx7625: send DPCD command to down=
stream")
> >> > Fixes: 27f26359de9b ("drm/bridge: anx7625: Set downstream sink into =
normal status")
> >> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >> > Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> >> > ---
> >> > Collected tags and rebased on v6.5-rc1.
> >> >
> >> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> >> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu=
/drm/bridge/analogix/anx7625.c
> >> > index 8b985efdc086..9db3784cb554 100644
> >> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> >> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> >> > @@ -931,8 +931,8 @@ static void anx7625_dp_start(struct anx7625_data=
 *ctx)
> >> >
> >> >       dev_dbg(dev, "set downstream sink into normal\n");
> >> >       /* Downstream sink enter into normal mode */
> >> > -     data =3D 1;
> >> > -     ret =3D anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, =
1, &data);
> >> > +     data =3D DP_SET_POWER_D0;
> >> > +     ret =3D anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POW=
ER, 1, &data);
> >>
> >> So you have code to implement the drm dp aux abstractions, why aren't
> >> you using drm_dp_dpcd_writeb() and friends here?
> >
> > I didn't write the original code. Nor do I do much DP stuff. IIRC someo=
ne
> > pointed out to me these had proper macros, so I converted them.
> >
> > Would you accept a follow-up patch to convert the AUX transfers to the
> > DRM abstractions?
>
> I believe they would be welcome, but I'm personally not familiar with
> the driver in question.

OK. I take it you are not blocking this patch then?

ChenYu
