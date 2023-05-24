Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28DB7100C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbjEXWT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjEXWTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:19:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD610C0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-560ee0df572so29563177b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966740; x=1687558740;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02rUQOyiNwiIsyzOJl6kmDGqZDjZZQRLfOwGjV/VqPE=;
        b=6nKoJ2ZO2zIHMG8Vdhftw3G8IlB6fVDXK39qsnSEPChSilm0wJ/DBoEf/QAb9CKCtT
         sfl6tJ20fNMBLh97PdjBYAb4xwqrGbsF0B0qpOXvzMqb/SbfEy09hJ36UhQFCY2+3EkZ
         Ecs+YMXsSgSVwlenuoOLTusuDp6eMpj4MthxKqw7ozC/oX/4yiAau6Ja80T5wm+YIZph
         wg2k7TOddlTZGJ5APBshhaqD7+LEbnxMoJV6jtZYQq0CsMy27uPahpzu5IDpGWSkBCKC
         hX5nos7aAoj3UzTj18VQxbOd1qzYBmweEpaWI1d5IvW0Fz2DhWgg+2qTJc+zCcK6Z6cc
         uBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966740; x=1687558740;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02rUQOyiNwiIsyzOJl6kmDGqZDjZZQRLfOwGjV/VqPE=;
        b=ew5sau7aZ26skqVhcOYe1Q0kqiv2P6MtKiWUeFAH/9nVwZ2JSbwLtJvn2/glaSJO6D
         Rya5SMzrvO5+KClWwgANCh3xeQ6K/I5zlrR6alnNEpNiWdq/eUDgfSxh130tmorANQzC
         aWpbOpQdvHsDzxUqYgW8Wk8dp+rEacLcCzA48Z8KLBimXh0NCOKEggFBx8w2O5OYwiPj
         kVtm9gZaB4QX+ZYMtDf8yYzO/EuHR+2tf2w124kGD/OKpulBLVW7ic8pDltJkklOdpr5
         4RJBYD5VvlG9xtoSbq/OmogXjpAZ+R8xqvMCO0AEU8k+zCh7C5Mcrl3ttdU84CzH5n/j
         9qhA==
X-Gm-Message-State: AC+VfDz9Qze7UQlOchHMXg2faKwpP/sv6l1YUzfra/jmOGmC6p6iWtnS
        BY+uKlFv4Q16/Ka8EFhm0hna8eWEpxcE
X-Google-Smtp-Source: ACHHUZ4T7vcSgycY4rtVGxUs6e/PZeDHYPYD8NwHQcrQfDN3dFzRusqoyw6Y03vhVSWmL2KloRvoUXcR1GS5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ad4d:0:b0:552:d924:a304 with SMTP id
 l13-20020a81ad4d000000b00552d924a304mr11478114ywk.4.1684966740240; Wed, 24
 May 2023 15:19:00 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:07 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-12-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 11/35] perf target: Remove unused hybrid value
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

Previously this was used to modify CPU map propagation, but it is now
unnecessary as map propagation ensure core PMUs only have valid PMUs
in the CPU map from user requested CPUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 2 --
 tools/perf/builtin-stat.c   | 1 -
 tools/perf/util/target.h    | 1 -
 3 files changed, 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ec0f2d5f189f..d152ab04a209 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4204,8 +4204,6 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
-	rec->opts.target.hybrid = perf_pmu__has_hybrid();
-
 	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP)
 		arch__add_leaf_frame_record_opts(&rec->opts);
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bc45cee3f77c..c70cb0990661 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2467,7 +2467,6 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
-	target.hybrid = perf_pmu__has_hybrid();
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 880f1af7f6ad..d582cae8e105 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -17,7 +17,6 @@ struct target {
 	bool	     default_per_cpu;
 	bool	     per_thread;
 	bool	     use_bpf;
-	bool	     hybrid;
 	int	     initial_delay;
 	const char   *attr_map;
 };
-- 
2.40.1.698.g37aff9b760-goog

