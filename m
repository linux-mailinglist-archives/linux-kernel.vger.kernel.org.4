Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E60E6EEECA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbjDZHEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbjDZHD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:03:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5E640EF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9968fb4a8cso6730412276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492549; x=1685084549;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9dV1HXRQkiWMKZVLdaY4bVU/Hf3Dw7k75f83fuRHhM=;
        b=5w82RPC6szHn+Va0SUfcs2hthQOevUJuVy27Y5n5efJyeASRP1ff8R5UlcULSXwf9e
         fWdgzbw6r68Y481RyMXKnF7BqJ+oraE+umbmok64j15bcIL2HvvQeAGJFhyqnM/RFA24
         h1+gHQAY8esoqeWCvRKRkWFVtS/8I81FO/BTIM8ePSZkppagTBhEA6npz7NAsM0/nn8W
         SYUXyMTlg7h77e2Z4rZtKOeAWiSkVKwSTU7fk59Qm6/S3doIngtsnLrfBzfR30vffti7
         f5Wtu66mUTrC/vlGpTNhIYcsNUWpfATkRXULY53ado3qo+zzsyKIPXKjiYrqRx5gH5Ye
         zuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492549; x=1685084549;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9dV1HXRQkiWMKZVLdaY4bVU/Hf3Dw7k75f83fuRHhM=;
        b=XkgoFwitvD51AOQXBJshjvvH5+XbU2ASCVkCWrg0cGdsS8fr2j6z4m504IWgdKsruS
         AUdt9hIubZgn7hTm4wOUFvi5D1ZIU6n4TfNkQ6BXX/WdbVEsREGtUpHwQn1Z8vDj7SNX
         HwPhCvImT5hd/9kfnW+oJ5dnM/udNcVsYowoVT/c4s0M0Usf89lJWPgHHq+nStXYS7u5
         WwOfY2OPU0hR65DVqgzcWVcBqVUWxANhF/BVN2WWY811G78ozp8AAcXs4pPAnlNLi/Ia
         +1HCctNJWCNDWcuXlHOC3ytG0vQivwp6dURVFc2xsTlMVsD0uLaUjnxlKaGX2RrVUM46
         vT/g==
X-Gm-Message-State: AAQBX9fBnX07mnDfpg5rKV0SNfTzhUvY8GFm2T39KNVEVZubmY/Q2E5+
        dsnogpCytfVDwqMCe8U27jl7J/i385fH
X-Google-Smtp-Source: AKy350aWNpGpTLR8W0EWTQQVT2NEw070CNOkTq04simk79S6cosAIu82ayrYX7c+/LgE4HNeWiBmXidzWg4H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:7402:0:b0:b99:45a4:3f96 with SMTP id
 p2-20020a257402000000b00b9945a43f96mr6225830ybc.5.1682492549439; Wed, 26 Apr
 2023 00:02:29 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:21 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-12-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 11/40] perf test: Test more with config_cache
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test__checkevent_config_cache checks the parsing of
"L1-dcache-misses/name=cachepmu/". Don't just check that the name is
set correctly, also validate the rest of the perf_event_attr for
L1-dcache-misses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index fa016afbc250..177464793aa8 100644
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

