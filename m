Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8D5F6429
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJFKKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiJFKKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:10:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108CC422D3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:10:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d10so1621201pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nejt1fj38fltULT62/FjLAauaU4MfqY1Q9gtNTwMHWg=;
        b=DePWpXaL28tCO2BGOPQxTfgkKA19ZzEFAgu9ehMWd2038sDv2KrbMNNrW/AP+0UTsG
         BZnlq6WEu4MB0dlfJqzcoqlOYXDAHsRZi4LmIBDLciMoeof5p/NDozSOS1gJh27NXeeN
         7iE5yoslA1Mrs6MkuturlSlfKmo8OiNpwgWFECoi5o2iqGtE3f+yobyIRR812PZcL2nm
         QattyEGU2FYrTnt5xHMORS8Pw6P9tFyqRec6sZ3CLf+1CbyXIYXfhxR0a3Qrk6ndw292
         4lgDe4omwL6afbkAN3BSor/KLeNbWhR7IOup8RoRkraUxzBup1HI9mvmQXmuA9jz/n95
         Y7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nejt1fj38fltULT62/FjLAauaU4MfqY1Q9gtNTwMHWg=;
        b=KtBcTkmdA3CTBhqIiG+hE9n69cfIHd1LuVBC0Pw18RsImsHyaStwk/9FhKdHgfuwq+
         cjULGwfO79irVJCRkO9kl51tQha7mBkpf6ULqpXnA2vRIBjTyYpDRyEE1dmPWmddg4LZ
         uDM6TYyXEPLyUgfM4O6attsHWAmHkEDhcjHw0n9KHQbJky2shj1TkqahkqHuYKpotYJi
         XxGfvdzZpKJG4zhLpmqvAL2eVg4jMqTE45XhE+2PxNtcy9VO1q+K1/lf2SHhOWFhwdho
         wXMOVexm8CyWbv3mXn6A9gV918zLmQIbJgPXf14yBUGZbE6NNckt6JRzQauD3ohDQvkw
         qz7Q==
X-Gm-Message-State: ACrzQf1G6GwKe7WteYdLAgW4F58NLybQYEJ/PAs5MS9/n0VwH+69uuiD
        lfRjWG47oW2WmWBq4EBCxxPI9kxMlsiErKMP
X-Google-Smtp-Source: AMsMyM5Mc4PPDGFOBxGHcZi8ZvSmv6eXKPEkMUC08xrz0BBflyZjUCAw8DD38knHfGjKhLjtEK1B+g==
X-Received: by 2002:a62:144b:0:b0:562:38de:9a0e with SMTP id 72-20020a62144b000000b0056238de9a0emr4354715pfu.78.1665051051002;
        Thu, 06 Oct 2022 03:10:51 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-199.hinet-ip.hinet.net. [211.75.219.199])
        by smtp.gmail.com with ESMTPSA id i15-20020a63584f000000b004393c5a8006sm1453127pgm.75.2022.10.06.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:10:49 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5] perf test: Introduce script for data symbol testing
Date:   Thu,  6 Oct 2022 18:10:39 +0800
Message-Id: <20221006101039.47870-1-leo.yan@linaro.org>
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

Changes from v4:
- Remove the redundant argument "--" before CPU list (Namhyung).
  This patch is dependent on the fixing:
  https://lore.kernel.org/lkml/20221004200211.1444521-1-namhyung@kernel.org/

Changes from v3:
- Add specific testing chunk for AMD CPUs (Ravi).

 tools/perf/tests/shell/test_data_symbol.sh | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_data_symbol.sh

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
new file mode 100755
index 000000000000..cd6eb54d235d
--- /dev/null
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -0,0 +1,93 @@
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
+TEST_PROGRAM=$(mktemp /tmp/__perf_test.program.XXXXX)
+PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+check_result() {
+	# The memory report format is as below:
+	#    99.92%  ...  [.] buf1+0x38
+	result=$(perf mem report -i ${PERF_DATA} -s symbol_daddr -q 2>&1 |
+		 awk '/buf1/ { print $4 }')
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
+	rm -f ${TEST_PROGRAM}
+}
+
+trap cleanup_files exit term int
+
+# compile test program
+echo "Compiling test program..."
+cat << EOF | cc -o ${TEST_PROGRAM} -x c -
+typedef struct _buf {
+	char data1;
+	char reserved[55];
+	char data2;
+} buf __attribute__((aligned(64)));
+
+static buf buf1;
+
+int main(void) {
+	for (;;) {
+		buf1.data1++;
+		buf1.data2 += buf1.data1;
+	}
+	return 0;
+}
+EOF
+
+echo "Recording workload..."
+
+# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
+# user/kernel filtering and per-process monitoring, spin program on
+# specific CPU and test in per-CPU mode.
+is_amd=$(egrep -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
+if (($is_amd >= 1)); then
+	perf mem record -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM &
+else
+	perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
+fi
+
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

