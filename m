Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E995FF2BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJNRJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiJNRJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:09:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD614DF0A;
        Fri, 14 Oct 2022 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665767372; x=1697303372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jva74q/mI6mu3YiJK8quzWNt5hjNiitIrcO+L1oKapc=;
  b=a5VYWomRMemqXBspxOn12oKAMm+mZejsjuqV+H1LwXJ4gzUvcgDxhX8p
   3GUgvRixsWK2+1QNP/8CllsmGEC5Xy8uFVBKQkB0qB5BrEktUlWQdwmGf
   eByB6DoJY2w1b6e/yr+YaAOrmt1II5cdB9q+wLg6GKUItArOp7WZf8cn1
   p9lBHtUNujbmSml1TgwPQzgkeUDf5VfwI8/Z9s9H51R5i9sJzVde4Zw5v
   rHp1lN8JBjPlhLaxBEGf8bf2eWUpNJ3H0lR92hYvFI/QrFczrG5W/Fyce
   8jJh9rk1Q2nau1QvxZnZ4CXI5KCilLs0LSO2+Ulplv4mURuXY2upiXpc2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="303041973"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="303041973"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="696376928"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="696376928"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.43.79])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:30 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/7] perf test: test_intel_pt.sh: Tidy some perf record options
Date:   Fri, 14 Oct 2022 20:09:00 +0300
Message-Id: <20221014170905.64069-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014170905.64069-1-adrian.hunter@intel.com>
References: <20221014170905.64069-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When not decoding, the options "-B -N --no-bpf-event" speed up perf record.
Make a common function for them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 4609a24c9340..334836f92bdc 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -42,6 +42,14 @@ trap_cleanup()
 
 trap trap_cleanup EXIT TERM INT
 
+# perf record for testing without decoding
+perf_record_no_decode()
+{
+	# Options to speed up recording: no post-processing, no build-id cache update,
+	# and no BPF events.
+	perf record -B -N --no-bpf-event "$@"
+}
+
 have_workload=false
 cat << _end_of_file_ | /usr/bin/cc -o "${workload}" -xc - -pthread && have_workload=true
 #include <time.h>
@@ -76,7 +84,7 @@ _end_of_file_
 can_cpu_wide()
 {
 	echo "Checking for CPU-wide recording on CPU $1"
-	if ! perf record -o "${tmpfile}" -B -N --no-bpf-event -e dummy:u -C "$1" true >/dev/null 2>&1 ; then
+	if ! perf_record_no_decode -o "${tmpfile}" -e dummy:u -C "$1" true >/dev/null 2>&1 ; then
 		echo "No so skipping"
 		return 2
 	fi
@@ -93,7 +101,7 @@ test_system_wide_side_band()
 	can_cpu_wide 1 || return $?
 
 	# Record on CPU 0 a task running on CPU 1
-	perf record -B -N --no-bpf-event -o "${perfdatafile}" -e intel_pt//u -C 0 -- taskset --cpu-list 1 uname
+	perf_record_no_decode -o "${perfdatafile}" -e intel_pt//u -C 0 -- taskset --cpu-list 1 uname
 
 	# Should get MMAP events from CPU 1 because they can be needed to decode
 	mmap_cnt=$(perf script -i "${perfdatafile}" --no-itrace --show-mmap-events -C 1 2>/dev/null | grep -c MMAP)
@@ -109,7 +117,7 @@ test_system_wide_side_band()
 
 can_kernel()
 {
-	perf record -o "${tmpfile}" -B -N --no-bpf-event -e dummy:k true >/dev/null 2>&1 || return 2
+	perf_record_no_decode -o "${tmpfile}" -e dummy:k true >/dev/null 2>&1 || return 2
 	return 0
 }
 
@@ -235,7 +243,7 @@ test_per_thread()
 	wait_for_threads ${w1} 2
 	wait_for_threads ${w2} 2
 
-	perf record -B -N --no-bpf-event -o "${perfdatafile}" -e intel_pt//u"${k}" -vvv --per-thread -p "${w1},${w2}" 2>"${errfile}" >"${outfile}" &
+	perf_record_no_decode -o "${perfdatafile}" -e intel_pt//u"${k}" -vvv --per-thread -p "${w1},${w2}" 2>"${errfile}" >"${outfile}" &
 	ppid=$!
 	echo "perf PID is $ppid"
 	wait_for_perf_to_start ${ppid} "${errfile}" || return 1
-- 
2.25.1

