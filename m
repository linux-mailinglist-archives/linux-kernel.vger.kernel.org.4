Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377D9641303
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiLCBXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiLCBX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:23:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED323813A0;
        Fri,  2 Dec 2022 17:23:26 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2476E6602BC4;
        Sat,  3 Dec 2022 01:23:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670030605;
        bh=LopA+oSjD3fBAhDb+ubxMDBInXeZXWuU/yuEXq96bOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RP+6M9J9noiO1cvx2tSora1dSlEbngUnL6IXypSkuuXxcIYXIKzwzHFMPXLOYqzaZ
         go0m4+lg+qWiVi1zTPj4gCvMqjB3MgzgMpFp21UocQ091sesUdjKj9k+q6+IOSav7+
         9IAOGp8Yk0vgWiKj2JxXYeQZhi4ma3GfX97vx9ZXpSZaYaUphyr+94ywC+e2FcDJJ4
         yZsmc7piS8n+qU2NkeyBWx4OVEiKESry1TQvQjoNT6JrmnQZeCIlG8f+jiRe3o+M9s
         BmgZm9xZf68y9mKS27VzJ0WGhggkH98J6rqcxQbG57ZpceYWjHJdBiCSYEEDvwAEbi
         6vytohEXXi1QQ==
Received: by mercury (Postfix, from userid 1000)
        id C2D981060E96; Sat,  3 Dec 2022 02:23:22 +0100 (CET)
Date:   Sat, 3 Dec 2022 02:23:22 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     Qiheng Lin <linqiheng@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: Fix refcount leak in rk817_charger_probe
Message-ID: <20221203012322.pfempb5m4qtj6mjm@mercury.elektranox.org>
References: <20221128142740.1414-1-linqiheng@huawei.com>
 <638642f3.050a0220.8b7f1.d555@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w6mbcapmpzzamqzj"
Content-Disposition: inline
In-Reply-To: <638642f3.050a0220.8b7f1.d555@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w6mbcapmpzzamqzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 29, 2022 at 11:35:45AM -0600, Chris Morgan wrote:
> On Mon, Nov 28, 2022 at 10:27:40PM +0800, Qiheng Lin wrote:
> > of_get_child_by_name() returns a node pointer with refcount
> > incremented, we should use of_node_put() on it when not need anymore.
> > Add missing of_node_put() to avoid refcount leak.
> >=20
> > Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK=
817")
> > Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
>=20
> Good catch, thank you!
>=20
> Reviewed-by: Chris Morgan <macromorgan@hotmail.com>

Thanks, merged.

-- Sebastian

> > ---
> >  drivers/power/supply/rk817_charger.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/suppl=
y/rk817_charger.c
> > index 635f051b0821..d25a81d79fac 100644
> > --- a/drivers/power/supply/rk817_charger.c
> > +++ b/drivers/power/supply/rk817_charger.c
> > @@ -1060,8 +1060,10 @@ static int rk817_charger_probe(struct platform_d=
evice *pdev)
> >  		return -ENODEV;
> >=20
> >  	charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> > -	if (!charger)
> > +	if (!charger) {
> > +		of_node_put(node);
> >  		return -ENOMEM;
> > +	}
> >=20
> >  	charger->rk808 =3D rk808;
> >=20
> > --
> > 2.32.0
> >=20

--w6mbcapmpzzamqzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOKpQYACgkQ2O7X88g7
+pr0TA/+LmliblYQ0qVceGiVsTJnEuRbNevemtyfA9n7+Pl4fwq1uv08/RJXzXTl
7EERJ7SJIzDz+XHZkN8Frbvw+f/2QwN1jL0VHIPFxizN/OXBJ7MnmQrVheB/3uHh
OWwMidbGFsHsPHpt4qumU0NN2AbXnBMwD9gg4tcJXUsGrIP5rfC7apnNvZv2+/bb
+UHhxjmDVs4WCnYGVO6rqxqcwtFhEiwkzVggfI4aGzqXD+3AaCg6LXK/OpqHs7I6
G6sMK48R3e5CZWr3YplPElMQEpWKzpWsvIe/ZDvRzo6gzWyPZUsPDK1WY+2Txmlk
jnfOSac+OX7JJ1uNTTRm97ypVUizKbGtFoSkiFCieI/TePCl1kQng1beQVphiki/
Bzom8q0j1tFEAUhlLmilFkM85noSaoCoEqKeckIYxkkzKY31zgfdjLTK+Ea6MtKd
nf5QHSCZLChcXioNUf4Ib4pJ3jVLjm3DLyplCfu8nSR5gy0kT27EMIDVAHSi2zp5
xzi2CsG4m9kDbtIMLZXeP/Qn8j9XDtvOnuMPhvBOWgc1IQNPL/KfDm1Lqj4bCJqo
socICvZ+YzMU4/4tCs/2wbYPCeBYGr1iH1ZHhAsGDUVUaAIz+QCwfLSOTOByEr73
l7i7HZO4mcTgsMkpaAIAj4kKhk4tXUS4CPirBgk3wrgROT3o4EM=
=7IdE
-----END PGP SIGNATURE-----

--w6mbcapmpzzamqzj--
