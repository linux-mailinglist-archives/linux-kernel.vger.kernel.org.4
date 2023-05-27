Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B3B7132F8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjE0HYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjE0HYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:24:03 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1B3E73
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:33 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1ae3f6df1afso17436885ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172190; x=1687764190;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwNQ71nzWAtCurlrP6FCuEtDPR9XmwsHJykHXM8qing=;
        b=lOmkzKB/CDHXV/rco7HS2RvubFjRAX64Al/x/EveVXU+0EEbRI8AWv2xMFWJhKQCtV
         /8zoblOYubNZ1ztF7yf55Ugp4qBvu02MYXnz9Rhu0yZ2ixeo0LoYzpzS5z4YIEH6N4Op
         sVCEH62LkRrUAc3vbKYQ+TJ6iZqsSpKFbAh86EEmY8fIdwlskwcUxW0fu/46vt+mV7lX
         JdwDskbPIfkzzyIGTjkOypbJrFnoEdZyfcfAQlloVlkHDMrVF1tFvSdKVokf/2gQqAY/
         gXQDr+pOcntJtC7Odt3SiKE6CP1CUzqHWm1PpXA6VqAZjpNQTnSvxkFqjZ3Lshi7pnrx
         zgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172190; x=1687764190;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwNQ71nzWAtCurlrP6FCuEtDPR9XmwsHJykHXM8qing=;
        b=itp1oGy9bSoBW63jdijj46EHFGr3oMN4/oP43JdZ1YjclGGhTm2T3SAyoIHFFxe++7
         ukMRGDZ4aPorMHU4mYU2oYC8LnbCxgKESP43X95+vtzt4O/dpyTk/G56bil4RiD/fVdb
         aGzzQ6WcCh4pAeVqIXy4HQ6NAiRKr2IaXOsjjUtaBkG809/EW1NsZTGtwp3FL/rZFR8/
         cLcJDWkchV6E+lJYXPRuRCzMU8JAKj45fjf8xBZ4i0ZmEYNRD6nJjBOAqM3f+f3txqCg
         a4a8yWl2uQMChBBJ+5plKi94xVI0DWxoixJn4DuriL50XcXJweb2FfywlH+swpXhuT5l
         dN5g==
X-Gm-Message-State: AC+VfDzeafgE51MIaJa2+BkW0M2igh7qsjiFy6x7unmEWsFycrDw4pPd
        Ea5J56v6Yoc1RA7Z6OZdG1uaXWMKNcx6
X-Google-Smtp-Source: ACHHUZ7UV8GZgGYFzC4oxTs1TYELikiLvG9qg0wVWQ4EFn9Nb8epp081W/xOPomIVYFOAD5jMOcSUqzwfE1P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:902:bb92:b0:1ad:e398:4477 with SMTP id
 m18-20020a170902bb9200b001ade3984477mr1200446pls.8.1685172190553; Sat, 27 May
 2023 00:23:10 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:52 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-17-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 16/34] perf pmu: Rewrite perf_pmu__has_hybrid to avoid list
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

Rather than list empty on perf_pmu__hybrid_pmus, detect if any core
PMUs match the hybrid name. Computed values held in statics to avoid
recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 83c7eeb8abea..5a7bfbf621d0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -60,8 +60,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-static bool hybrid_scanned;
-
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
 
 /*
@@ -2013,12 +2011,20 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 
 bool perf_pmu__has_hybrid(void)
 {
+	static bool hybrid_scanned, has_hybrid;
+
 	if (!hybrid_scanned) {
+		struct perf_pmu *pmu = NULL;
+
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+			if (pmu->is_core && is_pmu_hybrid(pmu->name)) {
+				has_hybrid = true;
+				break;
+			}
+		}
 		hybrid_scanned = true;
-		perf_pmu__scan(NULL);
 	}
-
-	return !list_empty(&perf_pmu__hybrid_pmus);
+	return has_hybrid;
 }
 
 int perf_pmu__match(char *pattern, char *name, char *tok)
-- 
2.41.0.rc0.172.g3f132b7071-goog

