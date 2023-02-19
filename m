Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC21269BF6E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBSJ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjBSJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:29:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D473112059
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:29:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 124-20020a250482000000b0090f2c84a6a4so2099150ybe.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iXfoLKVrMT/xFDAU9J/MJSSK5kW91sU/HJUqY9Ndk9k=;
        b=hvIt7PlPUa96zxgL3OClxpS1XAsvx3NC/q+W9HuZaXdVTFcPF5mhHBBPgrxNo/plkE
         8SQgtmTt3OY+IeyeApAVO5G8qepG4VqMq1Rr0Pbx4PYZOqQAt6FIvLde6bhwNblKTjVK
         t3obfWfpr+KpqjPHIHR7LnqVww4FgJg5b5kXeSn61Ikf4P4eddPaykia8uJeA3rCltTk
         Ui4vESOwkX8LRuB+I4RbXOQOgqoMW16sEo1RhpbJ9scKV16Vp/7uA4jyyz0EdB/cBKp8
         a6/8FMaDj+VptzYctbUOoj7Qd4ameeLlWF+41x+qOCatSy9HcN2Qd9Nb4+sI94xObNim
         NIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXfoLKVrMT/xFDAU9J/MJSSK5kW91sU/HJUqY9Ndk9k=;
        b=gwAwbpzDZpljGdHLR3X/yx5dvAuxb2M+TF2fvmX4Lxx8EwXfgpUw2CmMX4nhh7t8eZ
         zPF8g5ILiOd9I3CB2O+buKrLSvAiobgOyn6BG+BXUjmy7+k0HGxitqGNEcOLLrqrpz15
         4VV+FAprzmhq5fchIK42wleJBkDXgidUbFMLg5q1F59PPI6BDfbl9hPoxUs3e7KHjjuq
         V0jckmAe5c4b55FmO6MnHaIJEGjLdvLvOV0dqH07EuWt+ckt0d/JNTIZiE93GFtLYVOp
         wb3mVBY/8RkFBCGiDVO1hlMf60iWm5x4tZQSPLpfLq4G5s8UieFIyLG9+Eke65dqwfD7
         epmA==
X-Gm-Message-State: AO0yUKWnYDr7EoOSK4sLLemToYfTE5j4dVK5Ix6PK4FicmX1gZM5HX1N
        Glme14yH+RKUQiCyS0n3iccp//Iv4WBV
X-Google-Smtp-Source: AK7set9hd3ZDbIQWKaAIzJWe78Jguq6KD4h6C3gb27HGyGAwJ/uPydzJVv/u7xKaSG2+TOj7ACh/9QLhh8rA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a0d:eb03:0:b0:535:83c5:cf3b with SMTP id
 u3-20020a0deb03000000b0053583c5cf3bmr347945ywe.87.1676798974536; Sun, 19 Feb
 2023 01:29:34 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:01 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-5-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 04/51] perf pmu-events: Change aggr_mode to be an enum
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than use a string to encode aggr_mode, use an enum value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/header.c |  2 +-
 tools/perf/pmu-events/jevents.py      | 17 +++++++++++------
 tools/perf/pmu-events/pmu-events.h    |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 78eef77d8a8d..c8d0dc775e5d 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -45,6 +45,6 @@ int arch_get_runtimeparam(const struct pmu_metric *pm)
 	int count;
 	char path[PATH_MAX] = "/devices/hv_24x7/interface/";
 
-	atoi(pm->aggr_mode) == PerChip ? strcat(path, "sockets") : strcat(path, "coresperchip");
+	strcat(path, pm->aggr_mode == PerChip ? "sockets" : "coresperchip");
 	return sysfs__read_int(path, &count) < 0 ? 1 : count;
 }
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index db8b92de113e..2b08d7c18f4b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -678,10 +678,13 @@ static void decompress_event(int offset, struct pmu_event *pe)
 {
 \tconst char *p = &big_c_string[offset];
 """)
+  enum_attributes = ['aggr_mode']
   for attr in _json_event_attributes:
-    _args.output_file.write(f"""
-\tpe->{attr} = (*p == '\\0' ? NULL : p);
-""")
+    _args.output_file.write(f'\n\tpe->{attr} = ')
+    if attr in enum_attributes:
+      _args.output_file.write("(*p == '\\0' ? 0 : *p - '0');\n")
+    else:
+      _args.output_file.write("(*p == '\\0' ? NULL : p);\n")
     if attr == _json_event_attributes[-1]:
       continue
     _args.output_file.write('\twhile (*p++);')
@@ -692,9 +695,11 @@ static void decompress_metric(int offset, struct pmu_metric *pm)
 \tconst char *p = &big_c_string[offset];
 """)
   for attr in _json_metric_attributes:
-    _args.output_file.write(f"""
-\tpm->{attr} = (*p == '\\0' ? NULL : p);
-""")
+    _args.output_file.write(f'\n\tpm->{attr} = ')
+    if attr in enum_attributes:
+      _args.output_file.write("(*p == '\\0' ? 0 : *p - '0');\n")
+    else:
+      _args.output_file.write("(*p == '\\0' ? NULL : p);\n")
     if attr == _json_metric_attributes[-1]:
       continue
     _args.output_file.write('\twhile (*p++);')
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index cee8b83792f8..7225efc4e4df 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -31,10 +31,10 @@ struct pmu_metric {
 	const char *metric_expr;
 	const char *unit;
 	const char *compat;
-	const char *aggr_mode;
 	const char *metric_constraint;
 	const char *desc;
 	const char *long_desc;
+	enum aggr_mode_class aggr_mode;
 };
 
 struct pmu_events_table;
-- 
2.39.2.637.g21b0678d19-goog

