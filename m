Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F55B5658
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiILIfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiILIe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:34:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA3DFC9;
        Mon, 12 Sep 2022 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662971691; x=1694507691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3m/ZScAWiEGrz3LUQkYhRaOYpQnCZS+U6PEHDFvP78=;
  b=YvqlVJSWnpG26Mn/XumJ6HsbUQr+7ne3tGlJkgeeglNnLxBHD1cazgWe
   nJAxmG0jTHn61NBNP8jUJsOpxnrCkXn13BM765hkyQK5H9BxYAz1GJfCJ
   WMR2II9tYAX+Z3ZHuFQ2hF0CeMIChk9/8oFYI1+lb8TigJQIXzs4/JI4Q
   epEByjsgAx+/QWY371T1qv4vu4y72beAhxc7uic2X1SaN5ZCphwm/OPZ+
   KY83UbCo9kxyCb5F787ePqIUr6FTSHd8vbHBN2YN7eYCGOlu5MksKx4ea
   vOHXUmDjU1BoXaYZ8MQ3zw9vDwDME6hq72Xsf/MnHER5jPWQtEuAN3Bvy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299153669"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="299153669"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="611688351"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 11/11] perf test: test_intel_pt.sh: Add per-thread test
Date:   Mon, 12 Sep 2022 11:34:12 +0300
Message-Id: <20220912083412.7058-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912083412.7058-1-adrian.hunter@intel.com>
References: <20220912083412.7058-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tracing the kernel with Intel PT, text_poke events are recorded
per-cpu. In per-thread mode that results in a mixture of per-thread and
per-cpu events and mmaps. Check that happens correctly.

The debug output from perf record -vvv is recorded and then awk used to
process the debug messages that indicate what file descriptors were opened
and whether they were mmapped or set-output.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 247 ++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 2d489de9097b..051d088c1b74 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -4,6 +4,8 @@
 
 set -e
 
+tenths=date\ +%s%1N
+
 # Skip if no Intel PT
 perf list | grep -q 'intel_pt//' || exit 2
 
@@ -15,6 +17,10 @@ temp_dir=$(mktemp -d /tmp/perf-test-intel-pt-sh.XXXXXXXXXX)
 
 tmpfile="${temp_dir}/tmp-perf.data"
 perfdatafile="${temp_dir}/test-perf.data"
+outfile="${temp_dir}/test-out.txt"
+errfile="${temp_dir}/test-err.txt"
+workload="${temp_dir}/workload"
+awkscript="${temp_dir}/awkscript"
 
 cleanup()
 {
@@ -35,6 +41,37 @@ trap_cleanup()
 
 trap trap_cleanup EXIT TERM INT
 
+have_workload=false
+cat << _end_of_file_ | /usr/bin/cc -o "${workload}" -xc - -pthread && have_workload=true
+#include <time.h>
+#include <pthread.h>
+
+void work(void) {
+	struct timespec tm = {
+		.tv_nsec = 1000000,
+	};
+	int i;
+
+	/* Run for about 30 seconds */
+	for (i = 0; i < 30000; i++)
+		nanosleep(&tm, NULL);
+}
+
+void *threadfunc(void *arg) {
+	work();
+	return NULL;
+}
+
+int main(void) {
+	pthread_t th;
+
+	pthread_create(&th, NULL, threadfunc, NULL);
+	work();
+	pthread_join(th, NULL);
+	return 0;
+}
+_end_of_file_
+
 can_cpu_wide()
 {
 	echo "Checking for CPU-wide recording on CPU $1"
@@ -69,6 +106,214 @@ test_system_wide_side_band()
 	return 1
 }
 
+can_kernel()
+{
+	perf record -o "${tmpfile}" -B -N --no-bpf-event -e dummy:k true >/dev/null 2>&1 || return 2
+	return 0
+}
+
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
+wait_for_perf_to_start()
+{
+	echo "Waiting for \"perf record has started\" message"
+	start_time=$($tenths)
+	while [ -e "/proc/$1" ] ; do
+		if grep -q "perf record has started" "${errfile}" ; then
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
+
+test_per_thread()
+{
+	k="$1"
+	desc="$2"
+
+	echo "--- Test per-thread ${desc}recording ---"
+
+	if ! $have_workload ; then
+		echo "No workload, so skipping"
+		return 2
+	fi
+
+	if [ "${k}" = "k" ] ; then
+		can_kernel || return 2
+	fi
+
+	cat <<- "_end_of_file_" > "${awkscript}"
+	BEGIN {
+		s = "[ ]*"
+		u = s"[0-9]+"s
+		d = s"[0-9-]+"s
+		x = s"[0-9a-fA-FxX]+"s
+		mmapping = "idx"u": mmapping fd"u
+		set_output = "idx"u": set output fd"u"->"u
+		perf_event_open = "sys_perf_event_open: pid"d"cpu"d"group_fd"d"flags"x"="u
+	}
+
+	/perf record opening and mmapping events/ {
+		if (!done)
+			active = 1
+	}
+
+	/perf record done opening and mmapping events/ {
+		active = 0
+		done = 1
+	}
+
+	$0 ~ perf_event_open && active {
+		match($0, perf_event_open)
+		$0 = substr($0, RSTART, RLENGTH)
+		pid = $3
+		cpu = $5
+		fd = $11
+		print "pid " pid " cpu " cpu " fd " fd " : " $0
+		fd_array[fd] = fd
+		pid_array[fd] = pid
+		cpu_array[fd] = cpu
+	}
+
+	$0 ~ mmapping && active  {
+		match($0, mmapping)
+		$0 = substr($0, RSTART, RLENGTH)
+		fd = $5
+		print "fd " fd " : " $0
+		if (fd in fd_array) {
+			mmap_array[fd] = 1
+		} else {
+			print "Unknown fd " fd
+			exit 1
+		}
+	}
+
+	$0 ~ set_output && active {
+		match($0, set_output)
+		$0 = substr($0, RSTART, RLENGTH)
+		fd = $6
+		fd_to = $8
+		print "fd " fd " fd_to " fd_to " : " $0
+		if (fd in fd_array) {
+			if (fd_to in fd_array) {
+				set_output_array[fd] = fd_to
+			} else {
+				print "Unknown fd " fd_to
+				exit 1
+			}
+		} else {
+			print "Unknown fd " fd
+			exit 1
+		}
+	}
+
+	END {
+		print "Checking " length(fd_array) " fds"
+		for (fd in fd_array) {
+			if (fd in mmap_array) {
+				pid = pid_array[fd]
+				if (pid != -1) {
+					if (pid in pids) {
+						print "More than 1 mmap for PID " pid
+						exit 1
+					}
+					pids[pid] = 1
+				}
+				cpu = cpu_array[fd]
+				if (cpu != -1) {
+					if (cpu in cpus) {
+						print "More than 1 mmap for CPU " cpu
+						exit 1
+					}
+					cpus[cpu] = 1
+				}
+			} else if (!(fd in set_output_array)) {
+				print "No mmap for fd " fd
+				exit 1
+			}
+		}
+		n = length(pids)
+		if (n != thread_cnt) {
+			print "Expected " thread_cnt " per-thread mmaps - found " n
+			exit 1
+		}
+	}
+	_end_of_file_
+
+	$workload &
+	w1=$!
+	$workload &
+	w2=$!
+	echo "Workload PIDs are $w1 and $w2"
+	wait_for_threads ${w1} 2
+	wait_for_threads ${w2} 2
+
+	perf record -B -N --no-bpf-event -o "${perfdatafile}" -e intel_pt//u"${k}" -vvv --per-thread -p "${w1},${w2}" 2>"${errfile}" >"${outfile}" &
+	ppid=$!
+	echo "perf PID is $ppid"
+	wait_for_perf_to_start ${ppid} || return 1
+
+	kill ${w1}
+	wait_for_process_to_exit ${w1} || return 1
+	is_running ${ppid} || return 1
+
+	kill ${w2}
+	wait_for_process_to_exit ${w2} || return 1
+	wait_for_process_to_exit ${ppid} || return 1
+
+	awk -v thread_cnt=4 -f "${awkscript}" "${errfile}" || return 1
+
+	echo OK
+	return 0
+}
+
 count_result()
 {
 	if [ "$1" -eq 2 ] ; then
@@ -85,6 +330,8 @@ count_result()
 
 ret=0
 test_system_wide_side_band || ret=$? ; count_result $ret
+test_per_thread "" "" || ret=$? ; count_result $ret
+test_per_thread "k" "(incl. kernel) " || ret=$? ; count_result $ret
 
 cleanup
 
-- 
2.25.1

