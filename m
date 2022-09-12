Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2B5B564A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiILIeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiILIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:34:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F611A;
        Mon, 12 Sep 2022 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662971666; x=1694507666;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jUWs7b1wiwhbL79/C/zNbX3tOcTeD7M8gF3DAD9mbgg=;
  b=UTiUJXWAgoDpnGlNgtH0I88SukxygP3n7TbObJKJ+CLS+dlaoBqq8AWG
   8m2hzxJiNiLjSwrBoMmxXycsZ/Jj7MkiKZgHkRLJnptslSMazBFu9vsoi
   4P1I9mFa+C+9O5UMUh4qgO4RxEwI+wGLf5lo6RXtVD8J18UcuAmeXCDe+
   PoiKHCFAztGeDw4cPXXTgOtPRKG8sicapWFplYKPOaghtjeXZ6xXzZkAp
   ntyYboFrc+DNfgWeT3Mf1h48SDVfDg7VlBLDB/wjpc2kM0wmHGe317Na3
   jrxn3BHikiV9t1SrPNzdelLDPBn1mILscVMZ+66GMG0cEGZIrFn1CAzDG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299153602"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="299153602"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="611688229"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 00/11] perf test: test_intel_pt.sh: Add per-thread test
Date:   Mon, 12 Sep 2022 11:34:01 +0300
Message-Id: <20220912083412.7058-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
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

Hi

Here is a new per-thread test for the test_intel_pt.sh test script.

The first 9 patches are tidy-ups for the script, mostly based on results
from the shellcheck utility.

The 10th patch adds debug prints that the script will capture to help
verify correct operation.

The final patch actually adds the new test.


Adrian Hunter (11):
      perf test: test_intel_pt.sh: Add cleanup function
      perf test: test_intel_pt.sh: Use a temp directory
      perf test: test_intel_pt.sh: Fix redirection
      perf test: test_intel_pt.sh: Stop using expr
      perf test: test_intel_pt.sh: Stop using backticks
      perf test: test_intel_pt.sh: Use grep -c instead of grep plus wc -l
      perf test: test_intel_pt.sh: Use quotes around variable expansion
      perf test: test_intel_pt.sh: Fix return checking
      perf test: test_intel_pt.sh: Add more output in preparation for more tests
      perf tools: Add debug messages and comments for testing
      perf test: test_intel_pt.sh: Add per-thread test

 tools/lib/perf/evlist.c                 |   2 +
 tools/perf/builtin-record.c             |   8 +
 tools/perf/tests/shell/test_intel_pt.sh | 307 ++++++++++++++++++++++++++++++--
 tools/perf/util/evsel.c                 |   2 +
 4 files changed, 304 insertions(+), 15 deletions(-)


Regards
Adrian
