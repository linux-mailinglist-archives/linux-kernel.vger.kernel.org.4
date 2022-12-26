Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ACB6564D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 20:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiLZTfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 14:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLZTfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 14:35:23 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FB6BCF0;
        Mon, 26 Dec 2022 11:35:22 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id EDB658F8;
        Mon, 26 Dec 2022 20:35:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1672083319;
        bh=fw89pnRCbIpQCMHd/3eD8CcHp04GmjjsFw8VwI7QeA0=;
        h=Date:From:Cc:Subject:From;
        b=IMq3gPRk6tjzNbhiKOXnmL9YRHmxX1O7Rz/yVpCC8kI1uJ0V0ZwpU/imraPjpFf4z
         aMCyWShy4gjzp9EWS1H+5Dil9QG3DDujLx6h8fgtI1AFcNt2OmxzCgGChRNcSDHOAC
         csy2QBKQEbdFfuHedJSLM6SBg02Fiqj6rRL9PzncupmQ4LP7By34lJL4RPx8Fecu2T
         MeQ5ZFJJu9XOHqcn30b8vyShQ03K4ZQ09Pb0Kx2qrEnPMLijorO7kkwAI7qjrIWpCh
         hxSr3s6juZKUlb5gWaDUTk2SQc1kkQ11W896vJKZxdIq5+9lC4vO99ffYEgaXGY7v2
         k/s526PoO93qg==
Date:   Mon, 26 Dec 2022 20:35:17 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        yaowenbin <yaowenbin1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tui: don't ignore job control
Message-ID: <20221226193517.qynxfceqgzvr4qwu@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ktmisgcf7dvsevo"
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


--7ktmisgcf7dvsevo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In its infinite wisdom, by default, SLang sets susp undef,
and this can only be un-done by calling SLtty_set_suspend_state(true).
After every SLang_init_tty().

Additionally, no provisions are made for maintaining the teletype
attributes across suspend/continue (outside of curses emulation mode(?!),
which provides full support, naturally), so we need to save and restore
the flags ourselves. We need to also re-draw the screen, and raising
SIGWINCH, shockingly, Just Works.

The correct solution would be to Not Use SLang, but as a stop-gap,
this makes TUI perf report usable.

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 tools/perf/ui/browsers/annotate.c |  1 +
 tools/perf/ui/browsers/hists.c    |  2 ++
 tools/perf/ui/browsers/scripts.c  |  1 +
 tools/perf/ui/tui/setup.c         | 19 +++++++++++++++++++
 4 files changed, 23 insertions(+)

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
index a3b8c397c24d..4211a161458a 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -2,6 +2,7 @@
 #include <signal.h>
 #include <stdbool.h>
 #include <stdlib.h>
+#include <termios.h>
 #include <unistd.h>
 #include <linux/kernel.h>
 #ifdef HAVE_BACKTRACE_SUPPORT
@@ -122,6 +123,21 @@ static void ui__signal(int sig)
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
@@ -136,6 +152,7 @@ int ui__init(void)
 	err =3D SLang_init_tty(-1, 0, 0);
 	if (err < 0)
 		goto out;
+	SLtty_set_suspend_state(true);
=20
 	err =3D SLkp_init();
 	if (err < 0) {
@@ -150,6 +167,8 @@ int ui__init(void)
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

--7ktmisgcf7dvsevo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmOp93UACgkQvP0LAY0m
WPGuhw/+IfBma2bEIbPiv89yX0VjjvOh7gCqore1yubiU/xLE4Rl9Ai25Vox/19H
NtWtPD1QB4xImEjaCm1nOP2gwLgB6xgQQM5hsZDQYj0KF3Im2tO2DLSiUx421PFp
CLRKRv7t77hA/LKMeGCHMNJVHXLpF6cFr/RY7raQiP4SpSJ5emvTSYCWxCSztL7V
YqpKWYikIum7O1nKn9L/1jzAvTJd5sUSBy7ASyz/I7P62eTILdGtge5vJU5YpdmV
/CIMWxqxtnAz7atL9IBrihf1mdNVtktCo9WJuDRzg0WjRftOQGcudi3WjKUZz8h0
nuzEkCy/8qiacJPoe79RdVvITFfiA6cRmQey5l/ZZPinV1SEgiZh+i/WmTaKvLTt
yhBCrynWl5HK9ihQ+HalIjxJ2v/8oFAIX4QPsMLMJ6l1h5ldun9OEqEQ5VaERxFM
XdJ2xTTIJU4NC+ywOYCj6vNyvlFDaMi3epUuAkGR+0Nt9/zLxVahTakRy7QUI0hm
TozK5sidRBuJxMtcybMQl/J7tGO46EWim77lktsBosvO2Wq6+08Iv3T8qjCuiv65
WgWj3t2badOLAPGA0p/ArBceLSFj/W+0bRztubjPa8LSlZxe8JvDtEK8hO3vH9/s
nvXcznlk5RF+IFR7faS+8vNImRzCy4jUAC7gxdMBx6sE6H+qkPc=
=8TZ8
-----END PGP SIGNATURE-----

--7ktmisgcf7dvsevo--
