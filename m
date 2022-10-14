Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CF65FF2BA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiJNRJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiJNRJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:09:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8491C1119FA;
        Fri, 14 Oct 2022 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665767370; x=1697303370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jUrjMM7Alwl5r3W2FcMRVxujVyEHUtZGS+tz5iNw/vk=;
  b=LouiBfqRHfInu7ezLdXFLIwptCPgcH8/dChsSNyir1ct55Tni4kVQKGq
   UWJzpXw6C7mhDiS7nayl94gVFHLfAXd+cKTEwZiXiU/Zd93vI64xbpSSz
   E9MWKUK1H6/aiB+wakUG8HEFPMNTzAYPMRjch5THMGaQD/SbPIXl0ewIx
   oKsf1AA+LkCgpcCUDRuBa3vpea+WF2BlXGH6DKMSBwFH8rzgmSrxta/hJ
   uiuynIJHDHjp+msS36703UB9oXPl/MDvEB+3x+wf9oG82k7K8ZuR5vsR/
   7c54K/jpRjZJ47Xqb4Xe7KM+Ad61hNCpCdH8o8imtA5bRihhtVOZtw6gL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="303041969"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="303041969"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="696376922"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="696376922"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.43.79])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 10:09:28 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/7] perf test: test_intel_pt.sh: Fix return checking again
Date:   Fri, 14 Oct 2022 20:08:59 +0300
Message-Id: <20221014170905.64069-2-adrian.hunter@intel.com>
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

count_result() does not always reset ret=0 which means the value can spill
into the next test result.

Fix by explicitly setting it to zero between tests.

Fixes: fd9b45e39cfa ("perf test: test_intel_pt.sh: Fix return checking")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index efaad9566c34..4609a24c9340 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -265,13 +265,12 @@ count_result()
 		return
 	fi
 	err_cnt=$((err_cnt + 1))
-	ret=0
 }
 
 ret=0
-test_system_wide_side_band || ret=$? ; count_result $ret
-test_per_thread "" "" || ret=$? ; count_result $ret
-test_per_thread "k" "(incl. kernel) " || ret=$? ; count_result $ret
+test_system_wide_side_band || ret=$? ; count_result $ret ; ret=0
+test_per_thread "" "" || ret=$? ; count_result $ret ; ret=0
+test_per_thread "k" "(incl. kernel) " || ret=$? ; count_result $ret ; ret=0
 
 cleanup
 
-- 
2.25.1

