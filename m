Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADC55B687A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIMHSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIMHSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:18:06 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B42DAA0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:18:04 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 1205C5FBEF;
        Tue, 13 Sep 2022 09:18:01 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: perf patches needed for 4.19 stable
Date:   Tue, 13 Sep 2022 09:17:55 +0200
Message-ID: <4425509.LvFx2qVVIh@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2252905.ElGaqSPkdT"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2252905.ElGaqSPkdT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: perf patches needed for 4.19 stable
Date: Tue, 13 Sep 2022 09:17:55 +0200
Message-ID: <4425509.LvFx2qVVIh@mobilepool36.emlix.com>
MIME-Version: 1.0

Greetings,

I had to compile perf for a 4.19 kernel with gcc 10.4 and glibc 2.36. It=20
failed because some patches seem to be missing there.

I have identified these 2 at least:

ebcb9464a2ae3a547e97de476575c82ece0e93e2
perf env: Do not return pointers to local variables

d08c84e01afa7a7eee6badab25d5420fa847f783
perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into=20
sysconf(__SC_THREAD_STACK_MIN_VALUE)

The former was introduced in 5.7, the latter in 5.14, so backports to 5.4 a=
nd=20
5.10 may also be missing.

At the end the build still has failed because of this:

In file included from /opt/emlix/master/sysroot/usr/include/stdio.h:906,
                 from /tmp/e2/build/linux-4.19.254/tools/lib/traceevent/eve=
nt-
parse.h:25,
                 from util/session.c:5:
In function 'printf',
    inlined from 'regs_dump__printf' at util/session.c:968:3,
    inlined from 'regs__printf' at util/session.c:996:2:
/opt/emlix/master/sysroot/usr/include/bits/stdio2.h:86:10: warning: '%-5s'=
=20
directive argument is null [-Wformat-overflow=3D]
   86 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pac=
k=20
());

I was not able to identify a patch for that, so I went with WERROR=3D0, but=
=20
maybe someone knows how to get that fixed as well.

If you agree that these should be added to stable please either send them=20
there or tell me to do so.

Regards,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart2252905.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYyAuowAKCRCr5FH7Xu2t
/F1zBACRo6wtV+HJ2iuu+6Fk5Jilk2/Hv3kJUxEihmoMlthOXwwmv1WkRZbfHuDw
tfpyJorEMhbFwfKWST/vutEBZlrvFwviHlDtKLcWXRADqu7KKx5tR4Zy3vy1vAuf
BernDlU48aiinaMmJuZcY168kV+6Edl+F77sG7oeIzh+/5Zixg==
=0E+u
-----END PGP SIGNATURE-----

--nextPart2252905.ElGaqSPkdT--



