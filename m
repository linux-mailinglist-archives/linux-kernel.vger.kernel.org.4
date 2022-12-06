Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3075644846
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiLFPpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiLFPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:45:06 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C87025C40
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:45:05 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c17so12292556edj.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 07:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCyYEDdk48a97hpw9YC0wE8Nlhmp8Q++xOxdXcadzbs=;
        b=NiLxwO/0bp0WunO9gq3XKg8VcYxoMCMAKVyqAt+Q+vWLfQDIPCk0OQdrwSCYdEmiTq
         f7x1L67s9CTH3Fh9C1To83Yv+WjGdf3zKa/TrgdAkznM730r6YQqrk3ON14f+P3jjZgs
         TWGshhqKTGeCFQ5vGSXP1F2oDbG6zQechMT4l+YnedWpO0AUSW+1UZ0rIePeWBK73bRQ
         Ei6Lk4+T8qZwCIBaoFqGtr1/7ckBZtI8Ec1XEJxxHN8Mz3whzHBkdfLBXlry+JOh5Bux
         USImqJ1yf1lDj4JYAtILLiSDNrCJSexU+oCbhuV7xI34CHPFuNMDsurSoEcnJMCYGJzk
         y2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCyYEDdk48a97hpw9YC0wE8Nlhmp8Q++xOxdXcadzbs=;
        b=mv7XcLLnVHatZDh6ny7mYZfzb7l6WHKnWCOCy3GleosCOIRFTokI31rnMN7TDJ5zKk
         7WdnW2uL+9nY/5429ay56b9IY7LThVMf+RyWiKQJizxdrHchs3Q7L2en90UCUt2Xv5l3
         qywO/90e9cF00ABa59PgFI7MCbl7JTPbwigRm9sfSPRqJWwDHHxy4r1Q1/akpY9qLU2n
         5jZH/Z6IogUneeiNkSrp6P4433UmPBsXrefznzNlD66DQwBRTzuClve5l5AZcU1wRdbZ
         iDECuPF6ULmLIUxP8izi85j+e5ukV3eyVC8CVH56BOnphjcXlbjZp8fU1LJfgUCfB0QO
         jRbA==
X-Gm-Message-State: ANoB5pkG5LZzdmzF+hHknaqA4uPpWAVj1FtuSciSYw5JRySMHrMQ48lZ
        9csPEXw3it/OIlOpdFjF8iK/0eDsoHfJLRw7Poo=
X-Google-Smtp-Source: AA0mqf68oOBytkxtQFD34KJhYuLKYHs9z8e8clNW8vrMWNHTwuI+73ti5ymsYD4mhPAEN22zTKFFTg==
X-Received: by 2002:a05:6402:2b91:b0:457:23cb:20ab with SMTP id fj17-20020a0564022b9100b0045723cb20abmr12866448edb.254.1670341503568;
        Tue, 06 Dec 2022 07:45:03 -0800 (PST)
Received: from localhost.localdomain ([86.48.7.22])
        by smtp.gmail.com with ESMTPSA id vs21-20020a170907139500b007c0ae137404sm6595550ejb.97.2022.12.06.07.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:45:03 -0800 (PST)
From:   Petar Gligoric <petar.gligor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 3/3] perf test: add new task-analyzer tests
Date:   Tue,  6 Dec 2022 10:44:06 -0500
Message-Id: <20221206154406.41941-4-petar.gligor@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206154406.41941-1-petar.gligor@gmail.com>
References: <20221206154406.41941-1-petar.gligor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petar Gligoric <petar.gligoric@rohde-schwarz.com>

Provide task-analyzer test cases for all possible arguments and a subset of possible
combinations.

12 Tests in total.

test_basic:
 - cmd:"perf script report task-analyzer"
 - Fundamental test of script without arguments.
 - Check for standard output.

test_ns_rename:
 - cmd:"perf script report task-analyzer --ns --rename-comms-by-tids 0:random"
 - Standard task with timestamps in nanoseconds and comm renamed.
 - Check for standard output.

test_ms_filtertasks_highlight:
 - cmd:"perf script report task-analyzer --ms --filter-tasks perf --highlight-tasks perf"
 - Standard task with timestamps in milliseconds, task filtered out and highlighted.
 - Check for standard output.

test_extended_times_timelimit_limittasks:
 - cmd "perf script report task-analyzer --extended-times --time-limit :99999"
 - Standard task with additional schedule out/in info and timlimit active at 99999.
 - Check for extended table output.

test_summary:
 - cmd:"perf script report task-analyzer --summary"
 - Standard task with additional summary output.
 - Check for summary print.

test_summary_extended:
 - cmd:"perf script report task-analyzer --summary-extended"
 - Standard task with summary and additional schedule in/out info.
 - Chceck for extended table print.

test_summaryonly:
 - cmd:"perf script report task-analyzer --summary-only"
 - Only summary should be printed.
 - Check for summary print.

test_extended_times_summary_ns:
 - cmd:"perf script report task-analyzer --extended-times --summary --ns"
 - Standard task with extended schedule in/out information and summary in ns.
 - Check for extended table and summary.

test_csv:
 - cmd:"perf script report task-analyzer --csv csv"
 - Print standard task to csv file in csv format.
 - Check for csv format.

test_csv_extended_times:
 - cmd:"perf script report task-analyzer --csv csv --extended-times"
 - Print standard task to csv file in csv format with additional schedule in/out
   information.
 - Check for additional information and csv format.

test_csvsummary:
 - cmd:"perf script report task-analyzer --csv-summary csvsummary"
 - Print summary to csvsummary file in csv format.
 - Check for csv format.

test_csvsummary_extended:
 - cmd:"perf script report task-analyzer --csv-summary csvsummary --summary-extended"
 - Print summary to csvsummary file in csv format with additional schedule in/out
   information.
 - Check for additional information and csv format.

Signed-off-by: Petar Gligoric <petar.gligoric@rohde-schwarz.com>
Signed-off-by: Hagen Paul Pfeifer <hagen@jauu.net>
Suggested-by: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_task_analyzer.sh | 151 +++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_task_analyzer.sh

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
new file mode 100755
index 000000000000..a98e4ab66040
--- /dev/null
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -0,0 +1,151 @@
+#!/bin/bash
+# perf script task-analyzer tests
+# SPDX-License-Identifier: GPL-2.0
+
+tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
+err=0
+
+cleanup() {
+  rm -f perf.data
+  rm -f perf.data.old
+  rm -f csv
+  rm -f csvsummary
+  rm -rf $tmpdir
+  trap - exit term int
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup exit term int
+
+report() {
+	if [ $1 = 0 ]; then
+		echo "PASS: \"$2\""
+	else
+		echo "FAIL: \"$2\" Error message: \"$3\""
+		err=1
+	fi
+}
+
+check_exec_0() {
+	if [ $? != 0 ]; then
+		report 1 "invokation of ${$1} command failed"
+	fi
+}
+
+find_str_or_fail() {
+	grep -q "$1" $2
+	if [ $? != 0 ]; then
+		report 1 $3 "Failed to find required string:'${1}'."
+	else
+		report 0 $3
+	fi
+}
+
+prepare_perf_data() {
+	# 1s should be sufficient to catch at least some switches
+	perf record -e sched:sched_switch -a -- sleep 1 > /dev/null 2>&1
+}
+
+# check standard inkvokation with no arguments
+test_basic() {
+	out="$tmpdir/perf.out"
+	perf script report task-analyzer > $out
+	check_exec_0 "perf"
+	find_str_or_fail "Comm" $out ${FUNCNAME[0]}
+}
+
+test_ns_rename(){
+	out="$tmpdir/perf.out"
+	perf script report task-analyzer --ns --rename-comms-by-tids 0:random > $out
+	check_exec_0 "perf"
+	find_str_or_fail "Comm" $out ${FUNCNAME[0]}
+}
+
+test_ms_filtertasks_highlight(){
+	out="$tmpdir/perf.out"
+	perf script report task-analyzer --ms --filter-tasks perf --highlight-tasks perf \
+	> $out
+	check_exec_0 "perf"
+	find_str_or_fail "Comm" $out ${FUNCNAME[0]}
+}
+
+test_extended_times_timelimit_limittasks() {
+	out="$tmpdir/perf.out"
+	perf script report task-analyzer --extended-times --time-limit :99999 \
+	--limit-to-tasks perf > $out
+	check_exec_0 "perf"
+	find_str_or_fail "Out-Out" $out ${FUNCNAME[0]}
+}
+
+test_summary() {
+	out="$tmpdir/perf.out"
+	perf script report task-analyzer --summary > $out
+	check_exec_0 "perf"
+	find_str_or_fail "Summary" $out ${FUNCNAME[0]}
+}
+
+test_summaryextended() {
+	out="$tmpdir/perf.out"
+	perf script report task-analyzer --summary-extended > $out
+	check_exec_0 "perf"
+	find_str_or_fail "Inter Task Times" $out ${FUNCNAME[0]}
+}
+
+test_summaryonly() {
+	out="$tmpdir/perf.out"
+	perf script report task-analyzer --summary-only > $out
+	check_exec_0 "perf"
+	find_str_or_fail "Summary" $out ${FUNCNAME[0]}
+}
+
+test_extended_times_summary_ns() {
+	out="$tmpdir/perf.out"
+	perf script report task-analyzer --extended-times --summary --ns > $out
+	check_exec_0 "perf"
+	find_str_or_fail "Out-Out" $out ${FUNCNAME[0]}
+	find_str_or_fail "Summary" $out ${FUNCNAME[0]}
+}
+
+test_csv() {
+	perf script report task-analyzer --csv csv > /dev/null
+	check_exec_0 "perf"
+	find_str_or_fail "Comm;" csv ${FUNCNAME[0]}
+}
+
+test_csv_extended_times() {
+	perf script report task-analyzer --csv csv --extended-times > /dev/null
+	check_exec_0 "perf"
+	find_str_or_fail "Out-Out;" csv ${FUNCNAME[0]}
+}
+
+test_csvsummary() {
+	perf script report task-analyzer --csv-summary csvsummary > /dev/null
+	check_exec_0 "perf"
+	find_str_or_fail "Comm;" csvsummary ${FUNCNAME[0]}
+}
+
+test_csvsummary_extended() {
+	perf script report task-analyzer --csv-summary csvsummary --summary-extended \
+	>/dev/null
+	check_exec_0 "perf"
+	find_str_or_fail "Out-Out;" csvsummary ${FUNCNAME[0]}
+}
+
+prepare_perf_data
+test_basic
+test_ns_rename
+test_ms_filtertasks_highlight
+test_extended_times_timelimit_limittasks
+test_summary
+test_summaryextended
+test_summaryonly
+test_extended_times_summary_ns
+test_csv
+test_csvsummary
+test_csv_extended_times
+test_csvsummary_extended
+cleanup
+exit $err
-- 
2.30.2

