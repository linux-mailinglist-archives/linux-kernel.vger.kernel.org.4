Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039F66564D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 20:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiLZTuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 14:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiLZTuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 14:50:19 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4186A55AB;
        Mon, 26 Dec 2022 11:50:18 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6396ED16;
        Mon, 26 Dec 2022 20:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672084216;
        bh=YCslYJBvGc4yDOQPyvEncGq7pKRSJi+w2wNx2nl1G/0=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=qWfxwCKjmFtNu0dEuzmX6QAKBEHIGhVuz3c7oU5eYjKC8x0WYAdY89ZPqhqAu1mvl
         scqT7envogZf7iv2Kq7AGzWlXrfXZBewQBVuqX3DxVJef8ufXpKC2fKqQchFnMLH8R
         HcOs2vtpjEd6SeBe+RHb1pb6FJNeu614pNWp8VzJw8UfAYMTx+6JAdDNQrv5Tmxaob
         lVYQhbbg3pHh8qid3sNXSu+2f1U+rqvHZaxibJGln2elku/PPHB67IHMh4gUXlux1U
         JI3T/sqMlDPSjtowVewsAWpLRL5AfcEUKdCc9PhuW/oG+4vrFmI8EJ5zWarygP7Jwm
         Y6nLiM0wvSTWQ==
Date:   Mon, 26 Dec 2022 20:50:15 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/1] perf tools: don't include signature in version strings
Message-ID: <20221226195015.venelpockrns7uk4@tarta.nabijaczleweli.xyz>
References: <20221226193517.qynxfceqgzvr4qwu@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4dosrao6gairlrlk"
Content-Disposition: inline
In-Reply-To: <20221226193517.qynxfceqgzvr4qwu@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        MISSING_HEADERS,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4dosrao6gairlrlk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This explodes the build if HEAD is signed, since the generated version
is gpg: Signature made Mon 26 Dec 2022 20:34:48 CET, then a few more
lines, then the SHA.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/perf/Documentation/Makefile | 2 +-
 tools/perf/util/PERF-VERSION-GEN  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/M=
akefile
index 6e7b88917ca0..ba5d942e4c6a 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -267,7 +267,7 @@ $(OUTPUT)%.xml : %.txt
 	$(ASCIIDOC) -b docbook -d manpage \
 		$(ASCIIDOC_EXTRA) -aperf_version=3D$(PERF_VERSION) \
 		-aperf_date=3D$(shell git log -1 --pretty=3D"format:%cd" \
-				--date=3Dshort $<) \
+				--date=3Dshort --no-show-signature $<) \
 		-o $@+ $< && \
 	mv $@+ $@
=20
diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSIO=
N-GEN
index 3cc42821d9b3..d7dc7c28508c 100755
--- a/tools/perf/util/PERF-VERSION-GEN
+++ b/tools/perf/util/PERF-VERSION-GEN
@@ -19,7 +19,7 @@ TAG=3D
 if test -d ../../.git -o -f ../../.git
 then
 	TAG=3D$(MAKEFLAGS=3D make -sC ../.. kernelversion)
-	CID=3D$(git log -1 --abbrev=3D12 --pretty=3Dformat:"%h" 2>/dev/null) && C=
ID=3D"-g$CID"
+	CID=3D$(git log -1 --abbrev=3D12 --pretty=3Dformat:"%h" --no-show-signatu=
re 2>/dev/null) && CID=3D"-g$CID"
 elif test -f ../../PERF-VERSION-FILE
 then
 	TAG=3D$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
--=20
2.30.2

--4dosrao6gairlrlk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOp+vYACgkQvP0LAY0m
WPGQvxAAtmwdCScLR3bvQPExdKkODJh54IwsedWXrZhAgfho+gXNqtTnnQ2HTMa9
zMMJ5wqsQQDBzAMXIG6Gyt3gpJueBknoGSEm5fhOmgwBMNMtgPBAwk8Ho/DxoEQF
HESQjREO3nO5DPIuBEJtE9qFbtVvzLQdJTFNjd0ufJmVekeLq8c8+j5oMfZiwLjD
x15f7h5FcnQlPjiPb85FLmI7naGIgQGdG/G4p/Q/6VisipL5EEaouIoegNeOPKJ1
p5+990Ea485oN6s534+ped2JiQY67i2ua3WMbpAPvp3C+JP+Adc0O+pVVImo3G+8
eTnyZ0gni6cGls67xHKsNFJBEcJ11NmNADM8ybOv5J/jpkIHi/Uif8mG8bzCOcqi
0fv8Lx1Agcraa4t7Bp0eySA4GHfJb+A5BGUcRcNIHazkwt6VY1fRcgDsiPhOzEp6
QTdwZabz0yKX4r844BhCYIcyJEa2Hgi8wXa2RakL9Uq3xMHEcTrXMorlKpV+GAYt
MGrfCUA7cS/pAq+KXzFtFDNiLZLJGZnF1A/BE+9KWpBunBCzXSRC00K75C3E2zyD
P10LHJGEvuh/wg850gOmU//0Z8pRK6mkUd90GTsXXtFJrX7PQrz4Hx3Ec2eE77tq
DZQplANwF/smDbB9JZqo9MUWtBgcx1Uto9ukYBVg2cCbvpgjfi8=
=1xWC
-----END PGP SIGNATURE-----

--4dosrao6gairlrlk--
