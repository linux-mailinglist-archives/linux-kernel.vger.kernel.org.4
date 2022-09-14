Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEE45B8C91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiINQKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiINQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:09:57 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6065A13F87;
        Wed, 14 Sep 2022 09:09:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id EA340DF3E2;
        Wed, 14 Sep 2022 09:09:18 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 97budlfwgD-l; Wed, 14 Sep 2022 09:09:16 -0700 (PDT)
Date:   Wed, 14 Sep 2022 18:09:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1663171755; bh=9vd0q6itDmfE21GUS13CLATbsBXtuez+ViX3pyN4+GU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=POtiF6ZHVUn1RLtqd+4PpfP0MFzBURxQv4e82DBAiDqTMBDDwZiQqwGAScjO+ZE7L
         Ls7SIk+HP/9IjgLT9GATMWXoFjenuezYha5t1bcD6/fYQgK3zDfatIuG6N9B+/ixS1
         LOy0O347j57HSvghB1qxpcxJyA0lztgD1mvH4xLSctbdxwRgUq6HF1X2yZUjHYZ0VT
         QCPeRPDmsEKv50jqLRa5bVdoJJrZAXL4Tmubsh6HGtRKAz355crFHj4EvkF4zifjxo
         Q4CEBDAmhM7ozinDNr/GQ9Wmfx5nTfsAwpwS2PS7h3uqMmsBy2JQ8cdhiYKS415KSn
         aCTnRJ5daTgsg==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, phone-devel@vger.kernel.org
Subject: Re: [PATCHv2 1/1] media: imx: Round line size to 4 bytes
Message-ID: <20220914180904.73929b55.dorota.czaplejewicz@puri.sm>
In-Reply-To: <YyH3ASYQsgD7i2Yt@kadam>
References: <20220914173236.3040f3a1.dorota.czaplejewicz@puri.sm>
        <YyH3ASYQsgD7i2Yt@kadam>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+n+/q=Q_lBmu8UM/QgzSajX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+n+/q=Q_lBmu8UM/QgzSajX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Sep 2022 18:45:05 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Wed, Sep 14, 2022 at 05:32:36PM +0200, Dorota Czaplejewicz wrote:
> > Section 13.7.6.13 "CSI Image Parameter Register" of the
> > i.MX 8M Quad Applications Processors Reference Manual
> > states that the line size should be divisible by 8 bytes.
> > However, the hardware also accepts sizes divisible by 4 bytes,
> > which are needed to fully utilize the S5K3L6XX sensors.
> >=20
> > This patch accepts line sizes divisible 4-bytes in non-planar mode.
> >=20
> > --- =20
>=20
> So do we need a Fixes tag?  Was this ever working in kernel?
>=20
No, it wasn't actually ever working upstream, just in a patched up branch I=
 mixed up with the real thing.
> Definitely need a Signed-off-by line, though. ;)

Thanks again!
--Dorota
>=20
> regards,
> dan carpenter
>=20


--Sig_/+n+/q=Q_lBmu8UM/QgzSajX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmMh/KAACgkQADBpX4S8
ZndI4RAAlq82TFtsRkB9fSpZPJetLf+MLb+8reJuV74AOy78S+31TY4xnn6+XssS
HU8KPNXEQmsJu96TbhFPnUVNtYKIUi/c/qfEw1BMWxaAyCxBIwaEmL0FHtBAdryg
/lIJN8vbttzH2z3cB0Zc5BpbzJBElAf91g/GWQxGikDd2hm0aYEYgnSmOf4stFLX
R2ik2hRTGT2IU3U2qyYHZlL1Y4IWqO+UKhaSpzKykuPP0OCWwacerl+zObySI7hF
51rWrxC/UKMWGD2ksY82TqAeo4utFIfYJFR7kvmlhD7FHBOF2g424pMGHuSj4iEo
8qnvkAfoiQhAsoSpe8FwcIr8KMyRbMHPHHYrm3JI6XGtFoNfMvvoOZcTZdfFrm69
vwBvST4QIdgJpaqGXfQH6hNCjEYMsTEpFevoLiVQEU9ISfcUFlRZOgQa0wbIjbWP
Dabnk8y058BQ97x0rWW95X5yK2T+89/jQG3h30b0iGdVTOmoYQlO/RmcoDk/wd+l
A57G7bAed97qkdbYkaiK7RDGoBcTKapb1g2g+/y+NzijL1jbfXp13bEGRK4OhfTp
QO+2r6aT9hFSqiMhNr30gNMixi8Zul32U0VFEfYBP0wbKoMlV7Yh8ux8v30QBH89
+G3Ed19L5h6NvrYZH7HxK7yy8mdKyW+d8kzOYkXiVwZ0SB9VkQY=
=Brg3
-----END PGP SIGNATURE-----

--Sig_/+n+/q=Q_lBmu8UM/QgzSajX--
