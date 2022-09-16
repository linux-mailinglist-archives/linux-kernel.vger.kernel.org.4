Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089645BB550
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiIQBTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIQBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:19:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA626366;
        Fri, 16 Sep 2022 18:19:36 -0700 (PDT)
Received: from mercury (dyndsl-095-033-170-064.ewe-ip-backbone.de [95.33.170.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D8A12660204D;
        Sat, 17 Sep 2022 02:19:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663377575;
        bh=yqaC0PvBVidOF8Av25zyiT7pjFZ/iTKywbyjXrnbYvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MilfT3BTIhIq+zYmQ7U5eYGdXz86psnvJ/+uIX/QS7q2U/khLo6D7H68u/szJ8StO
         DJsGwhtDAHfBKojS/RgtPavCSIfGAzlukHnl3NIeww7wj6ejeRe34MaGXpFRnXoAtg
         x0btlbQOOnAuwLd/Tm8OnAMdUZbEwleIcTVMmnS1wu+EQXiCL/M+wzNIRxwwgtffXg
         neGyXPF1dAd+PcuM7qt96EoEvE3Ul77kHWLhiCMWHwLlC1Htn+jGqI+TYuCXT0R2uO
         lYeLO8P6OTCbtF4uWkmRhv7vJTJRZku+yVG5wWB/yMdGlGOlXbHqZVP/d0v9OKgN+E
         Qv+XGozy63+TQ==
Received: by mercury (Postfix, from userid 1000)
        id B24CA106084B; Sat, 17 Sep 2022 00:25:21 +0200 (CEST)
Date:   Sat, 17 Sep 2022 00:25:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: Ignore -EIO for uevent
Message-ID: <20220916222521.hxkgml5pslc6ln5v@mercury.elektranox.org>
References: <20220824165459.1.I059ae712dd6d324897162ee9f37c22849aa22745@changeid>
 <20220825140243.tgotqpymswduzlyy@mercury.elektranox.org>
 <YwgdraBXTWk1DhCE@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6hlcum573u663t4h"
Content-Disposition: inline
In-Reply-To: <YwgdraBXTWk1DhCE@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6hlcum573u663t4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2022 at 06:11:09PM -0700, Brian Norris wrote:
> Hi Sebastian,
>=20
> Thanks for the response.
>=20
> On Thu, Aug 25, 2022 at 04:02:43PM +0200, Sebastian Reichel wrote:
> > > For uevents, we enumerate all properties. Some battery implementations
> > > don't implement all standard properties, and may return -EIO for
> > > properties that aren't recognized. This means we never report uevents
> > > for such batteries.
> > >=20
> > > It's better to ignore these errors and skip the property, as we do wi=
th
> > > ENODATA and ENODEV.
> > >=20
> > > Example battery implementation: Acer Chromebook Tab 10 (a.k.a. Google
> > > Gru-Scarlet) has a virtual "SBS" battery implementation in its Embedd=
ed
> > > Controller on top of an otherwise non-SBS battery.
> > >=20
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> >=20
> > -EIO means input/output error. If a driver is reporting that for an
> > unimplemented feature it's a bug that should be fixed in the driver.
> > Handling it here means userspace ABI changes for temporary issues.
>=20
> I suppose I can agree with your last sentence.
>=20
> But the first part is much easier said than done. This is sbs-battery.c,
> on top of i2c-cros-ec-tunnel.c, talking to an EC (whose firmware is
> pretty much unchangeable at this point), which implements a subset of
> commands.
>=20
> The intention is that i2c-cros-ec-tunnel.c will see something like a NAK
> / "invalid argument" response, and it converts that to ENXIO.
> Unforunately, for reasons I have yet to figure out, it's very common for
> retries (|i2c_retry_count|) to eventually yield an unexpected response
> size, which i2c_smbus_xfer_emulated() treats as EIO; so this layer is
> seeing EIO.
>=20
> Anyway, I might be able to coax the i2c/sbs-battery driver to return
> ENXIO instead. Would you consider that to be a better case to handle
> here? "No such device or address" seems like an appropriate description
> of a permanent error, and not a temporary IO error.
>=20
> Brian

The device is obviously not fully implementing the SBS standard,
so I think the best is to create a new compatible value. Then the
driver can register a different set of properties based on that
and you never run into any error at all and userspace knows what
to expect.

-- Sebastian

--6hlcum573u663t4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMk984ACgkQ2O7X88g7
+ppzhQ/7B69yz3FJDXabgb6fD3Y2/g+yKs4mzqimNNyzOojCOGsktIuFqbKBa/G7
DTDwEswL0agxSen2YoMcXkByDgafI/XaVPcwAKfsM1uSK5iwO0NXoNz56kNsIixS
OKuU3Jcl4aAkXOU0QGab8QQ71nAJO5qfVSf3mQU7Dmrcid2QbH2d4Pv5iGsyivzG
9GJ9k7bMtQVLrRXsQ35RG3Fwm4nuDnKemfwlH0yGSEr9WZiQXwtj5USCqrA4JGES
doNfr9MKXRjFh+CTEcxlF1i0L6B3/HSNFqSiFu5hUK8DmcvWu8DqcH+XpMfw+AA0
EV1e1iq1T+cSLcvV4W2tav8NS1k0IVhVoAHvCMEeo4XPOwN6E/g0DwDdTkYjVLKE
RZGBqYU8BqmZPxU0a8uBhA5jSV7EreOo+ow06p2JsgNI1VE/ar7fWDme5e+RFIkn
1mW9TvWp2J5dC7B5/AmJnKvxzda/OrljuHbiyVwRYt6XnE6Nwh/2xN/a6WzRv5HV
bsWrXewij3V/W+F6D9LvmHaK0rVLHqwjhMHn0DkXWc3aPBDF1gU0cTEagIjlZWXB
cM9KWwFRqme6qVfDAuZ1A2R5ANqVG8HdsY9o0YZP1BcPiwFGjbIk4dt2lGpLin/T
T8qXD34cju0GySAypjwxBhsuIZRD0zHjvw6G2Zgo5IbDX36sdTM=
=abHX
-----END PGP SIGNATURE-----

--6hlcum573u663t4h--
