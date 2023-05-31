Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F353D717BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbjEaJcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjEaJbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:31:38 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE9F138;
        Wed, 31 May 2023 02:31:36 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9B5AB86133;
        Wed, 31 May 2023 11:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685525494;
        bh=Dz8YLbWlb/NHfvHF8tw3jpOgx8T7EoJoBQZXSzPm0ho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=US98Yr7JZkhutjp4/Ic9zChHzheG0ZmIaNCxqnMNDeZsua0iEZ5sVMv0w2JYc8N9Q
         9/pOqGlWBE+KFY+fCmzVKcRoQUhaIHhVZmaGPf+MSLxBG0292JjLTL8brESgkQywcG
         lFy22BEQ3xn66Pzuv+8zbwlMcrd+c9YkYoMb2ZMGIp1sqyBUzMTmA0xV83/HREdVkM
         dqb0aa7f9g3AY6NVbqyButvMAnqc49CfviagRIXyO3aueDIVKu7FA9BuucPdfoeDr6
         xuOCUdCoRoIshiP79Seclhi7L2F1WI8gzj4hOEnsNCfdBa2yPp6FOQbdBVRHmaIAvv
         zkxv/uDBJpMZg==
Date:   Wed, 31 May 2023 11:31:26 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: dsa: slave: Advertise correct EEE capabilities at
 slave PHY setup
Message-ID: <20230531113121.4dd392d9@wsk>
In-Reply-To: <ZHcBZ5hGTu7aBCsJ@pengutronix.de>
References: <20230530122621.2142192-1-lukma@denx.de>
        <32aa2c0f-e284-4c5e-ba13-a2ea7783c202@lunn.ch>
        <20230530154039.4552e08a@wsk>
        <ZHcBZ5hGTu7aBCsJ@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p0ndmoiOlqD_T5Ryyql7.kd";
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

--Sig_/p0ndmoiOlqD_T5Ryyql7.kd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

> Hi Lukasz,
>=20
> On Tue, May 30, 2023 at 03:40:39PM +0200, Lukasz Majewski wrote:
> > Hi Andrew,
> >  =20
> > > On Tue, May 30, 2023 at 02:26:21PM +0200, Lukasz Majewski wrote: =20
> > > > One can disable in device tree advertising of EEE capabilities
> > > > of PHY when 'eee-broken-100tx' property is present in DTS.
> > > >=20
> > > > With DSA switch it also may happen that one would need to
> > > > disable EEE due to some network issues.   =20
> > >=20
> > > Is EEE actually broken in the MAC/PHY combination?
> > >  =20
> >=20
> > Problem is that when I connect on this project some non-manageable
> > switches (which by default have EEE enabled), then I observe very
> > rare and sporadic link loss and reconnection. =20
>=20
> The interesting question is, do other link partner or local system is
> broken?

I was able to reproduce customer issue on my local setup with this
switch.

Moreover, only two devices were connected to this switch - mv88e6071
and the host PC.

> In some cases, not proper tx-timer was triggering this kind of
> symptoms. And timer configuration may depend on the link speed. So,
> driver may be need to take care of this.

The speed is only 100 Mbps, full duplex (as this switch only supports
speed up till 100Mbps).=20

>=20
> > Disabling EEE solves the problem.
> >  =20
> > > You should not be using this DT option for configuration. It is
> > > there because there is some hardware which is truly broken, and
> > > needs EEE turned off. =20
> >=20
> > Yes, I do think that the above sentence sums up my use case. =20
>=20
> As Andrew already described, current linux kernel EEE support is not
> in the best shape, it is hard to see the difference between broken HW
> and SW.

Ok.

>=20
> > > If EEE does work, but you need to turn it off because of latency
> > > etc, then please use ethtool.
> > >  =20
> >=20
> > Yes, correct - it is possible to disable the EEE with=20
> >=20
> > ethtool --set-eee lan2 eee off
> >=20
> > However, as I've stated in the mail, I cannot re-enable EEE once
> > disabled with:
> >=20
> > ethtool --set-eee lan2 eee on
> >=20
> > ethtool --show-eee lan2
> > EEE Settings for lan2:
> >         EEE status: not supported
> >=20
> >=20
> > As the capability register shows value of 0. =20
>=20
> Some PHYs indeed have this issues:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/net/phy/micrel.c?h=3Dv6.4-rc4#n1402
>=20
> In case of your older kernel version, you will need to fake access to
> the EEE caps register.

Thanks for pointing this out - I will add this functionality when
re-enabling of EEE will be required via ethtool.

>=20
> Regards,
> Oleksij




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/p0ndmoiOlqD_T5Ryyql7.kd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmR3E+4ACgkQAR8vZIA0
zr259wf/VvtYLeQbYYlr2YpitCq/igWjlShQTjsO2holZJmOHsBfQF5KoRPjcFbT
FEAn/X1C3PsVu2MkxdFUgTlnwZ7FnFkCtvo7o91oTwmoRAI+nkSkfVroA7/iGhj0
lU7EsIElUAK25cH2jOGwucvbCbCtvMjEF3g3M8wjwDrpd8DDaXQtUasiB439D5te
q9NyJ0NZCJcq6DwEWiDsH4KuNX91vdnpiGwxrph7quVngvLa9/3+W6/InTmtcm38
PLoCRqYQP5o56Tl1jHQfEc/JsJ114Jco8GRlvbmps7tWsr4lLyM3GNNAPRhAmJt8
0WUGOmEq4rmkzGTkwAWSpPmM48koEQ==
=NHQC
-----END PGP SIGNATURE-----

--Sig_/p0ndmoiOlqD_T5Ryyql7.kd--
