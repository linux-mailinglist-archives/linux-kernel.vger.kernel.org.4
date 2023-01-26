Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C2867D591
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjAZTms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjAZTmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:42:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACCD10A96;
        Thu, 26 Jan 2023 11:42:35 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j5so2510653pjn.5;
        Thu, 26 Jan 2023 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BuaqGXOr0ykBCTuoaAAMQk3i6JDBx0lzbqRkLeeKldg=;
        b=hbza4nhDguQDOSfw6mb7peB+5XpyN67HuIOoylMEKAFEf0fCdq5s/kohRNVhHg9l68
         z6bKNCHMV+z5vbNYwKth07Jx5yS7a+A5GGqzw0uDzwGzGOP2PQNy9kdlcrPV5nXzZks/
         8lK2XZdzD+o4w4G2VfH1A4+r3xiH/ECahluzrVcSjQRbY0+GgZzcikHjyiLQIG52VziD
         sjyZE4tcN6tG0wdXXwObOZCMG2h6YdcO10deqzmazbcqoj/kbLpqSIBvO6OA0+ysQuUm
         10tej21AD1+wvLotjIdc7kT1DJORb0xnLTrg3apvOOp4H+/kmn+xafZteofhAlGAocHq
         Y5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuaqGXOr0ykBCTuoaAAMQk3i6JDBx0lzbqRkLeeKldg=;
        b=NMcUrnZm6VsxUxrSktikcoftmN6ljqbiDu/vcPmMz1z31eGCzMWfiLRJVMaSJqRUdA
         6WReHRFwD7NKqq08cMvFSlcNHltuvF7hA6aGo7lX3jfNVrdzHtQFX/ZQcHdiPfzDDniE
         3BPG8xhdRFtB6aayZzUgX27q8SKBC2eKcu1Zs0DLJT4kRa1VxnuPR8R29+jX/l12ycAY
         iyp5bpHpwreZlgRWYWGgCdSrr0H+i6cvS+9FKdZ20GBSlfbTZdPrWmXfxXnf7PTzWleI
         KIMezCXNBfd3L8QHqBSudQ6cidxSEYtoZW+uXBpt8ih4+owvk61Qu0xqNZDLr53ta4nW
         AQmw==
X-Gm-Message-State: AFqh2krm+lPrseMWq6svIbDibBf4jUGabV4dcW6i1OLIA/VyVip6mig0
        UCnmm+KGhLXj5OnCT8fmdtk=
X-Google-Smtp-Source: AMrXdXt4etOhvMJDbSwS/e6LkG8PqVZ4j72ffOhxh4TBixgd7wyLwWhMxf7TJMMAA1w5bThI6wSRMw==
X-Received: by 2002:a05:6a20:6725:b0:b8:587f:e0ad with SMTP id q37-20020a056a20672500b000b8587fe0admr37937551pzh.29.1674762154558;
        Thu, 26 Jan 2023 11:42:34 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:1f5d:eee8:d409:8a17])
        by smtp.gmail.com with ESMTPSA id o13-20020a637e4d000000b004cd2eebc551sm1032286pgn.62.2023.01.26.11.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:42:33 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH] perf script: Add 'cgroup' field for output
Date:   Thu, 26 Jan 2023 11:42:30 -0800
Message-Id: <20230126194230.3339019-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no field for the cgroup, let's add one.  To do that, users need to
specify --all-cgroup option for perf record to capture the cgroup info.

  $ perf record --all-cgroups -- true

  $ perf script -F comm,pid,cgroup
            true 337112  /user.slice/user-657345.slice/user@657345.service/...
            true 337112  /user.slice/user-657345.slice/user@657345.service/...
            true 337112  /user.slice/user-657345.slice/user@657345.service/...
            true 337112  /user.slice/user-657345.slice/user@657345.service/...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 8d77182fbf31..82c4dcb9c42e 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -134,7 +134,7 @@ OPTIONS
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
         brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
         phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
-        machine_pid, vcpu.
+        machine_pid, vcpu, cgroup.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69394ac0a20d..79976dde99b3 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -59,6 +59,7 @@
 #include "util/dlfilter.h"
 #include "util/record.h"
 #include "util/util.h"
+#include "util/cgroup.h"
 #include "perf.h"
 
 #include <linux/ctype.h>
@@ -130,6 +131,7 @@ enum perf_output_field {
 	PERF_OUTPUT_BRSTACKINSNLEN  = 1ULL << 36,
 	PERF_OUTPUT_MACHINE_PID     = 1ULL << 37,
 	PERF_OUTPUT_VCPU            = 1ULL << 38,
+	PERF_OUTPUT_CGROUP          = 1ULL << 39,
 };
 
 struct perf_script {
@@ -200,6 +202,7 @@ struct output_option {
 	{.str = "brstackinsnlen", .field = PERF_OUTPUT_BRSTACKINSNLEN},
 	{.str = "machine_pid", .field = PERF_OUTPUT_MACHINE_PID},
 	{.str = "vcpu", .field = PERF_OUTPUT_VCPU},
+	{.str = "cgroup", .field = PERF_OUTPUT_CGROUP},
 };
 
 enum {
@@ -2220,6 +2223,17 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(CODE_PAGE_SIZE))
 		fprintf(fp, " %s", get_page_size_name(sample->code_page_size, str));
 
+	if (PRINT_FIELD(CGROUP)) {
+		const char *cgrp_name;
+		struct cgroup *cgrp = cgroup__find(machine->env,
+						   sample->cgroup);
+		if (cgrp != NULL)
+			cgrp_name = cgrp->name;
+		else
+			cgrp_name = "unknown";
+		fprintf(fp, " %s", cgrp_name);
+	}
+
 	perf_sample__fprintf_ipc(sample, attr, fp);
 
 	fprintf(fp, "\n");
@@ -3856,7 +3870,7 @@ int cmd_script(int argc, const char **argv)
 		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
 		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
 		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
-		     "code_page_size,ins_lat",
+		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.39.1.456.gfc5497dd1b-goog

