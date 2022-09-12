Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA45B5653
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiILIfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiILIer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:34:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED8E655A;
        Mon, 12 Sep 2022 01:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662971682; x=1694507682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZF4Uom56OPBctkfid8EbPdt+2zuP7cmlHZQN8PMrF5A=;
  b=Jag13JwRKks3VrL/+SFd7+NKDMF8rKJCmfBJ1AdJU/jz7oTw32u58isT
   dHyM59hobEN7YT2uC3AZy4a1lleweUq8keo1LwX2yf/wSytQPTE84JCeS
   LbzpjcGUDDSQLuBVmZxO/shbZ4T/dSI8AgCzbQgpWwBHfNI5dyGEhZG0C
   fwjWNQszFTUyvmew4Fm2tqYbOf//SiE/zlThkFnscCFMK3Mx079yPg/7Y
   ZmJNQjtE2raZWHEzm9T2XB+LfVCKvMDCRg/9aCJtWUpVcFr3GOuYODre/
   6CRdT3iV+GtXMJIaiB933uKi6QpUPf80g1mAMKPQrOAc/8we6UgDAMXqp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299153640"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="299153640"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="611688295"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:39 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 07/11] perf test: test_intel_pt.sh: Use quotes around variable expansion
Date:   Mon, 12 Sep 2022 11:34:08 +0300
Message-Id: <20220912083412.7058-8-adrian.hunter@intel.com>
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

As suggested by shellcheck, use quotes around variable expansion.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 3dfdef4fa6f4..075b780fe9ed 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -37,7 +37,7 @@ trap trap_cleanup EXIT TERM INT
 
 can_cpu_wide()
 {
-	perf record -o ${tmpfile} -B -N --no-bpf-event -e dummy:u -C $1 true >/dev/null 2>&1 || return 2
+	perf record -o "${tmpfile}" -B -N --no-bpf-event -e dummy:u -C "$1" true >/dev/null 2>&1 || return 2
 	return 0
 }
 
@@ -48,12 +48,12 @@ test_system_wide_side_band()
 	can_cpu_wide 1 || return $?
 
 	# Record on CPU 0 a task running on CPU 1
-	perf record -B -N --no-bpf-event -o ${perfdatafile} -e intel_pt//u -C 0 -- taskset --cpu-list 1 uname
+	perf record -B -N --no-bpf-event -o "${perfdatafile}" -e intel_pt//u -C 0 -- taskset --cpu-list 1 uname
 
 	# Should get MMAP events from CPU 1 because they can be needed to decode
-	mmap_cnt=$(perf script -i ${perfdatafile} --no-itrace --show-mmap-events -C 1 2>/dev/null | grep -c MMAP)
+	mmap_cnt=$(perf script -i "${perfdatafile}" --no-itrace --show-mmap-events -C 1 2>/dev/null | grep -c MMAP)
 
-	if [ ${mmap_cnt} -gt 0 ] ; then
+	if [ "${mmap_cnt}" -gt 0 ] ; then
 		return 0
 	fi
 
@@ -63,11 +63,11 @@ test_system_wide_side_band()
 
 count_result()
 {
-	if [ $1 -eq 2 ] ; then
+	if [ "$1" -eq 2 ] ; then
 		skip_cnt=$((skip_cnt + 1))
 		return
 	fi
-	if [ $1 -eq 0 ] ; then
+	if [ "$1" -eq 0 ] ; then
 		ok_cnt=$((ok_cnt + 1))
 		return
 	fi
-- 
2.25.1

