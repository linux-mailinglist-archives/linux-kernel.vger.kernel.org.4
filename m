Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81376F4CFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjEBWlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjEBWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:41:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E212722
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:40:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso558758276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067245; x=1685659245;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8nwm9FM63+8LyKX6JPZhyGr0V07Z0tZiVV7cZTfwEo=;
        b=RryHY3yjpE1k1gRrW1Qmm8/Sj/Tj3bA431RHAOaLshSWLtZOI1IDrfok8oOxQGq+1L
         srO6LFsU/XHwpHXl1oyzwE/alpKo4htNBqi81q29JUojWWEXr7vCe8JtJ7RIzgEeowue
         /bIrBh1O0Xt98CGXPJYn8ROD7zZazVf8wqfp9/BF+xQyVaFXMORAaL4hsigZADL8Je9Q
         mKni2h14dI+1+eNuV22ZdPVB/j6mTGhXRJpEl0jX/Hiy4dqm4qAMXd+ljd4+r92Dr1K+
         oamliAIaOSlXc8kjQ+qE6tZMjCfBoaojoaUiV43sM/g7nAJsoNOtJSEVbfOvpvUhvz5X
         4tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067245; x=1685659245;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8nwm9FM63+8LyKX6JPZhyGr0V07Z0tZiVV7cZTfwEo=;
        b=g+lXcdzjKOBhdJax3Wp+aDumACfaEZN/NYUnhjJgPko9UnVO2g5Ls7FQz3hUVEf1eJ
         ifWGVEImEJiCaFmGx6X/zedvbA2zgUvxNnJr7NvxE0kFmgh97rBCzgEXC3HWt5Vk+YbR
         ESHTMq/FYvxG6nu611nNLqUowjW8YFM3q5ETuLb7DTbxlSvObX/bYOWL0lIzshkBwWko
         XTQae6L+i+QQ7cMpSQ/d873OmumOMMXA35kQHc+EuojXCoNJLCD7IXWp/yO8RZH/3VqE
         bbZrvtK2+6JZ12PUUyzmEENtLh43mZaTKWPvGBfGOXxW7Y0JNkrmoPv9X+U8Gryltlfw
         pE6g==
X-Gm-Message-State: AC+VfDzwqowCmwe5FYSUgLf+md+NEgMse2EktvNnP9YIHOU0tSx9Ot37
        zo2AQcP3S5T1m75WUO6eUWNNIFeypeB3
X-Google-Smtp-Source: ACHHUZ5aYfqJ48wRkPJWZd0xz/8ZyNgjy30vQ9zOnan16SX0b/DjkBZhUlkn7Fy4Mvk0BCydktLkxNwuFYp2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:7e4d:0:b0:559:d859:d749 with SMTP id
 p13-20020a817e4d000000b00559d859d749mr85943ywn.5.1683067244808; Tue, 02 May
 2023 15:40:44 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:20 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-14-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 13/44] perf test: Test more with config_cache
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
index 4b00cb4aa73a..3f75f0315db8 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1406,7 +1406,7 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "cachepmu"));
-	return TEST_OK;
+	return test__checkevent_genhw(evlist);
 }
 
 static bool test__pmu_cpu_valid(void)
-- 
2.40.1.495.gc816e09b53d-goog

