Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7396FA381
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjEHJkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjEHJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:40:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A81C1709;
        Mon,  8 May 2023 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683538834; x=1715074834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sSDUjz0u29bzzq8v6TDWYjblxhEbQSlIDyH3SkiaiiY=;
  b=YfbM8KxdYdwjvwI7cGEVhXhmuI1L1JNoyYTHnDLkmMdlfwRzfvsl9tqT
   4CaltOI815bTsjEcnZ26bEvul2MNlOmlisa8p6I4Ov4mMnFnPfRKUAcFq
   3VBy/luVpPRs+D1Pkyt2kbaCJNDlqkYV/iC223uTwb/cU6pN+vm5wGJUG
   yJEHWjfv64Amp4cWTfuyvUk7V72/2Rs0Yho+RIZnKcGFL4xet45QaFfO2
   DOi1Pw4bbhRruSPvWbbX+w5/WWTuoMwk78FRAgiYfo7qXeogjE4XPm3AN
   6brXv9ZMDCCDW3g33WUXlnUwGpkELbQia3mCZ9emKELEvmMV3xeIt/CcN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329223680"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329223680"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 02:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="1028354989"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="1028354989"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.218.65])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 02:40:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V2 1/2] perf test: test_intel_pt.sh: Test sample mode with event with PMU name
Date:   Mon,  8 May 2023 12:39:51 +0300
Message-Id: <20230508093952.27482-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508093952.27482-1-adrian.hunter@intel.com>
References: <20230508093952.27482-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

br_misp_retired.all_branches is supported on processors that support
Intel PT, so use it to test sample mode with an event that has been given
a PMU name.

Please note, the test fails prior to the fix "perf parse-events: Do not
break up AUX event group".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 4ddb17cb83c5..3a8b9bffa022 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -506,6 +506,13 @@ test_sample()
 		echo "perf record failed with --aux-sample"
 		return 1
 	fi
+	# Check with event with PMU name
+	if perf_record_no_decode -o "${perfdatafile}" -e br_misp_retired.all_branches:u uname ; then
+		if ! perf_record_no_decode -o "${perfdatafile}" -e '{intel_pt//,br_misp_retired.all_branches/aux-sample-size=8192/}:u' uname ; then
+			echo "perf record failed with --aux-sample-size"
+			return 1
+		fi
+	fi
 	echo OK
 	return 0
 }
-- 
2.34.1

