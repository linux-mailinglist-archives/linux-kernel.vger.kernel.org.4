Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A54675497
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjATMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjATMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D0C2C656;
        Fri, 20 Jan 2023 04:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218116; x=1705754116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2X57CfR6KCOC5jRYy3gQh0I2KsDNwZmyV484WgF/6tY=;
  b=BaORSXNNCFyV3Ccjgv66binl9puWXuicV6Mc+xyypNEgXuIy3Rlsdq4k
   C1Mgs/GbZH+bwZAAMMgzeklo2mJ0x6D+V/yIiksMznAdouV/93HvbtODr
   Q57dvr0StG76aGbqYxrqU1caPbGoHyFqityXpUbe+7Jx5xDivrAFGU6I3
   wVjHIKpDAVXVGDQIX1NEhMUa0t5M8tEqRI62q77Hu/VlROokImeL5wXXZ
   58BxOXtwNmGgz9FRURO+jMffAsbQlVOJbRhMeqHD8D5AREja4G9TyJuCu
   NTmp4prvrV3g2o+lA7q8LQ2JFYQWnG9iU7uKQDYKP04hsoCokU2dx9IlZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935149"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935149"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847415"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847415"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:13 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 01/10] perf test: Add Symbols test
Date:   Fri, 20 Jan 2023 14:34:47 +0200
Message-Id: <20230120123456.12449-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120123456.12449-1-adrian.hunter@intel.com>
References: <20230120123456.12449-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test to check function symbols do not overlap and are not zero
length.

The main motivation for the test is to make it easier to review changes
to PLT symbol synthesis i.e. changes to dso__synthesize_plt_symbols().

By default the test uses the perf executable as a test DSO, but a
specific DSO can be specified via a new perf test option "--dso".

The test is useful in the following ways:
 - Any DSO can be tested, even ones that do not run on the current
 architecture. For example, using cross-compiled DSOs to see how
 well perf handles different architectures.
 - With verbose > 1 (e.g. -vv), all the symbols are printed, which
 makes it easier to see issues.
 - perf removes duplicate symbols and expands zero-length symbols
 to reach the next symbol, however that is done before adding
 synthesized symbols, so the test is checking those also.

Example:

 $ perf test -v Symbols
  74: Symbols                                                         :
 --- start ---
 test child forked, pid 154918
 Testing /home/user/bin/perf
 Overlapping symbols:
  7d000-7f3a0 g _init
  7d030-7d040 g __printf_chk@plt
 test child finished with -1
 ---- end ----
 Symbols: FAILED!

Note the test fails because perf expands the _init symbol over the PLT
because there are no PLT symbols at that point, but then
dso__synthesize_plt_symbols() creates them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-test.txt |   3 +
 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   3 +
 tools/perf/tests/symbols.c             | 150 +++++++++++++++++++++++++
 tools/perf/tests/tests.h               |   3 +
 5 files changed, 160 insertions(+)
 create mode 100644 tools/perf/tests/symbols.c

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index b329c65d7f40..951a2f262872 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -34,3 +34,6 @@ OPTIONS
 -F::
 --dont-fork::
 	Do not fork child for each test, run all tests within single process.
+
+--dso::
+	Specify a DSO for the "Symbols" test.
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 90fd1eb317bb..fb9ac5dc4079 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -68,6 +68,7 @@ perf-y += perf-time-to-tsc.o
 perf-y += dlfilter-test.o
 perf-y += sigtrap.o
 perf-y += event_groups.o
+perf-y += symbols.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index cfa61493c750..35cc3807cc9e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -31,6 +31,7 @@
 #include "builtin-test-list.h"
 
 static bool dont_fork;
+const char *dso_to_test;
 
 struct test_suite *__weak arch_tests[] = {
 	NULL,
@@ -117,6 +118,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__dlfilter,
 	&suite__sigtrap,
 	&suite__event_groups,
+	&suite__symbols,
 	NULL,
 };
 
@@ -521,6 +523,7 @@ int cmd_test(int argc, const char **argv)
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
 		    "Do not fork for testcase"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
+	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_END()
 	};
 	const char * const test_subcommands[] = { "list", NULL };
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
new file mode 100644
index 000000000000..057b16df6416
--- /dev/null
+++ b/tools/perf/tests/symbols.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/string.h>
+#include <sys/mman.h>
+#include <limits.h>
+#include "debug.h"
+#include "dso.h"
+#include "machine.h"
+#include "thread.h"
+#include "symbol.h"
+#include "map.h"
+#include "util.h"
+#include "tests.h"
+
+struct test_info {
+	struct machine *machine;
+	struct thread *thread;
+};
+
+static int init_test_info(struct test_info *ti)
+{
+	ti->machine = machine__new_host();
+	if (!ti->machine) {
+		pr_debug("machine__new_host() failed!\n");
+		return TEST_FAIL;
+	}
+
+	/* Create a dummy thread */
+	ti->thread = machine__findnew_thread(ti->machine, 100, 100);
+	if (!ti->thread) {
+		pr_debug("machine__findnew_thread() failed!\n");
+		return TEST_FAIL;
+	}
+
+	return TEST_OK;
+}
+
+static void exit_test_info(struct test_info *ti)
+{
+	thread__put(ti->thread);
+	machine__delete(ti->machine);
+}
+
+static void get_test_dso_filename(char *filename, size_t max_sz)
+{
+	if (dso_to_test)
+		strlcpy(filename, dso_to_test, max_sz);
+	else
+		perf_exe(filename, max_sz);
+}
+
+static int create_map(struct test_info *ti, char *filename, struct map **map_p)
+{
+	/* Create a dummy map at 0x100000 */
+	*map_p = map__new(ti->machine, 0x100000, 0xffffffff, 0, NULL,
+			  PROT_EXEC, 0, NULL, filename, ti->thread);
+	if (!*map_p) {
+		pr_debug("Failed to create map!");
+		return TEST_FAIL;
+	}
+
+	return TEST_OK;
+}
+
+static int test_dso(struct dso *dso)
+{
+	struct symbol *last_sym = NULL;
+	struct rb_node *nd;
+	int ret = TEST_OK;
+
+	/* dso__fprintf() prints all the symbols */
+	if (verbose > 1)
+		dso__fprintf(dso, stderr);
+
+	for (nd = rb_first_cached(&dso->symbols); nd; nd = rb_next(nd)) {
+		struct symbol *sym = rb_entry(nd, struct symbol, rb_node);
+
+		if (sym->type != STT_FUNC && sym->type != STT_GNU_IFUNC)
+			continue;
+
+		/* Check for overlapping function symbols */
+		if (last_sym && sym->start < last_sym->end) {
+			pr_debug("Overlapping symbols:\n");
+			symbol__fprintf(last_sym, stderr);
+			symbol__fprintf(sym, stderr);
+			ret = TEST_FAIL;
+		}
+		/* Check for zero-length function symbol */
+		if (sym->start == sym->end) {
+			pr_debug("Zero-length symbol:\n");
+			symbol__fprintf(sym, stderr);
+			ret = TEST_FAIL;
+		}
+		last_sym = sym;
+	}
+
+	return ret;
+}
+
+static int test_file(struct test_info *ti, char *filename)
+{
+	struct map *map = NULL;
+	int ret, nr;
+
+	pr_debug("Testing %s\n", filename);
+
+	ret = create_map(ti, filename, &map);
+	if (ret != TEST_OK)
+		return ret;
+
+	nr = dso__load(map->dso, map);
+	if (nr < 0) {
+		pr_debug("dso__load() failed!\n");
+		ret = TEST_FAIL;
+		goto out_put;
+	}
+
+	if (nr == 0) {
+		pr_debug("DSO has no symbols!\n");
+		ret = TEST_SKIP;
+		goto out_put;
+	}
+
+	ret = test_dso(map->dso);
+out_put:
+	map__put(map);
+
+	return ret;
+}
+
+static int test__symbols(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	char filename[PATH_MAX];
+	struct test_info ti;
+	int ret;
+
+	ret = init_test_info(&ti);
+	if (ret != TEST_OK)
+		return ret;
+
+	get_test_dso_filename(filename, sizeof(filename));
+
+	ret = test_file(&ti, filename);
+
+	exit_test_info(&ti);
+
+	return ret;
+}
+
+DEFINE_SUITE("Symbols", symbols);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index fb4b5ad4dd0f..9a0f3904e53d 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -148,6 +148,7 @@ DECLARE_SUITE(perf_time_to_tsc);
 DECLARE_SUITE(dlfilter);
 DECLARE_SUITE(sigtrap);
 DECLARE_SUITE(event_groups);
+DECLARE_SUITE(symbols);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
@@ -208,4 +209,6 @@ DECLARE_WORKLOAD(sqrtloop);
 DECLARE_WORKLOAD(brstack);
 DECLARE_WORKLOAD(datasym);
 
+extern const char *dso_to_test;
+
 #endif /* TESTS_H */
-- 
2.34.1

