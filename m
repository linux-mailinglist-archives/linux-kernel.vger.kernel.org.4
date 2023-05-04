Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B346F6C2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjEDMko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjEDMkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:40:40 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93C5618C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683204039; x=1714740039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XjD5Lue9Lkf/dmQP/R8Jn9j1qoZB72NHWl/kVOiids0=;
  b=LgEXsIE0Bn5P12MhAPayb5pP0J0IKm4qeqwXOTeFBljeoymfHpzpFyHc
   j6SnvyNjclmX588dGEhcJJr0/QJM+dR0C3mzUWRdqLptYOLkg6D49uUmD
   piriGZphUJHbzn5wfM9Js0/p6Qi0XZGbkFNJnneATqsSEZOwqLg34Mmlm
   yWipURoL4QpE71dh778X9ZysI3bcborGa0U9cRUtnC3fYS+AhweiJ6WRP
   SatyNDE2gVvWgX4Sj7Q3AoIF6bn7pNQiDE8c2tR6/DSdWt1E782bY4euh
   +STjpcYP1PTCvNIhMPrEKdt1WezmtG5SnD6qmnkLj10dBD9xfDSA3+m2U
   g==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677538800"; 
   d="scan'208";a="30721542"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 May 2023 14:40:36 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 04 May 2023 14:40:37 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 04 May 2023 14:40:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683204037; x=1714740037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XjD5Lue9Lkf/dmQP/R8Jn9j1qoZB72NHWl/kVOiids0=;
  b=cfKKuBCgLWD7c7nJ4RWavABYJt/bmpVc7s/NzVD+64y5qkj+Bz9YTj7D
   bqpLGYjr+616GSjF1P7NMmW9Fm2PUbn2RsCFrXshyGdckBSdwq1EbWfAg
   5NHtGpMXSvVdxIVM9CFZKxIwK+BWKbB6wmjzJHTOJwLkhQZJcUxwkwv+t
   5j7Hog7kCr+C85V3oE+aSz5SzpwO5Y0HA44nOaBvtt7B2Y7jZF32azCpt
   174/RWXpnEnyPovjQ/29N9Uy9tfXtPm+HRlbTWJx2ShrDFwmW+KUfnbP4
   HExUVarBS8E0J+OB/XvLh2QHohLvjNn7oUx96ku87ADBgdqqxigsYbwM1
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677538800"; 
   d="scan'208";a="30721541"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 May 2023 14:40:36 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4EF22280056;
        Thu,  4 May 2023 14:40:36 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, marex@denx.de,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH V3 3/7] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
Date:   Thu, 04 May 2023 14:40:34 +0200
Message-ID: <1759996.VLH7GnMWUR@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAHCN7x+7YWyvy+cDXcD2D5twJt_Ys6tP+TsLgjH4TgcORW0LPA@mail.gmail.com>
References: <20230502010759.17282-1-aford173@gmail.com> <7519081.EvYhyI6sBW@steina-w> <CAHCN7x+7YWyvy+cDXcD2D5twJt_Ys6tP+TsLgjH4TgcORW0LPA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Am Donnerstag, 4. Mai 2023, 14:00:08 CEST schrieb Adam Ford:
> On Thu, May 4, 2023 at 4:21=E2=80=AFAM Alexander Stein
>=20
> <alexander.stein@ew.tq-group.com> wrote:
> > Am Dienstag, 2. Mai 2023, 03:07:55 CEST schrieb Adam Ford:
> > > Make the pll-clock-frequency optional.  If it's present, use it
> > > to maintain backwards compatibility with existing hardware.  If it
> > > is absent, read clock rate of "sclk_mipi" to determine the rate.
> > >=20
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > >=20
> > >  drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > b/drivers/gpu/drm/bridge/samsung-dsim.c index bf4b33d2de76..2dc02a9e3=
7c0
> > > 100644
> > > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > > @@ -1726,12 +1726,20 @@ static int samsung_dsim_parse_dt(struct
> > > samsung_dsim *dsi) {
> > >=20
> > >       struct device *dev =3D dsi->dev;
> > >       struct device_node *node =3D dev->of_node;
> > >=20
> > > +     struct clk *pll_clk;
> > >=20
> > >       int ret;
> > >      =20
> > >       ret =3D samsung_dsim_of_read_u32(node,
> > >       "samsung,pll-clock-frequency",
> > >      =20
> > >                                      &dsi->pll_clk_rate);
> > >=20
> > > -     if (ret < 0)
> > > -             return ret;
> > > +
> > > +     /* If it doesn't exist, read it from the clock instead of faili=
ng
> > > */
> > > +     if (ret < 0) {
> > > +             pll_clk =3D devm_clk_get(dev, "sclk_mipi");
> > > +             if (!IS_ERR(pll_clk))
> > > +                     dsi->pll_clk_rate =3D clk_get_rate(pll_clk);
> > > +             else
> > > +                     return PTR_ERR(pll_clk);
> > > +     }
> >=20
> > Now that 'samsung,pll-clock-frequency' is optional the error in
> > samsung_dsim_of_read_u32() should be changed. Otherwise you will get
> >=20
> > > /soc@0/bus@32c00000/dsi@32e10000: failed to get 'samsung,pll-clock-
> >=20
> > frequency' property
>=20
> I'll change the message from err to info with a message that reads "no
> samsung,pll-clock-frequency, using pixel clock"
>=20
> Does that work?

Having just a info is totally fine with me. Thanks.
Although your suggested message somehow implies (to me) using pixel clock i=
s=20
just a fallback. I'm a bit concerned some might think "samsung,pll-clock-
frequency" should be provided in DT. But this might just be me.

Best regards,
Alexander

> adam
>=20
> > Best regards,
> > Alexander
> >=20
> > >       ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-
> >=20
> > frequency",
> >=20
> > >                                      &dsi->burst_clk_rate);
> >=20
> > --
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > http://www.tq-group.com/


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


