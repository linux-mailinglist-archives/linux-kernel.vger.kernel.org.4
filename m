Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3BD731A91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbjFONzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344641AbjFONyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:54:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD0D1FD4;
        Thu, 15 Jun 2023 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837284; x=1718373284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=815xhyqBJVkUcTa8Wnb+dhIrshSrEjCMA06FFhOLA18=;
  b=kmXuT3ujwTcmvUdRvX4h+dVAgbOY5t3ACG20eWo3smlgfNTBOpBHQMZD
   2D9XqijUdcNJEgBSMCa4g+A0Fy+T8Zb1sTJ84Nj/H0BD4cXmFxfB1BwpK
   f+LldfKonXADpSibh/lksv2p27AhHUP6yz7+VoDvkodfHvd2RSOU9wRtr
   1Gl/Bv2PvpOl+5dyelAqVgPaiD2MltHgZOjc22paFZhmozAvqypB2AHf+
   phgksY9Xph7ZduabuvhKgSg/REkX2uXDjplYFJhltBMJsGSwf1gUVF1ZD
   uQRM/lvflUoptMfwLVriqw8Bp5MELRh8Gtaf5F2+z+DcHQg9ALRr6zwZa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356411436"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356411436"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:54:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782527077"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="782527077"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 06:54:42 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 8/8] perf test: Add test case for the standard perf stat output
Date:   Thu, 15 Jun 2023 06:53:15 -0700
Message-Id: <20230615135315.3662428-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230615135315.3662428-1-kan.liang@linux.intel.com>
References: <20230615135315.3662428-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add a new test case to verify the standard perf stat output with
different options.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 108 ++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat+std_output.sh

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
new file mode 100755
index 000000000000..98cc3356a04a
--- /dev/null
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -0,0 +1,108 @@
+#!/bin/bash
+# perf stat STD output linter
+# SPDX-License-Identifier: GPL-2.0
+# Tests various perf stat STD output commands for
+# default event and metricgroup
+
+set -e
+
+. $(dirname $0)/lib/stat_output.sh
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
+perf_cmd="-o ${stat_output}"
+
+skip_test=$(check_for_topology)
+check_no_args "STD" "$perf_cmd"
+check_system_wide "STD" "$perf_cmd"
+check_interval "STD" "$perf_cmd"
+check_per_thread "STD" "$perf_cmd"
+check_per_node "STD" "$perf_cmd"
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr "STD" "$perf_cmd"
+	check_per_core "STD" "$perf_cmd"
+	check_per_cache_instance "STD" "$perf_cmd"
+	check_per_die "STD" "$perf_cmd"
+	check_per_socket "STD" "$perf_cmd"
+else
+	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
+fi
+cleanup
+exit 0
-- 
2.35.1

