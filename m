Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD469BFBE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBSJia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjBSJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:38:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8969740D6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:37:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h204-20020a256cd5000000b00953ffdfbe1aso2267589ybc.23
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ApboYwC5HDpqa4KgO9vE7lItPOtxh0INRVt9hDTELA=;
        b=eKrS9YbE5MvFZdViv4py+wujaC6AoA78JFYCdWX32lF9PoiXUgE3idq0OBKkFhvJ8L
         8iy6lGZX2pkmRRG5L9VoyF4JMYhESKqhxg1bQRw3cbXu9cp0CTVAsnfEx7iX0m8WcHmJ
         0khwL4pKRPFny0ZCfaK1RnTWEWhb3jRklhCcxexJ/lPXaF39kJkIOOWW9PvDQfhH3qw8
         i6SXakOmGvzYKxm+6U79/2sZgCBcFrdbqgmoGs3Zp43La0bVDCky0ubQmF3HRG8l/moZ
         Or4Qbi5jk1XP9gTTmxi3oHJe1J1/5t4dUvhGzSs/SXr7RmRzmHYiWa0KAaYnoxYzSygO
         fbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ApboYwC5HDpqa4KgO9vE7lItPOtxh0INRVt9hDTELA=;
        b=BNixwsjfXHEcPz1iFVz3cp/TAnJUNz1d+zWvKUnI6oHklHpTWfaFA9OOYbWfH5Rjmw
         VR0AZtoeu0bka7P2ML8Af6IhMWCtp9EXaxkPzwxTJIOM98NHrsVZHAeE2jE//gAHNoPF
         yPHPXqgpST8mqguYQcTneS8vpcq74Oox2DaMkZe942jlBDPu6HDIQ+fAWAcm5y6mtSGH
         K1roptYPssbUCUYAAL+mCm30z6f1+VzXSQjOfeVffVmbvPwf6nMg8ZaApOZxsW1nxd7T
         Z4sa26aUae4N9RRx7MnExm76mMvkae1SOyArXWfIIBU3mstq1AXE5W70XXLnLsvKCOKL
         Z6Sg==
X-Gm-Message-State: AO0yUKVMNWPce3WfhRy1hBY0ScrRrlakv/QggtAv2z/eVxZNGFWq0CYA
        qo01AvL84nX/CFjfIrKDO54PTLJxvRJ8
X-Google-Smtp-Source: AK7set9l7EzTRgvXB15GxGWCICFKm8udU74GJTOUVF1jH0sNKtgIcL7PqS/JykUEiXuu54Ngmu99y9XTMRbT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a81:e94c:0:b0:507:68eb:1b20 with SMTP id
 e12-20020a81e94c000000b0050768eb1b20mr311210ywm.236.1676799327857; Sun, 19
 Feb 2023 01:35:27 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:43 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-47-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 46/51] perf stat: Move enums from header
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enums are only used in stat-shadow.c, so narrow their scope by
moving to the C file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 25 +++++++++++++++++++++++++
 tools/perf/util/stat.h        | 27 ---------------------------
 2 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index d14fa531ee27..fc948a7e83b7 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -29,6 +29,31 @@ struct runtime_stat rt_stat;
 struct stats walltime_nsecs_stats;
 struct rusage_stats ru_stats;
 
+enum {
+	CTX_BIT_USER	= 1 << 0,
+	CTX_BIT_KERNEL	= 1 << 1,
+	CTX_BIT_HV	= 1 << 2,
+	CTX_BIT_HOST	= 1 << 3,
+	CTX_BIT_IDLE	= 1 << 4,
+	CTX_BIT_MAX	= 1 << 5,
+};
+
+enum stat_type {
+	STAT_NONE = 0,
+	STAT_NSECS,
+	STAT_CYCLES,
+	STAT_STALLED_CYCLES_FRONT,
+	STAT_STALLED_CYCLES_BACK,
+	STAT_BRANCHES,
+	STAT_CACHEREFS,
+	STAT_L1_DCACHE,
+	STAT_L1_ICACHE,
+	STAT_LL_CACHE,
+	STAT_ITLB_CACHE,
+	STAT_DTLB_CACHE,
+	STAT_MAX
+};
+
 struct saved_value {
 	struct rb_node rb_node;
 	struct evsel *evsel;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index df6068a3f7bb..215c0f5c4db7 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -55,33 +55,6 @@ enum aggr_mode {
 	AGGR_MAX
 };
 
-enum {
-	CTX_BIT_USER	= 1 << 0,
-	CTX_BIT_KERNEL	= 1 << 1,
-	CTX_BIT_HV	= 1 << 2,
-	CTX_BIT_HOST	= 1 << 3,
-	CTX_BIT_IDLE	= 1 << 4,
-	CTX_BIT_MAX	= 1 << 5,
-};
-
-#define NUM_CTX CTX_BIT_MAX
-
-enum stat_type {
-	STAT_NONE = 0,
-	STAT_NSECS,
-	STAT_CYCLES,
-	STAT_STALLED_CYCLES_FRONT,
-	STAT_STALLED_CYCLES_BACK,
-	STAT_BRANCHES,
-	STAT_CACHEREFS,
-	STAT_L1_DCACHE,
-	STAT_L1_ICACHE,
-	STAT_LL_CACHE,
-	STAT_ITLB_CACHE,
-	STAT_DTLB_CACHE,
-	STAT_MAX
-};
-
 struct runtime_stat {
 	struct rblist value_list;
 };
-- 
2.39.2.637.g21b0678d19-goog

