Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D515FF380
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJNSRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNSRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:17:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC862C64A;
        Fri, 14 Oct 2022 11:16:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fw14so5631052pjb.3;
        Fri, 14 Oct 2022 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8lu99TreD62VQY25U22MDIq+Ln7QdQfqyolDbpUShM=;
        b=IxfH68BU48muWWR3n0/1IfsZ+6nK93/nbIFlczi0zRbxn9AaHXbhz5qE7G4anwchkF
         SDg9elaLPNnhsfVtfjQDT42WNwLhfrAZdkFzgluT5J6SgIFgNtv86WCxX0aYoFrdztx4
         pfx0KHHx6ExECUsq8gcdUpk/DcZGghigqtMimsB+AkL9VC23Al4WWeWFMsZKmfn30DVT
         tp3r6bwXKVFLp8Qd7+8/VH0SSJsvw4oNdf1TQzGz93yaLI9Z7XZpQ8qH2nyMZAFOZTJc
         AzDe4qcr6TOkV6s2ZrpRgi2owcdeUVhhVlffi2ePFCIdGENwsrbO3WnxHy5NPC93W5ba
         uuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8lu99TreD62VQY25U22MDIq+Ln7QdQfqyolDbpUShM=;
        b=mHnkI8VCgbK3G6CohI+jplp6Z2V8tEyZDr0yvz+ZIt33MijyJTg38b03wdxQX+83Hv
         L0yehkH/AkGp8XsLDekZRnO/QdH2M/LHYowH/5nRb14DVZGwbihOqnbJg5Sw/5IW/Bud
         ByWExjWfkiy1deypCAh0onkgbeSHcsmWE0kZ8PWUuXP24thxOgv/nS647vgUwovRFdQT
         RBV6Kke5/MZrk3IQCvBpA5uuBjWiQkF1jLeWRe+b0+N6NgDeWyye3U0FO490AOBHEe5g
         QWMyUFpNLVaalTddkbSMhwCd8TiJfzMllY/LgEFUrFYBPiyVB2qulXbIOh7myw19r/BI
         rJBQ==
X-Gm-Message-State: ACrzQf0kH+1mhwYec7PSNBdeHbhzDHBFO5MqLDwdTFA9kpO3Cz3cpm0f
        4x241SS8LAl9HCYQt61+s3k=
X-Google-Smtp-Source: AMsMyM6qR2AUN7z94MI32vIFmmxMs+HiEaT9GGJNmgyQyywpzMVUhpeGTd1qfmUK9CnAVVwQe8rjBA==
X-Received: by 2002:a17:902:8309:b0:17a:695:b5bf with SMTP id bd9-20020a170902830900b0017a0695b5bfmr6138455plb.35.1665771419037;
        Fri, 14 Oct 2022 11:16:59 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:f2c0:9a9f:e007:3520])
        by smtp.gmail.com with ESMTPSA id g18-20020aa79dd2000000b0056149203b60sm2058940pfq.46.2022.10.14.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 11:16:58 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 20/19] perf stat: Factor out evsel__count_has_error()
Date:   Fri, 14 Oct 2022 11:16:55 -0700
Message-Id: <20221014181655.771612-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <CAM9d7ch_CV3mpno+6D23UGaXzL9zhmzmt513RzbWq8q_0DhU4A@mail.gmail.com>
References: <CAM9d7ch_CV3mpno+6D23UGaXzL9zhmzmt513RzbWq8q_0DhU4A@mail.gmail.com>
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
 tools/perf/util/stat.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 6ab9c58beca7..9dfa8cac6bc4 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -396,6 +396,25 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
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
@@ -450,11 +469,9 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 
 			/*
 			 * When any result is bad, make them all to give consistent output
-			 * in interval mode.  But per-task counters can have 0 enabled time
-			 * when some tasks are idle.
+			 * in interval mode.
 			 */
-			if (((count->ena == 0 || count->run == 0) && cpu.cpu != -1) ||
-			    evsel->counts->scaled == -1) {
+			if (evsel__count_has_error(evsel, count, config) && !ps_aggr->failed) {
 				ps_aggr->counts.val = 0;
 				ps_aggr->counts.ena = 0;
 				ps_aggr->counts.run = 0;
-- 
2.38.0.413.g74048e4d9e-goog

