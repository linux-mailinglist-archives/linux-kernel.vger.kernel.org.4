Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CBC740B98
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjF1IdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:33:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:49425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234365AbjF1I0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1687940733; x=1688545533; i=georgmueller@gmx.net;
 bh=lX1SFIDH/DjnF2RTjr07qmuOiAaOoTet4ihFLdZkW4U=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZtqXIDtAdoRWRzOPAJfQC3vUvTh6xiZuA5bQh7JEI5gPRRxRlla7g12UHBSYdnHQWW5tqA4
 Pw+3Y38vo3U55pea5ZMoALIc0Pwm5pp2UDZonYThAclkt8MD8rzzsJsw8vu6H7vkHlVIU/7DF
 40OLLlI8MnFKfBrHM9WOOyrH27UGgkWHV9ItW1UAl8Yf+qDdPPsh8BZYXZU5QPr4fBnqwXh35
 URzc3CjcezIGDoAwa7Q+FbvhZWE+IHAdNk1FJnuWQjNAoZ1wjvVeZIMVxNrn13LGQvXCYnywc
 P7Z9uTXk5ZY4JC+qoNwu/UFuK96qIcsY+MDQlpKdo8j6HWagCvCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.intra.allegro-packets.com ([79.246.84.17]) by
 mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MfHEJ-1pXfsc1mn5-00gs88; Wed, 28 Jun 2023 10:25:33 +0200
From:   =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        regressions@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] perf probe: add test for regression introduced by switch to die_get_decl_file
Date:   Wed, 28 Jun 2023 10:23:20 +0200
Message-ID: <20230628082337.1857302-2-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628082337.1857302-1-georgmueller@gmx.net>
References: <20230628082337.1857302-1-georgmueller@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YGSi6eDIMMawrdpYsl2gWYVO5Yxpk1YFBBfBJaPgMKCJ3zItKO+
 ocb+pHIaFx15IWZLcOitXrxu01BQ51jpEkVcoYdDrudkLmJEK3kvOdJtpR8MKYzBUQn14zg
 Ou5fl3KA9R3S1+P3JLK/C0J4EknIMKIWhW411uENugyJkgcHCGQBqHcmiu3pH48bc/d8LhY
 sQmRCnq08meaKm2Pz0FxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hmH6H3tVmPo=;57ptHhTdSiqKxkHVwRWQiJFah62
 zibYIBnYN/Nl02CUB6KPQ78G+FIM8pRb9AVGzQwmQDcrDkR9F1dj7EiFrdu4OkAOkOnVuBrCK
 txdUQhio1zjCqzaiP0yNknMyZwfv20SzQN8aqYf9yaSIaT+fGAXlsYRZRSaNiwAENMDPNciKn
 83QS11znZALXU0Dee7e2mLf5ROThoFTkOW2EuO6q+Qaoi3ZbdXn1IAu63rObnXsnwLOO3T55x
 orkGcuTljfnCzcQOarFHCVJqRub583QuEHMvw/EZwo8WuTEZvzMln/v7B9Vjlw54RLMP/qshL
 FZWIwWIUUG4uGjdGWIg/5cEEID+SBptiF056Oh4/823N5j6lB2Y29R+O9Ed582Z8VZyXARmJ5
 rCZwTzL0V3wrw3UFjbAEu+7Wl5fnoXOLJddxeYapv/Q13x4KE86BcaW9CBk6ZmwxlvgPV8hhr
 QJBufRkuIAJn+PgtAwdvHKR9Od15greR3tMk96C17M9I5kJb0coZaAOI0YzakJPEsPWzjb7Hd
 RZ+VoWylELoZEgZQFXlJsYkcGUM148yX2aQo1RwFPzj+FFj8A/XiPo16DlqRB07bes09qTa6s
 rjpXvZW6uw7kcDYOM9RTLvhNwjYPWIE+zFmxYbkbvIjOOJwebcEdRzdLQaQN/5Kao9bHxEp8B
 5OVcQSvigxk6Z205EIV1NGv1zLoYycf+1SB0UxKLxKZWHaX4SzMdeS8mUC/xCWBWnat/5D9j6
 LjoqBLK9mpe8GJj3X2WtQ4afh0JQ4k7XRFTvaD+gQ08rh799Gh3YSRKw1FROuF+oqXUAFFl5y
 WoMcfR/iKmqMsTsRH1KPMZfeoyhcasopS8qV1NNZ+nLf4O2Krl0EIkNVywlHu2/obToKfRVHr
 AS5QO01i0oNTijCaStkvkVx+cjZHtp65saykWFteXtZyumh7+Tcyj12sWJJm4YpZelIQwtYce
 vqpu6Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a test to validate that perf probe works for binaries
where DWARF info is split into multiple CUs

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
Link: https://lore.kernel.org/r/5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.n=
et/
=2D--
 .../shell/test_uprobe_from_different_cu.sh    | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_uprobe_from_different_cu.s=
h

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/too=
ls/perf/tests/shell/test_uprobe_from_different_cu.sh
new file mode 100755
index 000000000000..00d2e0e2e0c2
=2D-- /dev/null
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# test perf probe of function from different CU
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+temp_dir=3D$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	if [[ "${temp_dir}" =3D~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
+		echo "--- Cleaning up ---"
+		perf probe -x ${temp_dir}/testfile -d foo
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
+}
+
+trap_cleanup()
+{
+        cleanup
+        exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+cat > ${temp_dir}/testfile-foo.h << EOF
+struct t
+{
+  int *p;
+  int c;
+};
+
+extern int foo (int i, struct t *t);
+EOF
+
+cat > ${temp_dir}/testfile-foo.c << EOF
+#include "testfile-foo.h"
+
+int
+foo (int i, struct t *t)
+{
+  int j, res =3D 0;
+  for (j =3D 0; j < i && j < t->c; j++)
+    res +=3D t->p[j];
+
+  return res;
+}
+EOF
+
+cat > ${temp_dir}/testfile-main.c << EOF
+#include "testfile-foo.h"
+
+static struct t g;
+
+int
+main (int argc, char **argv)
+{
+  int i;
+  int j[argc];
+  g.c =3D argc;
+  g.p =3D j;
+  for (i =3D 0; i < argc; i++)
+    j[i] =3D (int) argv[i][0];
+  return foo (3, &g);
+}
+EOF
+
+gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-fo=
o.o
+gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
+gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}=
/testfile-main.o
+
+perf probe -x ${temp_dir}/testfile --funcs foo
+perf probe -x ${temp_dir}/testfile foo
+
+cleanup
=2D-
2.41.0

