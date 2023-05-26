Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196C5712DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbjEZTpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243271AbjEZTow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:44:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D65FB6
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:44:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4eefebso2442171276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685130290; x=1687722290;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjbMXf/jBCxB/sH0FkQPUm1SvrJy5PH1+LA+XDb0Zps=;
        b=CSctNJp4S2q0DHrryM39VvBZdpM8b8CWJpmP/Q8o9UqglncEroGPepL0FsNvI60yMt
         B6Q4rqPzGsNOOGFkhy7F/HIDdyTq37p6I+BanaCyLBpXsrEpSal/BBzV35RTPVOpKgyh
         cFfFLGntgqWb/3V6Q/+Y0ktWmj/SzpUY2a32i1ViTx5PWJrC62fi76ZeO94yGOgVDx24
         ULDEk4zzHWt+wEgQC6s514iQ3blhMm4ao4OhHOQDcBGYgcMSpDSu43sMHA/kXnpCVbEM
         7Kfxd+HNnuObRfdIWMi3VDfD6izgY79eMmOeBiVCCB0NqIpMMQHAlOGQZXqmNqJkZEfj
         UCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685130290; x=1687722290;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjbMXf/jBCxB/sH0FkQPUm1SvrJy5PH1+LA+XDb0Zps=;
        b=D+rWVXMx2NrU7QE1ZBGNrrQB5XR9Sj2xKtapq+JLmSIG7ziagJwhKvgpCiflcrfw5V
         ZSPB2wnKh7G1yTt/vMyh/Q9V3u4i8NuHSX6MBmXpfqaCoiRkC7PzbgAlehh0rjRitIq0
         O8gpGt1d1cxR6zITcT5Z+ZzwH8SsR1HHtyytLsZD0yguHYClVbHWm2uV4vNNqCnlTiom
         obOg4sU+zUbztHo9P3PoXZd8BY83LxCyfd+Py3cXPu1p79YOt0qvQsoeGfL0M3TjPrIR
         KGk0o2WoLm70YduKYSi0gbLddjEkLghRSRA81O0eMCMolK0lcpjsx4r/4EcCNcKm4YZ+
         liUg==
X-Gm-Message-State: AC+VfDydkv4lwclJojtJqfTaolxlmkQ4uEI/R2WXDOSSeeBxvZPTzcyj
        b2Uj+WwZ8uEbF4escwMIzStdzLeZYdMw
X-Google-Smtp-Source: ACHHUZ4pHyEoD9K2o0Xh8qppwGD7sUhniJqD+UOaHDb0zLqYmdzSraJe1E6XyX8y6Y9/+6eIJkuIvsZV7OGM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:4296:0:b0:ba8:3e1a:3fd6 with SMTP id
 p144-20020a254296000000b00ba83e1a3fd6mr1107185yba.3.1685130290583; Fri, 26
 May 2023 12:44:50 -0700 (PDT)
Date:   Fri, 26 May 2023 12:44:42 -0700
In-Reply-To: <20230526194442.2355872-1-irogers@google.com>
Message-Id: <20230526194442.2355872-3-irogers@google.com>
Mime-Version: 1.0
References: <20230526194442.2355872-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v3 2/2] perf evsel: for_each_group fixes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Changbin Du <changbin.du@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Address/memory sanitizer was reporting issues in evsel__group_pmu_name
because the for_each_group_evsel loop didn't terminate when the head
was reached, the head would then be cast and accessed as an evsel
leading to invalid memory accesses. Fix for_each_group_member and
for_each_group_evsel to terminate at the list head. Note,
evsel__group_pmu_name no longer iterates the group, but the problem is
present regardless.

Fixes: 717e263fc354 ("perf report: Show group description when event group is enabled")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.h         | 24 ++++++++++++++++--------
 tools/perf/util/evsel_fprintf.c |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6d9536ecbc7b..5e8371613565 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -459,16 +459,24 @@ static inline int evsel__group_idx(struct evsel *evsel)
 }
 
 /* Iterates group WITHOUT the leader. */
-#define for_each_group_member(_evsel, _leader) 					\
-for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node); \
-     (_evsel) && (_evsel)->core.leader == (&_leader->core);					\
-     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+#define for_each_group_member_head(_evsel, _leader, _head)				\
+for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node);		\
+	(_evsel) && &(_evsel)->core.node != (_head) &&					\
+	(_evsel)->core.leader == &(_leader)->core;					\
+	(_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+
+#define for_each_group_member(_evsel, _leader)				\
+	for_each_group_member_head(_evsel, _leader, &(_leader)->evlist->core.entries)
 
 /* Iterates group WITH the leader. */
-#define for_each_group_evsel(_evsel, _leader) 					\
-for ((_evsel) = _leader; 							\
-     (_evsel) && (_evsel)->core.leader == (&_leader->core);					\
-     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+#define for_each_group_evsel_head(_evsel, _leader, _head)				\
+for ((_evsel) = _leader;								\
+	(_evsel) && &(_evsel)->core.node != (_head) &&					\
+	(_evsel)->core.leader == &(_leader)->core;					\
+	(_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+
+#define for_each_group_evsel(_evsel, _leader)				\
+	for_each_group_evsel_head(_evsel, _leader, &(_leader)->evlist->core.entries)
 
 static inline bool evsel__has_branch_callstack(const struct evsel *evsel)
 {
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 79e42d66f55b..a1655fd7ed9b 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 #include <stdbool.h>
+#include "util/evlist.h"
 #include "evsel.h"
 #include "util/evsel_fprintf.h"
 #include "util/event.h"
-- 
2.41.0.rc0.172.g3f132b7071-goog

