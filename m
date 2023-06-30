Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4396743F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjF3PjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjF3PjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:39:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C84B10F8;
        Fri, 30 Jun 2023 08:39:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4201CD75;
        Fri, 30 Jun 2023 08:39:55 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11A2C3F73F;
        Fri, 30 Jun 2023 08:39:09 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf symbol: Fix uninitialized return value in symbols__find_by_name()
Date:   Fri, 30 Jun 2023 16:38:39 +0100
Message-Id: <20230630153840.858668-1-james.clark@arm.com>
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

found_idx and s aren't initialized, so if no symbol is found then the
assert at the end will index off the end of the array causing a
segfault. The function also doesn't return NULL when the symbol isn't
found even if the assert passes. Fix it by initializing the values and
only setting them when something is found.

Fixes the following test failure:

  $ perf test 1
  1: vmlinux symtab matches kallsyms     : FAILED!

Fixes: 259dce914e93 ("perf symbol: Remove symbol_name_rb_node")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/symbol.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index bc79291b9f3b..f849f9ef68e6 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -495,7 +495,10 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 					    size_t *found_idx)
 {
 	size_t i, lower = 0, upper = symbols_len;
-	struct symbol *s;
+	struct symbol *s = NULL;
+
+	if (found_idx)
+		*found_idx = SIZE_MAX;
 
 	if (!symbols_len)
 		return NULL;
@@ -504,8 +507,7 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 		int cmp;
 
 		i = (lower + upper) / 2;
-		s = symbols[i];
-		cmp = symbol__match_symbol_name(s->name, name, includes);
+		cmp = symbol__match_symbol_name(symbols[i]->name, name, includes);
 
 		if (cmp > 0)
 			upper = i;
@@ -514,10 +516,11 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 		else {
 			if (found_idx)
 				*found_idx = i;
+			s = symbols[i];
 			break;
 		}
 	}
-	if (includes != SYMBOL_TAG_INCLUDE__DEFAULT_ONLY) {
+	if (s && includes != SYMBOL_TAG_INCLUDE__DEFAULT_ONLY) {
 		/* return first symbol that has same name (if any) */
 		for (; i > 0; i--) {
 			struct symbol *tmp = symbols[i - 1];
@@ -525,13 +528,12 @@ static struct symbol *symbols__find_by_name(struct symbol *symbols[],
 			if (!arch__compare_symbol_names(tmp->name, s->name)) {
 				if (found_idx)
 					*found_idx = i - 1;
+				s = tmp;
 			} else
 				break;
-
-			s = tmp;
 		}
 	}
-	assert(!found_idx || s == symbols[*found_idx]);
+	assert(!found_idx || !s || s == symbols[*found_idx]);
 	return s;
 }
 
-- 
2.34.1

