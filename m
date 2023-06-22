Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589B5739E46
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjFVKS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjFVKSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:18:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 894B111C;
        Thu, 22 Jun 2023 03:18:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDCCC1042;
        Thu, 22 Jun 2023 03:19:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01EC73F64C;
        Thu, 22 Jun 2023 03:18:18 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, spoorts2@in.ibm.com
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tests: Fix test_arm_callgraph_fp variable expansion
Date:   Thu, 22 Jun 2023 11:18:09 +0100
Message-Id: <20230622101809.2431897-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$TEST_PROGRAM is a command with spaces so it's supposed to be word
split. The referenced fix to fix the shellcheck warnings incorrectly
quoted this string so unquote it to fix the test.

At the same time silence the shellcheck warning for that line and fix
two more shellcheck errors at the end of the script.

Fixes: 1bb17b4c6c91 ("perf tests arm_callgraph_fp: Address shellcheck warnings about signal names and adding double quotes for expression")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/test_arm_callgraph_fp.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index 1380e0d12dce..66dfdfdad553 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -15,7 +15,8 @@ cleanup_files()
 trap cleanup_files EXIT TERM INT
 
 # Add a 1 second delay to skip samples that are not in the leaf() function
-perf record -o "$PERF_DATA" --call-graph fp -e cycles//u -D 1000 --user-callchains -- "$TEST_PROGRAM" 2> /dev/null &
+# shellcheck disable=SC2086
+perf record -o "$PERF_DATA" --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
 PID=$!
 
 echo " + Recording (PID=$PID)..."
@@ -33,8 +34,8 @@ wait $PID
 # 	76c leafloop
 # ...
 
-perf script -i $PERF_DATA -F comm,ip,sym | head -n4
-perf script -i $PERF_DATA -F comm,ip,sym | head -n4 | \
+perf script -i "$PERF_DATA" -F comm,ip,sym | head -n4
+perf script -i "$PERF_DATA" -F comm,ip,sym | head -n4 | \
 	awk '{ if ($2 != "") sym[i++] = $2 } END { if (sym[0] != "leaf" ||
 						       sym[1] != "parent" ||
 						       sym[2] != "leafloop") exit 1 }'
-- 
2.34.1

