Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D11724533
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbjFFODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbjFFODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:03:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7413B196;
        Tue,  6 Jun 2023 07:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02D1F616E1;
        Tue,  6 Jun 2023 14:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C84C433EF;
        Tue,  6 Jun 2023 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686060181;
        bh=92sQlbOKY9LIyGWaHFriwmNnM+2pjstn4I/di/uN298=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRJu/8w8Wm0pzOl+OasRCkcLo+IOctRM2eC1PltWbmL48B+sYq33TC7hKpXKLqPKF
         QghQDUacG9jOlgMgaFSj3H29CCsCQNms6vo3prGx8LvIqX2X8bMh2joFmo6zkQmpwO
         nBbQiiqL8DRtzGxwnQweb7UceEnkFNc1vojV33+lhAXaBqYkoPrBF5w44NfWNnvhaW
         hJU+wHsYcBLhMDrtNsaYJkyyGUXvFF9Uf9CXfZUgIzJMdufuWcavRJOtVH5aNmzB1f
         b8iifCYwz0obcwXZn2ebQuylkYWQfBcOgnJ4Mgpyev4bfbBVL0PDlDYdf+O3v6SHHg
         X8ELB738mcIUQ==
Date:   Tue, 6 Jun 2023 16:02:58 +0200
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
Message-ID: <xcgmqvdoip53yao4sfoznnppauhmsmdablwoewh43zjv3bhidp@d7pxqohxydve>
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq>
 <87mt1jbf18.fsf@oltmanns.dev>
 <uvjlkaq4drqsndpwwflmbfnxseiftkrhq5qqmpfx5vfmduazed@wcohoxcd23wc>
 <87edmq9m2m.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oorsjwbcoooqvgbe"
Content-Disposition: inline
In-Reply-To: <87edmq9m2m.fsf@oltmanns.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oorsjwbcoooqvgbe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 12:31:41PM +0200, Frank Oltmanns wrote:
> Hi Maxime,
>=20
> On 2023-06-02 at 09:31:59 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> > [[PGP Signed Part:Undecided]]
> > Hi,
> >
> > On Thu, Jun 01, 2023 at 07:16:45AM +0200, Frank Oltmanns wrote:
> >> On 2023-05-31 at 15:48:43 +0200, Maxime Ripard <mripard@kernel.org> wr=
ote:
> >> > [[PGP Signed Part:Undecided]]
> >> > Hi Frank,
> >> >
> >> > On Sat, May 27, 2023 at 03:27:44PM +0200, Frank Oltmanns wrote:
> >> >> I would like to bring your attention to the current process of sett=
ing
> >> >> the rate of an NKM clock. As it stands, when setting the rate of an
> >> >> NKM clock, the rate nearest but less than or equal to the requested
> >> >> rate is found, instead of the nearest rate.
> >> >
> >> > Yeah, it's actually pretty common, see clk_mux_determine_rate_flags()
> >> > for example. Some devices require that we don't overshoot, while some
> >> > prefer to have the closest rate.
> >> >
> >> > Both are fine, and it's a bit context specific which one we should
> >> > favour. If we were to do anything, it would be to support both and l=
et
> >> > the clock driver select which behaviour it wants.
> >> >
> >>
> >> Ok, understood. Thank you for the explanation! Now, I'm wondering if
> >> anyone would be using such a flag, if I added it.
> >
> > I guess that's another thing :) If no-one is going to use it, why should
> > we do it in the first place?
> >
> > But most likely the display and audio clocks are usually fairly ok with
> > overshooting a bit, and a closest rate is usually better.
>=20
> Ok, I dived a bit deeper into this, but, as far as I can tell, the
> closest rate is not used anywhere in the sunxi-ng ccu driver. So, when
> extending, e.g., the NM or NKM clock to support, one must also extend at
> least the mux clocks, because they expect rates less than the requested
> rate. That seems to be quite the undertaking for only a small gain in
> precision.

mux clocks are using __clk_mux_determine_rate which should have the
behaviour you want when CLK_MUX_ROUND_CLOSEST is set.

> >> >> Moreover, ccu_nkm_find_best() is called multiple times (footnote [1=
])
> >> >> when setting a rate, each time iterating over all combinations of n,
> >> >> k, and m.
> >> >
> >> > Yeah, that's expected as well.
> >>
> >> I'm wondering though, if iterating over all combinations is set in
> >> stone, or if some kind of optimization would be in order.
> >
> > The thing with optimization is that you need to optimize for something.
> > So you need to show that this code is suboptimal (by whatever metric you
> > want to optimize for), and that your code is more optimal that it used
> > to be.
> >
> > It means identifying a problem, writing benchmarks, and showing that the
> > new code performs better there.
> >
> > For example, your code might very well be faster, but it will increase
> > the kernel image (and thus the RAM usage). One is not more optimal than
> > the other in absolute, they both are, using a different metric.
>=20
> Sure, I get that. I'll submit a patchset that adds the functionality to
> NKM clocks to set the rate of their parents.
>=20
> With the new patchset, the time for, e.g. setting DCLK increases from
> ~0.5 ms to a whopping 30 - 37 ms. Those times were taken
> unscientifically on my pinephone, i.e. kernel logging and a couple of
> re-boots. But I think that still might give an idea of why I thought
> about the need to increase performance.
>
> The reason for this massive increase is, that the patch iterates over
> all combinations of NKM for pll-mipi, and for each combination it
> iterates over all combinations of NM for pll-video0.
>=20
> Nevertheless, following your and Jernej's advice, I'll submit the
> patchset first and then we can discuss if speed optimizations are needed
> and what cost is acceptable.

Honestly, for 40ms, it will be a hard sell :)

> >> or that pll-mipi should try to set the *requested* rate instead of the
> >> previous rate when the pll-video0 changes.
> >
> > It's not clear to me what is the distinction you make here between the
> > requested rate and the previous rate?
>=20
> This is quite a de-tour from the original discussion, so I'm sorry for
> the confusion.
>=20
> By requested rate I mean the rate that the user (DCLK) requested. But
> this is not necessarily the rate that the clock is using in the end,
> because of its parent's rate.
>=20
> So, when the pll-video0 changes rate from 294 MHz to 297MHz (upon
> plugging in HDMI), pll-mipi does not know any longer what the requested
> rate (let's say 432MHz) was.

It does, it's struct clk_core's req_rate. It doesn't look like it's
available to clk_hw users, but given the rest of your explanation, I
guess you have a compelling use case to make it available.

Maxime

--oorsjwbcoooqvgbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZH88kgAKCRDj7w1vZxhR
xYZZAP0SAEPvAUvjDPfVv3zOHOnaNCsV5M4IfwS/1NtJva9K0AD/ZufHZhbfMnIu
WquTg8eFvgf8+koLgpj/tFUrEbonwQY=
=7fL/
-----END PGP SIGNATURE-----

--oorsjwbcoooqvgbe--
