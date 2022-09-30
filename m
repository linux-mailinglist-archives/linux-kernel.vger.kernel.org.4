Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730195F0B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiI3MKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiI3MJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:09:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028F3B71F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:09:54 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 78so3990879pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=CHaTp7QZSQUooBvNoSi37fDgk69eBnJkDBwcq2YT4xM=;
        b=LBpRzE/3WITuM8U0CAQdLOWVDXGiGPynlAcW2eBOzSOcxA07uOuMHnrxhYkCUag3Kc
         x8yMO7SIYCXO7CegIJuspkNr8hZP5m8C7AfgTDATfyf+PDbDL5Li7C0bjjErcrFoN9xo
         BXST5eVr20dPXB5Pl+8NdFD/arAjcWUbDVTRCukNl3AKXNEuu0dxBDhXSwd8YXV15Xf2
         WlX6WSuAz5tUjcoCdigAZ1OpMFOO6cZQYquVtgbmnZ9knPLcEmgtxGKgVK21q95CSnvk
         f0pk7T658ppZmxhgho2V319j/pDF8XhXKer9j4jL8Cz7OuCzKkndwTznfKIntxcS59W6
         H1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CHaTp7QZSQUooBvNoSi37fDgk69eBnJkDBwcq2YT4xM=;
        b=1DBlaAmM7chvCbK5T0xF6MbdLb415sYXL7W+hoo6Lsu11/GoQ/e8vvz4FCV0EEx7JV
         8lSNbFhZf9GGszOiZBP3rBJZRoHVfkzstWofKDh/7mZOn5P425fpvlB74zKKX9vSe+kn
         yXxXYN/tX7UAB3joD1YGva3Y6jWKZ8xq74YZ/svMFl1nz1mb9Y1OysLhRKVi8DTRNSpk
         aBgy27O7foBuIMGQFdHEB90i8EjHMV1vG+yeXD/b/KDkgxy6Y7A8rvOqIuUIQ/ooGUjm
         g0OsfLe8+hoVlH/4Ksi/R4e9af1b2ctausFfOEzs4UE411J5zuVTm6XZ81FHmEeTySf8
         UMrw==
X-Gm-Message-State: ACrzQf1nJHbMBjTSrXW/7qfga5RzyVVNCFJGyQC9Yp1YlUeRma83wfB3
        Ubehfd4ZgzSfVlMrPxh0ib8DLA==
X-Google-Smtp-Source: AMsMyM5hsNRg222QC8iTzK6zIyjAR5enxeWBLBa1jips+12sgjDVWAdDcURZSFKE4Knt1VzWKdXPVw==
X-Received: by 2002:a05:6a00:1353:b0:541:5258:4e43 with SMTP id k19-20020a056a00135300b0054152584e43mr8519377pfu.6.1664539793931;
        Fri, 30 Sep 2022 05:09:53 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-199.hinet-ip.hinet.net. [211.75.219.199])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b001745662d568sm1763159pla.278.2022.09.30.05.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 05:09:53 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4] perf test: Introduce script for data symbol testing
Date:   Fri, 30 Sep 2022 20:09:39 +0800
Message-Id: <20220930120939.353315-1-leo.yan@linaro.org>
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

Channges from v3:
- Add specific testing chunk for AMD CPUs (Ravi).

 tools/perf/tests/shell/test_data_symbol.sh | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_data_symbol.sh

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
new file mode 100755
index 000000000000..43ab1e37407c
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
+	perf mem record -o ${PERF_DATA} -- -C 0 -- taskset -c 0 $TEST_PROGRAM &
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

