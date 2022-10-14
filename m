Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4075FF2BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiJNRJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiJNRJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:09:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F91A2F7;
        Fri, 14 Oct 2022 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665767375; x=1697303375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lAd0o379HfkSn8aHAVMv65Af3jNDxH5nPEb/kxUyFvs=;
  b=HAgrlFexjV9+JjH6PwN5N18gbubqvuUHpdwM9AV13nYnZmS3u0BVjKc+
   qMDo/FRR70fmFVxmP0usaNN683K6u03q2HShQ3IWeoaiLCMgmgu5Sj12N
   0kb3mHBEAQDz4l+ST9MEQT34hoP4C7+6roiH9SJ/ssrfwXmFO8nc9fTlt
   U12PKxOiXt8MEC+NcGD3jTV0mTVikkG56hCYFwKDEPUjiV1r5ZpZOjx4G
   ufvcJO/bPmlbA6Vwg0XJCzKyaoVvKhL/SOE6OqcoCDzkPW1MROjKz6hHS
   ZH1JgKs+IgMg7hG2RC+J/yu2+LAsy92DZrfgsFB72j97ZjqvtWhtMiwhS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="303041981"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="303041981"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="696376948"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="696376948"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.43.79])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/7] perf test: test_intel_pt.sh: Print a message when skipping kernel tracing
Date:   Fri, 14 Oct 2022 20:09:01 +0300
Message-Id: <20221014170905.64069-4-adrian.hunter@intel.com>
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

Messages display with the perf test -v option. Add a message to show when
skipping a test because the user cannot do kernel tracing.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 334836f92bdc..9c746ff1c4d2 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -117,7 +117,14 @@ test_system_wide_side_band()
 
 can_kernel()
 {
-	perf_record_no_decode -o "${tmpfile}" -e dummy:k true >/dev/null 2>&1 || return 2
+	if [ -z "${can_kernel_trace}" ] ; then
+		can_kernel_trace=0
+		perf_record_no_decode -o "${tmpfile}" -e dummy:k true >/dev/null 2>&1 && can_kernel_trace=1
+	fi
+	if [ ${can_kernel_trace} -eq 0 ] ; then
+		echo "SKIP: no kernel tracing"
+		return 2
+	fi
 	return 0
 }
 
-- 
2.25.1

