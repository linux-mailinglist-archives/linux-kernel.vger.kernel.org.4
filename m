Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BABE6ED533
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjDXTRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjDXTRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:17:37 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C644B5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=TqyP53BK1QNJZ0dWGD7gHEmj7/js
        wK7ug0KpqedoeLw=; b=iU23Iu1X196WF1lXyGx+Bn9NP7tFL5/vw836ufA7M8WP
        J6epUlS98VSAYzpteUyMRlwWHGabVrsnZYuFKORXktW3OmNuCkQLX4ICNlfK7UXA
        toSeewdeiJI4AJxo8zJlUZJqPk5yXF7lkp78/w/y8UJqynpl+r6LsTBeebSwieE=
Received: (qmail 1123223 invoked from network); 24 Apr 2023 21:17:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Apr 2023 21:17:30 +0200
X-UD-Smtp-Session: l3s3148p1@Vd2z2xn6iLAujnsI
Date:   Mon, 24 Apr 2023 21:17:30 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH 05/11] media: renesas: fdp1: remove R-Car H3 ES1.*
 handling
Message-ID: <ZEbVyhjKs15Rj+5h@sai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
 <20230307163041.3815-6-wsa+renesas@sang-engineering.com>
 <CAMuHMdVQiMbupkCYhZ86WHND25E==iA1DyVwGf2rg32zJLcV2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sNz7uPXnCVFL3uVV"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVQiMbupkCYhZ86WHND25E==iA1DyVwGf2rg32zJLcV2g@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sNz7uPXnCVFL3uVV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

thanks for reporting!

> > -#define FD1_IP_H3_ES1                  0x02010101

=2E..

> Apparently 0x02010101 is also used on (at least) R-Car M2-W ES1.0,
> causing the following annoying (but further harmless?) messages
> during boot:
>=20
>     rcar_fdp1 fe940000.fdp1: FDP1 Unidentifiable (0x02010101)
>     rcar_fdp1 fe944000.fdp1: FDP1 Unidentifiable (0x02010101)

Hmm, that means before my removal patch, Gen2 has been incorrectly
defined as H3 ES1?

> Note that the R-Car Gen2 documentation states the register's contents
> are all zeroes.  But that value would trigger the error message, too.

Bad, but well...

> Sorry for not noticing before. Apparently I never booted a kernel
> with this patch on koelsch...

We could re-add this version and just let it print "FDP1 Initial
Version" or something? I could test this on my Lager board.

All the best,

   Wolfram


--sNz7uPXnCVFL3uVV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmRG1cYACgkQFA3kzBSg
KbZqMhAAg4xWq1Ob2U4Uuc4wd5dD28eW0sFRhm+Yn/FojNi+I4/fVQXRI18Wajiu
nBTuVF8HEs91GfARCLKN/h/yi4F7Chit+mtyNl1DQA437iKIJwngAFJelhxKT84y
fwQbJvKe1nhvch4VmrxTvu3L3/sYZ+KYF2oplkxIqeMux7Yn1V+fHKNgP6NG/7Km
qaz0yQQ11aByTkb+77dHh9lsUVWDhiTrf+pyIhsq7Ad8RV9zKI5eWNwFu+Qfv74d
hcAnVsKcn+Dd3qxVeX0p+9cexaEimu+32NkUDX+qA514MiDOR/g5j+kwLjvJlH1j
0kYvfwRTDKuChXiGC96BN7fIivzxCqz344PXjRImJNY0NCXi1NIoiWfvLUsg20eK
xjbbpHNeUJrxI1JTjO85gDLIzN0LVj7sq8qrUiwiJzQogXUc7HWk/rcplnEdP3Yx
L4Mp/uZEuJ/wOyyTEqZzmfqk86h2/IjiWAKzGc483l4VKuPACHlhpluVqzEL+1sN
e8kwQnkGRG4OI7DmkEMK4M25jxCxaBnx7X2mkY49cSiAkF/HVHn672lCvRhkjkNG
/fhul+FccKfUX3d8XRwpGf+NTYszNYHzs9bMueWoM5ErMK9GSvCKVt6/+4NqNvvA
fWpVeVN0Y8l9YbEd8Y4nDkZV0dqMN4oToZrY9K8ZLskohc7p1Ho=
=ePn6
-----END PGP SIGNATURE-----

--sNz7uPXnCVFL3uVV--
