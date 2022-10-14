Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30ED5FF2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJNRKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJNRKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:10:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82298AEA2E;
        Fri, 14 Oct 2022 10:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665767437; x=1697303437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hwd2CIUhGHK6qQ/DysaH8oDK+SeFFMChlzMY14O6WEI=;
  b=SFjxob+DXxNXUvsVeamcWOMmfrvwpmqS0njgFmxW8Qq65zm+Ut/fTJOL
   BqZMaMUJ2pAV6m4BCfSmVaCM0QrXwVW3UlcaH4tgsGWpPXYHshGtXtR4o
   NJvYi3izI/IpLYISRNsX5izI12aw8Irm+zUACLbt5IVXSqhjIJhepiI8X
   ztygKqfk0cAf/xfvRo2ef5NZJHoZk4bXHGoml1KvpVhJZ93Lno0jkhI9o
   cS01eVZP99Gki2LxMb1okdRCow0qRIh0lDaWn/C8KynH80ii8/oRX11fZ
   WPR9z2IApiZYg8JzgCZNeAgxYUvhB7RysNBLDz0ioNQq1YL6jk6opCG0Y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="369622666"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="369622666"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="696377057"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="696377057"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.43.79])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 7/7] perf test: test_intel_pt.sh: Add 9 tests
Date:   Fri, 14 Oct 2022 20:09:05 +0300
Message-Id: <20221014170905.64069-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014170905.64069-1-adrian.hunter@intel.com>
References: <20221014170905.64069-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammy Yi <ammy.yi@intel.com>

Add tests:
	Test with MTC and TSC disabled
	Test with branches disabled
	Test with/without CYC
	Test recording with sample mode
	Test with kernel trace
	Test virtual LBR
	Test power events
	Test with TNT packets disabled
	Test with event_trace

These tests mostly check that perf record works with the corresponding
Intel PT config terms, sometimes also checking that certain packets do or
do not appear in the resulting trace as appropriate.

The "Test virtual LBR" is slightly trickier, using a Python script to
check that branch stacks are actually synthesized.

Signed-off-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 195 +++++++++++++++++++++++-
 1 file changed, 194 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index e0bf75981b9c..4c0aabbe33bd 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -23,6 +23,7 @@ errfile="${temp_dir}/test-err.txt"
 workload="${temp_dir}/workload"
 awkscript="${temp_dir}/awkscript"
 jitdump_workload="${temp_dir}/jitdump_workload"
+maxbrstack="${temp_dir}/maxbrstack.py"
 
 cleanup()
 {
@@ -422,7 +423,7 @@ test_jitdump()
 	# Should be no errors
 	if [ "${decode_err_cnt}" -ne 0 ] ; then
 		echo "Decode failed, ${decode_err_cnt} errors"
-		perf script -i "${perfdatafile}" --itrace=e-o-l
+		perf script -i "${perfdatafile}" --itrace=e-o-l --show-mmap-events | cat
 		return 1
 	fi
 
@@ -430,6 +431,189 @@ test_jitdump()
 	return 0
 }
 
+test_packet_filter()
+{
+	echo "--- Test with MTC and TSC disabled ---"
+	# Disable MTC and TSC
+	perf_record_no_decode -o "${perfdatafile}" -e intel_pt/mtc=0,tsc=0/u uname
+	# Should not get MTC packet
+	mtc_cnt=$(perf script -i "${perfdatafile}" -D 2>/dev/null | grep -c "MTC 0x")
+	if [ "${mtc_cnt}" -ne 0 ] ; then
+		echo "Failed to filter with mtc=0"
+		return 1
+	fi
+	# Should not get TSC package
+	tsc_cnt=$(perf script -i "${perfdatafile}" -D 2>/dev/null | grep -c "TSC 0x")
+	if [ "${tsc_cnt}" -ne 0 ] ; then
+		echo "Failed to filter with tsc=0"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
+test_disable_branch()
+{
+	echo "--- Test with branches disabled ---"
+	# Disable branch
+	perf_record_no_decode -o "${perfdatafile}" -e intel_pt/branch=0/u uname
+	# Should not get branch related packets
+	tnt_cnt=$(perf script -i "${perfdatafile}" -D 2>/dev/null | grep -c "TNT 0x")
+	tip_cnt=$(perf script -i "${perfdatafile}" -D 2>/dev/null | grep -c "TIP 0x")
+	fup_cnt=$(perf script -i "${perfdatafile}" -D 2>/dev/null | grep -c "FUP 0x")
+	if [ "${tnt_cnt}" -ne 0 ] || [ "${tip_cnt}" -ne 0 ] || [ "${fup_cnt}" -ne 0 ] ; then
+		echo "Failed to disable branches"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
+test_time_cyc()
+{
+	echo "--- Test with/without CYC ---"
+	# Check if CYC is supported
+	cyc=$(cat /sys/bus/event_source/devices/intel_pt/caps/psb_cyc)
+	if [ "${cyc}" != "1" ] ; then
+		echo "SKIP: CYC is not supported"
+		return 2
+	fi
+	# Enable CYC
+	perf_record_no_decode -o "${perfdatafile}" -e intel_pt/cyc/u uname
+	# should get CYC packets
+	cyc_cnt=$(perf script -i "${perfdatafile}" -D 2>/dev/null | grep -c "CYC 0x")
+	if [ "${cyc_cnt}" = "0" ] ; then
+		echo "Failed to get CYC packet"
+		return 1
+	fi
+	# Without CYC
+	perf_record_no_decode -o "${perfdatafile}" -e intel_pt//u uname
+	# Should not get CYC packets
+	cyc_cnt=$(perf script -i "${perfdatafile}" -D 2>/dev/null | grep -c "CYC 0x")
+	if [ "${cyc_cnt}" -gt 0 ] ; then
+		echo "Still get CYC packet without cyc"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
+test_sample()
+{
+	echo "--- Test recording with sample mode ---"
+	# Check if recording with sample mode is working
+	if ! perf_record_no_decode -o "${perfdatafile}" --aux-sample=8192 -e '{intel_pt//u,branch-misses:u}' uname ; then
+		echo "perf record failed with --aux-sample"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
+test_kernel_trace()
+{
+	echo "--- Test with kernel trace ---"
+	# Check if recording with kernel trace is working
+	can_kernel || return 2
+	if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt//k -m1,128 uname ; then
+		echo "perf record failed with intel_pt//k"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
+test_virtual_lbr()
+{
+	echo "--- Test virtual LBR ---"
+
+	# Python script to determine the maximum size of branch stacks
+	cat << "_end_of_file_" > "${maxbrstack}"
+from __future__ import print_function
+
+bmax = 0
+
+def process_event(param_dict):
+	if "brstack" in param_dict:
+		brstack = param_dict["brstack"]
+		n = len(brstack)
+		global bmax
+		if n > bmax:
+			bmax = n
+
+def trace_end():
+	print("max brstack", bmax)
+_end_of_file_
+
+	# Check if virtual lbr is working
+	perf_record_no_bpf -o "${perfdatafile}" --aux-sample -e '{intel_pt//,cycles}:u' uname
+	times_val=$(perf script -i "${perfdatafile}" --itrace=L -s "${maxbrstack}" 2>/dev/null | grep "max brstack " | cut -d " " -f 3)
+	case "${times_val}" in
+		[0-9]*)	;;
+		*)	times_val=0;;
+	esac
+	if [ "${times_val}" -lt 2 ] ; then
+		echo "Failed with virtual lbr"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
+test_power_event()
+{
+	echo "--- Test power events ---"
+	# Check if power events are supported
+	power_event=$(cat /sys/bus/event_source/devices/intel_pt/caps/power_event_trace)
+	if [ "${power_event}" != "1" ] ; then
+		echo "SKIP: power_event_trace is not supported"
+		return 2
+	fi
+	if ! perf_record_no_decode -o "${perfdatafile}" -a -e intel_pt/pwr_evt/u uname ; then
+		echo "perf record failed with pwr_evt"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
+test_no_tnt()
+{
+	echo "--- Test with TNT packets disabled  ---"
+	# Check if TNT disable is supported
+	notnt=$(cat /sys/bus/event_source/devices/intel_pt/caps/tnt_disable)
+	if [ "${notnt}" != "1" ] ; then
+		echo "SKIP: tnt_disable is not supported"
+		return 2
+	fi
+	perf_record_no_decode -o "${perfdatafile}" -e intel_pt/notnt/u uname
+	# Should be no TNT packets
+	tnt_cnt=$(perf script -i "${perfdatafile}" -D | grep -c TNT)
+	if [ "${tnt_cnt}" -ne 0 ] ; then
+		echo "TNT packets still there after notnt"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
+test_event_trace()
+{
+	echo "--- Test with event_trace ---"
+	# Check if event_trace is supported
+	event_trace=$(cat /sys/bus/event_source/devices/intel_pt/caps/event_trace)
+	if [ "${event_trace}" != 1 ] ; then
+		echo "SKIP: event_trace is not supported"
+		return 2
+	fi
+	if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/event/u uname ; then
+		echo "perf record failed with event trace"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
 count_result()
 {
 	if [ "$1" -eq 2 ] ; then
@@ -448,6 +632,15 @@ test_system_wide_side_band		|| ret=$? ; count_result $ret ; ret=0
 test_per_thread "" ""			|| ret=$? ; count_result $ret ; ret=0
 test_per_thread "k" "(incl. kernel) "	|| ret=$? ; count_result $ret ; ret=0
 test_jitdump				|| ret=$? ; count_result $ret ; ret=0
+test_packet_filter			|| ret=$? ; count_result $ret ; ret=0
+test_disable_branch			|| ret=$? ; count_result $ret ; ret=0
+test_time_cyc				|| ret=$? ; count_result $ret ; ret=0
+test_sample				|| ret=$? ; count_result $ret ; ret=0
+test_kernel_trace			|| ret=$? ; count_result $ret ; ret=0
+test_virtual_lbr			|| ret=$? ; count_result $ret ; ret=0
+test_power_event			|| ret=$? ; count_result $ret ; ret=0
+test_no_tnt				|| ret=$? ; count_result $ret ; ret=0
+test_event_trace			|| ret=$? ; count_result $ret ; ret=0
 
 cleanup
 
-- 
2.25.1

