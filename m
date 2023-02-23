Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EF76A0298
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjBWFx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjBWFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:53:51 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26434A1F5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:53:40 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bf635080so110016107b3.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqdZ+G+VG1pXrXKKnIZ+HhiVU4LU/SJNnBh8ENQqCxc=;
        b=FkVPW5Pne6GEsLhxFV5uq6tgPY0W90Ql62F75cJ/6JEft9Qs3BuMx8IqpH6whEnFhB
         jBiAIFrhRK39OrfdF0OclJnRf4uWrUOV7XgsGUIoh3jK0wMk5lbuHNg4FpCEp5WYbnYM
         8y/Ra9oMvTXwm28RkGL+UeON25KoAMcQ+Hds4G45H1byarL2ptd2I999jYaTTQtgeLGN
         /vxACwmkg5Q8sHitLhu5DdSiN8qG61Zw76Rv0WCSMZdWMznKkMdrVzu0odE+EEFpsLIu
         4WFIRZ6HQpvxdCiypiTYi33v+i1op3Ftff7PxLA6HQwLY6GSCI41CrxO5t1RHFXfK9PF
         Q0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqdZ+G+VG1pXrXKKnIZ+HhiVU4LU/SJNnBh8ENQqCxc=;
        b=Qu4EBRcs3JG+GUI8LAQJCJC3Y3Auk0QgG892pBo6wFM35ENskCzarSu5DwBMEb7KaA
         0Nea1UAeVEjF0YqT+bI3ZhGR6lP42oiqameeWU0dFgnAhACnX8QqgIyRa0E+w0Cwu4mY
         gR/PnAM57ec0kqRXsQd4v86kfnZ4rZYeeIlOsrHrZOffuta9xPscmV2XO0gzIA/fLuJp
         zuIjz5u1QvGSXgsSTlmnfimb7WmcxUpPFAGJvni0Msq5SYOVubI8+a8Crrcb55jG7fyB
         xn3LH2C3UVQkm8PluN76VTapeCKHBPYl2PNa3w8NVuX23QSEwvdc9F4tlRaHknJsOeDk
         Iryg==
X-Gm-Message-State: AO0yUKX+EzUJlyinvzeH3UmEKNH3dLR0KcYN4fVvY+1fX/LtavOnc2t3
        0ghIHGkgvCN+/ZqdH/GRgx6W6qwiZ79i
X-Google-Smtp-Source: AK7set+dgqX2j8MuW+xdhwgM+ldNVX/T9gkhXNcSHS8RuMbBK8laFiP6db7m4u8zEoccn+w38ASYt8b6K28j
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9002:67cd:9e6b:7083])
 (user=irogers job=sendgmr) by 2002:a05:6902:154b:b0:9f5:af6b:6f69 with SMTP
 id r11-20020a056902154b00b009f5af6b6f69mr1961555ybu.5.1677131619856; Wed, 22
 Feb 2023 21:53:39 -0800 (PST)
Date:   Wed, 22 Feb 2023 21:53:05 -0800
In-Reply-To: <20230223055306.296179-1-irogers@google.com>
Message-Id: <20230223055306.296179-3-irogers@google.com>
Mime-Version: 1.0
References: <20230223055306.296179-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 2/3] perf vendor events intel: Update alderlaken to v1.19
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
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

Update alderlaken perf json from v1.18 to v1.19.

Based on:
https://github.com/intel/perfmon/pull/58
perf json files created using:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/alderlaken/memory.json | 7 +++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv            | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
index f84bf8c43495..37259d38a222 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
@@ -13,6 +13,13 @@
         "SampleAfterValue": "1000003",
         "UMask": "0xf4"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a DL1 miss.",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to other block cases.",
         "EventCode": "0x05",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index e69b29123327..1c5776e37120 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.19,alderlake,core
-GenuineIntel-6-BE,v1.18,alderlaken,core
+GenuineIntel-6-BE,v1.19,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v7,broadwellde,core
-- 
2.39.2.637.g21b0678d19-goog

