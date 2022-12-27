Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FAB656FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiL0VI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiL0VH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:07:57 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00613DAB;
        Tue, 27 Dec 2022 12:57:45 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id C6624E2A;
        Tue, 27 Dec 2022 21:57:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672174661;
        bh=u+4jI8sJ77aO6ldqx4NYEzP0FaHDnE/y5VlgR4hoBjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/ibEgq982ZTO2/K+QueqWfH8IEBEYrQGQVoaF3jwenqJwLwUmhgVFj2k2vfVWB46
         NbJ6l2rrli/dL2OEo1vwoXCzhHL+SqNLvfrKxMYWaUH/vcxW5dWT8qw1D16Rx9/VUA
         SwRHz4WCtSXL6zbncBxty7xHcXlNTvjGjJ1pH8NjB3IxtNW8ssv89KvPSfzVI8Ejzp
         THkAMi0dGKJuyD9J2aYt51GxabcUCwoxwonn9sdv6nf36GDYUj02p/LB9WwMuhl3VQ
         CviQEZY4ujyyOWsFSB2dABMVvIZDFesAMVB5q5DmTOMvtI4t5oXEoAJf36Oi/BVNC5
         /3quRgYJ5T/Xw==
Date:   Tue, 27 Dec 2022 21:57:40 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        yaowenbin <yaowenbin1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf tui: don't ignore job control
Message-ID: <0354dcae23a8713f75f4fed609e0caec3c6e3cd5.1672174189.git.nabijaczleweli@nabijaczleweli.xyz>
References: <CAM9d7ciuh1H2Mfx5ToYGT1fOm8E3jrQhkzg304JKDd7BhT=h5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zypchkvuvqgxav6j"
Content-Disposition: inline
In-Reply-To: <CAM9d7ciuh1H2Mfx5ToYGT1fOm8E3jrQhkzg304JKDd7BhT=h5g@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zypchkvuvqgxav6j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In its infinite wisdom, by default, SLang sets susp undef,
and this can only be un-done by calling SLtty_set_suspend_state(true).
After every SLang_init_tty().

Additionally, no provisions are made for maintaining the teletype
attributes across suspend/continue (outside of curses emulation mode(?!),
which provides full support, naturally), so we need to save and restore
the flags ourselves, as well as reset the text colours when going under.
We need to also re-draw the screen, and raising SIGWINCH, shockingly,
Just Works.

The correct solution would be to Not Use SLang, but as a stop-gap,
this makes TUI perf report usable.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Yeah, somehow I didn't hit that in my tests, but it was relatively easy
to trigger when I tried. A full partial write retry loop is an overkill
here, I think, and few other places in perf actually try to resubmit
partial writes, so.

 tools/perf/ui/browsers/annotate.c |  1 +
 tools/perf/ui/browsers/hists.c    |  2 ++
 tools/perf/ui/browsers/scripts.c  |  1 +
 tools/perf/ui/tui/setup.c         | 22 ++++++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/ann=
otate.c
index c03fa76c02ff..6a4ffbf66c7f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -942,6 +942,7 @@ int hist_entry__tui_annotate(struct hist_entry *he, str=
uct evsel *evsel,
 	/* reset abort key so that it can get Ctrl-C as a key */
 	SLang_reset_tty();
 	SLang_init_tty(0, 0, 0);
+	SLtty_set_suspend_state(true);
=20
 	return map_symbol__tui_annotate(&he->ms, evsel, hbt, opts);
 }
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b72ee6822222..2479e6d42e7c 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3010,6 +3010,7 @@ static int evsel__hists_browse(struct evsel *evsel, i=
nt nr_events, const char *h
 	/* reset abort key so that it can get Ctrl-C as a key */
 	SLang_reset_tty();
 	SLang_init_tty(0, 0, 0);
+	SLtty_set_suspend_state(true);
=20
 	if (min_pcnt)
 		browser->min_pcnt =3D min_pcnt;
@@ -3682,6 +3683,7 @@ int block_hists_tui_browse(struct block_hist *bh, str=
uct evsel *evsel,
 	/* reset abort key so that it can get Ctrl-C as a key */
 	SLang_reset_tty();
 	SLang_init_tty(0, 0, 0);
+	SLtty_set_suspend_state(true);
=20
 	memset(&action, 0, sizeof(action));
=20
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scri=
pts.c
index 47d2c7a8cbe1..50d45054ed6c 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -166,6 +166,7 @@ void run_script(char *cmd)
 	printf("\033[c\033[H\033[J");
 	fflush(stdout);
 	SLang_init_tty(0, 0, 0);
+	SLtty_set_suspend_state(true);
 	SLsmg_refresh();
 }
=20
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index a3b8c397c24d..09524ba04975 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -2,12 +2,14 @@
 #include <signal.h>
 #include <stdbool.h>
 #include <stdlib.h>
+#include <termios.h>
 #include <unistd.h>
 #include <linux/kernel.h>
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #endif
=20
+#include "../../util/color.h"
 #include "../../util/debug.h"
 #include "../../perf.h"
 #include "../browser.h"
@@ -122,6 +124,23 @@ static void ui__signal(int sig)
 	exit(0);
 }
=20
+static void ui__sigcont(int sig)
+{
+	static struct termios tty;
+
+	if (sig =3D=3D SIGTSTP) {
+		while (tcgetattr(SLang_TT_Read_FD, &tty) =3D=3D -1 && errno =3D=3D EINTR)
+			;
+		while (write(SLang_TT_Read_FD, PERF_COLOR_RESET, sizeof(PERF_COLOR_RESET=
) - 1) =3D=3D -1 && errno =3D=3D EINTR)
+			;
+		raise(SIGSTOP);
+	} else {
+		while (tcsetattr(SLang_TT_Read_FD, TCSADRAIN, &tty) =3D=3D -1 && errno =
=3D=3D EINTR)
+			;
+		raise(SIGWINCH);
+	}
+}
+
 int ui__init(void)
 {
 	int err;
@@ -136,6 +155,7 @@ int ui__init(void)
 	err =3D SLang_init_tty(-1, 0, 0);
 	if (err < 0)
 		goto out;
+	SLtty_set_suspend_state(true);
=20
 	err =3D SLkp_init();
 	if (err < 0) {
@@ -150,6 +170,8 @@ int ui__init(void)
 	signal(SIGINT, ui__signal);
 	signal(SIGQUIT, ui__signal);
 	signal(SIGTERM, ui__signal);
+	signal(SIGTSTP, ui__sigcont);
+	signal(SIGCONT, ui__sigcont);
=20
 	perf_error__register(&perf_tui_eops);
=20
--=20
2.30.2


--zypchkvuvqgxav6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOrXEQACgkQvP0LAY0m
WPErzQ/7BVoBHjawpxBVUElSwDnWp3b8eJKom09IBHgTf8p+u194W6g2UTeJUB7T
aZpZFTtwJn8Dp4Frh6kdNbpGX4Rn70ZuIFiw/4rIUJ2SEKaSr5/f9b2h/sTwKbCP
PBVKT1pUg/AAQFTwPRL0p0vNXjXFn+fDsWVO9zaVJuXuiVv+suxAUD2ZKiAdKvrM
cuWrt1EKc0mFw5dIQQcnNK8FqkGW7bMjOqb+q07C9G94McDkdy35fHU/qW5Zka90
SxDa8itNNRR/w1khKGBUGMhRf7Q8rkEzo7AQkAGpWUqlipB3oeve2a6BEWcmXPvt
iF2NGWnz8fTiE8k14aWDlKoRt3Jm5TzVLO6qiXLEa3XhhJD3WNW6+U6uhB6JWEBU
7nlWLslb4BrMIcbx+MVx5pZEN+Jp80VCqGLnf6AiJ/U+PkHo/Q5PQau4RmLZ9LHE
PcKmaLVL25plsYTMauMOn49U+C4G/HZXTqePV7kLJIlJXIjgVR0ztKxZ0UF5E5ju
B0yrWt2h2G2ctHVeEqO/TEd7kFy1RlrJsyL6W0vyfUv3+JEM08Vj5Qr+mRJd043d
NKgX1HsCUwwILt7zzHqE8vqykJ1jUReudgNxwuxIYTZ2hxp8DBzQ+INSHCXH/b3K
+nSs7RMxdGDv0+RyhT7w3Q3VCbitrChrbfFXpnVvGrs3/SSxTxw=
=3TTM
-----END PGP SIGNATURE-----

--zypchkvuvqgxav6j--
