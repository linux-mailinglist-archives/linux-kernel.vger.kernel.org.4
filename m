Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181EA740C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjF1JEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:04:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:60829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233497AbjF1Itt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1687942153; x=1688546953; i=georgmueller@gmx.net;
 bh=IqMVZAVcC6oao8CL+MjCeJoklvxUgAe2/NirNejdy8k=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PO8Q4Ymw00tef3JsmohZqScnvZgOjJEDD2HoBmWtQtZE+v+v51lAFQdFVZSRZ7cnB2YQf+x
 E9kG9ah0x1qhzu3FUokpHBEt5s5OyHbHw0T+mCx1oY4gFkUMQmspKbsKdFFETIPFVFfUesSyM
 wr2esT8BE5cVde5TEEwZAA77jejx32t0Il6b6mQugoAG5HyC/7X+WNYmqhD/gLdrSbAEkM6xM
 b6MOaBE7plfFg0qZuaLz8fUieuAvx96LXCszfG6cxQm50zxGL7j8BCUpUdlXwF8fnfY4srXmA
 41pYAYBFt9eMl8c5AX1LphfboMNb2xr4+Kvljb70Ato8DxF1JeSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nb-georg.intra.allegro-packets.com ([79.246.84.17]) by
 mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MMXUD-1qWEjH3txv-00JYeE; Wed, 28 Jun 2023 10:49:13 +0200
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3 1/2] perf probe: add test for regression introduced by switch to die_get_decl_file
Date:   Wed, 28 Jun 2023 10:45:50 +0200
Message-ID: <20230628084551.1860532-5-georgmueller@gmx.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628084551.1860532-3-georgmueller@gmx.net>
References: <20230628084551.1860532-3-georgmueller@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kdGhZgfEbflE33yA0vvf/egN3okf3RDeYUzy9I3XmrQKqp64kyS
 ZCvjqt1Xy+L+i1hzZVR81GnnkNfmju/AsraIyz+mWKnhh9N5VuagyCScGL2w9LPg4NjBQcz
 EwblKYezTE3IrCTrFCNtb2NwDCLMoMNesms8vojdlshKazRJwK/TOBbEGmoq0YWGPQaR2hQ
 LTs0uVDzI8AgoL9qxAxiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uPxKcZocKN8=;Y+mmy4nqoTka2UdcxmCpU7DmPmq
 wGchdmvx3cXXWQFZ9snoG9/sVicxe2kCdS2a+8J/2l4vMJ00hLy/SRd5PWAnxbj45Z8w78bsn
 xAk135uApf75LznxzgE774U+D2w77fxfPSl7ShCacM3Ml/SaX2NERbuh2+M4JIRrxkwT8Gjoh
 NizRog2VM1udzCFVjBwY49vI4UlqFYi1T90k3deuJTjHlOMo1QBsybEWTZ2SLMcJlD1L4QACV
 Mv/srZdKY5NrIvM8r8gNxQZZXirTvcwSKRJp3s9fkenYw/6VeiwWCemhgmmXblRQxFxEiTYhJ
 jbFyQix+nQAz3Lhk/c5PhxEhO+zrBIxeNyRTBXCmppKMhtPMxDnEyb9L4X8NAsE4hEU/jl2TW
 0VWAKuIE0mLH596zFaLmp91DZil7VgEJpMQhHxfYtCRwr8msG6XT6tkokeYky7byxhfk8N2i8
 jIqlJ41FkAS45FGEZ+Wd6X3fuZbIhEVgdEpCSBb/rSyohM7q0WAaVtYzEjOZ1nZAtRHheJ+iB
 RroTy9QXdtIuBXDbTK5/aCOa+GUnoXn34mB2YGRrntQi5GhmOfmZwqsQuouoeQ8BwxKTfiKTp
 uvqEN+CtAwvb4P8Kz+XPXs3NOdADGU9xOEm9hRiwpn/RbgujmLcpDxRWnRbLNDtRb+1QPAUwU
 wFCKdPsND4RyRBshTTJzpNep/9clb9Cxq7Ydw15j/3IEXW7PlTTnhR1UC8NtMHnq/GuzsctCA
 kD9VDwNX2QuZIpobLaI87hcEUbkOJY90Z5ti0PBywK+XJQQaE2RSxs54Q6wXQLZlU5mEF17x5
 Mxgq7AXCmaS/iU3FtVU9t6SHAYu9nfIs6FHaydOJWCJQEzOZx3NzqheV4nMUXujfuPhO8ti9S
 L7H9VNIdVui7Zr2k8CPJSOJoWuLYK8WBK9gYu/uOv7CBW/cUDsV54Z+2+g+4j8++ges6bKLVE
 f82fEE2aAwJNzXgQNcwDQjw9lDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a test to validate that perf probe works for binaries
where DWARF info is split into multiple CUs

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
Link: https://lore.kernel.org/r/5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.n=
et/
Cc: stable@vger.kernel.org
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

