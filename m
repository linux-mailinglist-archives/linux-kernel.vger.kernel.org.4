Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68590740A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjF1ICr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:02:47 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:44636 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjF1H7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:59:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F8B61331;
        Wed, 28 Jun 2023 07:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F264C433C8;
        Wed, 28 Jun 2023 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687938262;
        bh=ePwte3hrhMRziyfeeDbbH3c5avzzRC0gIsBYcHlC9js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjMlEnesyK9P+AFJZDUq00Qv7DFOoMq6ry7r+9WCXSqcUqAptsBa2G+J6AXCIKA9W
         8D+GnaHBh+6RIKisxsCWnGAmEk5BO78SXlHoGzHSSvQeLc49aTCMvjJthF2dVIAoRw
         9gnQ6Tt3MjkldESuFSecBALzpffGtoe1QomDSuZK33ACMt2eZWflhvrlT3z6I3g7Yi
         g5c88ledeW63xvTC2vAkYgaKWR7l5zeMaGDDAu4emO99xAbO7/fzY/tB5p5vOh1rf5
         NmoqrrRp7zVourImRSsBDs1SwOjEz0Xf1NCRCQYSpX7H3KyzEaA+beATg/HNpzmZEx
         d32LGGb8NJLSQ==
Date:   Wed, 28 Jun 2023 09:44:18 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] clk: sunxi-ng: Convert early providers to
 platform drivers
Message-ID: <maqh4yir66agto4lyulvrqrim7qnixwd246jusvvhsjlhhrmmw@gjbubqc2cv4o>
References: <20211119033338.25486-1-samuel@sholland.org>
 <20211119033338.25486-4-samuel@sholland.org>
 <yw1xedly2z3m.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyafrdifo4lqltls"
Content-Disposition: inline
In-Reply-To: <yw1xedly2z3m.fsf@mansr.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyafrdifo4lqltls
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 01:21:33PM +0100, M=E5ns Rullg=E5rd wrote:
> Samuel Holland <samuel@sholland.org> writes:
>=20
> > The PRCM CCU drivers depend on clocks provided by other CCU drivers. For
> > example, the sun8i-r-ccu driver uses the "pll-periph" clock provided by
> > the SoC's main CCU.
> >
> > However, sun8i-r-ccu is an early OF clock provider, and many of the
> > main CCUs (e.g. sun50i-a64-ccu) use platform drivers. This means that
> > the consumer clocks will be orphaned until the supplier driver is bound.
> > This can be avoided by converting the remaining CCUs to use platform
> > drivers. Then fw_devlink will ensure the drivers are bound in the
> > optimal order.
> >
> > The sun5i CCU is the only one which actually needs to be an early clock
> > provider, because it provides the clock for the system timer. That one
> > is left alone.
> >
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/clk/sunxi-ng/Kconfig             | 20 ++++----
> >  drivers/clk/sunxi-ng/ccu-sun4i-a10.c     | 58 +++++++++++++--------
> >  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c   | 56 ++++++++++++--------
> >  drivers/clk/sunxi-ng/ccu-sun50i-h616.c   | 33 ++++++++----
> >  drivers/clk/sunxi-ng/ccu-sun6i-a31.c     | 40 +++++++++++----
> >  drivers/clk/sunxi-ng/ccu-sun8i-a23.c     | 35 +++++++++----
> >  drivers/clk/sunxi-ng/ccu-sun8i-a33.c     | 40 +++++++++++----
> >  drivers/clk/sunxi-ng/ccu-sun8i-h3.c      | 62 ++++++++++++++--------
> >  drivers/clk/sunxi-ng/ccu-sun8i-r.c       | 65 ++++++++++++++----------
> >  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c     | 57 +++++++++++++--------
> >  drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c | 38 ++++++++++----
> >  11 files changed, 332 insertions(+), 172 deletions(-)
>=20
> This broke the hstimer clocksource on A20 since it requires a clock
> provided by the sun4i ccu driver.

The A10 is probably broken by this, but the A20 should be able to use
the arch timers just like all the other Cortex-A7-based SoCs.

Do you have a dmesg log that could help debug why it's not working?

Maxime

--oyafrdifo4lqltls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZJvk0gAKCRDj7w1vZxhR
xUNZAQCPJxji/u47iktYmhrmFscqGGbXgQkRSC/fP3nBs/RnnwEAqbOxrzh8lF3J
naqyI7DLolA/9Bf37opYB4Lh1y4PIQw=
=juQ0
-----END PGP SIGNATURE-----

--oyafrdifo4lqltls--
