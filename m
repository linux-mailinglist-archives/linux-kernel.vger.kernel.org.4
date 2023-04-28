Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A838A6F1296
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345731AbjD1Hli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345677AbjD1HlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:41:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD2D524A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8ec97a706fso16440502276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667639; x=1685259639;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVN+WtVBinIPas0ggbaTczLlntAFDczu4JgyAZ0ncIE=;
        b=Ln4Z1Mzd7ToDZx8sos6KrvSnFRITAhaqld/WXl01VdbV21CgcnvaGqWKkTtvqmIA9t
         /cVXO94qnUMwcSZ+z7ACeG2gm16c44Qj/Yv0RcWnD4cj4YQHdJvp/igoLteZzaqG4tX9
         QJ8efo4ELIz2zxTEUSmK4iNdspz6cq8Q244VkgNJDb6jQb4qn7a0HQ5fNa7pGdmSG3+i
         AJXE20eTL3f9TLnujtMML9b3kcJoeGXjFPtApmVHOPl+HlD52aJIO/w/Gq3cMVzbIe/f
         O4nqaf/l8ETMC0vWqXdUPdIMJaPLroaRi92EujrdIP+ebl85b4fFN/Nh+ULL5VxWqeBr
         klsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667639; x=1685259639;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVN+WtVBinIPas0ggbaTczLlntAFDczu4JgyAZ0ncIE=;
        b=Djc6iM5tHnozdO/kCybsUnqAqb5NPXavM3HM8u/wny8eG37M7/0vOMjpCa/vLXzjOD
         hpFZbVDutvZcbPhALRcufiD4GtsGVVyY5fNj4bxYmidm2fGADnepQUVQf+dMDryU1yjT
         PNTfLDAVKCT5Ht4GkDxqQ4ZNSjLML2msPdY6hegac2/gWTNABC08kzCcdK9Cq0lue4Wb
         mavbuea4t9c1LdN03W48yQuskaPEyguerOZ66KXfOSkrhqStrNOTfNwkYo/5rAkugU8X
         NUWqhLhTwtoEici4DZra3u9pf/56+aPHDxh5M8Y6widLf5mAs42OTraiMUlznGGt7IEQ
         DbMQ==
X-Gm-Message-State: AC+VfDwx9duKgKvwUrhuJb02JTnBKtBnr0vtZCbDiMs+rZymY6gokAnL
        mEsaiRJiw3v2Ay2//O8s6b9HiIxLCsvO
X-Google-Smtp-Source: ACHHUZ5hN23+fVpX6ccKkZSOr31HcPGBhO6A+/DBexP4RgOR+EgfuvMFhTL11MoYu1TCu2K9WOdhU2Vp+u6c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1241:b0:b99:465f:9000 with SMTP
 id t1-20020a056902124100b00b99465f9000mr1758587ybu.9.1682667639646; Fri, 28
 Apr 2023 00:40:39 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:41 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-16-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 15/43] perf parse-events: Set attr.type to PMU type early
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

Set attr.type to PMU type early so that later terms can override the
value. Setting the value in perf_pmu__config means that earlier steps,
like config_term_pmu, can override the value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 +-
 tools/perf/util/pmu.c          | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d71019dcd614..4ba01577618e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1492,9 +1492,9 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	} else {
 		memset(&attr, 0, sizeof(attr));
 	}
+	attr.type = pmu->type;
 
 	if (!head_config) {
-		attr.type = pmu->type;
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ad209c88a124..cb33d869f1ed 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1398,7 +1398,6 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 {
 	bool zero = !!pmu->default_config;
 
-	attr->type = pmu->type;
 	return perf_pmu__config_terms(pmu->name, &pmu->format, attr,
 				      head_terms, zero, err);
 }
-- 
2.40.1.495.gc816e09b53d-goog

