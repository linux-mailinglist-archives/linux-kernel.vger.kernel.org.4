Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CC26412E4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiLCBDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiLCBDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:03:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E37B57C;
        Fri,  2 Dec 2022 17:03:07 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB6666602BC4;
        Sat,  3 Dec 2022 01:03:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670029385;
        bh=RPzrkCAEPQfXJKn3vlW1rRB5Paq8qy2yzBRMuA91aro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYl9EBhdamrmdZ5isDmggxdedUwh1pOFlx4pjxLaszlup3Vgye+CZt7Vcov1FO/iy
         HH4XttI7mqu5cpk3WEZo1+GTzjcpqDTmjikvgpp5OzCeaD1UQw4Sd67WkyZ37YoxYe
         SbwvPabiKz+gVgc7o1jPj/hS3XLwyO9gnLDMUHGnIXYkHcuJV9JwUXPLu3t+ZvvkMu
         o6VTqsCo570eDSun6TZvptTkaEeTJFpT0X8OkXPKrWFezr87I9IDzObcbEiZONyvXv
         BynUabe/B95dUW46/WlMUt3NVQmCJ/HZddHWKGnVI5W06BmqaE52M9dYdUp/XAMhnb
         xWYAYFcsIsvxA==
Received: by mercury (Postfix, from userid 1000)
        id 2525D1060E96; Sat,  3 Dec 2022 02:03:03 +0100 (CET)
Date:   Sat, 3 Dec 2022 02:03:03 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermes Zhang <Hermes.Zhang@axis.com>
Cc:     kernel <kernel@axis.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: bq256xx: Remove init ichg/vbat with max
 value
Message-ID: <20221203010303.it5urfo2i7pj4n3n@mercury.elektranox.org>
References: <20221129090112.3451501-1-chenhuiz@axis.com>
 <20221129152715.4hwtobuv57hrndzu@mercury.elektranox.org>
 <60ca0aa6-508a-4350-f892-98d1368e3783@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e73lyxseft2hv73d"
Content-Disposition: inline
In-Reply-To: <60ca0aa6-508a-4350-f892-98d1368e3783@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e73lyxseft2hv73d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 30, 2022 at 09:27:42AM +0000, Hermes Zhang wrote:
> Hi,
>=20
> =E5=9C=A8 2022/11/29 23:27, Sebastian Reichel =E5=86=99=E9=81=93:
> > Hi,
> >
> > On Tue, Nov 29, 2022 at 05:01:12PM +0800, Hermes Zhang wrote:
> >> Init the ichg and vbat reg with max value is not good. First the chip
> >> already has a default value for ichg and vbat (small value). Init these
> >> two reg with max value will result an unsafe case (e.g. battery is over
> >> charging in a hot environment) if no user space change them later.
> >>
> >> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> >> ---
> > It's the driver's task to setup safe initial maximum values.
> > Pre-kernel values may or may not be safe if you consider things
> > like kexec. If you get unsafe values programmed, then fix the
> > values instead.
> >
> > -- Sebastian
>=20
> The constant_charge_current_max_ua is either from dts or default value=20
> for each chip in the code, but I guess I could ot change them because it=
=20
> has their own meaning (it will be used to check if the setting is valid=
=20
> or not). Do you mean I can set some other value here instead of=20
> constant_xxx_max?

You can just change the DT value to something safe as it is meant to be?

-- Sebastian

--e73lyxseft2hv73d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOKoD8ACgkQ2O7X88g7
+poN4w//QbZtCLgYYjGGtlCJ6WSd02LPonSwrZrDsr3f06OMvpyP5c0WPNMJw1DV
j4JtAwI7w3kn+rGU7STFImF4I+Hjwq2k8u2I+hbTm/OhIkr9/nPR/Hvon2xDmDoL
Q73EI9x90KLCzkS/UfySp9/nGOnZfUkYauiZnPDroJk79mBLqwtxIq1qUboSygi/
D/0laui233oH8kZXwb14xndhfsECNTHHw1yENh5WYhbuLW/Uk3aT5utTty06Hgnk
6aGzW8s8WbzK7nWRICdmEJaMdqBdbxhmNSI6HY6+Zkel2+8q9bfXQZB0BplVSk0j
y9bW5eb7bB9widLVkYnfga61uCfGJNfVkvWgHoCn/bP2Xipy0oRmCFofqFAXRIMc
wgZ9+1NtRteEhRzJjoLXyu6e8w0HOaMZG5PQs67eTo4vDRa3YgXbaBFUaH32M8LA
N7iC19znDIRJ80YzhmAkAQmZSVOP0qy3t7nvl+gAHd9ZeHLHeuvoH7cTFNTtykBv
v7mh3NujnyD+mbg7xwY9qH5PxetwPcq/vAnfg2ZvIbw+dwZ8hz0QpKkCm1Vgt+h2
IpPs6OGbNjVlDqBzui64rYqS3CAlB40MC9mhPh/L9kBB7gf5yZTakA3AE/HnJDVj
77ceCPaEp9pPf+QyzjjySp/vFpLL1LsDAhw5IKDB1tJry4nzBEY=
=EH02
-----END PGP SIGNATURE-----

--e73lyxseft2hv73d--
