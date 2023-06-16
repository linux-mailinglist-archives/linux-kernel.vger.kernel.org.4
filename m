Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA877325C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjFPDP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbjFPDPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:15:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BDA1FE8;
        Thu, 15 Jun 2023 20:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686885296; x=1718421296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EOzWNHuA05l8t1lT/on7ueUWwrY92i0s8PwEvMAtVIs=;
  b=mc+900OIRVAMPpxwxDeGr+/FhpOeSl4adpJ0i0kvgktQx3+npTnfCxck
   8/h8skdmWBBE5shmQp19cMbWKe72ZsuSfYB4o8tYqKOJzh4grBmhffEPb
   nIb3vxR4VRTGeLAteBb75YgoL1FRWmFmksfBttaZKxCYXuwH8q6ghHK9S
   oCRBLULId/6kEf7ZiZWTsFRr2VhZXTqhnOO/r1Li3FvQ2WRi809K94XHX
   xPAgjTkBH8gUsaC3mXx4C4sEQebWKe3nCg1YdYh55O6KeVRFdEpJybCCU
   Ik0jD4a3Y01TyTjP5x5s+tzvO/o4CWpXFvTIcu5wYA0rHwH3rQtrRPQwE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338718216"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="338718216"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825555619"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="825555619"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 20:14:53 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 3/5] perf test: Move all the check functions of stat csv output to lib
Date:   Thu, 15 Jun 2023 20:14:18 -0700
Message-Id: <20230616031420.3751973-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230616031420.3751973-1-kan.liang@linux.intel.com>
References: <20230616031420.3751973-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

These functions can be shared with the stat std output test.

There is no functional change.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/lib/stat_output.sh | 169 +++++++++++++++++++
 tools/perf/tests/shell/stat+csv_output.sh | 188 ++--------------------
 2 files changed, 184 insertions(+), 173 deletions(-)
 create mode 100755 tools/perf/tests/shell/lib/stat_output.sh

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
new file mode 100755
index 000000000000..363979b1123d
--- /dev/null
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Return true if perf_event_paranoid is > $1 and not running as root.
+function ParanoidAndNotRoot()
+{
+	 [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
+}
+
+# $1 name $2 extra_opt
+check_no_args()
+{
+        echo -n "Checking $1 output: no args"
+        perf stat $2 true
+        commachecker --no-args
+        echo "[Success]"
+}
+
+check_system_wide()
+{
+	echo -n "Checking $1 output: system wide "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat -a $2 true
+	commachecker --system-wide
+	echo "[Success]"
+}
+
+check_system_wide_no_aggr()
+{
+	echo -n "Checking $1 output: system wide no aggregation "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat -A -a --no-merge $2 true
+	commachecker --system-wide-no-aggr
+	echo "[Success]"
+}
+
+check_interval()
+{
+	echo -n "Checking $1 output: interval "
+	perf stat -I 1000 $2 true
+	commachecker --interval
+	echo "[Success]"
+}
+
+check_event()
+{
+	echo -n "Checking $1 output: event "
+	perf stat -e cpu-clock $2 true
+	commachecker --event
+	echo "[Success]"
+}
+
+check_per_core()
+{
+	echo -n "Checking $1 output: per core "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-core -a $2 true
+	commachecker --per-core
+	echo "[Success]"
+}
+
+check_per_thread()
+{
+	echo -n "Checking $1 output: per thread "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-thread -a $2 true
+	commachecker --per-thread
+	echo "[Success]"
+}
+
+check_per_cache_instance()
+{
+	echo -n "Checking $1 output: per cache instance "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-cache -a $2 true
+	commachecker --per-cache
+	echo "[Success]"
+}
+
+check_per_die()
+{
+	echo -n "Checking $1 output: per die "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-die -a $2 true
+	commachecker --per-die
+	echo "[Success]"
+}
+
+check_per_node()
+{
+	echo -n "Checking $1 output: per node "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-node -a $2 true
+	commachecker --per-node
+	echo "[Success]"
+}
+
+check_per_socket()
+{
+	echo -n "Checking $1 output: per socket "
+	if ParanoidAndNotRoot 0
+	then
+		echo "[Skip] paranoid and not root"
+		return
+	fi
+	perf stat --per-socket -a $2 true
+	commachecker --per-socket
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
+function check_for_topology()
+{
+	if ! ParanoidAndNotRoot 0
+	then
+		socket_file=`ls $FILE_LOC/$FILE_NAME | head -n 1`
+		[ -z $socket_file ] && {
+			echo 0
+			return
+		}
+		socket_id=`cat $socket_file`
+		[ $socket_id == -1 ] && {
+			echo 1
+			return
+		}
+	fi
+	echo 0
+}
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index ed082daf839c..34a0701fee05 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -6,7 +6,8 @@
 
 set -e
 
-skip_test=0
+. $(dirname $0)/lib/stat_output.sh
+
 csv_sep=@
 
 stat_output=$(mktemp /tmp/__perf_test.stat_output.csv.XXXXX)
@@ -63,181 +64,22 @@ function commachecker()
 	return 0
 }
 
-# Return true if perf_event_paranoid is > $1 and not running as root.
-function ParanoidAndNotRoot()
-{
-	 [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
-}
-
-check_no_args()
-{
-	echo -n "Checking CSV output: no args "
-	perf stat -x$csv_sep -o "${stat_output}" true
-        commachecker --no-args
-	echo "[Success]"
-}
-
-check_system_wide()
-{
-	echo -n "Checking CSV output: system wide "
-	if ParanoidAndNotRoot 0
-	then
-		echo "[Skip] paranoid and not root"
-		return
-	fi
-	perf stat -x$csv_sep -a -o "${stat_output}" true
-        commachecker --system-wide
-	echo "[Success]"
-}
-
-check_system_wide_no_aggr()
-{
-	echo -n "Checking CSV output: system wide no aggregation "
-	if ParanoidAndNotRoot 0
-	then
-		echo "[Skip] paranoid and not root"
-		return
-	fi
-	perf stat -x$csv_sep -A -a --no-merge -o "${stat_output}" true
-        commachecker --system-wide-no-aggr
-	echo "[Success]"
-}
-
-check_interval()
-{
-	echo -n "Checking CSV output: interval "
-	perf stat -x$csv_sep -I 1000 -o "${stat_output}" true
-        commachecker --interval
-	echo "[Success]"
-}
-
-
-check_event()
-{
-	echo -n "Checking CSV output: event "
-	perf stat -x$csv_sep -e cpu-clock -o "${stat_output}" true
-        commachecker --event
-	echo "[Success]"
-}
-
-check_per_core()
-{
-	echo -n "Checking CSV output: per core "
-	if ParanoidAndNotRoot 0
-	then
-		echo "[Skip] paranoid and not root"
-		return
-	fi
-	perf stat -x$csv_sep --per-core -a -o "${stat_output}" true
-        commachecker --per-core
-	echo "[Success]"
-}
-
-check_per_thread()
-{
-	echo -n "Checking CSV output: per thread "
-	if ParanoidAndNotRoot 0
-	then
-		echo "[Skip] paranoid and not root"
-		return
-	fi
-	perf stat -x$csv_sep --per-thread -a -o "${stat_output}" true
-        commachecker --per-thread
-	echo "[Success]"
-}
-
-check_per_cache_instance()
-{
-	echo -n "Checking CSV output: per cache instance "
-	if ParanoidAndNotRoot 0
-	then
-		echo "[Skip] paranoid and not root"
-		return
-	fi
-	perf stat -x$csv_sep --per-cache -a true 2>&1 | commachecker --per-cache
-	echo "[Success]"
-}
-
-check_per_die()
-{
-	echo -n "Checking CSV output: per die "
-	if ParanoidAndNotRoot 0
-	then
-		echo "[Skip] paranoid and not root"
-		return
-	fi
-	perf stat -x$csv_sep --per-die -a -o "${stat_output}" true
-        commachecker --per-die
-	echo "[Success]"
-}
-
-check_per_node()
-{
-	echo -n "Checking CSV output: per node "
-	if ParanoidAndNotRoot 0
-	then
-		echo "[Skip] paranoid and not root"
-		return
-	fi
-	perf stat -x$csv_sep --per-node -a -o "${stat_output}" true
-        commachecker --per-node
-	echo "[Success]"
-}
-
-check_per_socket()
-{
-	echo -n "Checking CSV output: per socket "
-	if ParanoidAndNotRoot 0
-	then
-		echo "[Skip] paranoid and not root"
-		return
-	fi
-	perf stat -x$csv_sep --per-socket -a -o "${stat_output}" true
-        commachecker --per-socket
-	echo "[Success]"
-}
-
-# The perf stat options for per-socket, per-core, per-die
-# and -A ( no_aggr mode ) uses the info fetched from this
-# directory: "/sys/devices/system/cpu/cpu*/topology". For
-# example, socket value is fetched from "physical_package_id"
-# file in topology directory.
-# Reference: cpu__get_topology_int in util/cpumap.c
-# If the platform doesn't expose topology information, values
-# will be set to -1. For example, incase of pSeries platform
-# of powerpc, value for  "physical_package_id" is restricted
-# and set to -1. Check here validates the socket-id read from
-# topology file before proceeding further
-
-FILE_LOC="/sys/devices/system/cpu/cpu*/topology/"
-FILE_NAME="physical_package_id"
-
-check_for_topology()
-{
-	if ! ParanoidAndNotRoot 0
-	then
-		socket_file=`ls $FILE_LOC/$FILE_NAME | head -n 1`
-		[ -z $socket_file ] && return 0
-		socket_id=`cat $socket_file`
-		[ $socket_id == -1 ] && skip_test=1
-		return 0
-	fi
-}
+perf_cmd="-x$csv_sep -o ${stat_output}"
 
-check_for_topology
-check_no_args
-check_system_wide
-check_interval
-check_event
-check_per_thread
-check_per_node
+skip_test=$(check_for_topology)
+check_no_args "CSV" "$perf_cmd"
+check_system_wide "CSV" "$perf_cmd"
+check_interval "CSV" "$perf_cmd"
+check_event "CSV" "$perf_cmd"
+check_per_thread "CSV" "$perf_cmd"
+check_per_node "CSV" "$perf_cmd"
 if [ $skip_test -ne 1 ]
 then
-	check_system_wide_no_aggr
-	check_per_core
-	check_per_cache_instance
-	check_per_die
-	check_per_socket
+	check_system_wide_no_aggr "CSV" "$perf_cmd"
+	check_per_core "CSV" "$perf_cmd"
+	check_per_cache_instance "CSV" "$perf_cmd"
+	check_per_die "CSV" "$perf_cmd"
+	check_per_socket "CSV" "$perf_cmd"
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
-- 
2.35.1

