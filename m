Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DBF716475
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjE3Oke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjE3Ok3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:40:29 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FDAD9;
        Tue, 30 May 2023 07:40:27 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E654184771;
        Tue, 30 May 2023 16:40:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685457626;
        bh=nCAsO6YzdaocrJisOtvhkHpnwIFZ8klzdEiTQeOXs58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MZyIIttksS/gBqEIOIGNvY92AWhBWGmlzKYhQCitmBDCFrSbXHLuyczc/ncWrPJru
         Yn1Z4QPp4dqn52rG+X05724EG2X+sb6DeiFlz3tGJRP32d/q7phs42ZWVTxn1J/osU
         WfFOBr4O+MCQG+5D+CFv3v3aj2ICBw6io5eg9OAUB+IDf889KPPR72YoVhHcAOh1kn
         H4kaDVOtp59tFZeHonxWpzmHeQKSPpoFrFAeWMizoRsxsaHy55pwXb8N/1oO65RRYh
         2XCR206EAr406odJUgZuYEJCSSWxJxNRX+fFHgN8EuwTxYrrIbmguAbMivyKNfMfb0
         qhaYQSLM69GAQ==
Date:   Tue, 30 May 2023 16:40:25 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: dsa: slave: Advertise correct EEE capabilities at
 slave PHY setup
Message-ID: <20230530164025.7a6d6bbd@wsk>
In-Reply-To: <e7696621-38a9-41a1-afdf-0864e115d796@lunn.ch>
References: <20230530122621.2142192-1-lukma@denx.de>
        <ZHXzTBOtlPKqNfLw@shell.armlinux.org.uk>
        <20230530160743.2c93a388@wsk>
        <e7696621-38a9-41a1-afdf-0864e115d796@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z=PGOl1xXbXnvYC4ToDKDEA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z=PGOl1xXbXnvYC4ToDKDEA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> On Tue, May 30, 2023 at 04:07:43PM +0200, Lukasz Majewski wrote:
> > Hi Russell,
> >  =20
> > > On Tue, May 30, 2023 at 02:26:21PM +0200, Lukasz Majewski wrote: =20
> > > > One can disable in device tree advertising of EEE capabilities
> > > > of PHY when 'eee-broken-100tx' property is present in DTS.
> > > >=20
> > > > With DSA switch it also may happen that one would need to
> > > > disable EEE due to some network issues.
> > > >=20
> > > > Corresponding switch DTS description:
> > > >=20
> > > >  switch@0 {
> > > > 	 ports {
> > > > 		port@0 {
> > > > 		reg =3D <0>;
> > > > 		label =3D "lan1";
> > > > 		phy-handle =3D <&switchphy0>;
> > > > 		};
> > > > 	}
> > > > 	mdio {
> > > > 		switchphy0: switchphy@0 {
> > > > 		reg =3D <0>;
> > > > 		eee-broken-100tx;
> > > > 	};
> > > > 	};
> > > >=20
> > > > This patch adjusts the content of MDIO_AN_EEE_ADV in MDIO_MMD_AN
> > > > "device" so the phydev->eee_broken_modes are taken into account
> > > > from the start of the slave PHYs.   =20
> > >=20
> > > This should be handled by phylib today in recent kernels without
> > > the need for any patch (as I describe below, because the
> > > config_aneg PHY method should be programming it.) Are you seeing
> > > a problem with it in 6.4-rc? =20
> >=20
> > Unfortunately, for this project I use LTS 5.15.z kernel.
> >=20
> > My impression is that the mv88e6xxx driver is not handling EEE setup
> > during initialization (even with v6.4-rc). =20
>=20
> In general, nearly every driver gets EEE wrong.=20

Ach... I see :/

> I have a patchset
> which basically rewrites EEE.

Ok.

> It has been posted as RFC a couple
> times, and i plan to start posting it for merging this week.

Ok. :-)

>=20
> But as a result, don't expect EEE to actually work with any LTS
> kernel.

Then, I think that it would be best to use the above "hack" until your
patch set is not reviewed and merged. After that, when customer will
mover forward with LTS kernel, I can test the EEE on the proper HW.

>=20
> 	Andrew




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/z=PGOl1xXbXnvYC4ToDKDEA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmR2CtkACgkQAR8vZIA0
zr2wMwf/ThyB1oVLay5mqG9rhyAeruSDYpuA/uGmNY4Pqhm1328aigl+OIoXx0AT
fbMbpmRBzV2D+SWDcU4RI/B2h0KmNQTinvBmXU/5L1D3VDbD+vQW/KbNeupxBehr
eta15sKjLszfsILZneloCcCow/pNLZ65TLgCtHb0wi6rnkAvMI0Cnn/8jTm2Lp6I
MHvCMujniLDPp8EnifQN27fqGe1AQWjuQrRIU/yzsuSodSv5ekFk7iIX2dYWVAzg
Rv0OnKM1gkJ6rqXk4YNFhDzDwlFIiAlDkR7OuXxt1alNax/D+WkT0LRsiPZsjijg
5KI04xFlGZuZeD7jIty1oCV74JT2YQ==
=Hxj6
-----END PGP SIGNATURE-----

--Sig_/z=PGOl1xXbXnvYC4ToDKDEA--
