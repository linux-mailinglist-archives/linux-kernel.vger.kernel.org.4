Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA4740339
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjF0S27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjF0S25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:28:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B14E71
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:28:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5704991ea05so65706677b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687890534; x=1690482534;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pCEk4rjcfYTL2DuAl4m74mxfXYI4yN7w7niW6JdDvXw=;
        b=Cm3bw124FnPJLd/hOVzZkDDEl6NNM4e2Hl/lg4rqzZFObSGD+uZnXFozeYjh0LOYLL
         kpEDPktwyWqw0Pq7ozb4zkXc9QwiUAW+kmkiYBWTROZNSUezXf+9Rsv9cqOvedHA/I76
         ryK1te8HJfEiHohIYLEA69RFYB+bmV+37MNrsT4ebstip6UaYunO7AdrjpaYjflhlpL6
         xS8yCJmHsstL8q/t/CDMkfPTjMJAoTgn+5QT+1HYSIFM8haYxKCw/kaL8B2g9p/CpxVE
         YTZo30pAo3ee7f6jXZWZIPJ6ae6c/EE7RzoncuCGrfwEJ/Jf8K3Ok1ReXADB6GJnX0AF
         AsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890534; x=1690482534;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCEk4rjcfYTL2DuAl4m74mxfXYI4yN7w7niW6JdDvXw=;
        b=EQlU+I10KXD0RBGF1oe8XFe5R9X5QPdCKb0sFz17UkUW8bzeQ7Ep3R9xq6ftiYb3w6
         RjwILoTxGrGMfsf+1kN8E0L4L3NR9QSskRWZGpGE4BRIcmg3yyrbi6Zju8jQI+UgbrqJ
         UdLtxTt40l5Xzblxqb/ajLElw4O1x5/FhmWllHK9CGhcEse2jeQQJ8Sr+dHvfXqWmbdC
         zxhyyDOizrJF7TW3LGgv2de6+RyuoYJSL6GT025W0jLAbKcWNdw24vnzW5FmGkWEelbF
         ZFJ2TdEBSSMNldBOaiYpcWSfc8z4RlbEgBLrMV9CvOuNd6pEjAN3mB2aprrLwR2J7PMA
         s3tg==
X-Gm-Message-State: AC+VfDxGwOKZasDs7xkrbdblr0UdMC9qj/kRYd+yjzwlB6dJ93TX0/Wq
        WhfWhllIIP1adr8fDbpt/eqTu6eYKfu0
X-Google-Smtp-Source: ACHHUZ6wQDXh989UuoDBFM6nLfDD0nRgSuyNK+A4PNTa/4bB+SnOFzM6nso7l0EW6nj0faBVK5sPn3IhC3XE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a81:ac08:0:b0:56d:1b6:5360 with SMTP id
 k8-20020a81ac08000000b0056d01b65360mr13365076ywh.5.1687890534617; Tue, 27 Jun
 2023 11:28:54 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:28:34 -0700
Message-Id: <20230627182834.117565-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1] perf pmus: Add placeholder core PMU
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If loading a core PMU fails, legacy hardware/cache events may segv due
to there being no PMU. Create a placeholder empty PMU for this
case. This was discussed in:
https://lore.kernel.org/lkml/20230614151625.2077-1-yangjihong1@huawei.com/

Reported-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 25 +++++++++++++++++++++++++
 tools/perf/util/pmu.h  |  1 +
 tools/perf/util/pmus.c |  7 ++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8d5ecd4ff1a9..7f984a7f16ca 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -928,6 +928,31 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	return NULL;
 }
 
+/* Creates the PMU when sysfs scanning fails. */
+struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus)
+{
+	struct perf_pmu *pmu = zalloc(sizeof(*pmu));
+
+	if (!pmu)
+		return NULL;
+
+	pmu->name = strdup("cpu");
+	if (!pmu->name) {
+		free(pmu);
+		return NULL;
+	}
+
+	pmu->is_core = true;
+	pmu->type = PERF_TYPE_RAW;
+	pmu->cpus = cpu_map__online();
+
+	INIT_LIST_HEAD(&pmu->format);
+	INIT_LIST_HEAD(&pmu->aliases);
+	INIT_LIST_HEAD(&pmu->caps);
+	list_add_tail(&pmu->list, core_pmus);
+	return pmu;
+}
+
 void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 {
 	struct perf_pmu_format *format;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8807a624e918..203b92860e3c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -286,6 +286,7 @@ int perf_pmu__event_source_devices_fd(void);
 int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags);
 
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name);
+struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
 
 #endif /* __PMU_H */
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 0866dee3fc62..3cd9de42139e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -153,7 +153,12 @@ static void pmu_read_sysfs(bool core_only)
 
 	closedir(dir);
 	if (core_only) {
-		read_sysfs_core_pmus = true;
+		if (!list_empty(&core_pmus))
+			read_sysfs_core_pmus = true;
+		else {
+			if (perf_pmu__create_placeholder_core_pmu(&core_pmus))
+				read_sysfs_core_pmus = true;
+		}
 	} else {
 		read_sysfs_core_pmus = true;
 		read_sysfs_all_pmus = true;
-- 
2.41.0.162.gfafddb0af9-goog

