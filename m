Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A306C0962
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCTDj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCTDjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:39:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A1C1B55A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:39:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z31-20020a25a122000000b00b38d2b9a2e9so11653999ybh.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283555;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp06SaO3sEqKpsudj2OEFM6hmtCSHDlmEVrT0Oyh9g0=;
        b=oVlLy7C6zk07uvV078+G3tAiOSzYAnnphvIKsGkr7X87lY7rdXejY5aqdAZhnZqurU
         NLmHm30WqEW3T4Ohz83AZNdwIWA6BqcBR51g66JhSdnUB7xRaQw7PU2zYgMibh7YrqIq
         9ZpEBh7W7VfsRswyeQNnDf7VnFEPy0zWYb+cMafP1CKpk/2l3eQRqA1CnuX1SzUIaMWr
         r63nsFVxf5KF2TKfTYcpNWMAD4DyXgcYuzFT/9jJUuHF6VK6HrQ07RrMtoOuAL/ZjWKt
         zoWMGS/5DkjqASK2ZdZrIcQmSSRA/BLLQIk4M7DZAHsdX88Ep1WdRiCCP8rADhVeSBRx
         70KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283555;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp06SaO3sEqKpsudj2OEFM6hmtCSHDlmEVrT0Oyh9g0=;
        b=Flt1qRzIYOVnHmTvpISEhnu0iJ7Si6VxaT2SJ7xeUAS95UlL+qOjgABwdljZpmnjQE
         vGb/a7kPlJrYA9e90mFcchOXpNV59vLD4gFmvuw2iak1kgwY46DzaxG/T+FWhu+K40dt
         vHkcweocdzIUFGrmLXs6tJy6yAXaSInbi1bCV4NNZ1zv1BeISvvF8VMnm+T9j20GoGGJ
         LAdirZx2wikngAkQWurMeHJeci+Fg9TQGbQ6+vDbNrG4aEjtxSTED4zI2YgNMqp0IDPX
         HTAoxrt63DAgnvyiW34DnWL+RqjlWD/OthXw352SVlipVkyaE6Q6HGdsRgwCeTa6l+mB
         jrFg==
X-Gm-Message-State: AO0yUKVSsqPKzj4jUdxyHnEptzrGQeL0skurXYwgcTpmti/qBIKY3Gvp
        Eep1q8ILoeYAPfgpAvdhPr4zqGtiHKjU
X-Google-Smtp-Source: AK7set8DXFIYSHJXW7PIqklNOFVLXkRtk81Ryce9utE5CyGINekjemf91kZj1GKnU0xUvk3YNr67AY0kdQGO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a81:b649:0:b0:541:8995:5334 with SMTP id
 h9-20020a81b649000000b0054189955334mr9279059ywk.3.1679283555031; Sun, 19 Mar
 2023 20:39:15 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:37:53 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-6-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 05/22] perf symbol: Sort names under write lock
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If finding a name doesn't find the sorted names then they are
allocated and sorted. This shouldn't be done under a read lock as
another reader may access it. Release the read lock and acquire the
write lock, then release the write lock and reacquire the read lock.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 317c0706852f..a458aa8b87bb 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2018,6 +2018,9 @@ static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 	if (maps_by_name == NULL)
 		return -1;
 
+	up_read(&maps->lock);
+	down_write(&maps->lock);
+
 	maps->maps_by_name = maps_by_name;
 	maps->nr_maps_allocated = maps->nr_maps;
 
@@ -2025,6 +2028,10 @@ static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 		maps_by_name[i++] = map;
 
 	__maps__sort_by_name(maps);
+
+	up_write(&maps->lock);
+	down_read(&maps->lock);
+
 	return 0;
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

