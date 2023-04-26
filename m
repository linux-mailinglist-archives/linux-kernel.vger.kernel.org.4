Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B06EEED0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbjDZHEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbjDZHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:04:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30D235AC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:03:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f855ecb9cso93868577b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492586; x=1685084586;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3TpL6YWGjupQ3WBzrUZ30H8DHXRPaH7nMpBJtPSJiI=;
        b=g30x9L8UgdVw6DJHtU2H0uB7Vxe8J7Y+RrY5Qf4ksV/3xQNCmkLP8CoVxeuUuBRtet
         DYV7P/d4ktzTe9C+X7S5fGJFx3DOMqbgeEsnMZJPD/XEkt7mUEUGhLoXbF7Hsx2ULcri
         0GwsN/eY4gbCWv1ZDSark0EkevkkI8UuV6X9FGjhIePbzOm0jXLPJBWecqxuNTGQLNmS
         LTnfOLXHEI1cSJsovHLG4tt5+SmNVW/jJtdc43QO85pRpHpFyEMWej91uUxIZ/6IGyx2
         L1VSkL1TKNDTAbkkYTg4zsMWXWzVfxtD2sPod7xapxxyujytUk6eF/sQMw3SOVa3uQuP
         Zy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492586; x=1685084586;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3TpL6YWGjupQ3WBzrUZ30H8DHXRPaH7nMpBJtPSJiI=;
        b=PRQ4nTzKxGfqj5L91aiGbFNj3uVZHRMxHGvEsx5xrOfqOvBhmaeum6qbvMoulkVdLu
         JSAit3MSNzZfJSExS0r4P6KbjGhzcxSlQ0wdQCdAnvfspla+MI64FnWWIf6SxB5TrxVG
         o1BIWJuHxvdn3jQxQ6BjpVCJyMxPEi0jBruinCsWRTPHhhhw99ckHLnSLjMMdcprL4w7
         26nLxu97vRuGtz1fKlYINDDthqm8/bxOs1YR72q0tvDNqyXKl8Xzxmn67ntJhnComZ1+
         XKdh0p8lU4YGJ3HOSsGT3i/VSp+rc/5B4Loo5k8moIu3J/86X+qxuYncVl/EBt9giyWL
         5P/g==
X-Gm-Message-State: AAQBX9c/C1eEN6ebAKdLyE7nMcogMT/QxHhCtbqF9Zsa2voMl//RW3LS
        s8lcEB3dpogWWIFawBeSHFJawOUCCkQo
X-Google-Smtp-Source: AKy350ZOr84LhTx6WtgtzK7iSlsnlMgnj9gCw6aE0anxQxK4LjR4vAQGIdLpubzDlmqtK2frKlg0jawecRQt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a0d:ec48:0:b0:54f:ae82:3f92 with SMTP id
 r8-20020a0dec48000000b0054fae823f92mr9252414ywn.2.1682492586249; Wed, 26 Apr
 2023 00:03:06 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:26 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-17-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 16/40] perf test: Validate events with hyphens in
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

Rewritten event parsing can handle event names that contain components
of legacy events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 6eadb8a47dbf..cb976765b8b0 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2198,18 +2198,6 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 			ret = combine_test_results(ret, TEST_SKIP);
 			continue;
 		}
-		/*
-		 * Names containing '-' are recognized as prefixes and suffixes
-		 * due to '-' being a legacy PMU separator. This fails when the
-		 * prefix or suffix collides with an existing legacy token. For
-		 * example, branch-brs has a prefix (branch) that collides with
-		 * a PE_NAME_CACHE_TYPE token causing a parse error as a suffix
-		 * isn't expected after this. As event names in the config
-		 * slashes are allowed a '-' in the name we check this works
-		 * above.
-		 */
-		if (strchr(ent->d_name, '-'))
-			continue;
 
 		dir = opendir(path);
 		if (!dir) {
-- 
2.40.1.495.gc816e09b53d-goog

