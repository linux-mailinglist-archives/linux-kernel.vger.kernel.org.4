Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB6A5B5650
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiILIfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiILIek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:34:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809E52DF6;
        Mon, 12 Sep 2022 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662971677; x=1694507677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sG0EKmdS1Nv+reiqvP3unM1JN2nbO7x3UkOs1kKBZEk=;
  b=VQc+Bggim8empXWIBhUIQE/NYQYr5UeEdVcgyH6+IqJ/gRyv9PRhKa7b
   lFUtKgOJnNCQLGciRz+9uIRin2mDOx2oCqOExFvO4Qms2Ko/0RO4nPGMz
   pMTHn7KZkXSXWWL4lQBUDD+2CH6pxtizhLcY3yeGsrF4d68GmBDhqYLL3
   dJh5zB6F9Z7ZDN9bWp4KNY+Upr2bPs94UQ3sMAiTi1Zt86wPNpMnsSevC
   lY+H0SZmYmzE6uvHA+jEIuf6SviNBWURTybKKmrjfBlsbdjEG5MNNHJBq
   DERcQInWeU8RvE7D377VhViqW4DTYuF3lryKWa2GT+EJBrp8fql+PoD0Y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299153633"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="299153633"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="611688282"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 05/11] perf test: test_intel_pt.sh: Stop using backticks
Date:   Mon, 12 Sep 2022 11:34:06 +0300
Message-Id: <20220912083412.7058-6-adrian.hunter@intel.com>
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

As suggested by shellcheck, stop using backticks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 2be8cb03a620..0273332b99e9 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -51,7 +51,7 @@ test_system_wide_side_band()
 	perf record -B -N --no-bpf-event -o ${perfdatafile} -e intel_pt//u -C 0 -- taskset --cpu-list 1 uname
 
 	# Should get MMAP events from CPU 1 because they can be needed to decode
-	mmap_cnt=`perf script -i ${perfdatafile} --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`
+	mmap_cnt=$(perf script -i ${perfdatafile} --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l)
 
 	if [ ${mmap_cnt} -gt 0 ] ; then
 		return 0
-- 
2.25.1

