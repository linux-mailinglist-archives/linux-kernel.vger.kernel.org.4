Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE76020CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiJRCDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJRCDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:03:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4329D8C47B;
        Mon, 17 Oct 2022 19:02:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l6so12051308pgu.7;
        Mon, 17 Oct 2022 19:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nACLFNBsjYXmah7mo5IuPePokH3SR0lSD6pvQDkNzQs=;
        b=GOtlBAruGtyUlmZCBd0mozdiBCEJAZrxCoMmN9RuJYsOiaEr3K9+17PXsDtwoBVxvs
         AJ2d2EImfPf37t3cMPiWwLoVTX9XxiyayscH4j7GJdZRwUcrQj88Oelyysf33334NNUA
         wdJy4fI3SjWF8NrdW5nljbbgtrW61MdL5F3HNgnz17XkaKj8k3YoXeNn0Phraw4mlLMS
         gYHiEHSdwFgN/Lx65E9+qPXInDKTkfHVSrLtmi6nTn8mlzTh645g9gpUWfaDuXOYkIiY
         YhMu+gGmHzwDPK6cmw3II5yV5fb3TtjN3ogeyb8k1ul0TjOb16zvAkejXh0jYTV4HAj2
         59zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nACLFNBsjYXmah7mo5IuPePokH3SR0lSD6pvQDkNzQs=;
        b=X3UDAI67gC4SDyVnHWChswC5Yjqf1P9bUoCCsES+RWBwz4TepWSdfmdov6xR8drtLQ
         PtcgeNcsttm8jkJ+28aNSAYW+v7RgzYWdDMjz/fvhzKxEzYRacLtJz9kV64RBRO/Hf5x
         Z5sVFQr7sUnyCZXZKgU1JTTPfrnnrECyKHFm3XjT4sxYuymNAmQ/Uu74TOOXeBm4xFs6
         y/mJ9RZdFIbypPz8g3A3hhlJvPYc5bXDyLruUc1XkVxfwpxNHwsXIar3OCEHRqtkMf7J
         Zvsv9rk2gThpxLRrbEyzh7/qUytvmzvTovTcfZYfKeNg0vBVCCMUBb3BDFzgG4AMkaM+
         aogA==
X-Gm-Message-State: ACrzQf1YmW81CrRu0QKW/UyJKCsz8MxqlkGCMeJqgAtZgRFcGduVhHwR
        Fktr2lGswERRqX793ShlQg4=
X-Google-Smtp-Source: AMsMyM6Gq68xtWQnEcyp0ALgcNtFDaCzcXIp16xSJjUbbbBFUE/V9XpkmgnS+F7GWqI1Vh8DfzL95Q==
X-Received: by 2002:a63:4e18:0:b0:43c:2fc7:2eea with SMTP id c24-20020a634e18000000b0043c2fc72eeamr661184pgb.119.1666058568896;
        Mon, 17 Oct 2022 19:02:48 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1f90:85c4:58f0:7a81:6bb5])
        by smtp.gmail.com with ESMTPSA id t4-20020a655544000000b00464858cf6b0sm6851564pgr.54.2022.10.17.19.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:02:48 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 10/20] perf stat: Factor out evsel__count_has_error()
Date:   Mon, 17 Oct 2022 19:02:17 -0700
Message-Id: <20221018020227.85905-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018020227.85905-1-namhyung@kernel.org>
References: <20221018020227.85905-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to have 0 enabled/running time for some per-task or per-cgroup
events since it's not scheduled on any CPU.  Treating the whole event as
failed would not work in this case.  Thinking again, the code only existed
when any CPU-level aggregation is enabled (like per-socket, per-core, ...).

To make it clearer, factor out the condition check into the new
evsel__count_has_error() function and add some comments.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 99874254809d..dc075d5a0f72 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -381,6 +381,25 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 	return ret;
 }
 
+static bool evsel__count_has_error(struct evsel *evsel,
+				   struct perf_counts_values *count,
+				   struct perf_stat_config *config)
+{
+	/* the evsel was failed already */
+	if (evsel->err || evsel->counts->scaled == -1)
+		return true;
+
+	/* this is meaningful for CPU aggregation modes only */
+	if (config->aggr_mode == AGGR_GLOBAL)
+		return false;
+
+	/* it's considered ok when it actually ran */
+	if (count->ena != 0 && count->run != 0)
+		return false;
+
+	return true;
+}
+
 static int
 process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 		       int cpu_map_idx, int thread,
@@ -420,8 +439,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 			 * When any result is bad, make them all to give
 			 * consistent output in interval mode.
 			 */
-			if (count->ena == 0 || count->run == 0 ||
-			    evsel->counts->scaled == -1) {
+			if (evsel__count_has_error(evsel, count, config) && !ps_aggr->failed) {
 				ps_aggr->counts.val = 0;
 				ps_aggr->counts.ena = 0;
 				ps_aggr->counts.run = 0;
-- 
2.38.0.413.g74048e4d9e-goog

