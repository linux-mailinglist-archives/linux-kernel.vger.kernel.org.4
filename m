Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3C728BCC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbjFHXai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbjFHX3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83C35AC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568bc5db50dso47625507b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266984; x=1688858984;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPF7IjZ8365DLvNifZS3V/NQW6xDgZgKvmfjNlf3DkQ=;
        b=itwn2UF1L5IRvMQmodMDp3qI2lqRvmKdaS107elk7C12AWXzh8ahltNoZ+uIedzSao
         Z5nPTNZ39DfV2wj2fEMWthmk8ZWqECcA1HmdKnFbGZThP+yFsU6w9K4r4iMuSwC+rTer
         EcWSBl/KxyzJ5qXuvLjL6H+bggq364mlGKr2MYXkh3Kbi5DfjeZ35f/2sga9p88CsyCJ
         1x5Lgt+wRgAoGBGVX9eiMHGMbDcOxWi1Q+eWrmJUCXLEtW/vElNsBPp2KO980YmYQPtT
         c5VyCdiu8CZ0cZrP6Tqt4GU1zJpDIwoZzVB/grwp7PWp0LLEfV//Yr6DY+3xUFBbfGqk
         yrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266984; x=1688858984;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPF7IjZ8365DLvNifZS3V/NQW6xDgZgKvmfjNlf3DkQ=;
        b=TLXWXlpl10HAm7UAJ7SmdIf/wU0xCiGliDB1loJS9RHnaAYHs/sETP5TgOx1wwory9
         RlYi2VHPvQnB6I6XzowLJ2p+DUW5UK3D6fodVXzPmtJV+DJwUE+mbSb6bAugtD9+5o7K
         tcprpu6sf39AtKW1vh/wBPb0Mh4wA7wV7hJJdtWR8zhhuXs0gGz/JPjs68zepQCnsOtw
         vfMiAqtLDp10JGTPthHw8mKTzq130wPyHR5KIB5LNn5mZi2QywrAU+6u02+rc6I2I4qW
         mA25QObLyS25PkLFMK+eizfKd6mRAFsmaCFxV7VrMqOsIJvENq+Q9+7EN8s7zwFJpDC0
         DZjw==
X-Gm-Message-State: AC+VfDzCCPgeKZW8dCAJJ2XL/RMLEUNIIZA3Msxl3hAJ0Kru5TKRmwdm
        9F9vKS0aUB/8aerSomzezygPY19y6NjL
X-Google-Smtp-Source: ACHHUZ4KUthDyR45xo5gd3C4Cm0xs+E5OTaPloOE/qHPF2T0/EN5ljbLzp/gTLV/MuBSrD9FlGxtf1FaRYl7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:ae19:0:b0:561:8c16:2b66 with SMTP id
 m25-20020a81ae19000000b005618c162b66mr75982ywh.4.1686266983934; Thu, 08 Jun
 2023 16:29:43 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:10 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-14-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 13/26] perf evlist: Free stats in all evlist destruction
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.41.0.162.gfafddb0af9-goog

