Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9BC6F2331
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347423AbjD2Fl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347414AbjD2FlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:41:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BE430EE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:40:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f6da2edbdso10729507b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746772; x=1685338772;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=feNyjAPtIUSUDrmLxKNanb31JNx+5xcJ7s4SppqU3s8=;
        b=mzrmCY6ku4SyMEw1YxXy3v7fV8LU/PrtiOl3HBoXxT6jsenn6LMJOwlsO9n/bGjz/2
         qO+ErKCjKYsdmEDudSRRtXNZipPl1wI+ReV2D7hQCw2D15ESfkukSqKdH8edXgSb8Z9Z
         aJDDKU9DmrTf36vElrOEOy22+lVO2upP5Ll41L5jcGpSJ6DrRhYn+TTOL2IXZdVKku8N
         nUQ8+02s0Y9JrWlqkY0LkY4WMnzbAJiqwfIHAFPVnMevB2/zTUd0Tdljl+kEX2t2i75V
         eE+miOrRCeSDozDizzHam+111mqezpmzeoopJxdWam6MY7U8snyzppK32vqj2YQvHEYl
         48Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746772; x=1685338772;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feNyjAPtIUSUDrmLxKNanb31JNx+5xcJ7s4SppqU3s8=;
        b=V5CuF4jS6k3dIOIG49HpSiuxctbaHsCCFmQ5jsb4Lisd7cbhbLegfi0dw4Qwb12UB/
         DaH4N9LWqigWDmtKlX42fAD7tcfDoJcPs9lKEeDmh/p6sbvLCe1S3EjkNRnpEWlFZkdW
         aEnihccIMJmjVDCGtZoTpl56Nofb10eMjX2YX2HiRjw0AZHQIqCHI04m7DyIVFE9DyBD
         1IYbFB2WQliGcjyxj7CbH3Yqy99wuBym7KpOdpEFpcgNBeL56+X4uLehdR/1yCH/ZZn7
         LG0SiImRK9INoV8Q/SmxGxSUy9LSo/0N8n+3WFBZGb6Yhq1xhV1nWEISwaEar+3EoJsS
         DiVA==
X-Gm-Message-State: AC+VfDwtZVs8VSpOIrbH6nbTkPx7bMVvEB2cWqDPs/TgZRcUHx1KQO/q
        j8JpyzRUuCF+Hldr77kyolT1D653bMiY
X-Google-Smtp-Source: ACHHUZ5d7P7OElXE+wFiE99bHufiixYpH4ohcTYPlNNqlQhyD+Rw8etEfaPJqlRSgvpF+2y2f4Kn74S+lQyk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a81:bd4d:0:b0:54f:b2a3:8441 with SMTP id
 n13-20020a81bd4d000000b0054fb2a38441mr4268579ywk.10.1682746772308; Fri, 28
 Apr 2023 22:39:32 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:50 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-31-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 30/46] perf parse-events: Minor type safety cleanup
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

Use the typed parse_state rather than void* _parse_state when
available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 5055a29a448f..e709508b1d6e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -301,7 +301,7 @@ PE_NAME opt_pmu_config
 	if (!list)
 		CLEANUP_YYABORT;
 	/* Attempt to add to list assuming $1 is a PMU name. */
-	if (parse_events_add_pmu(_parse_state, list, $1, $2, /*auto_merge_stats=*/false)) {
+	if (parse_events_add_pmu(parse_state, list, $1, $2, /*auto_merge_stats=*/false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 
@@ -319,7 +319,7 @@ PE_NAME opt_pmu_config
 			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
-				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms,
+				if (!parse_events_add_pmu(parse_state, list, pmu->name, terms,
 							  /*auto_merge_stats=*/true)) {
 					ok++;
 					parse_state->wild_card_pmus = true;
@@ -331,7 +331,7 @@ PE_NAME opt_pmu_config
 		if (!ok) {
 			/* Failure to add, assume $1 is an event name. */
 			zfree(&list);
-			ok = !parse_events_multi_pmu_add(_parse_state, $1, $2, &list);
+			ok = !parse_events_multi_pmu_add(parse_state, $1, $2, &list);
 			$2 = NULL;
 		}
 		if (!ok)
-- 
2.40.1.495.gc816e09b53d-goog

