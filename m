Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153B65E90CC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 04:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIYC7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 22:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIYC7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 22:59:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA23E4454A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 19:59:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so9420030pjm.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 19:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HwTvvHaQnXpVhdRORP97NwmhkzDfJTDDIupOGVxMbjo=;
        b=ZgBaza0msnPIVY09tayTWp+QQjlETTmQwJmOgr/CoS/qSoEXAQGJaYLH9aKt0W8XnK
         X8ypRlrYJQSviDFPkquHh3b1tnswjp4PiSrQP2CBgGCNZ0XcZHM0JqyXyO/59G9XYp9j
         nksqrEsSIa+5P6kL/7JoW7w+vBq1eNfkxIR55aahKhie0BVPPk7Xq+pCK4ERuO54Hf9H
         nNZC3/dtWP6LWaIqTSgH9P+jagKaByr9iR/bSDiSBXIaN9aIY37tXML+I9C8hT+J5NeN
         HnY7celDq/AtLnfWNs2G7HSUsJ8eb7eTZ1Rb7LHRhSzWXfQ7lpsEBVHwaMbbXKGUpZH7
         UQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HwTvvHaQnXpVhdRORP97NwmhkzDfJTDDIupOGVxMbjo=;
        b=DjA7lYTvkVsIIyLMIcEgTsursls/SttYnh2YUzka8Ksxw9uRPmst3S9UV8BotO9Q3J
         xvdxkE0SYUSMejaaE6ukFqyZ8x6DzUATaamp8mWnNPQTUG4JPeBg2X4AH4p0WH+lZx8G
         uJBvCxWtE9NB1UOR+D/CTOM39G3q078ePi6FwtCW826YsXEFh7WP5m8EhZ75r+KtUc+a
         QjVZ78rVUBWff0uO5cM/BEpmy+oxseU7FZ7pdGcx4Py1xQRlfBmUElQUIOPJT1wqSvbM
         c6jfsoDYUp12BbMdNKbbWYKpzqZV0gSSM9vxPbBLPRuwytWz+y+6vGBNrcCP0xujxzms
         1a8Q==
X-Gm-Message-State: ACrzQf2SNGQAolYURvZRlLQ3cZWY1T24obSIq4+fiMmwqXRpNBwgdJfF
        Bo9IwJ+5ap6CUhgXBd9rLhiBNw==
X-Google-Smtp-Source: AMsMyM5lJ5Qlh7efWt9kQk8UedtdV39ouMD6V7ZF6S46Zp1jz8tt/NpLLrSnxcjhT9vtw/bU0Zx0Cw==
X-Received: by 2002:a17:90a:ce82:b0:200:aca2:5a19 with SMTP id g2-20020a17090ace8200b00200aca25a19mr29655101pju.156.1664074756070;
        Sat, 24 Sep 2022 19:59:16 -0700 (PDT)
Received: from leoy-huanghe.lan ([137.184.34.254])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b0016bf5557690sm8409198plg.4.2022.09.24.19.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 19:59:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/2] perf test: Introduce script for java symbol testing
Date:   Sun, 25 Sep 2022 10:58:35 +0800
Message-Id: <20220925025835.70364-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925025835.70364-1-leo.yan@linaro.org>
References: <20220925025835.70364-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces a script for testing java symbols.

The test records java program, inject samples with JIT samples, check
specific JIT symbols in the report, the test will pass only when these
two symbols are detected.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/test_java_symbol.sh | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_java_symbol.sh

diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
new file mode 100755
index 000000000000..f221225808a3
--- /dev/null
+++ b/tools/perf/tests/shell/test_java_symbol.sh
@@ -0,0 +1,75 @@
+#!/bin/bash
+# Test java symbol
+
+# SPDX-License-Identifier: GPL-2.0
+# Leo Yan <leo.yan@linaro.org>, 2022
+
+# skip if there's no jshell
+if ! [ -x "$(command -v jshell)" ]; then
+	echo "skip: no jshell, install JDK"
+	exit 2
+fi
+
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+PERF_INJ_DATA=$(mktemp /tmp/__perf_test.perf.data.inj.XXXXX)
+
+cleanup_files()
+{
+	echo "Cleaning up files..."
+	rm -f ${PERF_DATA}
+	rm -f ${PERF_INJ_DATA}
+}
+
+trap cleanup_files exit term int
+
+if [ -e "$PWD/tools/perf/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PWD/tools/perf/libperf-jvmti.so
+elif [ -e "$PWD/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PWD/libperf-jvmti.so
+elif [ -e "$PREFIX/lib64/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PREFIX/lib64/libperf-jvmti.so
+elif [ -e "$PREFIX/lib/libperf-jvmti.so" ]; then
+	LIBJVMTI=$PREFIX/lib/libperf-jvmti.so
+elif [ -e "/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so" ]; then
+	LIBJVMTI=/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so
+else
+	echo "Fail to find libperf-jvmti.so"
+	# JVMTI is a build option, skip the test if fail to find lib
+	exit 2
+fi
+
+cat <<EOF | perf record -k 1 -o $PERF_DATA jshell -s -J-agentpath:$LIBJVMTI
+int fib(int x) {
+	return x > 1 ? fib(x - 2) + fib(x - 1) : 1;
+}
+
+int q = 0;
+
+for (int i = 0; i < 10; i++)
+	q += fib(i);
+
+System.out.println(q);
+EOF
+
+if [ $? -ne 0 ]; then
+	echo "Fail to record for java program"
+	exit 1
+fi
+
+if ! perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
+	echo "Fail to inject samples"
+	exit 1
+fi
+
+# Below is an example of the instruction samples reporting:
+#   8.18%  jshell           jitted-50116-29.so    [.] Interpreter
+#   0.75%  Thread-1         jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)
+perf report --stdio -i ${PERF_INJ_DATA} 2>&1 | \
+	egrep " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" > /dev/null 2>&1
+
+if [ $? -ne 0 ]; then
+	echo "Fail to find java symbols"
+	exit 1
+fi
+
+exit 0
-- 
2.34.1

