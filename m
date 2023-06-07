Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504CF7251B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbjFGBqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbjFGBol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B597219BE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb3cb542875so994584276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102280; x=1688694280;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lh3ZPj+Wzo2hfjfSWit72WLXRXJmKCjosdWMK8GGHUA=;
        b=3o9qJWhUHNoQNGjubcZF65jCf+kylBRuNrh/H8uqZh8T9IE7SSsDbQdJAJqkGygZ/M
         XUmP4BGq/x9wgJBAhBViGncUpwNN2utiZ9qBzS74mgWQA9TAd1yT6PxKwrY6axXJfoka
         xLBd+y1FTCyaQ8wtCWDkY7jTYi1N/aIH8fzG2ptJwcuGV1neC/CfhkzGgXRMnmez4ToI
         7zfazA3RCOCqNCGwYQ3piafzBFPOCEl6Iiy3qDsgKJQSvSkzxH1q4Czl9Fgamm0CXqul
         SQ8P0Iql/omNg2GbZcfLUD+dqe8nJ4RmJNzdOs2uPS4ts5K1aUmvO3nFu0WoPgZ4IAnz
         QZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102280; x=1688694280;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh3ZPj+Wzo2hfjfSWit72WLXRXJmKCjosdWMK8GGHUA=;
        b=Wi2tDUPt9R4iLrKpOXdV+muweXgAOkFIz1p0a+1YEoC7cNQWiKIFkO4YZ0oJP4iZtP
         OXvhgP5Y2YrvKXk0SLzH19igKV5pIC3lBv9eUGIkW/J1Q3K+9dyZhQpxIvcWzc/5ruBw
         sOI6b1OSzS8RAVw52/m6S8C5u7DTEC6UeW+4jTK4dHiigz/HwIFDF4x9p5y7mO0xUsjR
         XhGXbrd2ef/zhO4Y1zwNx2IBis4w52KTKsVUaofGMr4r/wCynZKUPvT53PDmxQiUR4DL
         82F35je4oxEUl9PDU3DgKLJbhYaqxZeTR2OR+g/SVCORGzFfoe/ITvW8+NuWAU+gSWAN
         Vm3A==
X-Gm-Message-State: AC+VfDzDxHVweIhVEhGP7my3fqWX2YmGVG0rpNKlgwRancIrXPU/jkog
        QfvKcOpvl/BVpy29auVu5VOc3PNXe8sv
X-Google-Smtp-Source: ACHHUZ5k0RG8X6zpnvumVsnIGTroi8c4VO2eafr6KT17+45l3nZ2TRcZyfvFyEu2jFiCKaPHKnGy224Junv5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1206:b0:bb1:f26d:b18d with SMTP
 id s6-20020a056902120600b00bb1f26db18dmr2138419ybu.13.1686102279962; Tue, 06
 Jun 2023 18:44:39 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:46 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-14-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 13/20] perf evlist: Free stats in all evlist destruction
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
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

There is no evsel free stats, freeing in the evlist__delete ensures
memory leaks are avoided. Issues detected with "perf stat report" and
leak sanitizer, perf stat uses perf_session__delete to free the
evlist. Add dummy symbol for python build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 2 ++
 tools/perf/util/python.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 82c0b3d0c822..7ef43f72098e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -31,6 +31,7 @@
 #include "util/pmu.h"
 #include "util/sample.h"
 #include "util/bpf-filter.h"
+#include "util/stat.h"
 #include "util/util.h"
 #include <signal.h>
 #include <unistd.h>
@@ -171,6 +172,7 @@ void evlist__delete(struct evlist *evlist)
 	if (evlist == NULL)
 		return;
 
+	evlist__free_stats(evlist);
 	evlist__munmap(evlist);
 	evlist__close(evlist);
 	evlist__purge(evlist);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8de1b759bbaa..a7b2cb05dc86 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1494,3 +1494,7 @@ void test_attr__open(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cp
                      int fd, int group_fd, unsigned long flags)
 {
 }
+
+void evlist__free_stats(struct evlist *evlist)
+{
+}
-- 
2.41.0.rc0.172.g3f132b7071-goog

