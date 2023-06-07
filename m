Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4EC7265E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjFGQ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjFGQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:27:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A4C1FC8;
        Wed,  7 Jun 2023 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686155247; x=1717691247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDFGuYU/fWQ64S00Ylbe8Fwu73ikBHRCTGZrVvEniZI=;
  b=gvMwdtIg3jCMCPyPhV8V+fn73j4S8Mpjjsz0BfHSvZWT8ERMaiu2Vr9D
   NrA+IWAlCoIYAnkg1Lp72+TIfENnNPyeSLsx9JpQnRD/igQ0E+8TLKZFj
   FoyfXU1Se2G0x/RkEhWq6po2gI/OAqqdpx7pHURmzJ+Fz1QDAr9nQj2OH
   WcMkJVv7/D0rvDNocE9Hwb80aIqjNhJKdkqGc1TGYhvG3wSc+lymTswRQ
   ZMKp6pSn7sZSm2hAmxLFwXYAatUU8SFV9EPoMX8+zOcRM9lgP8TiRw7/F
   bf8UhI0Kyyq+83CNAtORkCc1i00iSPRn3UCrdD+fKJkvhmDfo9LjJhRr0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="355892685"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="355892685"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 09:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774697688"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="774697688"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 09:27:23 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 8/8] perf test: Add test case for the standard perf stat output
Date:   Wed,  7 Jun 2023 09:27:00 -0700
Message-Id: <20230607162700.3234712-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230607162700.3234712-1-kan.liang@linux.intel.com>
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add a new test case to verify the standard perf stat output with
different options.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 259 ++++++++++++++++++++++
 1 file changed, 259 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat+std_output.sh

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
new file mode 100755
index 000000000000..b9db0f245450
--- /dev/null
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -0,0 +1,259 @@
+#!/bin/bash
+# perf stat STD output linter
+# SPDX-License-Identifier: GPL-2.0
+# Tests various perf stat STD output commands for
+# default event and metricgroup
+
+set -e
+
+skip_test=0
+
+stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
+
+event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults cycles instructions branches branch-misses stalled-cycles-frontend stalled-cycles-backend)
+event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "GHz" "insn per cycle" "/sec" "of all branches" "frontend cycles idle" "backend cycles idle")
+
+metricgroup_name=(TopdownL1 TopdownL2)
+
+cleanup() {
+  rm -f "${stat_output}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+function commachecker()
+{
+	local -i cnt=0
+	local prefix=1
+
+	case "$1"
+	in "--interval")	prefix=2
+	;; "--per-thread")	prefix=2
+	;; "--system-wide-no-aggr")	prefix=2
+	;; "--per-core")	prefix=3
+	;; "--per-socket")	prefix=3
+	;; "--per-node")	prefix=3
+	;; "--per-die")		prefix=3
+	;; "--per-cache")	prefix=3
+	esac
+
+	while read line
+	do
+		# Ignore initial "started on" comment.
+		x=${line:0:1}
+		[ "$x" = "#" ] && continue
+		# Ignore initial blank line.
+		[ "$line" = "" ] && continue
+		# Ignore "Performance counter stats"
+		x=${line:0:25}
+		[ "$x" = "Performance counter stats" ] && continue
+		# Ignore "seconds time elapsed" and break
+		[[ "$line" == *"time elapsed"* ]] && break
+
+		main_body=$(echo $line | cut -d' ' -f$prefix-)
+		x=${main_body%#*}
+		# Check default metricgroup
+		y=$(echo $x | tr -d ' ')
+		[ "$y" = "" ] && continue
+		for i in "${!metricgroup_name[@]}"; do
+			[[ "$y" == *"${metricgroup_name[$i]}"* ]] && break
+		done
+		[[ "$y" == *"${metricgroup_name[$i]}"* ]] && continue
+
+		# Check default event
+		for i in "${!event_name[@]}"; do
+			[[ "$x" == *"${event_name[$i]}"* ]] && break
+		done
+
+		[[ ! "$x" == *"${event_name[$i]}"* ]] && {
+			echo "Unknown event name in $line" 1>&2
+			exit 1;
+		}
+
+		# Check event metric if it exists
+		[[ ! "$main_body" == *"#"* ]] && continue
+		[[ ! "$main_body" == *"${event_metric[$i]}"* ]] && {
+			echo "wrong event metric. expected ${event_metric[$i]} in $line" 1>&2
+			exit 1;
+		}
+	done < "${stat_output}"
+	return 0
+}
+
+# Return true if perf_event_paranoid is > $1 and not running as root.
+function ParanoidAndNotRoot()
+{
+	 [ $(id -u) != 0 ] && [ $(cat /proc/sys/kernel/perf_event_paranoid) -gt $1 ]
+}
+
+check_no_args()
+{
+	echo -n "Checking STD output: no args "
+	perf stat -o "${stat_output}" true
+        commachecker --no-args
+	echo "[Success]"
+}
+
+check_system_wide()
+{
+	echo -n "Checking STD output: system wide "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat -a -o "${stat_output}" true
+        commachecker --system-wide
+	echo "[Success]"
+}
+
+check_system_wide_no_aggr()
+{
+	echo -n "Checking STD output: system wide no aggregation "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat -A -a --no-merge -o "${stat_output}" true
+        commachecker --system-wide-no-aggr
+	echo "[Success]"
+}
+
+check_interval()
+{
+	echo -n "Checking STD output: interval "
+	perf stat -I 1000 -o "${stat_output}" true
+        commachecker --interval
+	echo "[Success]"
+}
+
+
+check_per_core()
+{
+	echo -n "Checking STD output: per core "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-core -a -o "${stat_output}" true
+        commachecker --per-core
+	echo "[Success]"
+}
+
+check_per_thread()
+{
+	echo -n "Checking STD output: per thread "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-thread -a -o "${stat_output}" true
+        commachecker --per-thread
+	echo "[Success]"
+}
+
+check_per_cache_instance()
+{
+	echo -n "Checking STD output: per cache instance "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat  --per-cache -a true 2>&1 | commachecker --per-cache
+	echo "[Success]"
+}
+
+check_per_die()
+{
+	echo -n "Checking STD output: per die "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-die -a -o "${stat_output}" true
+        commachecker --per-die
+	echo "[Success]"
+}
+
+check_per_node()
+{
+	echo -n "Checking STD output: per node "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-node -a -o "${stat_output}" true
+        commachecker --per-node
+	echo "[Success]"
+}
+
+check_per_socket()
+{
+	echo -n "Checking STD output: per socket "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-socket -a -o "${stat_output}" true
+        commachecker --per-socket
+	echo "[Success]"
+}
+
+# The perf stat options for per-socket, per-core, per-die
+# and -A ( no_aggr mode ) uses the info fetched from this
+# directory: "/sys/devices/system/cpu/cpu*/topology". For
+# example, socket value is fetched from "physical_package_id"
+# file in topology directory.
+# Reference: cpu__get_topology_int in util/cpumap.c
+# If the platform doesn't expose topology information, values
+# will be set to -1. For example, incase of pSeries platform
+# of powerpc, value for  "physical_package_id" is restricted
+# and set to -1. Check here validates the socket-id read from
+# topology file before proceeding further
+
+FILE_LOC="/sys/devices/system/cpu/cpu*/topology/"
+FILE_NAME="physical_package_id"
+
+check_for_topology()
+{
+	if ! ParanoidAndNotRoot 0
+	then
+		socket_file=`ls $FILE_LOC/$FILE_NAME | head -n 1`
+		[ -z $socket_file ] && return 0
+		socket_id=`cat $socket_file`
+		[ $socket_id == -1 ] && skip_test=1
+		return 0
+	fi
+}
+
+check_for_topology
+check_no_args
+check_system_wide
+check_interval
+check_per_thread
+check_per_node
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr
+	check_per_core
+	check_per_cache_instance
+	check_per_die
+	check_per_socket
+else
+	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
+fi
+cleanup
+exit 0
-- 
2.35.1

