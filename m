Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7015874E56B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGKDm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKDmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:42:24 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22BEE5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:42:22 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7948c329363so1767751241.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689046942; x=1691638942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Njt3Ks8h4H91aSe9Y34oWfsbhXfcKAW5IwH8sXjNG4o=;
        b=ErLdye0cTKi2RkUw95t6n18FDc51HiRKt8OT1ZEN2eQANsswcs7RIQdKomDzfaqN/l
         /aWaBxygT9plDea2fy/Q/wDRPE6guaEmZFK5QxADPemyZoI2cRY5kaBKG1RxP7QTHEZ6
         2dlpehTzMzEEwn1R1nrvfCxLXO2oMv2cg4+OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689046942; x=1691638942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Njt3Ks8h4H91aSe9Y34oWfsbhXfcKAW5IwH8sXjNG4o=;
        b=UvDQy1o/1BruBHseK0yLs30Vh2tj+PO4xC/5oFysLZELsbNyWarDrpHHurqeQcDk6d
         0LVFo56Lw78tlUHgmQamQvvTJnBkSCEJwAdgm9U0RCBbkna1lNdBEu7jd/wWhAJBS/gt
         1pG/sRwbD5n5uc1saJk1rfn5wRq/G3g7VHQ9f7HUlYbKaCjHvZeJDiruPu5MIh4KLer6
         p2EXaQxTkTBOph+5O7L1OBSjh3huGBgNKCIxYELmExLjLQmOvUFLaSbpCLGYyWKHuucW
         nug6eJQN3i4oH6IAt2t+OsI8p6QQhD1uqZMPzIebHrGuk9UwdhS378DIGW4cEag4ZGt+
         4jYA==
X-Gm-Message-State: ABy/qLZInEmMD/y43MR/FMjbKlrK4UOC3rvT9BUUDCYak3okAA5ia71x
        C22F0GxwyiNWt5cT4XI1BeD+sbeTYiVnCI7l65vn/g==
X-Google-Smtp-Source: APBJJlFvbyeKetjrozI3mnk55uXLN9gS8auD3FJkxsO4OUFinZWuOx1OsA5jHVJ+PmltkXlJ1D7B4WmhjCsRCpfeqBI=
X-Received: by 2002:a1f:d0c2:0:b0:471:b3f3:9bf9 with SMTP id
 h185-20020a1fd0c2000000b00471b3f39bf9mr6869698vkg.6.1689046941861; Mon, 10
 Jul 2023 20:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230710090929.1873646-1-wenst@chromium.org> <87edlgjbvg.fsf@intel.com>
In-Reply-To: <87edlgjbvg.fsf@intel.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 11 Jul 2023 11:42:10 +0800
Message-ID: <CAGXv+5HPaJf_M0nAgaGsUZ3mG=BFhTkS-ASbMwjL4K8CRkxChA@mail.gmail.com>
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

On Mon, Jul 10, 2023 at 6:32=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Mon, 10 Jul 2023, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > The DRM DP code has macros for the DP power sequencing commands. Use
> > them in the anx7625 driver instead of raw numbers.
> >
> > Fixes: 548b512e144f ("drm/bridge: anx7625: send DPCD command to downstr=
eam")
> > Fixes: 27f26359de9b ("drm/bridge: anx7625: Set downstream sink into nor=
mal status")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > Collected tags and rebased on v6.5-rc1.
> >
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/dr=
m/bridge/analogix/anx7625.c
> > index 8b985efdc086..9db3784cb554 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -931,8 +931,8 @@ static void anx7625_dp_start(struct anx7625_data *c=
tx)
> >
> >       dev_dbg(dev, "set downstream sink into normal\n");
> >       /* Downstream sink enter into normal mode */
> > -     data =3D 1;
> > -     ret =3D anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, =
&data);
> > +     data =3D DP_SET_POWER_D0;
> > +     ret =3D anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POWER,=
 1, &data);
>
> So you have code to implement the drm dp aux abstractions, why aren't
> you using drm_dp_dpcd_writeb() and friends here?

I didn't write the original code. Nor do I do much DP stuff. IIRC someone
pointed out to me these had proper macros, so I converted them.

Would you accept a follow-up patch to convert the AUX transfers to the
DRM abstractions?

ChenYu

> BR,
> Jani.
>
>
> >       if (ret < 0)
> >               dev_err(dev, "IO error : set sink into normal mode fail\n=
");
> >
> > @@ -971,8 +971,8 @@ static void anx7625_dp_stop(struct anx7625_data *ct=
x)
> >
> >       dev_dbg(dev, "notify downstream enter into standby\n");
> >       /* Downstream monitor enter into standby mode */
> > -     data =3D 2;
> > -     ret |=3D anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1,=
 &data);
> > +     data =3D DP_SET_POWER_D3;
> > +     ret |=3D anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POWER=
, 1, &data);
> >       if (ret < 0)
> >               DRM_DEV_ERROR(dev, "IO error : mute video fail\n");
>
> --
> Jani Nikula, Intel Open Source Graphics Center
