Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6571FB04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjFBHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjFBHcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:32:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41923C0;
        Fri,  2 Jun 2023 00:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C502E64CE6;
        Fri,  2 Jun 2023 07:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4865C433EF;
        Fri,  2 Jun 2023 07:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685691122;
        bh=6iHuX3uLHEp1J9fcDwMcWRd3yhdnvne0WcvP9Yv5swI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksxp3wwdRT7mXkPVNQT/GV2o+bCyg8HGnoxSuyb1QUndyU8g1vK52OkWroKRDxV9l
         p1fIbVilRp/59RlSYBKadkiNVoOSjXtMK0HL5Cdzhj9vbz7kyTIoMHsi4u3vE3urnY
         olGnBq1s6Nv+T2SmNplrhl6ZSS9vbnvDoDDGBaIhLey7F5iThz0bPzQ8aItQketulV
         SQ/but6KIi0ayJlnRrb68s9SoduKMp4yRqq0ZU2PLiNyng9EjM+Zr8J3hW8JFjSk0Z
         V/kNI/pG0yK1WHeOLf46Vi8G6n3aqKvmhucfUc6MTLXUijvO+rapLj1M42Jt6GNAxa
         G74Axy4HlO7RA==
Date:   Fri, 2 Jun 2023 09:31:59 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH 0/3] clk: sunxi-ng: Optimize rate selection for NKM
 clocks
Message-ID: <uvjlkaq4drqsndpwwflmbfnxseiftkrhq5qqmpfx5vfmduazed@wcohoxcd23wc>
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq>
 <87mt1jbf18.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfgafmbx7bxa2ywm"
Content-Disposition: inline
In-Reply-To: <87mt1jbf18.fsf@oltmanns.dev>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rfgafmbx7bxa2ywm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 01, 2023 at 07:16:45AM +0200, Frank Oltmanns wrote:
> On 2023-05-31 at 15:48:43 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> > [[PGP Signed Part:Undecided]]
> > Hi Frank,
> >
> > On Sat, May 27, 2023 at 03:27:44PM +0200, Frank Oltmanns wrote:
> >> I would like to bring your attention to the current process of setting
> >> the rate of an NKM clock. As it stands, when setting the rate of an
> >> NKM clock, the rate nearest but less than or equal to the requested
> >> rate is found, instead of the nearest rate.
> >
> > Yeah, it's actually pretty common, see clk_mux_determine_rate_flags()
> > for example. Some devices require that we don't overshoot, while some
> > prefer to have the closest rate.
> >
> > Both are fine, and it's a bit context specific which one we should
> > favour. If we were to do anything, it would be to support both and let
> > the clock driver select which behaviour it wants.
> >
>=20
> Ok, understood. Thank you for the explanation! Now, I'm wondering if
> anyone would be using such a flag, if I added it.

I guess that's another thing :) If no-one is going to use it, why should
we do it in the first place?

But most likely the display and audio clocks are usually fairly ok with
overshooting a bit, and a closest rate is usually better.

> >> Moreover, ccu_nkm_find_best() is called multiple times (footnote [1])
> >> when setting a rate, each time iterating over all combinations of n,
> >> k, and m.
> >
> > Yeah, that's expected as well.
>=20
> I'm wondering though, if iterating over all combinations is set in
> stone, or if some kind of optimization would be in order.

The thing with optimization is that you need to optimize for something.
So you need to show that this code is suboptimal (by whatever metric you
want to optimize for), and that your code is more optimal that it used
to be.

It means identifying a problem, writing benchmarks, and showing that the
new code performs better there.

For example, your code might very well be faster, but it will increase
the kernel image (and thus the RAM usage). One is not more optimal than
the other in absolute, they both are, using a different metric.

And then you have the more social factors that play a huge part too:
readibility, maintainability, etc.

> >> In response to this, I propose the following refinements to optimize t=
he NKM
> >> clock setting:
> >>  a. when finding the best rate use the nearest rate, even if it is gre=
ater than
> >>     the requested rate (PATCH 1)
> >>  b. utilize binary search to find the best rate by going through a
> >>     precalculated, ordered list of all meaningful combinations of n, k=
, and m
> >>     (PATCH 2)
> >
> > One thing you haven't really addressed is why we would be doing this? Is
> > there some clocks that require a more precise clock and don't? Is the
> > factor calculation a bottleneck for some workloads?
>=20
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I'm a pinephone user (ccu-sun50i-a64). I'm using U-Boot which sets the
> pll-video0 to 294 MHz on boot. The phone's panel requires DCLK to run at
> 108 MHz to get a nice 60 Hz vertical refresh rate. The clock structure
> is this:
>=20
>     clock                       clock type
>     --------------------------------------
>     pll-video0                  ccu_nm
>        pll-mipi                 ccu_nkm
>           tcon0                 ccu_mux
>              tcon-data-clock    sun4i_dclk
>=20
> The divider between tcon0 and tcon-data-clock is fixed at 4. So, I need
> pll-mipi to run at 432 MHz to get the desired vertical refresh rate.
> When pll-vdeo0 is at 294 MHz this is that rate cannot be matched exactly
> with any combination. The best we can get is 431.2 MHz (n=3D11, k=3D2,
> m=3D15).
>=20
> The pinephone has some "vendor" patches (megi kernel) that
>  a. add HDMI
>  b. allow re-setting pll-mipi's rate when pll-video0 changes
>=20
> Re: Who needs a more precise clock?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> When plugging in HDMI, pll-video's rate is set to 297 MHz, which - in
> the vendor kernel, not mainline - triggers recalculation of pll-mipi
> (trying to set it to 431.2 MHz). It ends up with a rate of 424.285714
> MHz, because this is the nearest, but less than 431.2 MHz (n=3D5, k=3D2,
> m=3D7). The nearest rate would be 432 MHz.
>=20
> So, while analyzing the whole situation that I described above, I found
> out that the NKM clocks are not set to the closest rate and wondered why
> that is. Hence my request for comments.

It all makes sense, but I'm not sure why it requires a complete rewrite
of the factor calculation algo?

> Now, one could argue that pll-video0 should be set to 297MHz at boot

Not really no, we should strive to be as immune as possible from the
boot state.

> or that pll-mipi should try to set the *requested* rate instead of the
> previous rate when the pll-video0 changes.

It's not clear to me what is the distinction you make here between the
requested rate and the previous rate?

Do you mean that you have two clk_set_rate in sequence, with the first
one on pll-mipi (or one of its child clocks), and the second one on
pll-video0 (but on a different sub-tree than pll-mipi) and thus pll-mipi
has its rate changed by the second, but doesn't match the previous rate
enforced?

If so, that's kind of expected: clk_set_rate doesn't provide any
warranty on for how long the rate is going to stay there. There's two
way to prevent that. Either we call clk_set_rate_exclusive (on the
first) instead, but it will effectively lock a clock subtree and prevent
any rate change which is a pretty big constraint. Or you add a notifier
to adjust to the parent clock rate change and still provide the same
output rate, with a different set of parameters.

Maxime

--rfgafmbx7bxa2ywm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZHma7wAKCRDj7w1vZxhR
xT6PAQC0c9UVSLFWvbVCqXRf35M+nKt6zaOLCrSsqq/GVMGhWQEA2odSUgp35a7D
WOd65Yy70MbeYpR0fau7/aVfMyEZPgs=
=iHML
-----END PGP SIGNATURE-----

--rfgafmbx7bxa2ywm--
