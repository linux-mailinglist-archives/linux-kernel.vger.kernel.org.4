Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE7712F35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbjEZVyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243606AbjEZVyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:54:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92838F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83a9779f3so2660558276.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138059; x=1687730059;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8S0Hv+a/Zvfp18A5nlLX6T7tZ0kZRLdYhlDuYf6C4lU=;
        b=Ic9P7IyNJyUX8+dGFzOhxlyMJxl5ZCGy2OhS5BWms0QeuJynt2dmm54BBT2HIawiXL
         8EirOGt/fHGjWBek/XIMZp3lOa7cypL2GtbHz70XUytSdFl6TzKqB5oB4oWZ1ijvs+Eo
         G6Sfz1Ae0XVDeVzya5nc6DAsOdl+5RBUQp01L08aF5OrwiLymQmDX5/MQbgK9TL1xXR5
         5TiWq11FCHdBO/u9uM6EvRWYuTd6vgw8qZSjG5682B0h7MXnHJVSEAw704mykSJ22Apr
         zZvRDDxK8+Ooqss5Zg1aYbYMFlJxIKyhM6l/grJIQdyEOmGIsw+Fl2Xy22Py9OV3D+rc
         bUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138059; x=1687730059;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8S0Hv+a/Zvfp18A5nlLX6T7tZ0kZRLdYhlDuYf6C4lU=;
        b=MQKLTkeonbFES80z7PYIenlF/hWjtwPCAp54vx9PlkiaoNjQiTVU4PKl/H/yURRDr1
         +BwzovSN0dO0s60IbxC9S79a2iDD/i5yXtuc2O0logWjyKo1Xa6oBwaI4eaCpSQ/goZG
         ZWI5vdx7KE52twK4vhRp5pbUSx7Vxm4UNiblMpug2xtmsnRyoI+CqAkkcly5D3yoBgSu
         9+fYhuKhFZKbDhEIpdhk2QGwpMsMb3MkEkHD4dYjAnlQ+2C3K10KgyXB8YnWd47HwcF/
         ojsNUOosLTU0D0QYuLaV17lfBhUbzLp0l1ZdiSujy0MxZ4vrgJzKIvQAIpdFdLWdpIPj
         zcgg==
X-Gm-Message-State: AC+VfDyavEj3Ne6M7khHkPn82ULC/SwknGfowCxw87khMcPSK5/DFy7g
        rbORc2xsfnh4VBxSL0mF1K43TxpsKERM
X-Google-Smtp-Source: ACHHUZ6wlwN1t7qV13GabHWFUElri+i1zZLXEXx4+eZbvTw4JBb5huMJ6Ed5ui05ffjbLI0Ms+DZshJaMdBG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:ab13:0:b0:ba8:757c:2523 with SMTP id
 u19-20020a25ab13000000b00ba8757c2523mr1698848ybi.9.1685138058810; Fri, 26 May
 2023 14:54:18 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:37 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-3-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 02/35] perf tests: Organize cpu_map tests into a single suite
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

Go from 4 suites to a single suite with 4 test cases.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/builtin-test.c |  5 +----
 tools/perf/tests/cpumap.c       | 16 ++++++++++++----
 tools/perf/tests/tests.h        |  5 +----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index eef400025fca..aa44fdc84763 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -88,16 +88,13 @@ static struct test_suite *generic_tests[] = {
 	&suite__bpf,
 	&suite__thread_map_synthesize,
 	&suite__thread_map_remove,
-	&suite__cpu_map_synthesize,
+	&suite__cpu_map,
 	&suite__synthesize_stat_config,
 	&suite__synthesize_stat,
 	&suite__synthesize_stat_round,
 	&suite__event_update,
 	&suite__event_times,
 	&suite__backward_ring_buffer,
-	&suite__cpu_map_print,
-	&suite__cpu_map_merge,
-	&suite__cpu_map_intersect,
 	&suite__sdt_event,
 	&suite__is_printable_array,
 	&suite__bitmap_print,
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 92232978fe5e..83805690c209 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -211,7 +211,15 @@ static int test__cpu_map_intersect(struct test_suite *test __maybe_unused,
 	return ret;
 }
 
-DEFINE_SUITE("Synthesize cpu map", cpu_map_synthesize);
-DEFINE_SUITE("Print cpu map", cpu_map_print);
-DEFINE_SUITE("Merge cpu map", cpu_map_merge);
-DEFINE_SUITE("Intersect cpu map", cpu_map_intersect);
+static struct test_case tests__cpu_map[] = {
+	TEST_CASE("Synthesize cpu map", cpu_map_synthesize),
+	TEST_CASE("Print cpu map", cpu_map_print),
+	TEST_CASE("Merge cpu map", cpu_map_merge),
+	TEST_CASE("Intersect cpu map", cpu_map_intersect),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__cpu_map = {
+	.desc = "CPU map",
+	.test_cases = tests__cpu_map,
+};
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index b4e54f08bc39..f424c0b7f43f 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -118,16 +118,13 @@ DECLARE_SUITE(bpf);
 DECLARE_SUITE(session_topology);
 DECLARE_SUITE(thread_map_synthesize);
 DECLARE_SUITE(thread_map_remove);
-DECLARE_SUITE(cpu_map_synthesize);
+DECLARE_SUITE(cpu_map);
 DECLARE_SUITE(synthesize_stat_config);
 DECLARE_SUITE(synthesize_stat);
 DECLARE_SUITE(synthesize_stat_round);
 DECLARE_SUITE(event_update);
 DECLARE_SUITE(event_times);
 DECLARE_SUITE(backward_ring_buffer);
-DECLARE_SUITE(cpu_map_print);
-DECLARE_SUITE(cpu_map_merge);
-DECLARE_SUITE(cpu_map_intersect);
 DECLARE_SUITE(sdt_event);
 DECLARE_SUITE(is_printable_array);
 DECLARE_SUITE(bitmap_print);
-- 
2.41.0.rc0.172.g3f132b7071-goog

