Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3128E712F40
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbjEZVzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244184AbjEZVyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:54:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BB3E7E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bad0f5d6a7dso2466989276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138077; x=1687730077;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKlpZwIe+ZNMqSgCu8evjP4rcM8k5wR/kLw9LO8buYU=;
        b=vNEf07wd38olMIygDeoN49eL3LrM0kx+zZ/2Cv31L5rDqcu2u2HMGY22UqYAcRclhi
         xWcmudR/+KOmxloT1A+yCwbznoNqXA4muU4fC1iUhPu8yMN49rI+7ouhO7dxgVUSV/1a
         M2GvRHB7/EIDnQRRuoPRWKiOBbbCg2df/G0QdYaRJuekP9Q7ni2yTvJ4WD+VfQaki8tq
         v/sa5aeVQjSgtZlOUbhllM0Nf92nMRqw5PvnH9rVL6CIb3pdJOWFElwTFpPs0jXZOuUg
         mF8eG457uLaz65pA5jmMcOcdiqubBxp0wvSQdZyfI+Jy+eu4iahJXLaJi18YYG4XDmDD
         tcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138077; x=1687730077;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKlpZwIe+ZNMqSgCu8evjP4rcM8k5wR/kLw9LO8buYU=;
        b=LPMTh5fQXFkbarlzV/kQdZ9N+PKVRtSW5H+vvIPa7xG8ycUXGLFan+jYHSoOhB4P04
         BEu0YVA1fxyAmDlxbALHqDyTRF+vee8fzPz5ewddtvlOJV4aKmZCb+vttopXoX1fc1md
         F9VasMliS0iCrjXVW+/fZuSi4lqMQLBaqSOc/Xtg7CDPhQj8kzEBKCXOoGaaV2xyEvqV
         FhUUtg6SnvLb4VJxp/50W4GNdtpf/lgp103CA2eyHowN2lUnLS1q90rn7jYIdwAXVs5I
         W2GRh0aNTmOjs4DvaSW+zwZrbTjB4yXSt6p1wz7EEVifRy8cDEZ1lC3EaNhIsUx0cyKj
         I3tQ==
X-Gm-Message-State: AC+VfDyY8c5+5/0BzNnSqf5hEKsWwjI44uXOJ5trOidnw/f1ZOCj2wEh
        AGPJz5iRDvG0Y4aram9SzIVTfKAhORKE
X-Google-Smtp-Source: ACHHUZ7ivDl73fOYK0vU1vrJjuIWaoWY5OCr6BiWrhf+oEthpQhEpQTfyirjwDEjzcJSSvlUL0oqtE+qh/I2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a05:6902:4ef:b0:b9d:d5dc:5971 with SMTP id
 w15-20020a05690204ef00b00b9dd5dc5971mr1726290ybs.2.1685138076985; Fri, 26 May
 2023 14:54:36 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:45 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-11-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 10/35] perf evlist: Allow has_user_cpus to be set on hybrid
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

Now that CPU map propagation only sets valid CPUs for core PMUs, there
is no reason to disable "has_user_cpus" for hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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
2.41.0.rc0.172.g3f132b7071-goog

