Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096D26EEED4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbjDZHFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbjDZHEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:04:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3228469D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:03:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f87c0a000so115013097b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492613; x=1685084613;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCecFHyWQNvHuSdHOLhofsJDyWJSs+06+TmI+QyaYN0=;
        b=gVSbPwm9D++gi16FNhrLrEpbJ4BaXZJo0eStxrpKxGYv1ewUpb7O1ryFcx0Bdpnwtn
         w3FTA7rf4nK5usLkFfxLN5rpzeT5NhrPB1RwBe8oEjT9foVHO9xl41XuYTFc3ekU9Erg
         Gx5BjF/recceXW4EOrgjT25VFMF3N1vtfwnQsRYoVifEhhnjjxnwZUHmaJMR5fdUIdbV
         9OdZyzC9CPhA62OyTeIIpLSH4H+btZ/thE7SbMXJm6kp1Tw3deTgGFRxtIoE+k0Fj6Lz
         KQ2bTe/NAkHJIaCmmyBY7+kXLx6D/yRpLsn4LE2oiw2eBYmKv4JrnlDxIt5McOuBTkjd
         ovuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492613; x=1685084613;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCecFHyWQNvHuSdHOLhofsJDyWJSs+06+TmI+QyaYN0=;
        b=GLf2sJ9G8JOAgixcxJSJzArt5Ksa9W5zcAl/1DUpU+AiadqKCrNySDwNldzQOrvTIn
         4I4N9BYZsRHp8/GXwqLLUxqmKjm65241GImIkJeEaqoHBONuM0DSjLs8mOLRxnzERqBt
         IYPqtHWmOseLIY6HHrQ5ibHKysu2mqM4+3zaMt9vBj0x3DF08aHhM1kIQ8IjmUNCyN0h
         bEs0g4/CeC0mpho30qKLJ0sX/tvjCptTGxowRgsIIi1DJQdBgmlbtK6zizeYIRsfbWVe
         6WZu+9dWIgfX5dd7xV9Ympq3dhCEZdkTwulVD4dCoFkrul95I14ZJ3DlZqgszqCGEmOY
         G7eg==
X-Gm-Message-State: AAQBX9cKC012t43Zo2SWrpsYSs3HkoBtXcQeicknHxhdEzwj4wfmbYL3
        sJMZanP6T92wsnzCdFK9QgvrDwR0J+P0
X-Google-Smtp-Source: AKy350av7NFvDj+rflxYfossfIVHE6HTwADYYNuv31cSDOU9VOVUh8RcucpE14qEPxzBHfB0pgVp8mTzmn4E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a81:b725:0:b0:555:f33e:e346 with SMTP id
 v37-20020a81b725000000b00555f33ee346mr10340975ywh.6.1682492613034; Wed, 26
 Apr 2023 00:03:33 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:29 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-20-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 19/40] perf test x86 hybrid: Don't assume evlist order
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

Switch to a loop rather than depend on evlist order for raw events
test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index 0f99cfd116ee..66486335652f 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -11,6 +11,11 @@ static bool test_config(const struct evsel *evsel, __u64 expected_config)
 	return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == expected_config;
 }
 
+static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_config)
+{
+	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
+}
+
 static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
@@ -93,22 +98,15 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 
 static int test__hybrid_raw1(struct evlist *evlist)
 {
-	struct evsel *evsel = evlist__first(evlist);
+	struct perf_evsel *evsel;
 
-	if (!perf_pmu__hybrid_mounted("cpu_atom")) {
-		TEST_ASSERT_VAL("wrong number of entries", 1 == evlist->core.nr_entries);
-		TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-		TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
-		return TEST_OK;
-	}
+	perf_evlist__for_each_evsel(&evlist->core, evsel) {
+		struct perf_pmu *pmu = perf_pmu__find_by_type(evsel->attr.type);
 
-	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
-	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
-
-	/* The type of second event is randome value */
-	evsel = evsel__next(evsel);
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, 0x1a));
+		TEST_ASSERT_VAL("missing pmu", pmu);
+		TEST_ASSERT_VAL("unexpected pmu", !strncmp(pmu->name, "cpu_", 4));
+		TEST_ASSERT_VAL("wrong config", test_perf_config(evsel, 0x1a));
+	}
 	return TEST_OK;
 }
 
-- 
2.40.1.495.gc816e09b53d-goog

