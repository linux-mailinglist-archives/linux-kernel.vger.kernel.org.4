Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22173677551
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjAWG6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjAWG63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:58:29 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33F213DD4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 22:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=w2/0Egwe4kRDQ/DFE4RZRVQyZM30
        lVWADhMsVRXCkjU=; b=tUO1PCqPrBRUi50IjWfFMPMy7h/UHEU2DNMUkGN4u9hX
        BlRkQQ9dxoUbk2hz4yyO1I5X3u5k/iWU+2FUg8ABpQNf7GEluIY+T4NIznfurxdV
        iJOJC7GpNlgwXwiWs9U7h/AgBN1y7CGWRQdmI7Y6oYw4vjl4Xpq4tjZufKcC3oM=
Received: (qmail 2080884 invoked from network); 23 Jan 2023 07:58:24 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Jan 2023 07:58:24 +0100
X-UD-Smtp-Session: l3s3148p1@uoTc7OjyDpwujnvx
Date:   Mon, 23 Jan 2023 07:58:23 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Message-ID: <Y84wDxiBE6CZqSO5@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-kernel@vger.kernel.org
References: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
 <fb2a6e85-42ad-8b17-4433-8d5e96c87a80@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2vsSYDuLTlO6XvG+"
Content-Disposition: inline
In-Reply-To: <fb2a6e85-42ad-8b17-4433-8d5e96c87a80@linaro.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2vsSYDuLTlO6XvG+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> > +static const struct soc_device_attribute rpcif_info_match[]  =3D {
> > +	{ .soc_id =3D "r8a7795", .revision =3D "ES1.*", .data =3D &rpcif_info=
_r8a7795_es1 },
> > +	{ .soc_id =3D "r8a7796", .revision =3D "ES1.*", .data =3D &rpcif_info=
_r8a7796_es1 },
>=20
> Why do you need soc match? Can't this be inferred from device
> compatible? Maybe the device compatible is not specific enough? Devices
> should not be interested in which SoC they are running - it does not
> matter for them, because the device difference is in the device itself,
> not in the SoC (different SoCs come with different devices).

I need it because of ".revision". This only applies to "ES1.*",
there are "ES2.*" and "ES3.*" around which have the same SoC number.
Also, there is usually no version numbering for the IP core. We need to
use this scheme in a number of other places already, sadly.

Thanks for reviewing,

   Wolfram


--2vsSYDuLTlO6XvG+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPOMA8ACgkQFA3kzBSg
KbYdHw/9EkvOHommX0prFyAko7s1jFgavjDyBCgpfbs7tpJlXSNLquoeWkmzs/Gt
SzeOIuY5RZXuLcYiZViPHtR4/prXGjpsKld38FA+3ftifPfTmTb6FDKKIJ2SMiZ3
PNyzi8SU94fovlQ1cnZJsmUQqqyVFI9LBGZH7pc4J1FOZiITt+TQYuCbwoDbtmLd
7zFv5j8cedQzgOgR45b4DQYIh2SD1S02K4xUhejoKcbtU9r/s9G3rUCHAAPXFZoM
v4hq20RbpCxSHcPwGET9IAUqqLCP1EkeLM2LeeDDKPwji6XbbGGI6Gbh7wbW2DXG
UGsnZ6F/6naEVTuOWwKu5P9g2giFZ/pOQidlWvqqZAOxS23GxcUqDU38frhWiM2w
DuK5DoTe+Y8wNObXgCEuNnL1oMZH3+VkuKhb7SrRhKiG6gNbsDIxhIp4C6U0HKhR
s2Q5CVwvV3cCJpgfs4tI5Q4bX/huF7st+jZLR3f8KTrHfpSnx2RoKpSCnqzq2oiA
H+JdI1C0FxlBijfPE9gnEYghs/N1ZAOHnAKTZm+wsKxYQ2dLRVRadPJIo2llN/c9
4NhJUym05MJ7Z01yd2rJb+81msrWTPP3KQmu9xUCQH7VwMCrou6kL45899m03kVF
uA3yixIBpeEMWyf+cc7ToqTDFPgbmEBe2iY5o6RrvtOmF0+fqh4=
=jusg
-----END PGP SIGNATURE-----

--2vsSYDuLTlO6XvG+--
