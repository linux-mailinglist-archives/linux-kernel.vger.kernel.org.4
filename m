Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC2725D78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbjFGLm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjFGLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781B919BD;
        Wed,  7 Jun 2023 04:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 134B861610;
        Wed,  7 Jun 2023 11:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AEDC433D2;
        Wed,  7 Jun 2023 11:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686138144;
        bh=KLtdS8YfUVeUIHmboqaXGQWETl5UWBvzrYSCepsSYQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODkUrE1ZZL7RktgPYR1RuRY1/mao6dCbR5TofAsFB9BoZzWWgFy/Xfrt/gtW7DNis
         2hFcKb0vkYD2Ck1VvMfgD8cul59R8upUoQitve+aBxmQ/l8PlVhZPQY+Uoc96REuvb
         nOI9b/sk+pUDw1i6uTja6dhD2bldpWXla3vspk6ExiThxOcZPo2A/Kci9dYHA2obfq
         dUmqDk/C3GkMWdsqW/fo1c88tV2+HEvE06oPXSABxvCSeu09fGSdoi3T3f7ZKVSVIc
         iLkffTa7GAacQIH9QOVHzxWQwHRicKjZIeSYT/V4Cfq6vZ9OH40KK73IFtXIe4nv9l
         gtxZj9lYxal0Q==
Date:   Wed, 7 Jun 2023 13:42:21 +0200
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
Message-ID: <jscgfo3ydkjmthlsnkuaxkyztajxekz37wiq7zbdcfoievkbfn@ebr2lm6he6ku>
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq>
 <87mt1jbf18.fsf@oltmanns.dev>
 <uvjlkaq4drqsndpwwflmbfnxseiftkrhq5qqmpfx5vfmduazed@wcohoxcd23wc>
 <87edmq9m2m.fsf@oltmanns.dev>
 <xcgmqvdoip53yao4sfoznnppauhmsmdablwoewh43zjv3bhidp@d7pxqohxydve>
 <87sfb41fhl.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jjn4z4f2oj3kdsmu"
Content-Disposition: inline
In-Reply-To: <87sfb41fhl.fsf@oltmanns.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jjn4z4f2oj3kdsmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 10:40:34PM +0200, Frank Oltmanns wrote:
> Hi Maxime,
>=20
> On 2023-06-06 at 16:02:58 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Mon, Jun 05, 2023 at 12:31:41PM +0200, Frank Oltmanns wrote:
> >> Hi Maxime,
> >>
> >> On 2023-06-02 at 09:31:59 +0200, Maxime Ripard <mripard@kernel.org> wr=
ote:
> >> > [[PGP Signed Part:Undecided]]
> >> > Hi,
> >> >
> >> > On Thu, Jun 01, 2023 at 07:16:45AM +0200, Frank Oltmanns wrote:
> >> >> On 2023-05-31 at 15:48:43 +0200, Maxime Ripard <mripard@kernel.org>=
 wrote:
> >> >> > [[PGP Signed Part:Undecided]]
> >> >> > Hi Frank,
> >> >> >
> >> >> > On Sat, May 27, 2023 at 03:27:44PM +0200, Frank Oltmanns wrote:
> >> >> >> I would like to bring your attention to the current process of s=
etting
> >> >> >> the rate of an NKM clock. As it stands, when setting the rate of=
 an
> >> >> >> NKM clock, the rate nearest but less than or equal to the reques=
ted
> >> >> >> rate is found, instead of the nearest rate.
> >> >> >
> >> >> > Yeah, it's actually pretty common, see clk_mux_determine_rate_fla=
gs()
> >> >> > for example. Some devices require that we don't overshoot, while =
some
> >> >> > prefer to have the closest rate.
> >> >> >
> >> >> > Both are fine, and it's a bit context specific which one we should
> >> >> > favour. If we were to do anything, it would be to support both an=
d let
> >> >> > the clock driver select which behaviour it wants.
> >> >> >
> >> >>
> >> >> Ok, understood. Thank you for the explanation! Now, I'm wondering if
> >> >> anyone would be using such a flag, if I added it.
> >> >
> >> > I guess that's another thing :) If no-one is going to use it, why sh=
ould
> >> > we do it in the first place?
> >> >
> >> > But most likely the display and audio clocks are usually fairly ok w=
ith
> >> > overshooting a bit, and a closest rate is usually better.
> >>
> >> Ok, I dived a bit deeper into this, but, as far as I can tell, the
> >> closest rate is not used anywhere in the sunxi-ng ccu driver. So, when
> >> extending, e.g., the NM or NKM clock to support, one must also extend =
at
> >> least the mux clocks, because they expect rates less than the requested
> >> rate. That seems to be quite the undertaking for only a small gain in
> >> precision.
> >
> > mux clocks are using __clk_mux_determine_rate which should have the
> > behaviour you want when CLK_MUX_ROUND_CLOSEST is set.
>=20
> https://elixir.bootlin.com/linux/v6.3.6/source/drivers/clk/sunxi-ng/ccu-s=
un50i-a64.c#L539
> is one example of a mux clock combined with a divider that is a bit more
> complex. I didn't look too deeply, but it seemed to me, that it would
> require two separate flags: One for the mux component and one for the
> div component. Maybe I'm mistaken, but it seems to me that the concept
> of having selected rates always be equal to or less than requested
> rates, seems to be deeply ingrained in the sunxi-ng driver. I'm afraid
> that I might miss some parts, therefore I abandoned that idea for now
> (especially since I have only one board for testing).

All the implementations (afaik) of the "composite" clocks we have that
combine a mux and dividers eventually use ccu_mux_helper_determine_rate
and divider_round_rate_parent. The last one can use
CLK_DIVIDER_ROUND_CLOSEST, and you covered the first one in your patch.
Which one did you leave out?

> >> >> >> Moreover, ccu_nkm_find_best() is called multiple times (footnote=
 [1])
> >> >> >> when setting a rate, each time iterating over all combinations o=
f n,
> >> >> >> k, and m.
> >> >> >
> >> >> > Yeah, that's expected as well.
> >> >>
> >> >> I'm wondering though, if iterating over all combinations is set in
> >> >> stone, or if some kind of optimization would be in order.
> >> >
> >> > The thing with optimization is that you need to optimize for somethi=
ng.
> >> > So you need to show that this code is suboptimal (by whatever metric=
 you
> >> > want to optimize for), and that your code is more optimal that it us=
ed
> >> > to be.
> >> >
> >> > It means identifying a problem, writing benchmarks, and showing that=
 the
> >> > new code performs better there.
> >> >
> >> > For example, your code might very well be faster, but it will increa=
se
> >> > the kernel image (and thus the RAM usage). One is not more optimal t=
han
> >> > the other in absolute, they both are, using a different metric.
> >>
> >> Sure, I get that. I'll submit a patchset that adds the functionality to
> >> NKM clocks to set the rate of their parents.
> >>
> >> With the new patchset, the time for, e.g. setting DCLK increases from
> >> ~0.5 ms to a whopping 30 - 37 ms. Those times were taken
> >> unscientifically on my pinephone, i.e. kernel logging and a couple of
> >> re-boots. But I think that still might give an idea of why I thought
> >> about the need to increase performance.
> >>
> >> The reason for this massive increase is, that the patch iterates over
> >> all combinations of NKM for pll-mipi, and for each combination it
> >> iterates over all combinations of NM for pll-video0.
> >>
> >> Nevertheless, following your and Jernej's advice, I'll submit the
> >> patchset first and then we can discuss if speed optimizations are need=
ed
> >> and what cost is acceptable.
> >
> > Honestly, for 40ms, it will be a hard sell :)
>=20
> I'm not sure what part you think is the "hard-sell":
>  a. the patch itself because 30 to 40 ms is way too much
>  b. the optimization, because 30 to 40 ms isn't all that much.
> I honestly don't know.
>=20
> BTW, this is the patchset in case you missed it:
> https://lore.kernel.org/lkml/20230605190745.366882-1-frank@oltmanns.dev/
>=20
> Note, that I have a patch in the works, which is similar to the one in
> this thread, but for ccu_nm. Doing a binary search for finding the
> parent rate of pll-mipi, i.e., pll-video0, reduces the time from ~30 ms
> to less than 2 ms. If combined with only iterating through meaningful
> nkm combinations for pll-mipi, this should bring the time under 1 ms
> again.

My point is that:

 * it's regression prone, so quite risky

 * but if the endgoal is to gain 40ms once, at boot, without any use
   case to back that up, there's basically no reward.

a high risk, low reward patch is what's hard to sell.

Maxime

--jjn4z4f2oj3kdsmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIBtHQAKCRDj7w1vZxhR
xcbbAQDi9CqHyZ4Awx2jfBHXAwdVCXicmpGwuE4L9hIFEEdD2AEAshGCprSSUj7e
GBrw4iJRatq6f1o32cOMY40VD9fBdQ8=
=9gco
-----END PGP SIGNATURE-----

--jjn4z4f2oj3kdsmu--
