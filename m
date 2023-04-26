Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52D66EEEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbjDZHC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbjDZHCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:02:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13C4233
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9229dd8c62so7505395276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492520; x=1685084520;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiBqu+eAww97O/97VLe65d9bhhVAzSpreWJRIJD1hF8=;
        b=qCPTKPAkdd6ZDSLxXMEWiEVWcpRIA0sE7KzQdiC4ar3/yxSYEfLe7V8tr7EOFED32y
         kG/PqUXqo7he3VlQ6BqiG5yZxyjRHGYRAjOK4Ipa5hfQ4djJJy7NlI2D/n3Wrj05b9JY
         ImcEXQs9e90GKrGkRN5cxuOF/vP42NOre5fwKDTfwWQ1jS37sh7S4tdET/EPXDhKg+b6
         pAyCDWvfXJB6X7GrrthEucOOJUgtSJRI53ExcTivYx8gFV1W8W0IuJcJbXFUy4P53kFu
         mLVFMmeEa+vjK2Ovw/pFufBsKIan4i6Rf9jHbvwGg0ENsovNtjyAcuX2eCEx8Ia9FAhd
         a2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492520; x=1685084520;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiBqu+eAww97O/97VLe65d9bhhVAzSpreWJRIJD1hF8=;
        b=YH2axu7G5YaNGTzii3+nl84EF5+gTkFRTj1SxQcAJ8oqTzTqJu9J4ZncRuNzThlHeF
         o+wJqthSA/MSUTk3VblwwK9XxVW6f6fogJv8opNlBsHhJiMOW8E2VIqF9XbYGqJvcJUJ
         tPlks0VVQQlIw70lNRCkMzS5+p5pY5LIp2UJP2jOUIJSyFwL/D6Goqs9tSS60Wdjr0hZ
         UFnRCsTRdrgFu0CGcrFUPz4LoAiU6eldOHN+4XVKuXC9tHHu4/3KgLhMCvTOpGVtIxhL
         fVEEOWOTUcZU2xA8Kjfd1sDGkcxcDeyZe9aDmJzSZYN/vaUJCQ87RrKbJNIc9A9rla/J
         GGLg==
X-Gm-Message-State: AC+VfDzHvCbHdWRVpXC6aUlkCMA985KWBFcVjY32pGxf44HN6BLTxIH/
        TD9yLf+FTxy/H6FwREGE9SvB0GzLO03O
X-Google-Smtp-Source: ACHHUZ7XboWPDRNvVt+K/ZmYBPeDghLrO9PAzCKwPDUwIqHVeFa+nhpDM6XBmwmgStp9qdPYGid/1Slk4xdN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:dfd4:0:b0:b99:a54e:a61 with SMTP id
 w203-20020a25dfd4000000b00b99a54e0a61mr5606896ybg.1.1682492520044; Wed, 26
 Apr 2023 00:02:00 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:17 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-8-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 07/40] perf stat: Avoid segv on counter->name
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use evsel__name that doesn't return NULL for hardware and
similar events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6b46bbb3d322..71dd6cb83918 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *counter)
 	int ret = 0;
 
 	if (counter->uniquified_name || counter->use_config_name ||
-	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
+	    !counter->pmu_name || !strncmp(evsel__name(counter), counter->pmu_name,
 					   strlen(counter->pmu_name)))
 		return;
 
-- 
2.40.1.495.gc816e09b53d-goog

