Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0D63D41F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiK3LPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiK3LPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:15:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D86DB2791F;
        Wed, 30 Nov 2022 03:15:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1480D6E;
        Wed, 30 Nov 2022 03:15:40 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FF2E3F73B;
        Wed, 30 Nov 2022 03:15:32 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] perf tests: Fix "perf stat JSON output linter" test for new output
Date:   Wed, 30 Nov 2022 11:15:20 +0000
Message-Id: <20221130111521.334152-1-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c4b41b83c250 ("perf stat: Rename "aggregate-number" to
"cpu-count" in JSON") renamed a field, so update the tests to reflect
this.

This fixes the following failure:

  $ sudo ./perf test "json output" -vvv
   96: perf stat JSON output linter                                    :
  --- start ---
  test child forked, pid 327720
  Checking json output: no args [Success]
  Checking json output: system wide [Success]
  Checking json output: interval [Success]
  Checking json output: event [Success]
  Checking json output: per thread [Success]
  Checking json output: per node Test failed for input:
  ...
  Traceback (most recent call last):
    File "./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 93, in <module>
      check_json_output(expected_items)
    File "./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 78, in check_json_output
      raise RuntimeError(f'Unexpected key: key={key} value={value}')
  RuntimeError: Unexpected key: key=cpu-count value=16
  test child finished with -1
  ---- end ----
  perf stat JSON output linter: FAILED!

Fixes: c4b41b83c250 ("perf stat: Rename "aggregate-number" to "cpu-count" in JSON")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index d90f8d102eb9..9c073e257d33 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -54,7 +54,7 @@ def check_json_output(expected_items):
           raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
                              f' in \'{line}\'')
   checks = {
-      'aggregate-number': lambda x: isfloat(x),
+      'cpu-count': lambda x: isfloat(x),
       'core': lambda x: True,
       'counter-value': lambda x: is_counter_value(x),
       'cgroup': lambda x: True,
-- 
2.25.1

