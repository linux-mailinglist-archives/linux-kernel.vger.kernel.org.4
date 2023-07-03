Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B665746181
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjGCRml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjGCRmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:42:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048B390
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:42:36 -0700 (PDT)
Received: from mercury (dyndsl-091-248-215-029.ewe-ip-backbone.de [91.248.215.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31BF56606F85;
        Mon,  3 Jul 2023 18:42:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688406155;
        bh=+mh0Q3S2UjyB/www++yqUMy1ueB4lCohv4YJsD2q3iI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mz2VEYvXzWBHzDRjTWh+VfucTY5Ggl/3UAzQPkF0uRcMEqMnsvIf0nKsqlEq6TsXg
         r7kcGcS7zwCnEIPYc0IhXzVQxgMujFJkFZjx9VjeZLeI4GQczN3pYW4X2OvKkDpjfa
         F1wyCCFGTYV9vM8fcAed6hbuQ1G75zfpoF8Ce6/XQnRplEzgTnV4c+aqC/5ALcmfRr
         6jv4lYDzhq41ePV7tHPgsNAGqacA+zzVe/tf/IfCcm51KEvWgSaTAVa0UESMiSvzMm
         M45TYbOAcvH+aM/ZRuySvc3D7gVrDXIeKExiwMThqC2xjkIL6Jlb94DvsqYaNGE0B0
         HIj2+QJkAXdZA==
Received: by mercury (Postfix, from userid 1000)
        id 2E30F106098B; Mon,  3 Jul 2023 19:42:33 +0200 (CEST)
Date:   Mon, 3 Jul 2023 19:42:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Chris Morgan <macromorgan@hotmail.com>,
        Yixun Lan <dlan@gentoo.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v1 1/1] irqchip/gic-v3: Enable Rockchip 3588001 erratum
 workaround for RK3588S
Message-ID: <20230703174233.wn7jusqeh3udusdz@mercury.elektranox.org>
References: <20230703164129.193991-1-sebastian.reichel@collabora.com>
 <863525x7eb.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qc4np6zcipime3pj"
Content-Disposition: inline
In-Reply-To: <863525x7eb.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qc4np6zcipime3pj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 03, 2023 at 05:54:36PM +0100, Marc Zyngier wrote:
> On Mon, 03 Jul 2023 17:41:29 +0100,
> Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> >=20
> > Commit a8707f553884 ("irqchip/gic-v3: Add Rockchip 3588001 erratum
> > workaround") mentioned RK3588S (the slimmed down variant of RK3588)
> > being affected, but did not check for its compatible value. Thus the
> > quirk is not applied on RK3588S. Since the GIC ITS node got added to the
> > upstream DT, boards using RK3588S are no longer booting without this
> > quirk being applied.
> >=20
> > Fixes: 06cdac8e8407 ("arm64: dts: rockchip: add GIC ITS support to rk35=
88")
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > I recently got a Rock 5A and noticed this issue. Apart from it, the Ind=
iedroid
> > Nova should also be affected (I don't have that board). There are no ot=
her
> > upstream RK3588S boards at the moment.
>=20
> What about "khadas,edge2"?

[+cc Yixun Lan <dlan@gentoo.org>]

Ah yes, that too. I should have grepped for rk3588s instead of
rockchip,rk3588 and trying to sort out the false positives (I
tried it that way to check if any other potential suffixes being
used).

> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic=
-v3-its.c
> > index 1994541eaef8..034ece9ac47c 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -4727,7 +4727,8 @@ static bool __maybe_unused its_enable_rk3588001(v=
oid *data)
> >  {
> >  	struct its_node *its =3D data;
> > =20
> > -	if (!of_machine_is_compatible("rockchip,rk3588"))
> > +	if (!of_machine_is_compatible("rockchip,rk3588") &&
> > +	    !of_machine_is_compatible("rockchip,rk3588s"))
> >  		return false;
> > =20
> >  	its->flags |=3D ITS_FLAGS_FORCE_NON_SHAREABLE;
>=20
> I don't mind taking this, but it also mean that only a new kernel
> will boot.

Yes. My assumption is, that this is considered a fix and landing in the
6.5 cycle. The rk3588s.dtsi from v6.4 does not yet have the GIC ITS
nodes. So there is not yet a tagged kernel with the boot failure. The
first one will be v6.5-rc1.

The quirk in the GIC driver only landed in v6.4, so anything older
is broken anyways. So effectively we are talking about v6.4 booting
a v6.5 DT, which is not something we guarantee to be working as far
as I know.

> Shouldn't you *also* fix the DT so that it advertises rk3588 as
> a fallback to rk3588s? This would ensure that an old kernel can boot
> as well.

RK3588S is a subset of RK3588. Thus rk3588s could be a fallback for
rk3588, but not the other way around. That way the quirk could only
check for "rockchip,rk3588s". But this would break the following
DTs, if they are not being patched in parallel:

$ grep '"rockchip,rk3588"' *dts
rk3588-edgeble-neu6a-io.dts:		     "edgeble,neural-compute-module-6a", "roc=
kchip,rk3588";
rk3588-edgeble-neu6b-io.dts:		     "edgeble,neural-compute-module-6b", "roc=
kchip,rk3588";
rk3588-evb1-v10.dts:	compatible =3D "rockchip,rk3588-evb1-v10", "rockchip,r=
k3588";
rk3588-rock-5b.dts:	compatible =3D "radxa,rock-5b", "rockchip,rk3588";

And in this case it breaks the DT backwards compatibility guarantee,
because new kernel is supposed to be able to boot an old DT. I
suppose adding the extra fallback to RK3588 might still be sensible
for any future issues.

-- Sebastian

--qc4np6zcipime3pj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSjCH8ACgkQ2O7X88g7
+pq02Q//TlLemr1jP5o5Mh8WuCjiJ0cPKS4G74sM8zQQVBvWVShdTuKIhp3AgQFT
RuYTgF7cSIp5wYR5u0tM+cj/OR+h7/O4npsYP7oBUsVBiYuUg6DlSUqYGc64FcB1
kXzp8Iu1rug9MMl6fRYEfuNs7CJSwDE2/wYrW1wDOycPUgMAus5fbbviBhT2hnbV
j8HoQzoDNRegw8WETNcuMR9UVXkfgSqFERBcrcFP+xLgokO1/BkF55wInhF3n6OB
XBJjQDTwHr76MFgZMv/3kRk5CwwB//SEoHFb1f+WALPNToPGfJawXdP43WjmEy9+
kOpK9oKmUDDnRZ7Z8TmFWrk09ZaGnDBB4q6FvJ3Bk5zFzkuFca6+V0BKR9POP8kF
l9c8CrSObqFBsDb5Pkf4QYxvHx2c0z32HbG+1g+NIJkiZh0zwAJzbEzcutQ1aLXn
ScwhvpMsYeJRM75C8TXCWd/dtE1CWRl61WZXWV3EiL73FZm1X11v9A13j3ms2sGJ
44lw/f3pJmACqBsQpUwf7QZKjLg2Yf5xH392+0AMtDfr8uyjgmDK7I4nFsuGw946
qTfYgxDXHhpyRdKOWXU3/+wTMSLZ5++XwY74e5XKU8FgvwI7yTKmOeHlHN6FexL3
7+Kd9ZI3ShQt1l9GTPNDgVOEl4xiizPOx66JZ+9jKvY298VePks=
=Tpf7
-----END PGP SIGNATURE-----

--qc4np6zcipime3pj--
