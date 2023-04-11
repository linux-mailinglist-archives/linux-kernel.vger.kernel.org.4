Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0636DD71C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjDKJtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDKJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:49:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E99810E5;
        Tue, 11 Apr 2023 02:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681206545; x=1712742545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dHpcHWqCmfuIUPq8eG8tFeW/285bASnK1zbDtw4BpTc=;
  b=iXtfGBSDgoKwDSevaFYQtSPQ/WVCIOfxbeyKG6UWDSUXC6U3D6MN+cA7
   Tf5722Pgr5lBoXpTIoVv8K5cmdFeaDXkRxColVwplNFnnakpFLwdUH2wR
   67v0bgsQ50bWbnDCILa0DIVInHpSX5anIXcqkaRi+r//hTjMDy3C9Abpg
   Z/7zYUr/YFMoNf+PPyUjADPGU8bMNk+jnA+pm7es/i8mog6WxLQF1gfDL
   AmTdZ7PAb2bWFnH//dIZmQko76H0WHUKetq5zU9XrGWXMC9cJ5UeaCO5k
   DLRcTKVO3CujkBMCsiZDfLxt+fo0OzTtSjFWzPpc5620Klor3E+niuWOT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="343579220"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343579220"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 02:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757768815"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="757768815"
Received: from 9049fa088b1f.jf.intel.com ([10.165.154.143])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2023 02:45:29 -0700
From:   tinghao.zhang@intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, kan.liang@linux.intel.com,
        Tinghao Zhang <tinghao.zhang@intel.com>,
        Yi Ammy <ammy.yi@intel.com>
Subject: [PATCH] perf tests: Fix tests in 'Parse event definition strings'
Date:   Tue, 11 Apr 2023 02:43:30 -0700
Message-Id: <20230411094330.653965-1-tinghao.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tinghao Zhang <tinghao.zhang@intel.com>

The 'Test event parsing' test set under 'Parse event definion strings'
does not apply to hybrid events. Since hybrid events have a dedicated
test set 'Test parsing of hybrid CPU events', skip these tests on hybrid
platforms.

Fixes: 7741e03e808a ("perf test: Parse events break apart tests")
Reported-by: Yi Ammy <ammy.yi@intel.com>
Signed-off-by: Tinghao Zhang <tinghao.zhang@intel.com>
---
 tools/perf/tests/parse-events.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 71a5cb343311..c6949e458e61 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2146,6 +2146,9 @@ static int test_events(const struct evlist_test *events, int cnt)
 
 static int test__events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
+	if (perf_pmu__has_hybrid())
+		return TEST_SKIP;
+
 	return test_events(test__events, ARRAY_SIZE(test__events));
 }
 
@@ -2421,7 +2424,7 @@ static int test__pmu_events_alias2(struct test_suite *test __maybe_unused,
 static struct test_case tests__parse_events[] = {
 	TEST_CASE_REASON("Test event parsing",
 			 events2,
-			 "permissions"),
+			 "permissions or hybrid"),
 	TEST_CASE_REASON("Test parsing of \"hybrid\" CPU events",
 			 hybrid,
 			"not hybrid"),
-- 
2.34.1

