Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2873467C687
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbjAZJB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbjAZJBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:01:55 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5346779C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=u0sUEPVeCMKOWK/4uQF6FlZXB7Ib
        FACvVNl3+7NfhPk=; b=s5HB2qRShx4AmA0tcDFsDeLls5opixhiw9YNePafycP7
        XXQESvEh0u7v70wPijfZ+OcNqcN5BejcSugoxjG9lax4aJ2HvGEbD5825rxwGxY9
        tgf3fAetYvh5WsaW5qcwDCGSL7v/NUbhAw5Azo6so13KNkO7LnNDMFOg9PJwGGo=
Received: (qmail 3690228 invoked from network); 26 Jan 2023 10:01:50 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2023 10:01:50 +0100
X-UD-Smtp-Session: l3s3148p1@KtvW/ybz/Jgujnvo
Date:   Thu, 26 Jan 2023 10:01:49 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Message-ID: <Y9JBfTVqjXZqi1r3@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-kernel@vger.kernel.org
References: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
 <fb2a6e85-42ad-8b17-4433-8d5e96c87a80@linaro.org>
 <Y84wDxiBE6CZqSO5@ninjato>
 <8f9d6e07-6549-9b2e-a45b-f262b59bfe5f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HoSVSDqSZkvyTEVv"
Content-Disposition: inline
In-Reply-To: <8f9d6e07-6549-9b2e-a45b-f262b59bfe5f@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HoSVSDqSZkvyTEVv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> > I need it because of ".revision". This only applies to "ES1.*",
> > there are "ES2.*" and "ES3.*" around which have the same SoC number.
> > Also, there is usually no version numbering for the IP core. We need to
> > use this scheme in a number of other places already, sadly.
>=20
> I did not get whether this is runtime characteristics or it can be
> customized with compatible (just you did not do it)?

We have compatibles per SoC, i.e. "r8a7795". We don't have compatibles
for ES versions, i.e. no "r8a7795-es10" or "r8a7795-es20".

The latter would not be practical. We can't know in advance how many ES
revisions there will be, so we can't prepare DTs accordingly. Updating
later would be also difficult because we are usually not notified if
there is a new ES version. Only if there are problems with it. And which
board is available with which ES version is chaotic^2.

Also, if we update DTs later, old DTBs would not work with newer kernels
(requiring a later added compaible for a new ES version). This all still
ignores that it would be a churn to update for every ES version of every
SoC. We have quite many to support. That's why we use soc_device_match()
for ES versions in many places alreday. It was never a problem so far.

That's my reasoning, probably Geert has something to add. He maintains
the Renesas DT files.

All the best,

   Wolfram


--HoSVSDqSZkvyTEVv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPSQXYACgkQFA3kzBSg
Kbb/Kg//buuUfOdxQ33fjYDN8vDccNU3M8t6tkDIzbuIBKh7xMq2CPuMzSHixxp5
X5rmi9o5DYbzqm2G7JdrirWGQdH61M7/J4VwjMc64IlSL8UsPS3vzop2nFcMVGH1
Z9sVfoW2e2VycTevTPIeI2d6Ok5r8Leih5XDnhnn9z5uYXGvom72i+h9Pw3yHlXX
4nz8i/DUUulKJhwElj+Pq9nc4HR10lUoVcXtJPZo5cH2/T7Moi+/ZXiQ4gMV9hZi
YyJ/0AOmHfwGhZ8vc+NIVLxs56SpLYPMtlSANwtsSnVFZtCNpII5T3FpVOWC/YB1
kFHMJkSBq17P+ZOBnriaWYy5PUDRV6aEFO1DYe7nlsNJ6kDqaRjm++bDZRl83cVM
O4oOyVF+7jif1PqPDVhzESWQKAFa3Pctbz5nvyhrKZl2dxbXG2Hm1di18cCDeYu0
0lgMECLX6R+J5PbQdReMZAT/2IlCF7Zeq1PcUt4URAmX2r382mOIdfODRfHaylbH
h6naysEBs5XdkQ0y6UAGarh9KU+JW/eaf/+K+T5gYCCpZ62RcChyBMbzUAmgZwq+
pE8docN3vlKEanvaMH+u+0PVIxpyrF7FyTE/qdAoCkOq8gXadkcXw1ZmHMCSj2sf
UI7/OIjqilCDW6jU37C7mMsr4/WgxI7t3rLAC+ETITXMnIYhV+4=
=zTqh
-----END PGP SIGNATURE-----

--HoSVSDqSZkvyTEVv--
