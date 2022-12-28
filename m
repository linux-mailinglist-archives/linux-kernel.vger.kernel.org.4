Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EDB6571EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiL1B6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiL1B5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:57:49 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C3F9292;
        Tue, 27 Dec 2022 17:57:49 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 67C94120C;
        Wed, 28 Dec 2022 02:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672192668;
        bh=Xb7nUn6EDqGGST4kb/TTOlSVXa+n18Xx10sbI7pkaC4=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=WJ8W7cOkD3Lw2VBRVTJz9C7TXysy97mFkEQj8xQEkMWm/X/k6T2VOYZ+qILeedJT0
         HoAnOmyrwPpQLRXtCkU9ZqfdDBokmuVUzyo4FEoi3Fj5zqoNBuBsMnQKnE8xxTXcLU
         tnmHCeC3VWhFPkfu/zA+0JBd8OU7lnjAwSoy9fnoDqmeWE3fTm9tcg9kzihmc2m+bp
         /E8yxp2+08AuudJc84X4xan5COazxmYRzRhyax6dQnu12gjOHRGR+EYL7eU7D03sje
         3WtxhyNwnnvspISDmbEd/amakF6T5dG/wZblaaJYW+OdLWdqIydQwODUxS8zUtW9pa
         eE7aMnBJ8yFqQ==
Date:   Wed, 28 Dec 2022 02:57:47 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 3/4] perf python: don't run the linker for clang feature
 tests
Message-ID: <6dd7e9dd522c7c6014f8273affa7a558918b048b.1672192591.git.nabijaczleweli@nabijaczleweli.xyz>
References: <44bb9a29bd7a0385c25ebfd69abd0a41ac2d753b.1672187710.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gemavj4ktrh3cvwf"
Content-Disposition: inline
In-Reply-To: <44bb9a29bd7a0385c25ebfd69abd0a41ac2d753b.1672187710.git.nabijaczleweli@nabijaczleweli.xyz>
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


--gemavj4ktrh3cvwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This, for me, slightly-more-than-halves the time it takes to run
  for a in "-mcet" "-fcf-protection" "-fstack-clash-protection" \
           "-fstack-protector-strong" "-fno-semantic-interposition" \
           "-ffat-lto-objects"; do
    sh -c '$CC "$@"' '' "$a" -o /dev/null ../build/feature/test-hello.c; do=
ne
=66rom just over 600ms.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/perf/util/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index ba0b1e078855..0a557f2bf357 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -6,7 +6,7 @@ cc_is_clang =3D b"clang version" in Popen(["/bin/sh", "-c",=
 "$CC -v"], stderr=3DPIPE
 src_feature_tests  =3D getenv('srctree') + '/tools/build/feature'
=20
 def clang_has_option(option):
-    cc_output =3D Popen(["/bin/sh", "-c", '$CC "$@"', "", option, "-o", "/=
dev/null", path.join(src_feature_tests, "test-hello.c")], stderr=3DPIPE).st=
derr.readlines()
+    cc_output =3D Popen(["/bin/sh", "-c", '$CC "$@"', "", option, "-c", "-=
o", "/dev/null", path.join(src_feature_tests, "test-hello.c")], stderr=3DPI=
PE).stderr.readlines()
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is n=
ot supported" in o))] =3D=3D [ ]
=20
 if cc_is_clang:
--=20
2.30.2


--gemavj4ktrh3cvwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOropoACgkQvP0LAY0m
WPF2jw/6AkulK2kjFfwEHV9b87kJ7O45cSTHu4+l9vrgvVu3ZJr6ZQDbjwGZppE8
f+jcqMQAIQG7oHdOkGvReLU8M6nsrDYgCIpKtusuJ4GBfiRnSWAvLfpt6dNK+mjx
r9wAtF0Y4o1INYpUhIF2BCQ4T0Wtuo/C2Az8I2C1OxHLibxe4DYc86lxR+MUauv6
G8BCLBovebU6Sfn8DKNgEqXCac+aLsw1j9Rqb5rHY3/43Ea9PHvB5LPJk0+falm/
3qoq7BKb7MXg1am23d+EOtIuncTrkjiuknPmuiK3Wv4WaBDp6s7l0Hay2ORFFs1B
nAGe7gNYZ4Y2TjB6CJ18IX8zXED+THhk75Yc0IEMT2uzS6QZr8cLGBy8gKcnlTWq
A7TZB4vuLSq12LoGGF6PNhs2STMDDF3TqqVphKDeFldElzWiK4krlI253/dMaHS5
JzbM3HZ1SaBt1k6MZteMYu61SitmQ9EYc0/vg4ad/Q5LWLDf49/AngpIRrEBfeis
js8E+Doqf7M2DbXt41sEOyemsYYapfqj2cqN8FafsyL+9Gnj50hxuw0aNI4PNg9/
Eg5v0tG0uC2AquDKxeUIta0WQ0OMaVagiRVzOCIKagZv1/SEB8mQ6jErVxRpWBLc
OlihSeVYZ1CtAiedqvxx7+NBggBr6sz1uwJgAvMM6/5bcRMn3CI=
=bqp7
-----END PGP SIGNATURE-----

--gemavj4ktrh3cvwf--
