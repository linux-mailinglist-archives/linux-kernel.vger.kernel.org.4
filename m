Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191475B8295
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiINICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiINICV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:02:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D26FA1A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663142527; x=1694678527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jhBWGlbhd5gPIoylYCvWgDTpWF0L57HGp6RbsVQBl2U=;
  b=QXTrJCqGhkI5mWElphx7cZLiNNVdFG3g5SXXd52PIfLqFccPxpKgTQiu
   L+3lsiylhbQmTr6od7GM0KnRW1OyoVGXbDfRrF1UltS++jNOsbqRrvqpD
   5jZ//KDDhGsdFKk/2fz+fuYZNjIcf89JAC5zp3P94GtgmlsLNTX5VrWrr
   y3ZUtWXmbA8OGCwzJQtjLi60BATYLqzapAiABW5wogGWyPFw0A1mcS5jt
   rWGm6OUGxsuPeKYknWBZPlnP/LmVfT0h3p57n+u0Krfa7XCiC2I0SKQg6
   pGL92j04CpJdtpZe1s9KI4tsp+vresgqXgWQdHDYyFd9jysNnb6slBJrK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="295953248"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="295953248"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:02:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="678942497"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.32.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:02:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf test: test_intel_pt.sh: Move helper functions for waiting
Date:   Wed, 14 Sep 2022 11:01:49 +0300
Message-Id: <20220914080150.5888-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914080150.5888-1-adrian.hunter@intel.com>
References: <20220914080150.5888-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move helper functions for waiting to a separate file so they can be
shared.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/lib/waiting.sh   | 69 +++++++++++++++++++++++++
 tools/perf/tests/shell/test_intel_pt.sh | 68 ++----------------------
 2 files changed, 73 insertions(+), 64 deletions(-)
 create mode 100644 tools/perf/tests/shell/lib/waiting.sh

diff --git a/tools/perf/tests/shell/lib/waiting.sh b/tools/perf/tests/shell/lib/waiting.sh
new file mode 100644
index 000000000000..dbd5bd90105e
--- /dev/null
+++ b/tools/perf/tests/shell/lib/waiting.sh
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0
+
+tenths=date\ +%s%1N
+
+# Wait for PID $1 to have $2 number of threads started
+wait_for_threads()
+{
+	start_time=$($tenths)
+	while [ -e "/proc/$1/task" ] ; do
+		th_cnt=$(find "/proc/$1/task" -mindepth 1 -maxdepth 1 -printf x | wc -c)
+		if [ "${th_cnt}" -ge "$2" ] ; then
+			return 0
+		fi
+		# Wait at most 5 seconds
+		if [ $(($($tenths) - start_time)) -ge 50 ] ; then
+			echo "PID $1 does not have $2 threads"
+			return 1
+		fi
+	done
+	return 1
+}
+
+# Wait for perf record -vvv 2>$2 with PID $1 to start by looking at file $2
+# It depends on capturing perf record debug message "perf record has started"
+wait_for_perf_to_start()
+{
+	echo "Waiting for \"perf record has started\" message"
+	start_time=$($tenths)
+	while [ -e "/proc/$1" ] ; do
+		if grep -q "perf record has started" "$2" ; then
+			echo OK
+			break
+		fi
+		# Wait at most 5 seconds
+		if [ $(($($tenths) - start_time)) -ge 50 ] ; then
+			echo "perf recording did not start"
+			return 1
+		fi
+	done
+	return 0
+}
+
+# Wait for process PID %1 to exit
+wait_for_process_to_exit()
+{
+	start_time=$($tenths)
+	while [ -e "/proc/$1" ] ; do
+		# Wait at most 5 seconds
+		if [ $(($($tenths) - start_time)) -ge 50 ] ; then
+			echo "PID $1 did not exit as expected"
+			return 1
+		fi
+	done
+	return 0
+}
+
+# Check if PID $1 is still running after 0.3 seconds
+is_running()
+{
+	start_time=$($tenths)
+	while [ -e "/proc/$1" ] ; do
+		# Check for at least 0.3s
+		if [ $(($($tenths) - start_time)) -gt 3 ] ; then
+			return 0
+		fi
+	done
+	echo "PID $1 exited prematurely"
+	return 1
+}
diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 051d088c1b74..efaad9566c34 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -4,11 +4,12 @@
 
 set -e
 
-tenths=date\ +%s%1N
-
 # Skip if no Intel PT
 perf list | grep -q 'intel_pt//' || exit 2
 
+shelldir=$(dirname "$0")
+. "${shelldir}"/lib/waiting.sh
+
 skip_cnt=0
 ok_cnt=0
 err_cnt=0
@@ -112,67 +113,6 @@ can_kernel()
 	return 0
 }
 
-wait_for_threads()
-{
-	start_time=$($tenths)
-	while [ -e "/proc/$1/task" ] ; do
-		th_cnt=$(find "/proc/$1/task" -mindepth 1 -maxdepth 1 -printf x | wc -c)
-		if [ "${th_cnt}" -ge "$2" ] ; then
-			return 0
-		fi
-		# Wait at most 5 seconds
-		if [ $(($($tenths) - start_time)) -ge 50 ] ; then
-			echo "PID $1 does not have $2 threads"
-			return 1
-		fi
-	done
-	return 1
-}
-
-wait_for_perf_to_start()
-{
-	echo "Waiting for \"perf record has started\" message"
-	start_time=$($tenths)
-	while [ -e "/proc/$1" ] ; do
-		if grep -q "perf record has started" "${errfile}" ; then
-			echo OK
-			break
-		fi
-		# Wait at most 5 seconds
-		if [ $(($($tenths) - start_time)) -ge 50 ] ; then
-			echo "perf recording did not start"
-			return 1
-		fi
-	done
-	return 0
-}
-
-wait_for_process_to_exit()
-{
-	start_time=$($tenths)
-	while [ -e "/proc/$1" ] ; do
-		# Wait at most 5 seconds
-		if [ $(($($tenths) - start_time)) -ge 50 ] ; then
-			echo "PID $1 did not exit as expected"
-			return 1
-		fi
-	done
-	return 0
-}
-
-is_running()
-{
-	start_time=$($tenths)
-	while [ -e "/proc/$1" ] ; do
-		# Check for at least 0.3s
-		if [ $(($($tenths) - start_time)) -gt 3 ] ; then
-			return 0
-		fi
-	done
-	echo "PID $1 exited prematurely"
-	return 1
-}
-
 test_per_thread()
 {
 	k="$1"
@@ -298,7 +238,7 @@ test_per_thread()
 	perf record -B -N --no-bpf-event -o "${perfdatafile}" -e intel_pt//u"${k}" -vvv --per-thread -p "${w1},${w2}" 2>"${errfile}" >"${outfile}" &
 	ppid=$!
 	echo "perf PID is $ppid"
-	wait_for_perf_to_start ${ppid} || return 1
+	wait_for_perf_to_start ${ppid} "${errfile}" || return 1
 
 	kill ${w1}
 	wait_for_process_to_exit ${w1} || return 1
-- 
2.25.1

