Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B070712F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244271AbjEZV5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244390AbjEZV5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:57:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56C116
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:56:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564fb1018bcso30867997b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138132; x=1687730132;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I37rqh5cG8jyPI8CnkZDKw7uLKTCQzZXDibgw5Pks+s=;
        b=7vbUEjTg++uSRlxt9/L8w7EUfHc0cEng9J5xXYzkNK4RtEub32q+k1MjWS4ZoqgJVp
         bPakSgV6smTXGiuXxRwa+gbjMAHBndhZ0m4m7hRjgRVz+pMZzBDU+8jPInIiyMCbcDFO
         zhK0BCKwSsIXCqjGxY8icTH2xYVL8LcmhKtERl7jtq5kBg03lb5Z8+c5XjLm5udvEf+w
         qaU1g/frJAEfQgaE+aXUU1tmJcdcdkPHa3fqhn0uMJwn2rLJicoPv8aiFc4gkXi+Pacw
         g7/MqOE388AMWjIY+OcZdDllz8WfOf9h9CoQZCpSqa4kUAuh8KytEZ9C0cTpfsm172eC
         Arsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138132; x=1687730132;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I37rqh5cG8jyPI8CnkZDKw7uLKTCQzZXDibgw5Pks+s=;
        b=O3Yo4h/g9q+XFUii+gC6640ti1b8hE22RtOFnzgAdLj1L1YqQndVEo6EWgCe+D9IBd
         Soj+vUK6qsWqhAn7+jKIWNitl5GMEXbl3ytXW9q5qZDcgUyHExiGJKbi6oBZW6U/tYtR
         fKUBRKzkr6lKsRd9eiOzTz17zlrh+jrTG87wQe5VnFoSkfMo07mmVfaGLtcSDeUlcT/M
         vdaLfAoATThJuXB3+Wq+iPTiqUh4BMyHpQBCrSvdvw7CeNuGhfkON2/8x21vboVOMVbS
         jPz91xLTDGeCSrrkHSnW05qM4ViGG+HonW9KLWFAGBIswhHGCIZGTosx+TX4G79vi/yB
         ZdaA==
X-Gm-Message-State: AC+VfDyRN4hA/PiuN6JSDMuYWvmzzQw/bDY/RII1a91NBI9ZoDa4A1Yp
        xAck/UjG/tbbVerXG7pf9oxtIOOa861e
X-Google-Smtp-Source: ACHHUZ48ljorUNxuemfq25gYwZO+QkJCDIdXd2cai4k6TFvPbsNPR0m3OMWBkqmC6SCuVN9fnpWdn+ntMCja
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:d84a:0:b0:562:837:122f with SMTP id
 n10-20020a81d84a000000b005620837122fmr1901844ywl.9.1685138132485; Fri, 26 May
 2023 14:55:32 -0700 (PDT)
Date:   Fri, 26 May 2023 14:54:10 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-36-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 35/35] perf pmu: Remove is_pmu_hybrid
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

Users have been removed or switched to using pmu->is_core with
perf_pmus__num_core_pmus() > 1.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 7 +------
 tools/perf/util/pmu.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7102084dd3aa..0520aa9fe991 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1417,11 +1417,6 @@ bool is_pmu_core(const char *name)
 	return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
 }
 
-bool is_pmu_hybrid(const char *name)
-{
-	return !strcmp(name, "cpu_atom") || !strcmp(name, "cpu_core");
-}
-
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 {
 	return pmu->is_core;
@@ -1429,7 +1424,7 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 {
-	return !is_pmu_hybrid(pmu->name);
+	return pmu->is_core && perf_pmus__num_core_pmus() > 1;
 }
 
 bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 02fec0a7d4c8..287f593b15c7 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -221,7 +221,6 @@ int perf_pmu__format_parse(int dirfd, struct list_head *head);
 void perf_pmu__del_formats(struct list_head *formats);
 
 bool is_pmu_core(const char *name);
-bool is_pmu_hybrid(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
 bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name);
-- 
2.41.0.rc0.172.g3f132b7071-goog

