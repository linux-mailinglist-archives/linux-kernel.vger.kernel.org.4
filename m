Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B00971959D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjFAIad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjFAIaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:30:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3456C196
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:30:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso867895276.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685608208; x=1688200208;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBjsD43TTJUA5+5ML4PQTzZNVAmBu4fetqvUzrBnI2w=;
        b=1hFDF13eappzpr3oR5mOqV2PzI8qzt9K5J+pc/kdAnx4yAuAu9g8YIXTNNLCcJYdBo
         coUdghQLiKRTHFVSbF26jiQ1B7LKFDqfpYUFeha1HiYjyrFKjpFDR2JVLFjcbdkhQ2Uj
         6phY7ul7piXiTomRmhI/DczWalXMFCReEKYYgJr0lvY42dyKcYJjVHCI92KXWLGgyqEW
         mt22v0imRp53AZkxFrbFi5v5cHXMXzc0DsK4jRRGWEfHvWOp/erpBPbAydJn39+5yoqY
         Nn1DGiJ6D/xebG+xlNatsvHqinN6tXr7lgHzuErj0Q0L0zSFDfYM1DdbL7wCjLFcvgmy
         H1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608208; x=1688200208;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBjsD43TTJUA5+5ML4PQTzZNVAmBu4fetqvUzrBnI2w=;
        b=hv5bkMr6Jq4VYi+S4nfW9cY6N3mTdiWQ6XeP2bg90qV4EV6aVXQo4aeiav9+QaV6wQ
         GRu72KsEpyLDRb97Y0XyeXOm1fKGg2duNMjsn8O1Go4g091HsiMa2F4kWkUQf86U1pyc
         8KXJtF/7Xcj4+AM9lv6xrzWLVUB0Uh8kpp2X8HX4VFQFqt9+kta3VUNHWJgtOJwXHYgW
         z7UIqSBn9jMgo3gLWYgd8ylzZnxo1M7jC8Zfq7db8PDEUfWl6OOJRO1nXAEtfO6bvH6x
         SfK8/ahzgwoDfplN+fCDSfwMI3gt6HrR7d0P22/PO6pt/4bGuxrfTTUN3TLKNmFOalCM
         ZrLA==
X-Gm-Message-State: AC+VfDwR6rXnPYe2xfXIz0YtoSEXe7MfxPieIckATpnhjohqZnXDQ+CM
        FDakaICf507sfv2xtrXZbzBGGxDw2B+b
X-Google-Smtp-Source: ACHHUZ7fLyH0WGyX4qvVX4LXezYFbkIR8CXYC9O9u/4ZdeyQBvLkHIMozZgAwCoHk+bdhrc0lAu1gnJ+N75R
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a344:94b4:9b8d:a089])
 (user=irogers job=sendgmr) by 2002:a05:6902:1022:b0:bb1:3606:6a29 with SMTP
 id x2-20020a056902102200b00bb136066a29mr2576163ybt.3.1685608208084; Thu, 01
 Jun 2023 01:30:08 -0700 (PDT)
Date:   Thu,  1 Jun 2023 01:29:51 -0700
In-Reply-To: <20230601082954.754318-1-irogers@google.com>
Message-Id: <20230601082954.754318-2-irogers@google.com>
Mime-Version: 1.0
References: <20230601082954.754318-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 1/4] perf pmu: Correct perf_pmu__auto_merge_stats affecting hybrid
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
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
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

Flip the return value correcting a bug.

Fixes: 6b9da2607030 ("perf pmu: Remove is_pmu_hybrid")
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0520aa9fe991..36e163f38368 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1424,7 +1424,7 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 {
-	return pmu->is_core && perf_pmus__num_core_pmus() > 1;
+	return pmu->is_core && perf_pmus__num_core_pmus() == 1;
 }
 
 bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name)
-- 
2.41.0.rc0.172.g3f132b7071-goog

