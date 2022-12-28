Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A006571E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiL1B5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiL1B5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:57:47 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ECB7BE2;
        Tue, 27 Dec 2022 17:57:41 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 68ED4456;
        Wed, 28 Dec 2022 02:57:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672192659;
        bh=m02CFbCfLjgB/D/F8c3/1CJMeEw8Hb7kGUUt5zHmh94=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=IojomR1xBGcBofTo9LZmbGRmJ61IoSkBUvhP4FOcjSrLb0gsjuhDNGDzSEwRmlEL/
         pq85VA6FAoDBaZzAN0Egm0v0omd0KQ/Kc46F4rSiJKbRJ4cnZp3xi42jUvJi2X0+WY
         TXzdGZomYZNIjDiHA6G7w/7QJxWDVaDk8YE4g0D1wXG4jw2O5CCog0wQ0EX/6GJMC3
         QvGjEAu8VNyROqwGdin7xlGz4kAn4USxWC6Brb9Hw7FqO8Xl15BpW838e9RlKFl2vp
         k95XKgZPq6Bgb8T6P+mU9RvnHFiVwAkoz3q/eyIffU7wieD6Zk5AU0HkS6+U2Ai2bE
         jUd5YSbYKZr7g==
Date:   Wed, 28 Dec 2022 02:57:38 +0100
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
Subject: [PATCH v2 1/4] perf python: make clang feature detection work
Message-ID: <ea47c9d024e10a0cf50ae7f049320d89b307b5c7.1672192591.git.nabijaczleweli@nabijaczleweli.xyz>
References: <44bb9a29bd7a0385c25ebfd69abd0a41ac2d753b.1672187710.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tip2335yapfu46iq"
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


--tip2335yapfu46iq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As it stands, it's /entirely/ broken: cc_options is pasted together
with the tested option /as a single argument/.

For example, for CC=3D'cc -O3', this will run (the equivalent of)
  cc "-O3 -mcet" ../build/feature/test-heello.c
  cc "-O3 -fcf-protection" ../build/feature/test-heello.c
  ..
which, obviously, doesn't work, and has /never/ worked. The commit
referenced in Fixes: is just the first one that uses this approach.

Instead of emulating shell tokenisation and turning tokens into words
badly (well, we barely do it, which is even more alarming. the only way
I can foresee this having ever worked for anyone is if it, very literally,
returned False for /every/ clang_has_option() invocation with
non-single-token $CC, which, I mean, sure, but it means that every clang
build like this has all hardening off), just... run these through the
shell, like they will be at point-of-use anyway.

As a demo, with CC=3D'/tmp/cc -O3' and /tmp/cc consisting of
  #!/bin/sh
  echo "$*" | grep -qFe '-mcet' && printf 'CC:"%s"\n' "$@" "" > /dev/tty
  exec cc "$@"
before:
    AR      /mnt/filling/store/nabijaczleweli/code/linux/tools/perf/libsubc=
md/libsubcmd.a
  CC:"-O3 -mcet"
  CC:"/mnt/filling/store/nabijaczleweli/code/linux/tools/build/feature/test=
-hello.c"
  CC:""
  CC:"-O3 -mcet"
  CC:"/mnt/filling/store/nabijaczleweli/code/linux/tools/build/feature/test=
-hello.c"
  CC:""
    LD      /mnt/filling/store/nabijaczleweli/code/linux/tools/perf/libbpf/=
staticobjs/libbpf-in.o
after:
    GEN     python/perf.cpython-39-x86_64-linux-gnu.so
  CC:"-O3"
  CC:"-mcet"
  CC:"/mnt/filling/store/nabijaczleweli/code/linux/tools/build/feature/test=
-hello.c"
  CC:""
  CC:"-O3"
  CC:"-mcet"
  CC:"/mnt/filling/store/nabijaczleweli/code/linux/tools/build/feature/test=
-hello.c"
  CC:""
    LD      /mnt/filling/store/nabijaczleweli/code/linux/tools/perf/libbpf/=
staticobjs/libbpf-in.o

Fixes: commit 3cad53a6f9cdb ("perf python: Account for multiple words in
 CC")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/perf/util/setup.py | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index c294db713677..1cee26c63613 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -2,21 +2,11 @@ from os import getenv, path
 from subprocess import Popen, PIPE
 from re import sub
=20
-cc =3D getenv("CC")
-
-# Check if CC has options, as is the case in yocto, where it uses CC=3D"cc=
 --sysroot..."
-cc_tokens =3D cc.split()
-if len(cc_tokens) > 1:
-    cc =3D cc_tokens[0]
-    cc_options =3D " ".join([str(e) for e in cc_tokens[1:]]) + " "
-else:
-    cc_options =3D ""
-
-cc_is_clang =3D b"clang version" in Popen([cc, "-v"], stderr=3DPIPE).stder=
r.readline()
+cc_is_clang =3D b"clang version" in Popen(["/bin/sh", "-c", "$CC -v"], std=
err=3DPIPE).stderr.readline()
 src_feature_tests  =3D getenv('srctree') + '/tools/build/feature'
=20
 def clang_has_option(option):
-    cc_output =3D Popen([cc, cc_options + option, path.join(src_feature_te=
sts, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
+    cc_output =3D Popen(["/bin/sh", "-c", '$CC "$@"', "", option, path.joi=
n(src_feature_tests, "test-hello.c")], stderr=3DPIPE).stderr.readlines()
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is n=
ot supported" in o))] =3D=3D [ ]
=20
 if cc_is_clang:
--=20
2.30.2


--tip2335yapfu46iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOropEACgkQvP0LAY0m
WPGsVg/+PJMmdskKa6YK5DdrzqRRZeuhbZL/ZdF4Nnw+Ockjao22fsAPCLELOs51
382U/64gfXDl/Zo9ndgpzLF4z0yoh91SUssdF4zsHCXFg2WCeXb5DLRAOd821jAi
Um6B+PywCC9BhuYVh+I6Kng4xAEegW/NX5L46Xo0Qvv+C1sxDkuy+CtaaY8bKjxu
vCITb8JqyTMsvj+QM+OyyVhHOWGBwUS96EO5hv8a2GvidRPmDDjhYbC+px+XoBPA
NEkA50Ru3BOK0qZqJDa3CcwmTehX5Axc1sfY756abREEVtMGL0s3PL42fSH8EumE
cyYjgQOJP7pKqRiHtk2aF8OatTQPvC5Up0o9UQabS0OfaN6NP5zj+VlDFycH/N7p
2TtTx4gvSlnf4uwvE6DEKKn2wnszRACTn/S9CeSkQl0dzvKJRAZmb3pa8GVelgyE
LktIlYQN+ueUA7cZhLgUf1x5+KdWi5Syn1BKUQyu3oWVhRaMtJ3kwG6Wmx19tz9z
R2uouLeqWb8T7aSxbMR80huRZno5HxUzlq0rl2OCzYxEJNkOhBi8/YFyDKaQKUC5
Osad15aBLEV+ISzn1d8Zzcix40IvdtAVk/7nAQwvtJDHE7HeIlIWOWiuLc5UdIvw
5cmTeOqZq3tePl4ovM3iuLx4T3nqsxnqL70aL2vEPzKUaIEsXmE=
=9Kw2
-----END PGP SIGNATURE-----

--tip2335yapfu46iq--
