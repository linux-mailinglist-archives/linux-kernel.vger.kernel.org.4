Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED98365716B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiL1Af5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1Af4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:35:56 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AC8BC2A;
        Tue, 27 Dec 2022 16:35:53 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id B34C6DB4;
        Wed, 28 Dec 2022 01:35:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672187750;
        bh=+yuFqRfY2HLZJC2FTM5sps1/rCx07mHiCqapWOI0R/c=;
        h=Date:From:Cc:Subject:From;
        b=hsmtYgBQLo1Z4Qzh85AN9gMUxXyHYaoD5iz+hIUBCovvxPn6km+W6Z1C6v1MscyZh
         Lha37KFpdbgElHnNfALmj/AhX2VXwFxgZ2vUGoLmBRzZJaEeVUVPe6tRrEgzcPEyW6
         equ9UmhUp9IeYY8D0PfCeYpxvVomhg42/LJPGJ6PTDaMKuvjmB7KjTfzq6THmx9Itd
         B3e5634EoqAHoDAXNs9JLN9S8ZUPw4quAzlRqd+eYHvYAEs0jsOI15Sr1IjxZ2W1kp
         7N+AZ6KCyos8845Hofx20UxisuGi+6QxUpes/opTdX+SEfHwcXarHyZCpdKoxjA/Fz
         NH0pbvjRY+mNQ==
Date:   Wed, 28 Dec 2022 01:35:49 +0100
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
Subject: [PATCH 1/2] perf python: fix clang feature detection littering
Message-ID: <44bb9a29bd7a0385c25ebfd69abd0a41ac2d753b.1672187710.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t3pulo24eodgyv74"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,MISSING_HEADERS,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t3pulo24eodgyv74
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This left behind tools/perf/a.out,
not .gitignored and not removed by make clean.

Fixes: commit 5508672d7f4949f15c316ffd947228f130498534 ("perf python:
 Remove -mcet and -fcf-protection when building with clang")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/perf/util/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index c294db713677..58239e1cdb2a 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -16,7 +16,7 @@ cc_is_clang =3D b"clang version" in Popen([cc, "-v"], std=
err=3DPIPE).stderr.readline
 src_feature_tests  =3D getenv('srctree') + '/tools/build/feature'
=20
 def clang_has_option(option):
-    cc_output =3D Popen([cc, cc_options + option, path.join(src_feature_te=
sts, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
+    cc_output =3D Popen([cc, cc_options + option + "-o /dev/null", path.jo=
in(src_feature_tests, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is n=
ot supported" in o))] =3D=3D [ ]
=20
 if cc_is_clang:
--=20
2.30.2


--t3pulo24eodgyv74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOrj2UACgkQvP0LAY0m
WPHYow//fy0XFEF+QnvjTzfb45o4BtmQnZjdY1QcstapWBzocqgQ+vuygxVpc7kJ
q5WzQVBwEPgBgqnqlLH9cDsQ1W7YRzbL9/7hn3/yq84CqYAr5aGPoF1oE/yPEUO8
9ngrEXMCfLi9U1rPfkd51y3X27J6+dnogMskoyl4vFsRdyDcsgU9APA7L2jmHyVc
VRm5JQDLDEgJE2kajCks6r8Qpz9M1xEiFB2yIXw+9Ithl7T1LJez62CHLUiM3Tnj
yld3e1y/VkIqPykc/gTR0Wiza4WUHyMY8ZpFB1cv8rwnr2z4hBuQQRoZ5XhUPmrI
WXkQgkoB2yesb7fu9+f30UmHIxShr5etoeDhhzxo/y37qHm4n1DQ5Qrt4WctE7FE
e0E7FtDRUNvrPBaRdxhVI0PGpc6XKsHHzY/LSsjhtgcO3m1o2r3GLdrFguckBdEt
RyWHxMV4lzsBpmFAH2/QfLWQcmIa1dFSe9hP8xzoc2BOLsouo/0kadzzEIYwatSP
00HgN8zhf/9YGX10cP1X35lpDNvx8ow02a5t/YnpSpkIToAimIlo+Xu4Bt9xvcXk
XEcZfE1gPIiJNBwSeM6NRmDtWGCwqFirh9S4fDiEGlZElNUfyYYpV3tHtlraMSG4
EBW22aYuAIzoAvRb5tOXVL1O4cHyFb1DSg4vlmkKPkFXIXrM+1s=
=KmYn
-----END PGP SIGNATURE-----

--t3pulo24eodgyv74--
