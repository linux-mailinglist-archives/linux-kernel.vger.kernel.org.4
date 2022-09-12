Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276175B5656
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiILIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiILIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:34:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD1B1D3;
        Mon, 12 Sep 2022 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662971686; x=1694507686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ZoypAMshl4L1jQUb8bi0mrZjthI3V+83K+zBezDpJw=;
  b=KKrWyjI8sdza6TAJXo0vLIHjoX48nqd/5wJbatVfuhCcQSPRAyzZSOQL
   rWWYYAU7QKrH4UcmpaujU+CtlDv30hem4ZeqdOe8Q2qCQk6zhoYDQQWIk
   y2Q81PJOmNncf24r5kGWE0X00tqspBslsq80Yoz++MFu42bokWZe0NYcp
   c7pqFBxZzwkVXz9xQTneMyVyjIYN9NEEKcpyBbYY8pLlKR5vl7Jgqt4iy
   BgalEGs2RvPHAntypTni1qLISHk8/lFSDPGRskTAZArX8wr46UqjDCewl
   Ccdw3u3Yb25AAWWXkOYi7ic2qVKcxDKSGGuZgLtgmYCctnmj359w7+HXj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299153654"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="299153654"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="611688312"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:44 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 09/11] perf test: test_intel_pt.sh: Add more output in preparation for more tests
Date:   Mon, 12 Sep 2022 11:34:10 +0300
Message-Id: <20220912083412.7058-10-adrian.hunter@intel.com>
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

When there are more tests it won't be obvious which test failed. Add more
output so that it is.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 7d2f3136ce19..2d489de9097b 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -37,12 +37,19 @@ trap trap_cleanup EXIT TERM INT
 
 can_cpu_wide()
 {
-	perf record -o "${tmpfile}" -B -N --no-bpf-event -e dummy:u -C "$1" true >/dev/null 2>&1 || return 2
+	echo "Checking for CPU-wide recording on CPU $1"
+	if ! perf record -o "${tmpfile}" -B -N --no-bpf-event -e dummy:u -C "$1" true >/dev/null 2>&1 ; then
+		echo "No so skipping"
+		return 2
+	fi
+	echo OK
 	return 0
 }
 
 test_system_wide_side_band()
 {
+	echo "--- Test system-wide sideband ---"
+
 	# Need CPU 0 and CPU 1
 	can_cpu_wide 0 || return $?
 	can_cpu_wide 1 || return $?
@@ -54,6 +61,7 @@ test_system_wide_side_band()
 	mmap_cnt=$(perf script -i "${perfdatafile}" --no-itrace --show-mmap-events -C 1 2>/dev/null | grep -c MMAP)
 
 	if [ "${mmap_cnt}" -gt 0 ] ; then
+		echo OK
 		return 0
 	fi
 
@@ -80,6 +88,8 @@ test_system_wide_side_band || ret=$? ; count_result $ret
 
 cleanup
 
+echo "--- Done ---"
+
 if [ ${err_cnt} -gt 0 ] ; then
 	exit 1
 fi
-- 
2.25.1

