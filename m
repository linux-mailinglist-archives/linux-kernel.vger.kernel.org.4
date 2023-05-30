Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BF1715380
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjE3COt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjE3COr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:14:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7743ADB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:14:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb7aaa605so7726605276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685412884; x=1688004884;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JhVHx6Y59p5BY8t5ggwZZWj9vUfyNel0Ky85ZYEFuAQ=;
        b=InsqZGOJ8EtlyykvbzTnPldxO38j91PX4e0Wsotwu+NodzSXdYiMpivRU0QSwVhmgA
         PvdDh/ml27/UcuJiGcxeh29Prl9V032QAtsU7qknhXV/mpBgHBxHNSnwOVK9xrbb48aR
         FXu4mKQAINxI/zrIiQj1FIyg4ow3NLsZnoDSXcxdUtq6tHuzBVFuABOC5XqZeWs0DFHT
         LXO3w2zFtyR4Uq3m5DwuE84v92IsXGfM07qGZryjSYmpD1opQNmBweK3brerWdHGe6jK
         7EpQ2lj58OIRGuHdFp3j+6udKL3uKrm4iardBl4Bx8X5m08GDB4NIJovcYIPB9YD2V3r
         yotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685412884; x=1688004884;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhVHx6Y59p5BY8t5ggwZZWj9vUfyNel0Ky85ZYEFuAQ=;
        b=gFb0DX8/2YIMhIPnDt5xLmBGZWm6YvjJn/XTgG6VCHeH/x4frgWB8EDicMeWhzxZsx
         FSMaUWZbI3YMER+Fryj0cUHxokMoog83m5QMEaLgWpAypnTvdJabyTOrxcqnYAnklZZX
         R5F1vie+NMjkcbIWJEt0WGB7UK2orvYmtHFqWIolVivQl7pqZAy0jEsuhotOyYFLR4Hn
         D1VkHEMINBGAMwwMb3iGbxm8oUC0zbeq+lxOpVWbYjN0yJGIQc7k/H43PsjQS7cYKJlL
         taIroOaaOfT0Mhyf1o382bE6e4zwRVf5rkSArZpKoVkAoQRDbsrZyUrLRHBph9s8utTw
         kRLg==
X-Gm-Message-State: AC+VfDxzIP4pQzAKpd4dtUR3uBDEo9/PD5DLrqc83gvtGozNY1/142bk
        AUpUA05pwCi3RrGdADcPyfud4U1rAnBN
X-Google-Smtp-Source: ACHHUZ40kBnwrflyP7QwyQ27rx4j9fPFlP9lRnsFh7lo51Wo4mstGXpGsMCgJkQ0vA9xClr1/QSe2E7yORBu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:8bc9:a316:5479:7adf])
 (user=irogers job=sendgmr) by 2002:a25:8412:0:b0:ba8:757c:2523 with SMTP id
 u18-20020a258412000000b00ba8757c2523mr577356ybk.9.1685412884707; Mon, 29 May
 2023 19:14:44 -0700 (PDT)
Date:   Mon, 29 May 2023 19:14:33 -0700
Message-Id: <20230530021433.3107580-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1] perf kvm: Fix powerpc build
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
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
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

Missed function rename from pmu_have_event to perf_pmus__have_event.

Fixes: 1eaf496ed386 ("perf pmu: Separate pmu and pmus")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index ea1220d66b67..1039e15c27c9 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -204,7 +204,7 @@ int kvm_add_default_arch_event(int *argc, const char **argv)
 
 	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
 	if (!event) {
-		if (pmu_have_event("trace_imc", "trace_cycles")) {
+		if (perf_pmus__have_event("trace_imc", "trace_cycles")) {
 			argv[j++] = strdup("-e");
 			argv[j++] = strdup("trace_imc/trace_cycles/");
 			*argc += 2;
-- 
2.41.0.rc0.172.g3f132b7071-goog

