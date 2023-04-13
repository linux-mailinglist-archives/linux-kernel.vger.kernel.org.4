Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE136E0A50
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDMJeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDMJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:34:17 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDC310FC;
        Thu, 13 Apr 2023 02:34:16 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F35171C0AB2; Thu, 13 Apr 2023 11:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681378454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=umUMqWsiOaRqu7luUossCkhjp9MAzOhN4r0zCNlruGw=;
        b=j09S/WMQ7UC43E0YBYzSwzyrXdYzPTJUKQXOEBz6TGeZ3XbSTXKHbLJq7i/gNhIuWbjcem
        auCRYnaZskEmpqSHGXmWUxh7TXnK1Oe8jqKM+L/QuFbtnfLJK9k6mtzQD1+Iupx4JJAmvk
        t9QCYp1ARrQDvbQ9sFQlv5tm2PhlT2U=
Date:   Thu, 13 Apr 2023 11:34:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        martin_rysavy@centrum.cz, phone-devel@vger.kernel.org,
        maemo-leste@lists.dyne.org
Subject: Re: Motorola Droid 4 -- Stopping charger when battery is full
Message-ID: <ZDfMlfVDdSm8mXs0@duo.ucw.cz>
References: <ZAcvuP8kmWveLoE/@duo.ucw.cz>
 <ef4409b2-abd8-0eac-f66e-6858c3358cc1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v2tQ4p4f1q0mM6CF"
Content-Disposition: inline
In-Reply-To: <ef4409b2-abd8-0eac-f66e-6858c3358cc1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v2tQ4p4f1q0mM6CF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I complained that "battery life is very poor" with leste. It seems to
> > be combination of several factors.
> >=20
> > 1) I was using very old battery
> >=20
> > 2) My charger is detected as "USB", not as "AC"
> >=20
>=20
> And this is because there is no working charger detection in the driver, =
so
> initial current limit is hard-coded to 500mA.

Aha, thanks, makes sense.

> > According to my measurements "CPCAP_REG_CRM_FET_OVRD |
> > CPCAP_REG_CRM_FET_CTRL" results in battery discharding and 0A drawn
> > frmo the USB.  "CPCAP_REG_CRM_FET_OVRD" is phone powered from USB,
> > with battery more or less disconnected (<12mA), which is what we want
> > in battery full situation.
> >=20
>=20
> What will happen if phone needs to draw more than N mA (N is the set char=
ger
> current limit)?

We may run over the limit, AFAICT. I guess one solution would be to
only do this when limit is high enough...

With current setup, phone will not boot if battery is empty, so this
needs quite urgent solution.

I updated my leste, and now have:

user@devuan-droid4:~/g/droid4-linux$ uname -a
Linux devuan-droid4 6.1.9 #1 SMP PREEMPT Mon Mar 20 15:16:53 UTC 2023 armv7=
l GNU/Linux
user@devuan-droid4:~/g$ apt show linux-image-omap
Package: linux-image-omap
Version: 6.1.8.0-1+m7

Where can I find corresponding sources?

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--v2tQ4p4f1q0mM6CF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDfMlQAKCRAw5/Bqldv6
8sUaAJoDZHikjOWqxw/NosRn0342+r66mQCePUJTIGUw+651WfEGCjHdueGm+Ms=
=LkJe
-----END PGP SIGNATURE-----

--v2tQ4p4f1q0mM6CF--
