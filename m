Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506837100B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbjEXWTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbjEXWTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:19:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18AB1A2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5657dbf8cecso12750777b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966738; x=1687558738;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GDqhuhALscXPKh6eW/Ok5E7hxu+Cdr1krhYltfFoAk=;
        b=SNqtFPGQVnr4w8egpCSubSaXhVTLKjLdVF/wFOSP5H++vlIJPYJLnjJa+r5b/zXpdj
         sf86HjTJZfzi8pfsa9/f6DQvL2Z5FwyfBykVVjj/ZHiYiiXCPTt0tO+7swzm2O5E0RNl
         6/zf9HDiY1pm0LGnLTrEZzJPX4Rd76VXns+uHlNI+lvhyOzahLwiqLEfh1aTqkEWjhaK
         CIGKxQVPZKq7wkVr7w7w4K28rVnMOSjTDFFQi7yUE5UXpjgB5v5G2VrwtQVzBXpdgaHf
         gDy0Rnq/caZLJZuHgB6qF/VM+Spj9vnVcbEcsH0vYdwkESqr8D7m4HlzTBQUv9KJaNDo
         6qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966738; x=1687558738;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GDqhuhALscXPKh6eW/Ok5E7hxu+Cdr1krhYltfFoAk=;
        b=Iz8vVvMD5M2OELOSKWI86W3nwtmQFFQBlCE6cuy+MJ7wJ+FbRU2MeO8bn0FPvfcIAg
         rL36D6EjTMjTjppI5MkPBDyKuDKczzL83Odwa8+gYd467h9M7SID6OfWgzMRu0DXsnXb
         kQJP95Sb55VpMQsLVsr/ZcvfN74rp4AWbb1NUTStZB2xygYoMU/C5slWPSZbmVqWbl9y
         Q2OOMK9wj7IOGPXIbHkKT2qmhcWgWS9XnS1uCZ7pPL2cFNsfnpdSuW43L5/i5nss9TyT
         jALPw1NArPg/bxveSZGGV9kATLBLPUb12c1cJZuInjbkV4L+vOnY0c/Ozhin6U475Qb2
         tZHQ==
X-Gm-Message-State: AC+VfDwVXQPR2ed7IOcrngT5xWVj9LzCPdXe1G623aYUbX5+O1my+O6w
        fgbPLLTiklp97Zo3ksiud6qb3z9ntXMx
X-Google-Smtp-Source: ACHHUZ62cL31QtcLPt6L7GAvXC3BNk7BWMiqw6dzsT68FbgIH7rTRzHWyAjtzVAe9UpHLGfWmGYM7NAUHAtz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ac0e:0:b0:561:a7d5:ec0d with SMTP id
 k14-20020a81ac0e000000b00561a7d5ec0dmr11443469ywh.0.1684966737912; Wed, 24
 May 2023 15:18:57 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:06 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-11-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 10/35] perf evlist: Allow has_user_cpus to be set on hybrid
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CPU map propagation only sets valid CPUs for core PMUs, there
is no reason to disable "has_user_cpus" for hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a0504316b06f..2e2c3509bec3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1067,7 +1067,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!cpus)
 		goto out_delete_threads;
 
-	evlist->core.has_user_cpus = !!target->cpu_list && !target->hybrid;
+	evlist->core.has_user_cpus = !!target->cpu_list;
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-- 
2.40.1.698.g37aff9b760-goog

