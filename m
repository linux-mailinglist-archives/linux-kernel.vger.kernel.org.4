Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74A25BBB41
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIRDPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIRDPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:15:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9668B27FEC
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:15:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j12so24909174pfi.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/tDGwzAC/IwmP8HRle5sxobILjM+kn0MjdGIbElVqmc=;
        b=vBM4YlSUyA2cOuccMVcA5pzbosx7UpZ1THfDYtswOaOPlk93Ad3eWDAvc/kEm9aErw
         B7hTk79kCIwXQA5E9fAwZQkeeQ4zWB9AOganKNyrvpFP3WM+YDMW2Hej9f/2zyVURltL
         biVSH65GTPcyxMALXnOS8MXWeHVfiQr8siAo8pDO4D1e2RbMNWAKYk4zP3CcPgwFdtAl
         tPUWbZEE8/Z/iV7ZSb2k2CeFnFEb+bBpTXiB60BIOcFes+DdkfoxMzg2WtVVwBI1IIZs
         fHi2D0evwWGelMccqLnpRKGvVRt6UUMq7SsPn99/1wY7B5jy7qtsIGgeZXmscY0A8Feq
         BUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/tDGwzAC/IwmP8HRle5sxobILjM+kn0MjdGIbElVqmc=;
        b=qDhV1tASGPeAXMIHNTNM6mfJi2ZgxhQKPimrfTYBmdJ+IKu9AUOWAeELPkFy91HQBO
         bQhVNcs8Ozgi2yrXdXNtW2It+jU2xZ9EYpOq9ZhJ4XIuxMpkCWKJi42ghfNkXQjh25tj
         LpK4gOX8H+oFeP7YKj1poaCU+Etmp12XeDEjfR725+R4/J6C4nACCoEIFlQdqZnnQ4zu
         ruKmDOBghSyXEqo58YhFkkO69EsrnAtTLjnazAc+NOrSUWfJKFSXLoCY2zBzs8M4OXT7
         XJKmDeJigy/PEAIuayPJl8SJdfFgUWWGKd+C6zehbrXiHyvFqjhzUY/JTRzwRfOQ50HZ
         U2cg==
X-Gm-Message-State: ACrzQf3mCJNgLJm5LviFtTbG2uvmDvxqPiUjrx1PXOGeENcC5ISJu89m
        spaVsqhML2FKM9QLZii96hlXxw==
X-Google-Smtp-Source: AMsMyM6Cfk0nFXuMVmKDmCkPtqp+n750u2jSmTe7Qqmj8zHJ1GEyjXffIY2N/4HQ9Aug6obakPnQdg==
X-Received: by 2002:a63:c3:0:b0:439:72d7:7e1f with SMTP id 186-20020a6300c3000000b0043972d77e1fmr10466498pga.524.1663470935526;
        Sat, 17 Sep 2022 20:15:35 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.11.189.16clouds.com. [45.78.11.189])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b00177f4ef7970sm17822647plh.11.2022.09.17.20.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:15:35 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>
Subject: [PATCH v2 2/2] perf test: Introduce script for java symbol testing
Date:   Sun, 18 Sep 2022 11:15:24 +0800
Message-Id: <20220918031524.26719-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220918031524.26719-1-leo.yan@linaro.org>
References: <20220918031524.26719-1-leo.yan@linaro.org>
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
 tools/perf/tests/shell/test_java_symbol.sh | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_java_symbol.sh

diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
new file mode 100755
index 000000000000..d96fea405ea9
--- /dev/null
+++ b/tools/perf/tests/shell/test_java_symbol.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# Test java symbol
+
+# SPDX-License-Identifier: GPL-2.0
+# Leo Yan <leo.yan@linaro.org>, 2022
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
+if [ -e "/usr/lib/linux-tools-$(uname -a | awk '{ print $3 }' | sed -r 's/-generic//')/libperf-jvmti.so" ]; then
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

