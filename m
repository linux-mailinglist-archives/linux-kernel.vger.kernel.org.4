Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890696E2F9D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 10:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDOIBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 04:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:01:08 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D849D9;
        Sat, 15 Apr 2023 01:01:03 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E46FF1C0AB2; Sat, 15 Apr 2023 10:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681545661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WKOfHFSvF51S8U0qAFTMc9vvwKSGDaBvGYYgvsZmZKk=;
        b=f35DJZ/DoxfHcrF57sYZx+sKCO5YSn1hBjHDRULqu06+4KkItkxlVG7Tqc+FKue+Ld3Tys
        QzSaIstNHFre9/DnDvFDXZMShGivGLvRkQ+xFzjuBLI0ZXH91bu/bhBX6TG0waHwRuNw9B
        vpxBCgYM5+Ve3fYqw5XwsAakjoMm3SQ=
Date:   Sat, 15 Apr 2023 10:01:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel
 i2c LED driver
Message-ID: <ZDpZvhWX/Vx9jVUT@amd.ucw.cz>
References: <20230414055341.335456-1-andreas@kemnade.info>
 <20230414055341.335456-3-andreas@kemnade.info>
 <ZDlEsNZ3pTlfxkAz@duo.ucw.cz>
 <20230415000533.534ea99b@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HyL346m6DlBmbap6"
Content-Disposition: inline
In-Reply-To: <20230415000533.534ea99b@aktux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HyL346m6DlBmbap6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The device provides 6 channels which can be individually
> > > turned off and on but groups of two channels share a common brightness
> > > register. =20
> >=20
> > Yeah, well.. Turn it into 3-channel controller with brightness or
> > 6-channel on/off one... You can't really share brightness.
> >=20
> No, I cannot change the hardware, so it is a 6-channel with limitations.
> And the devicetree has to describe the hardware and not the driver.

Device tree is okay, I commented on the driver.

> What is discussable is just how the driver should deal with that:
>=20
> I see 5 possibilities.
> a) ignore the shared brightness problem (status quo)
> b) never set a brightness other than full on/off
> c) ignore one led of each pair (not register it at all{
> d) couple also the on/off of the pairs, so present to
>    userspace only max. 3 leds.
> e) allow full brightness control where independently possible,
>    if LEDs are defined where that leads to conflicts,
>    register them with max_brightness=3D1 and use them
>    in on/off mode.
>=20
> My preference were a) or e), the most possible usages.
> e) has a cleaner interface to the userspace.

b) c) e) are acceptable to me. So I guess e) is preffered.

BR,							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--HyL346m6DlBmbap6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDpZvgAKCRAw5/Bqldv6
8mJmAJ9pkr4g+mUllXlalLoHux4zFB6q8ACfcm6tduTKgAhtq5v26sV7/2ZHxa4=
=Vrcm
-----END PGP SIGNATURE-----

--HyL346m6DlBmbap6--
