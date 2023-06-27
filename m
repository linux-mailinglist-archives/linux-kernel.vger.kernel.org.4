Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD197402E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjF0SLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjF0SKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF762D48
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573d70da28fso67125877b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889450; x=1690481450;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pylB9mwmAKl3TUVj6l4nL/JaxRJCwOWbixQnNb1VbG4=;
        b=DwonPv3+k7d87RYPLiQHRluN8geVSL/JuBedm0iIRSSridMUKd+QRAh1UTNbrX4Rc+
         2tRuCmYb7a+HMHtj2KZX571wOPyJrGR60Dq3/+JaFxSG0GwbdlvEzEp6fxBQetHs3DJ3
         yFXaBGg9M+J8lE9iiX4UNTSDmX6x5pSWn2U5u/BIDPEoK5Qg185uhmRrS8ED6F1LE5jG
         dabyrr6kNBhj3hMpTPKXaptlQ3c9GVv9jv0jzRjvzTvVfngEgYWKc5xQfRpm1tT/IC7W
         irQV1RF7wayw3JHLbxBub63u0hwGyuMWjq1Y/13neXOMviL18Rv36saBLHX/JYwsdlo6
         mElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889450; x=1690481450;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pylB9mwmAKl3TUVj6l4nL/JaxRJCwOWbixQnNb1VbG4=;
        b=cacG/F63VuUTVssDMvxiN22x1rNUbTrVslyE7Kmev2yGp37Mbeit+eHqIHxNP/9owq
         1+FDyTdDxo30DdL9BGCfd0bXxoPxb/HI5kRrKKD7VJtGe7wHWFJeVmaaB+/N0CgsnN5Y
         vjbSU56JL+6z+4eEa4im9NlWB7BTZ8APcLh1SJOBGFpxFNIvKgGAgu6zEbNqslTumGHf
         9HwqtTAPCMIwYwO7X6EDxjSRh1u9fQdv04gE1UCm2TaUNLCpR+Nn+eAl8PUt74a+W0DR
         YvnM3aMNDr6RAllA5Mz6Fseha0QVyvWRR5sokVoOFZcHUkAQUbprKnnHK5SRRZVGVI80
         WQkg==
X-Gm-Message-State: AC+VfDzWPsOW0We9HA6evS+TYjy7Lpu9JumcUUfk+NLk/k1mJMa+3Eyh
        y5lghjEKRwfMd/9m4Hf2NtAp5Y8aEJyX
X-Google-Smtp-Source: ACHHUZ4XYIxsTEbA4adKWxNXnm8MjJHZ+dVuNGVRGkIxnc/aVH6goL6IK/5IA70vJOxc3jszcWLIrfctyYob
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a81:ae64:0:b0:573:7ae2:2684 with SMTP id
 g36-20020a81ae64000000b005737ae22684mr9718244ywk.4.1687889450770; Tue, 27 Jun
 2023 11:10:50 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:21 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-5-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 04/13] perf parse-events: Add more comments to parse_events_state
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

Improve documentation of struct parse_events_state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b0eb95f93e9c..b37e5ee193a8 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -121,17 +121,25 @@ struct parse_events_error {
 };
 
 struct parse_events_state {
+	/* The list parsed events are placed on. */
 	struct list_head	   list;
+	/* The updated index used by entries as they are added. */
 	int			   idx;
+	/* Error information. */
 	struct parse_events_error *error;
+	/* Used by BPF event creation. */
 	struct evlist		  *evlist;
+	/* Holds returned terms for term parsing. */
 	struct list_head	  *terms;
+	/* Start token. */
 	int			   stoken;
+	/* Special fake PMU marker for testing. */
 	struct perf_pmu		  *fake_pmu;
 	/* If non-null, when wildcard matching only match the given PMU. */
 	const char		  *pmu_filter;
 	/* Should PE_LEGACY_NAME tokens be generated for config terms? */
 	bool			   match_legacy_cache_terms;
+	/* Were multiple PMUs scanned to find events? */
 	bool			   wild_card_pmus;
 };
 
-- 
2.41.0.162.gfafddb0af9-goog

