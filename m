Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0C165716C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiL1AgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiL1AgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:36:13 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1170C2A;
        Tue, 27 Dec 2022 16:36:12 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 04443DB8;
        Wed, 28 Dec 2022 01:36:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672187772;
        bh=/RGVuKr5/3fCEx87FQ8Nip6ERreIb5DBGC2EyffIs24=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=fuPuYWcBEuWZDrHK7r+tlFxnVEDjRSfUxg5F1XbZUdKjSLnkAUn2hZH2WRFYRtVr8
         7wbGB7GKMQYpblP0yaD0DtfNvlvENzCWXcxQglQf288+wAbkC8nEH0BT4UmkQhCQnP
         vQ0spz/+EKLikRfa3lbF2LnzbCnoXuP+26d1jR4upnQOKZ/qSSyJpaZBkUyTlIw7As
         HhCx1oru5tKwvwf3knElh+jyjJH3ijWm8lONORICVA+3YDTNVUNYqM+8mMTZrueFEZ
         DZr/3V7lh66OSxXg0jtO1rBxeHh8ooZHLMAt8CWOKf+0eG73JtCyofQ4vMrHiF28GF
         jZSohr6L3xI+g==
Date:   Wed, 28 Dec 2022 01:36:10 +0100
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
Subject: [PATCH 2/2] perf python: don't run the linker for clang feature tests
Message-ID: <7d943ff294fbc606880a824b9764704f803f8beb.1672187710.git.nabijaczleweli@nabijaczleweli.xyz>
References: <44bb9a29bd7a0385c25ebfd69abd0a41ac2d753b.1672187710.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3obvt4otlktrkdug"
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


--3obvt4otlktrkdug
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This, for me, slightly-more-than-halves the time it takes to run
  for a in "-mcet" "-fcf-protection" "-fstack-clash-protection" \
           "-fstack-protector-strong" "-fno-semantic-interposition" \
           "-ffat-lto-objects"; do
    cc "$a" ../build/feature/test-hello.c -o /dev/null; done
=66rom just over 600ms.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/perf/util/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 58239e1cdb2a..400c99cd7734 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -16,7 +16,7 @@ cc_is_clang =3D b"clang version" in Popen([cc, "-v"], std=
err=3DPIPE).stderr.readline
 src_feature_tests  =3D getenv('srctree') + '/tools/build/feature'
=20
 def clang_has_option(option):
-    cc_output =3D Popen([cc, cc_options + option + "-o /dev/null", path.jo=
in(src_feature_tests, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
+    cc_output =3D Popen([cc, cc_options + option + "-c -o /dev/null", path=
=2Ejoin(src_feature_tests, "test-hello.c") ], stderr=3DPIPE).stderr.readlin=
es()
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is n=
ot supported" in o))] =3D=3D [ ]
=20
 if cc_is_clang:
--=20
2.30.2

--3obvt4otlktrkdug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOrj3oACgkQvP0LAY0m
WPHFcQ//VwvmoEt08EvPPuNlO0m3AH/15h9Tw3G8eXSbMBHT4IhvE7UZm7CiOaCx
ymvzKpnbZ4q/zqn8TV9MoVuppr9E6r6PNk7LTCzVFpTVPjphBuXM1tZ66JQAc1Tl
Gq/k9xumFejBUE9pRJHoeutprC2gAAIhc8Tn36URCjgqFLb1phq1MyPg6DbKuAVo
itbenP+2z5iSXtLM9cB1MmrK5UUSK61blfEsJJ4tph93zG9VSBGeqGMgHHSLpxUr
dLJkHbsrhlmhM2x1ufzCxcd6mOf8PN7Hur7krUKdyjguhmBvXDscHcmQrZooaZct
lFU5On8l5QHNClXH0cI8VectiD1tJGX82Y/c6XiEPV1Nn0Nz1vdiwtpX6rfV8Wey
tBWr+sFSLbDqgg0Iqr4ooxK/lraJvXj2PJrKLg1chwEcTAqYC8/kR1KNGfMq/b+D
/pdsXvVym1GWRMZ2wrhy+yvhja2mn3DRoEUQwTPi6Oxqv9JCgfuRHvuru2v4xP9c
Sf8VqDsVdu20Xuty6WUfo5pJaXAYMP8Ze/bGDOEGSM7tOBdzjRuTa5HkeOzUK9uu
LyusCrHNKV5H/A+DnZQWY/s4o/hilgJSpBOFySPT71tsM8aEoci2cdbbZOZB0NXm
5i8sfvHOnKdJHfgXThvcZmXj0vCZSSptTvEE0WIR4ATt/E2lge0=
=ZA2T
-----END PGP SIGNATURE-----

--3obvt4otlktrkdug--
