Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7F16F128F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbjD1HlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345660AbjD1Hkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:40:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F9D4ECD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b922aa3725fso18227831276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667623; x=1685259623;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z2X7LmFVQauBlgGsGcOl9/drZBMwRT7E40p+z8ki8E=;
        b=1itLQvCzq9IbYJkILTCislIUzF0ZbyiTdrgqSi9QtxudIzGbX5oE77TfJS/EAHVfbm
         OUxaJf9ldHtWe59vRJSKJixuQ0owWvgN4QZv/s9k8eCm0RSCTRJ4s4mu7e0/0a8IVbc9
         c0Kv6F9hVVTXpwTmATnZuvao6/H/MKi+KC3vGwagL5VC/TRxlf6bXa2RXQSxiog2lrJ2
         kq/zvbdQ/EqoIhs9CwZxtHMAiDa0Y+W6Fs6iB6og6CvPJTfl/fT39WJCynFSTISOSj7l
         iRcsTf2XThv7T04W8JRT2PoHIDi2lYOgboBCsRtyMi9RDF8BtfpSdaI4yz3zVC/Toe8g
         /ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667623; x=1685259623;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z2X7LmFVQauBlgGsGcOl9/drZBMwRT7E40p+z8ki8E=;
        b=IK90XTf4+LlPpXGkWtnxwUVPGrxSTBZrRozIRuh10j7hHaF2Gxe9HbzcfqiB+WFonr
         kq2dphsufjFD9ZQ2ImD3xsNqowxsCC+1AXF6EFosEk3ZoPbGTNmcvpBPIQ1nGECEEDqx
         XwZsnRb2rb3CyjB4roc/zDqfAzsLQlBmPRI7K3j41ZtDU1S8xKiSjjJxp+LjmiTvkdMa
         jnSt2sSMk4u6RLJdCQm89xb2nS9uxhy8AM2ip/AKKoIcAewPAt+jzXvWG/O9w4P/51NY
         iw6yWqg4BXFbZSWROhUEFSP6SBmfiNQYzIGWUg53P9OciJxZL1c4R15yHfgmuLHznqj6
         5bew==
X-Gm-Message-State: AC+VfDxZgCTpyUeHBqpqMNWPKk1tKj6wf9f+fcJb+K4941Np7DZ5LzPQ
        vvsaCr1jphe7hHodeaiN3W76B5QcNmZd
X-Google-Smtp-Source: ACHHUZ4uiFDO6wIeydYVZUPRu7dL256841YbNZNVJQIH6i9BebuTzspcXK4RCg52Nk7Gi7zV4W+7ylzUWRi3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a05:6902:100e:b0:b8f:47c4:58ed with SMTP
 id w14-20020a056902100e00b00b8f47c458edmr2536695ybt.9.1682667623074; Fri, 28
 Apr 2023 00:40:23 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:39 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-14-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 13/43] perf test: Test more with config_cache
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
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

test__checkevent_config_cache checks the parsing of
"L1-dcache-misses/name=cachepmu/". Don't just check that the name is
set correctly, also validate the rest of the perf_event_attr for
L1-dcache-misses.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 4ff1d70e8375..1b9513ef6aea 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1394,7 +1394,7 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "cachepmu"));
-	return TEST_OK;
+	return test__checkevent_genhw(evlist);
 }
 
 static bool test__pmu_cpu_valid(void)
-- 
2.40.1.495.gc816e09b53d-goog

