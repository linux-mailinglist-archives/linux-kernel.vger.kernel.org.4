Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E876C78C4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCXHYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjCXHXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:23:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD012BEC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:23:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-541942bfdccso10477107b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642622;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry4pmDb5s4Gk++Qn3wAlJyxk1mZP2UHgdh+PE9tgx6g=;
        b=tW4mgV7mWQiLK8AcqTZXh2yuHazguhic3RAC0D48flVTHzpTBmEIg5QxvvpDebANjd
         4l4G90L5nSp32JP1KyMED+mHvT5t/5CrbidI+71CSQGusErjYj5J51P5O++HjXQR+kMI
         vszIacWM8EARfIYHgYb0XcCKfO1dZCB5KKjIEnutn71Hs3ZyyHsU+bMMvwDQGRx2q3TD
         PKGUqjw7HjthWQbG2tLVurufNNQ3Rd5AnDbEV+EE9m9dBqWz6VUO9QEM4RlJpJDv7y09
         U6iszN7+qvuDto/1G10635ElvnFsFmqg0E7oFOBQ2EwKFdAsm2CYS9IJeED+w1u+OKHv
         QDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642622;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry4pmDb5s4Gk++Qn3wAlJyxk1mZP2UHgdh+PE9tgx6g=;
        b=52LfY2OPtRZaGZD4oP8MkTFJMdVyljwzJEetdFTL2YvvUdOCDO/6p32qLaYs1FFBRx
         FAM1oab6F1msBAn6kxKcMpfnuv0SsRz6E+xLlzWD7u2V3VeBBu6C4Qg5AcR67isRipw8
         gdBMzDPbv05w7HZ29p8JgZB1MjbngeuEyy8wAyeyQUU7KWue1JLFctFqtjsBadvPFM4f
         oXIfPvJ6pRexhvdd8cIg/HrwZWVIva+aLlqMYlxGTdeea382TrlEUhRO66bMQ2tzj/3h
         1yBTgW+uj/csNQhlF4ww3bQ0NyXQGmpwgpvKrFAhX04ejr+Ba9kOBj96AuId0CHZqHXx
         FmBw==
X-Gm-Message-State: AAQBX9cJ8hEekCaGwzHSTsudxwabdmKX7QEmAC161chel51V5wROY7N7
        4GOrX0Aq9yFgqNLWiPlno5Ae6Km1mLw7
X-Google-Smtp-Source: AKy350byPKDNZqQaNWAL43WYzFKPlhuXpZ/JUAVqqb5cbjw2IhUnkzZqyfFQ8d3iUk7LSl29zpi4mmzf+Wuw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a81:e405:0:b0:544:d5ce:eb33 with SMTP id
 r5-20020a81e405000000b00544d5ceeb33mr548381ywl.8.1679642622088; Fri, 24 Mar
 2023 00:23:42 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:22:17 -0700
In-Reply-To: <20230324072218.181880-1-irogers@google.com>
Message-Id: <20230324072218.181880-9-irogers@google.com>
Mime-Version: 1.0
References: <20230324072218.181880-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 8/9] perf metrics: Add has_pmem literal
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add literal so that if nvdimms aren't installed we can record fewer
events.  The file detection mechanism was suggested by Dan Williams
<dan.j.williams@intel.com> in:
https://lore.kernel.org/linux-perf-users/641bbe1eced26_1b98bb29440@dwillia2-xfh.jf.intel.com.notmuch/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index d46a1878bc9e..bb6ddad7e021 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -14,6 +14,7 @@
 #include "util/hashmap.h"
 #include "smt.h"
 #include "tsc.h"
+#include <api/fs/fs.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
@@ -400,6 +401,20 @@ double arch_get_tsc_freq(void)
 }
 #endif
 
+static double has_pmem(void)
+{
+	static bool has_pmem, cached;
+	const char *sysfs = sysfs__mountpoint();
+	char path[PATH_MAX];
+
+	if (!cached) {
+		snprintf(path, sizeof(path), "%s/firmware/acpi/tables/NFIT", sysfs);
+		has_pmem = access(path, F_OK) == 0;
+		cached = true;
+	}
+	return has_pmem ? 1.0 : 0.0;
+}
+
 double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx)
 {
 	const struct cpu_topology *topology;
@@ -449,6 +464,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 		result = perf_pmu__cpu_slots_per_cycle();
 		goto out;
 	}
+	if (!strcmp("#has_pmem", literal)) {
+		result = has_pmem();
+		goto out;
+	}
 
 	pr_err("Unrecognized literal '%s'", literal);
 out:
-- 
2.40.0.348.gf938b09366-goog

