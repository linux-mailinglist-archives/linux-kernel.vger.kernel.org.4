Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DFF71FB0B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjFBHeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjFBHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF4D19B;
        Fri,  2 Jun 2023 00:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 173C9616CD;
        Fri,  2 Jun 2023 07:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88C1C433D2;
        Fri,  2 Jun 2023 07:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685691246;
        bh=9mKK9xIT/M/5/jc96vgkpb/vVwKfqaNG0PLckzjbiG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F16FgOCcSPoEmt05v6oK+gE/WgeGCUBoueZaoq/VqkZdscoUAVuEVZnuUClN4ew/v
         Q2nOUi8xp/Ql3jqboZ0xVrYwINNEws3Pk2n3YJhhDVl7QFiNuRrM/SkuwTJYkF0NIE
         gUvNYg35gH5qJ25d1FRg/6okgyJ/+mR3W22YpU3G2Ci4JdMtUSLVi7XzkZRR9BBezg
         Ynhtsi8C/thkWiT51VYf6Yo0JvsfRFCm8P8m9RMgvyQ5ZpKSzNvDzlk8po+fGpHnJr
         zoGTeZ7YUh9G5zTEhXt1ecETeKaT8NzWQK5ur1R49ueGY3AdQXOtfDCkAYbHLJ/THD
         IvK4wfJpkr90g==
Date:   Fri, 2 Jun 2023 09:34:03 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH 0/3] clk: sunxi-ng: Optimize rate selection for NKM
 clocks
Message-ID: <bhjq4yxo7fvddq3kvvvbgefhyaygb5bwkzhsjp3adc5kp7ohtx@iclghpep3zkw>
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq>
 <87mt1jbf18.fsf@oltmanns.dev>
 <4831731.31r3eYUQgx@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mepy56bihzsswzod"
Content-Disposition: inline
In-Reply-To: <4831731.31r3eYUQgx@jernej-laptop>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mepy56bihzsswzod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 09:41:30PM +0200, Jernej =C5=A0krabec wrote:
> Dne =C4=8Detrtek, 01. junij 2023 ob 07:16:45 CEST je Frank Oltmanns napis=
al(a):
> > Re: Why speed up factor calculation?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > I'm not aware that the current implementation of calculating n, k, and m
> > poses a bottleneck in any situation. Again, while going through the
> > code, I wondered why not save a few CPU cycles by precalculating the
> > meaningful combinations. In my opinion, it does not have any side
> > effects, so we might as well do it. (There is of course the side effect
> > of using a higher rate, but this is unrelated to precalculation as I
> > could as well employ a rate comparison that only allows lower rates, or
> > only optionally higher rates.)
> >=20
> > > Clocks in general are very regression-prone, so I'd rather be a bit
> > > conservative there, and "if it ain't broke, don't fix it".
> >=20
> > Sure, I get that.
> >=20
> > As I stated in my cover letter:
> > "The motivation for these proposed changes lies in the current behavior
> > of rate selection for NKM clocks, which doesn't observe the
> > CLK_SET_RATE_PARENT flag. I.e. it does not select a different rate for
> > the parent clock to find the optimal rate."
> >=20
> > I thought that this required this optimization to be implemented, but by
> > now, I'm no longer sure. I'll probably continue investigating different
> > paths for CLK_SET_RATE_PARENT for NKM clocks and follow up with new
> > findings.
>=20
> Let's leave out any optimizations that are not apparently needed. Most cl=
ock
> rates are set only once at boot and others, like video clocks, not that o=
ften,
> so a suboptimal code speed doesn't hurt currently.

I'm not even sure we can make that assumption for video clocks. We might
for a panel, but for a more "dynamic" output like HDMI all bets are off
and depending on the monitor, the user settings and the userspace stack
we can definitely expect the video clock to change quite frequently.

Maxime

--mepy56bihzsswzod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZHmbawAKCRDj7w1vZxhR
xShKAPwNIDbWuVsfmQMaSWHoQcEXxKCSyuOn0P8yvZSBP9ukvgD+KAz6Y83cu2l3
Z/9DTMMbQ1AU1SWfM/GStx6AOU9woQA=
=+40T
-----END PGP SIGNATURE-----

--mepy56bihzsswzod--
