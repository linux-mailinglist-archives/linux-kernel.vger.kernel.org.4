Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E36B9BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCNQnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCNQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:42:58 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37812197B;
        Tue, 14 Mar 2023 09:42:49 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9C9FB240004;
        Tue, 14 Mar 2023 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678812168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zzVgwaMKBc3wjUCBmy0mhm9516M7clvhDl4lf3k+HM=;
        b=JW7tRHyM9QYTKJDVXeJGntwXpBsOI3RaVv0sZhH2bjMfRdXBqs13bmhctRBf37O/uSx+Gg
        x1qnQ52Ivvf439iPpNZ6LhOfru+n8E/GfodA7lvnCNNjcLuE2PmgxtY9gS+cTR0CqrIKyt
        BnuUHhNTD5pjxKESxxUcNPvcTMq0I3/tzrhTGtraaDiV9pzNLV+STW5FxUmc9miaq4STdH
        bApaBT0LvFdwvglUq/IR0SSFT/Ot7uCAYhc/SpwQNg28aO+hSEpWfjnOAQXn+iobG6r/cK
        SG4giW6F1mYqDlc4t0vk2eOEdjPnmu360r+eVX8PgthZaTSX5WsPE04grdeoxg==
Date:   Tue, 14 Mar 2023 17:45:34 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: add missing of_node_put() in "assigned-clocks"
 property parsing
Message-ID: <20230314174534.53534b25@fixe.home>
In-Reply-To: <20230220124420.4150c767@fixe.home>
References: <20230131083227.10990-1-clement.leger@bootlin.com>
        <20230220124420.4150c767@fixe.home>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, 20 Feb 2023 12:44:20 +0100,
Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com> a =C3=A9crit :

Gentle ping.

> Le Tue, 31 Jan 2023 09:32:27 +0100,
> Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com> a =C3=A9crit :
>=20
> Ping ?
>=20
> > When returning from of_parse_phandle_with_args(), the np member of the
> > of_phandle_args structure should be put after usage. Add missing
> > of_node_put() calls in both __set_clk_parents() and __set_clk_rates().
> >=20
> > Fixes: 86be408bfbd8 ("clk: Support for clock parents and rates assigned=
 from device tree")
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > ---
> > v2:
> >  - Add "Fixes"
> >=20
> >  drivers/clk/clk-conf.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> > index 2ef819606c41..1a4e6340f95c 100644
> > --- a/drivers/clk/clk-conf.c
> > +++ b/drivers/clk/clk-conf.c
> > @@ -33,9 +33,12 @@ static int __set_clk_parents(struct device_node *nod=
e, bool clk_supplier)
> >  			else
> >  				return rc;
> >  		}
> > -		if (clkspec.np =3D=3D node && !clk_supplier)
> > +		if (clkspec.np =3D=3D node && !clk_supplier) {
> > +			of_node_put(clkspec.np);
> >  			return 0;
> > +		}
> >  		pclk =3D of_clk_get_from_provider(&clkspec);
> > +		of_node_put(clkspec.np);
> >  		if (IS_ERR(pclk)) {
> >  			if (PTR_ERR(pclk) !=3D -EPROBE_DEFER)
> >  				pr_warn("clk: couldn't get parent clock %d for %pOF\n",
> > @@ -48,10 +51,12 @@ static int __set_clk_parents(struct device_node *no=
de, bool clk_supplier)
> >  		if (rc < 0)
> >  			goto err;
> >  		if (clkspec.np =3D=3D node && !clk_supplier) {
> > +			of_node_put(clkspec.np);
> >  			rc =3D 0;
> >  			goto err;
> >  		}
> >  		clk =3D of_clk_get_from_provider(&clkspec);
> > +		of_node_put(clkspec.np);
> >  		if (IS_ERR(clk)) {
> >  			if (PTR_ERR(clk) !=3D -EPROBE_DEFER)
> >  				pr_warn("clk: couldn't get assigned clock %d for %pOF\n",
> > @@ -93,10 +98,13 @@ static int __set_clk_rates(struct device_node *node=
, bool clk_supplier)
> >  				else
> >  					return rc;
> >  			}
> > -			if (clkspec.np =3D=3D node && !clk_supplier)
> > +			if (clkspec.np =3D=3D node && !clk_supplier) {
> > +				of_node_put(clkspec.np);
> >  				return 0;
> > +			}
> > =20
> >  			clk =3D of_clk_get_from_provider(&clkspec);
> > +			of_node_put(clkspec.np);
> >  			if (IS_ERR(clk)) {
> >  				if (PTR_ERR(clk) !=3D -EPROBE_DEFER)
> >  					pr_warn("clk: couldn't get clock %d for %pOF\n", =20
>=20
>=20
>=20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
