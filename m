Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360F75BBB47
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIRD25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIRD2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:28:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B41E28726
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:28:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c198so24938602pfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TO1lgjEBuoqSH/1skNlkmUo8mpA3J4adLJy7sHWwA2o=;
        b=rKZF6xhdNr3PJxqpQpbc/Ae97AzUZQwTi6Nf/2ESmMf9CywgFPxaKM17UmPnjFTclU
         wA5xFNIcHWSUw902PRTt3TTiPbKAuU4hfLSuj9fdwaACpgXZnvQBqakmZH+tnPDzWOQ5
         oOuYLjZM/Aiuz83r8UWWNEHi5nmlfOtIeyX5ku5FXBXqJ2lowwNTcJR6fUc+tusLGt2e
         Ofoekhj3IdbObjXJashnXNJLYjxo72qdjn1Yr7wLG9uP2hBwSJxIq6/hka+QlWOmT4qc
         Vsj1kY692We2O8c/nOpL3LCDUM2JL7ATaRqbCtwbrmDlPWRk/31rqxQhO4PPfjQo04YS
         Vh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TO1lgjEBuoqSH/1skNlkmUo8mpA3J4adLJy7sHWwA2o=;
        b=LLGp80tOtcxxnLQCpRXDA0TiNi8PYH1qf0jqyRfgAp0u1E7IyY1x1fGkW3WIWkKqbd
         jfFaye1Vu1PjBbfJrkHx7F4fmuiGRt15Zzmh9S1STMT603DZsHNZHU3q6hXhufu2MTYO
         s/J5PGmHxY3lJq90gHUVzOZJQVTe1oZsZ2k7cDrPzQKpBWmBiYpfTrP0AkCMknGp9LR5
         lDgPrskuivCbaVC5IdQSWTLSDNfN1UMzkrcRzf3ZheyGG1MkjCC06ZezMt4bXLxnJNTh
         AT1cdi/k0uLJztDI5rEkJh1PwsziOc8XvNZkvZuZ1z5ya40dC3k+aoFxRZT+OQvhzP6Z
         z6MQ==
X-Gm-Message-State: ACrzQf3IzIx0c1p/2O3eVlS3F/vwri4RTZzKnSrn3ilF1W8HXAQJVp2T
        98h6f3NPnihXSJGWLfNF0S6KwA==
X-Google-Smtp-Source: AMsMyM6nbZPZvj09ZSNhXJDObtdCCywFh8IDURznRTcNZJxGognZEJvWXDiqkX9cNoTTbYUQ1BX77Q==
X-Received: by 2002:a65:6955:0:b0:439:a99b:bca5 with SMTP id w21-20020a656955000000b00439a99bbca5mr10642998pgq.80.1663471729271;
        Sat, 17 Sep 2022 20:28:49 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.11.189.16clouds.com. [45.78.11.189])
        by smtp.gmail.com with ESMTPSA id 68-20020a620647000000b00545832dd969sm12255075pfg.145.2022.09.17.20.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:28:48 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v2] perf test: Introduce script for data symbol testing
Date:   Sun, 18 Sep 2022 11:28:43 +0800
Message-Id: <20220918032843.27285-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This commit introduces a shell script for data symbol testing.

The testing is designed a data structure with 64-byte alignment, it has
two fields "data1" and "data2", and other fields are reserved.

Using "perf mem" command, we can record and report memory samples for a
self-contained workload with 1 second duration.  If have no any memory
sample for the data structure "buf1", it reports failure;  and by
checking the offset in structure "buf1", if any memory accessing is not
for "data1" and "data2" fields, it means wrong data symbol parsing and
returns failure.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Changes from v1:
- Removed "killall" since the test has no child process (Ian);
- Used "char" instead of "long" in the buf structure.

 tools/perf/tests/shell/test_data_symbol.sh | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_data_symbol.sh

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
new file mode 100755
index 000000000000..d007513ecfbe
--- /dev/null
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -0,0 +1,92 @@
+#!/bin/bash
+# Test data symbol
+
+# SPDX-License-Identifier: GPL-2.0
+# Leo Yan <leo.yan@linaro.org>, 2022
+
+skip_if_no_mem_event() {
+	perf mem record -e list 2>&1 | egrep -q 'available' && return 0
+	return 2
+}
+
+skip_if_no_mem_event || exit 2
+
+# skip if there's no compiler
+if ! [ -x "$(command -v cc)" ]; then
+	echo "skip: no compiler, install gcc"
+	exit 2
+fi
+
+TEST_PROGRAM_SOURCE=$(mktemp /tmp/__perf_test.program.XXXXX.c)
+TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+check_result() {
+	# The memory report format is as below:
+	#    99.92%  ...  [.] buf1+0x38  ...
+	result=$(perf mem report -i ${PERF_DATA} --stdio 2>&1 | egrep "buf1" | \
+		awk '{ for (i = 1; i <= NF; i++) { if ($i ~ /^buf1/) { print $i; break; } } }')
+
+	# Testing is failed if has no any sample for "buf1"
+	[ -z "$result" ] && return 1
+
+	while IFS= read -r line; do
+		# The "data1" and "data2" fields in structure "buf1" have
+		# offset "0x0" and "0x38", returns failure if detect any
+		# other offset value.
+		if [ "$line" != "buf1+0x0" ] && [ "$line" != "buf1+0x38" ]; then
+			return 1
+		fi
+	done <<< "$result"
+
+	return 0
+}
+
+cleanup_files()
+{
+	echo "Cleaning up files..."
+	rm -f ${PERF_DATA}
+	rm -f ${TEST_PROGRAM_SOURCE}
+	rm -f ${TEST_PROGRAM}
+}
+
+trap cleanup_files exit term int
+
+# compile test program
+cat << EOF > $TEST_PROGRAM_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+typedef struct _buf {
+	char data1;
+	char reserved[55];
+	char data2;
+} buf __attribute__((aligned(64)));
+
+static buf buf1;
+
+int main() {
+	int i;
+	for (;;) {
+		buf1.data1++;
+		buf1.data2 += buf1.data1;
+	}
+	return 0;
+}
+EOF
+
+echo "Compiling test program..."
+cc $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
+
+echo "Recording workload..."
+perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
+PERFPID=$!
+
+sleep 1
+
+kill $PERFPID
+wait $PERFPID
+
+check_result
+exit $?
-- 
2.34.1

