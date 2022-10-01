Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526335F1A24
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJAGG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJAGGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:06:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027A212C1ED
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:06:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3547f988c19so60673837b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Qii+hgPKPKNgROLcY0ySesmuzhBUXysFitkb8xtJsts=;
        b=kZ8O2caPqw53jlKugZLlR+Ha0l+KrjBKX2Sa8I9wM+nnPRsYQSeH/Df7IoCdGrUcIl
         rgQE7UAmyPVC2VMDQbPmth6owH/L5RF4o4O4zoOlzdUPIHGd/AEYT5QOJuhcrdfoNKFf
         3aYLJb/6WHhWrQxdKEISRWilw09+C2yno3n9j1hymm5MEHmhcpqOc+0n/xe39xkg+RKN
         hn7YL2DdCVRiSnW2pEUdwZu47kzBDmzv6T2SY9gW5u3YeddJcf2u6cBpFXgEjsI0/k+l
         ply3jBRpOAiZ9MMRH5MF4kXo77kZ0R03iw0vlyeECWlLSoaBjPXIyFewjLqo0RA3PbOQ
         gGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Qii+hgPKPKNgROLcY0ySesmuzhBUXysFitkb8xtJsts=;
        b=acAa4ZzpYqfPFANjOa7jmUZzFnrgvJ7F+zoi2zL+ADTM7FGWZAM5yD0kRXUEbkb0JG
         Gq6N7+H3qCW2oPQf+62pEhM3PPfJp4D2OQMFcBmvDxghQaFOhU/dDkqbxXkoY624MVOl
         qtQVxmj1jloBfX0fXDIGViS1VZ5IDvKPKbQJ/lqoitUI6W+HchnsUYeE0VJ14BXpHx9H
         Hw3KSNoV5Wz8/syOGFZ8Q0Hjp0j0dY1bfh1Tv0rVJTsDS0mHOEPpyJyZTu20Obzn37k6
         ngZoStUdWSSMkknKpqM2sK8QHsFBg+Rt0gJ2tOejGod1MqJxI7si6lA2IVMmxVVcKD6q
         6oqw==
X-Gm-Message-State: ACrzQf3vmd3Iwpjljs5fPctuKOhDzI8uxI8q/Tm/2g6HlR6RFYyD0e+7
        E3Zrv87wBjR8FGn2Kf40vtJGlemtGC3R
X-Google-Smtp-Source: AMsMyM6CSUg0wKtyN/RjOi6+y/dw3yyuWC79SAMLGo1wP4u6qYogIbOdCOf+9bT2czdlpoe/KIHHWrXQKFX4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:de60:c6ac:8491:ce1e])
 (user=irogers job=sendgmr) by 2002:a81:160e:0:b0:356:e96c:d5ab with SMTP id
 14-20020a81160e000000b00356e96cd5abmr3725765yww.506.1664604407953; Fri, 30
 Sep 2022 23:06:47 -0700 (PDT)
Date:   Fri, 30 Sep 2022 23:06:16 -0700
In-Reply-To: <20221001060636.2661983-1-irogers@google.com>
Message-Id: <20221001060636.2661983-3-irogers@google.com>
Mime-Version: 1.0
References: <20221001060636.2661983-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v2 02/22] perf expr: Remove jevents case workaround
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

jevents.py no longer lowercases metrics and altering the case can cause
hashmap lookups to fail, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c6827900f8d3..aaacf514dc09 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -182,7 +182,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 {
 	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
 	char *old_key = NULL;
-	char *name, *p;
+	char *name;
 	int ret;
 
 	data_ptr = zalloc(sizeof(*data_ptr));
@@ -195,15 +195,6 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 		return -ENOMEM;
 	}
 
-	/*
-	 * The jevents tool converts all metric expressions
-	 * to lowercase, including metric references, hence
-	 * we need to add lowercase name for metric, so it's
-	 * properly found.
-	 */
-	for (p = name; *p; p++)
-		*p = tolower(*p);
-
 	/*
 	 * Intentionally passing just const char pointers,
 	 * originally from 'struct pmu_event' object.
-- 
2.38.0.rc1.362.ged0d419d3c-goog

