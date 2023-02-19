Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE569BF67
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBSJ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjBSJ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:29:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63957E3B8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:29:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x7-20020a25b907000000b006fdc6aaec4fso363357ybj.20
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFVME4MawZ7uSatJrZd2lz8rTpTsmAg9tHqKzSK6mH4=;
        b=lYts0MZFkBMWWWqsvbZ4s4LF7YBZTVWoKqr0XB8T3QZMUTOA2s2Z+G/g2UZslwUZuC
         Bg0JfwZvu8l1XTdfCWtyr+kOVvUd3vxdajoINwRuBTIhR35jt0E02ChfAVNX7oNfDnUc
         OQxysWfmRktf3N7SbQdfMUQDwloDegoPhyu+QeutG7viIgr3NSQJg+6Q1X7h+12Q6I/W
         lCtx21C8+b0DCEVf/bHP/8aPsvD8vdxjq3D6aElrMFCmBpWcEKc/gfnWhBWTMFWPGVfd
         G0NcqD61UhEmodEZAPS6XL71MQzBlkE/OwDXXgcA/gAT9OXasg2DRifrqgTUe2QIxicB
         mB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFVME4MawZ7uSatJrZd2lz8rTpTsmAg9tHqKzSK6mH4=;
        b=HJIJ6FXUsc35aEBlKPLKVeKvfhb/F/pf/3/f6WfRpLVs6AmhrXdUXmy4B/lsi0rrqP
         ttQjvecPVl3yvSgJjsppg4FEo0465/5qAzHXyrtwLpZuc46l0UdX3r6a2aP0H/+rQIuL
         QLt8YpFOT8kuGuH8jS2CCllbK12mObcgHdjMIUv0ER/jmrdebq+xCzxGfTZi+JXuVhJA
         WRpS4LN3YGK43QD/pI6tn/DyYrHQZQYSmwU2yONkfkJRf0x4w+iPPm03b8md2UQ+zKeH
         Z1YqOJGvpnGPdQ5vwbmnq7iPCKuEKxtZgbEtbxYZsbRUWnZl4T+tpUfcepRzO8vz1wZ4
         H/GQ==
X-Gm-Message-State: AO0yUKVaOlNqMQR8bm/zvtDLa7WU4rL0utpT/J+NNiPwgrTd0jmABkFR
        3wtuRE0pGG+6XxGcU+sNLhFAlmVW+EU4
X-Google-Smtp-Source: AK7set88ydp5C+tDl9Q//caqm5c4PHb281InYvDmoStSEM3jMHzSTQOu5zeqkSSBL+FN422RFEfJNs9jMi0d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a25:9a45:0:b0:97a:4493:a7b8 with SMTP id
 r5-20020a259a45000000b0097a4493a7b8mr128740ybo.505.1676798949427; Sun, 19 Feb
 2023 01:29:09 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:27:58 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-2-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 01/51] perf tools: Ensure evsel name is initialized
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the evsel__name accessor as otherwise name may be NULL resulting
in a segv. This was observed with the perf stat shell test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 9ab9308ee80c..6def01036eb5 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2004,7 +2004,7 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
 					     perf_event__handler_t process)
 {
 	struct perf_record_event_update *ev;
-	size_t len = strlen(evsel->name);
+	size_t len = strlen(evsel__name(evsel));
 	int err;
 
 	ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->core.id[0]);
-- 
2.39.2.637.g21b0678d19-goog

