Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8235FF947
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJOI7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 04:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJOI7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 04:59:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9978E558E5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 01:59:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk15so10848125wrb.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjSRqmWkaFZ0BLuD6MivrAvypkKqaIT8x6LKQIsQKn8=;
        b=gdcg6hXz5wuVSv/KtfFI848qYS7t9NYjUI618ptxzzIpxaqmveySS5BR9QIVwZQznb
         xBp1LMARjJsFgTsfoQXSKdlgOksIgUDgK5K2AKQXk0cNXfVB1iXroI7ut/cD9tGOsURQ
         jm8KdDG1cgj3F2tXB8fsFhaB4Dgqa4STOi2smUvQX0W6V5JuU1fb2T0Jx1olayaXMioH
         qUVlRlUtYIZYW47agdnyqxBUbpxtv8QqHmVCx5PtIwbbxpRu//fPm+9YkMHbweUr6hyr
         GIo4cI3kV/QaK6qCRbfx4UQzBvTvJNtzUUilSXr8/BKEVqoYVnzl8JMOwJPISK3D8rO8
         AGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjSRqmWkaFZ0BLuD6MivrAvypkKqaIT8x6LKQIsQKn8=;
        b=N5xfoPPXMgYcKZuekwveLQQPc3uUzDja0j8F35u6/dSvE4c4Ip02l0+JIR0/qmWb7m
         XO+PvIA8O8oYcDY8dAInVvC4z4r67fRwhk4skebLUhEJw5nG2sZL4190w9NqaisVqjO8
         m7tz+6Jk6bba34t5NvWZOcnH2PIbsKg9m66ahO9J6gWdAZWNte1sFbDhbJdKKLzUEJFE
         V9W8MDNcJiZfHRFWQ0zRkbriURcPRIiKw8+WsICdxCtbHrn4ZLP9/EgBKih93N7pGpNM
         pcDpwGEeUch4klzWV+Gr/bBZwXVHBpN/AackPd7IpWXZuP3L2BBfF/1KsKuB05h6sRJe
         CD7Q==
X-Gm-Message-State: ACrzQf1Lp/ukKJCfU6yDYp139BTVqdlEcOQ5opaIMMGo0bxaEpnISQDk
        KfRM8kuGz60vuIycEiT4QSy7VovGWoizKqDO
X-Google-Smtp-Source: AMsMyM6RC+ab/6o3qXAuzwTkjLJWhUo2MRVgXF2cNlp5Etq5q5a0yKzX7Not8qtetRts0yGJHJyAJg==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr985742wrr.472.1665824356510;
        Sat, 15 Oct 2022 01:59:16 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id k13-20020adff5cd000000b0022e36c1113fsm3693723wrp.13.2022.10.15.01.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 01:59:15 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Emma Anholt <emma@anholt.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?UTF-8?B?Tm9yYWxmIFRyw4PCuG5uZXM=?= <noralf@tronnes.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: Re: [PATCH v5 22/22] drm/sun4i: tv: Convert to the new TV mode property
Date:   Sat, 15 Oct 2022 10:59:14 +0200
Message-ID: <2649653.mvXUDI8C0e@kista>
In-Reply-To: <20221014073810.akfoyfzxerywnt65@houat>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech> <6482539.4vTCxPXJkl@kista> <20221014073810.akfoyfzxerywnt65@houat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 14. oktober 2022 ob 09:38:10 CEST je Maxime Ripard napisal(a):
> Hi Jernej,
>=20
> On Thu, Oct 13, 2022 at 08:23:51PM +0200, Jernej =C5=A0krabec wrote:
> > Dne =C4=8Detrtek, 13. oktober 2022 ob 15:19:06 CEST je Maxime Ripard=20
napisal(a):
> > > Now that the core can deal fine with analog TV modes, let's convert t=
he
> > > sun4i TV driver to leverage those new features.
> > >=20
> > > Acked-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > >=20
> > > ---
> > > Changes in v5:
> > > - Removed the count variable in get_modes
> > > - Removed spurious vc4 change
> > > ---
> > >=20
> > >  drivers/gpu/drm/sun4i/sun4i_tv.c | 145
> > >=20
> > > +++++++++++++-------------------------- 1 file changed, 48
> > > insertions(+),
> > > 97 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c
> > > b/drivers/gpu/drm/sun4i/sun4i_tv.c index c65f0a89b6b0..4f07aff11551
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> > > @@ -141,23 +141,14 @@ struct resync_parameters {
> > >=20
> > >  struct tv_mode {
> > > =20
> > >  	char		*name;
> > >=20
> > > +	unsigned int	tv_mode;
> > > +
> > >=20
> > >  	u32		mode;
> > >  	u32		chroma_freq;
> > >  	u16		back_porch;
> > >  	u16		front_porch;
> > >=20
> > > -	u16		line_number;
> > >=20
> > >  	u16		vblank_level;
> >=20
> > isn't there a way to get or calculate back_porch, front_porch and
> > vblank_level from mode? From quick glance over removed values below, I
> > would say that at least back_porch can be removed too?
>=20
> I tried actually, but I'm not sure what the front porch and back porch
> parameters actually are. They are called that way by Allwinner, but it
> doesn't match the PAL or NTSC timings at all.
>=20
> For example, back_porch is 118 for NTSC and 138 for PAL. Actual back
> porches would be around 12 and 16, respectively. Actually, the entire
> blanking area are 138 and 144. This is close enough for PAL, but pretty
> far off for NTSC.
>=20
> Allwinner has the habit of integrating the sync period into one of the
> porches, but still there's no obvious match.
>=20
> front_porch is pretty much in the same case.

Ok then.

>=20
> Since it affected the display output quite a lot, I chose to keep it for
> now unfortunately.
>=20
> > Otherwise this patch looks ok.
>=20
> Can I add your Acked-by/Reviewed-by then?

Sure.
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


