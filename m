Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49F76B7641
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCMLm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCMLl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:41:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E3D65C79
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so16615193pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MNnE3quOGvdDqG29dvywID+kT+Z2WHpLbe0kchj83s=;
        b=iHjA3HW8bxjICMYAwwBDMXriyMjyCoGNWZ/IveRUvJW4I6xPCm7LH5JpBJLKACCqtE
         2oxp+1EWlDjdTKJ4/7d9ZN8D1toR6VnB+osaCLpwEqUe0DTvc3wYuVBYyEOQdZvtdiaC
         laxiGP4xy8G5J+LrjSJJrHZUUvj+MM7njQJQyNbHlbfC882XG6Lte6uXLiOoVK1QfVOT
         v/dOWRujYZN80ljZDW+MbMxBF6pj0uCLYwyh3TVCxnwaFkEB5r0+IYVIpxnYRWaep+4T
         cBAfNOMFs8o05/YvHuF8EICP5jVx55lYWeaCb0V/TlADMTa/ceQuk8iAGV5O9iFZuKFZ
         sumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MNnE3quOGvdDqG29dvywID+kT+Z2WHpLbe0kchj83s=;
        b=bsy7i57ZyOMu4iN8LtPzTTtkB9UbHXY7RIbo9xoHVi5ZKEvVnGI9zYA0K6gDkySYuO
         Znve4kNZF/WajuBBBNzquBQpzJQeEpJlluNTeAQS2bhvfka5BvabzWSyERflNu21hXmR
         fk8KT7NyuQRK0Fs26DC0lY/SGRLJjNBoFPE0/XKDT7o19Q3HIiPjetBvO3jRFFV2EADo
         JqN+0Dy7Tu35JY30MiqxAAhehQgucVOQ6KeFThbo4jLNhZxuRfEMrjLKCPFbP5/FcdTA
         9ssHCQUcAuKZpyAlSIRiIIPk/ap134fucx7Wvyj5JCou5WIihaZEUwC+bjl5f2WIjf1n
         BDGA==
X-Gm-Message-State: AO0yUKUpMl2d0hQnpbXggvLx0LEF8UHOsO4Z1e3LGjX11zj8L64h1KQF
        aeJLtiLnqE57LTXG8avhoedsQw==
X-Google-Smtp-Source: AK7set9qrpXHCAgUfFwP2EzkBC5cR7tRC1nhrOapmqeyF1RayxLJTVQq/lkK4gReOoRBRAcZUst1tA==
X-Received: by 2002:a17:90b:33ce:b0:234:5eb:2177 with SMTP id lk14-20020a17090b33ce00b0023405eb2177mr36787199pjb.9.1678707680030;
        Mon, 13 Mar 2023 04:41:20 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:19 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 09/16] perf hist: Add 'kvm_info' field in histograms entry
Date:   Mon, 13 Mar 2023 19:40:11 +0800
Message-Id: <20230313114018.543254-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__hists__add_entry() creates a temporary entry and compare it with
existed histograms entries, if any existed entry equals to the
temporary entry it skips to allocation to avoid duplication.

The problem for support KVM event in histograms is it doesn't contain
any info to identify KVM event and can be used for comparison entries.

This patch adds 'kvm_info' field in the histograms entry which contains
the KVM event's key, this identifier will be used for comparison
histograms entries in later change.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-annotate.c |  2 +-
 tools/perf/builtin-c2c.c      |  4 ++--
 tools/perf/builtin-diff.c     |  4 ++--
 tools/perf/tests/hists_link.c |  4 ++--
 tools/perf/util/hist.c        | 19 ++++++++++++-------
 tools/perf/util/hist.h        |  3 +++
 tools/perf/util/kvm-stat.h    |  4 ++++
 tools/perf/util/sort.h        |  1 +
 8 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 90458ca6933f..4750fac7bf93 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -252,7 +252,7 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
 	if (ann->has_br_stack && has_annotation(ann))
 		return process_branch_callback(evsel, sample, al, ann, machine);
 
-	he = hists__add_entry(hists, al, NULL, NULL, NULL, sample, true);
+	he = hists__add_entry(hists, al, NULL, NULL, NULL, NULL, sample, true);
 	if (he == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 56974eae0638..d3181fee4d3d 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -315,7 +315,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 	c2c_decode_stats(&stats, mi);
 
 	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
-				  &al, NULL, NULL, mi,
+				  &al, NULL, NULL, mi, NULL,
 				  sample, true);
 	if (he == NULL)
 		goto free_mi;
@@ -349,7 +349,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 			goto free_mi;
 
 		he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
-					  &al, NULL, NULL, mi,
+					  &al, NULL, NULL, mi, NULL,
 					  sample, true);
 		if (he == NULL)
 			goto free_mi;
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ed07cc6cca56..22b526766e14 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -423,7 +423,7 @@ static int diff__process_sample_event(struct perf_tool *tool,
 	switch (compute) {
 	case COMPUTE_CYCLES:
 		if (!hists__add_entry_ops(hists, &block_hist_ops, &al, NULL,
-					  NULL, NULL, sample, true)) {
+					  NULL, NULL, NULL, sample, true)) {
 			pr_warning("problem incrementing symbol period, "
 				   "skipping event\n");
 			goto out_put;
@@ -442,7 +442,7 @@ static int diff__process_sample_event(struct perf_tool *tool,
 		break;
 
 	default:
-		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample,
+		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, NULL, sample,
 				      true)) {
 			pr_warning("problem incrementing symbol period, "
 				   "skipping event\n");
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 14b2ff808b5e..e7e4ee57ce04 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -87,7 +87,7 @@ static int add_hist_entries(struct evlist *evlist, struct machine *machine)
 				goto out;
 
 			he = hists__add_entry(hists, &al, NULL,
-						NULL, NULL, &sample, true);
+					      NULL, NULL, NULL, &sample, true);
 			if (he == NULL) {
 				addr_location__put(&al);
 				goto out;
@@ -106,7 +106,7 @@ static int add_hist_entries(struct evlist *evlist, struct machine *machine)
 				goto out;
 
 			he = hists__add_entry(hists, &al, NULL,
-						NULL, NULL, &sample, true);
+					      NULL, NULL, NULL, &sample, true);
 			if (he == NULL) {
 				addr_location__put(&al);
 				goto out;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b6e4b4edde43..3670136a0074 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -4,6 +4,7 @@
 #include "dso.h"
 #include "build-id.h"
 #include "hist.h"
+#include "kvm-stat.h"
 #include "map.h"
 #include "map_symbol.h"
 #include "branch.h"
@@ -698,6 +699,7 @@ __hists__add_entry(struct hists *hists,
 		   struct symbol *sym_parent,
 		   struct branch_info *bi,
 		   struct mem_info *mi,
+		   struct kvm_info *ki,
 		   struct block_info *block_info,
 		   struct perf_sample *sample,
 		   bool sample_self,
@@ -733,6 +735,7 @@ __hists__add_entry(struct hists *hists,
 		.hists	= hists,
 		.branch_info = bi,
 		.mem_info = mi,
+		.kvm_info = ki,
 		.block_info = block_info,
 		.transaction = sample->transaction,
 		.raw_data = sample->raw_data,
@@ -756,10 +759,11 @@ struct hist_entry *hists__add_entry(struct hists *hists,
 				    struct symbol *sym_parent,
 				    struct branch_info *bi,
 				    struct mem_info *mi,
+				    struct kvm_info *ki,
 				    struct perf_sample *sample,
 				    bool sample_self)
 {
-	return __hists__add_entry(hists, al, sym_parent, bi, mi, NULL,
+	return __hists__add_entry(hists, al, sym_parent, bi, mi, ki, NULL,
 				  sample, sample_self, NULL);
 }
 
@@ -769,10 +773,11 @@ struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct symbol *sym_parent,
 					struct branch_info *bi,
 					struct mem_info *mi,
+					struct kvm_info *ki,
 					struct perf_sample *sample,
 					bool sample_self)
 {
-	return __hists__add_entry(hists, al, sym_parent, bi, mi, NULL,
+	return __hists__add_entry(hists, al, sym_parent, bi, mi, ki, NULL,
 				  sample, sample_self, ops);
 }
 
@@ -846,7 +851,7 @@ iter_add_single_mem_entry(struct hist_entry_iter *iter, struct addr_location *al
 	 */
 	sample->period = cost;
 
-	he = hists__add_entry(hists, al, iter->parent, NULL, mi,
+	he = hists__add_entry(hists, al, iter->parent, NULL, mi, NULL,
 			      sample, true);
 	if (!he)
 		return -ENOMEM;
@@ -949,7 +954,7 @@ iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *a
 	sample->period = 1;
 	sample->weight = bi->flags.cycles ? bi->flags.cycles : 1;
 
-	he = hists__add_entry(hists, al, iter->parent, &bi[i], NULL,
+	he = hists__add_entry(hists, al, iter->parent, &bi[i], NULL, NULL,
 			      sample, true);
 	if (he == NULL)
 		return -ENOMEM;
@@ -987,7 +992,7 @@ iter_add_single_normal_entry(struct hist_entry_iter *iter, struct addr_location
 	struct hist_entry *he;
 
 	he = hists__add_entry(evsel__hists(evsel), al, iter->parent, NULL, NULL,
-			      sample, true);
+			      NULL, sample, true);
 	if (he == NULL)
 		return -ENOMEM;
 
@@ -1047,7 +1052,7 @@ iter_add_single_cumulative_entry(struct hist_entry_iter *iter,
 	struct hist_entry *he;
 	int err = 0;
 
-	he = hists__add_entry(hists, al, iter->parent, NULL, NULL,
+	he = hists__add_entry(hists, al, iter->parent, NULL, NULL, NULL,
 			      sample, true);
 	if (he == NULL)
 		return -ENOMEM;
@@ -1148,7 +1153,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 	}
 
 	he = hists__add_entry(evsel__hists(evsel), al, iter->parent, NULL, NULL,
-			      sample, false);
+			      NULL, sample, false);
 	if (he == NULL)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index d93a4e510dc7..86a677954279 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -14,6 +14,7 @@ struct hist_entry_ops;
 struct addr_location;
 struct map_symbol;
 struct mem_info;
+struct kvm_info;
 struct branch_info;
 struct branch_stack;
 struct block_info;
@@ -150,6 +151,7 @@ struct hist_entry *hists__add_entry(struct hists *hists,
 				    struct symbol *parent,
 				    struct branch_info *bi,
 				    struct mem_info *mi,
+				    struct kvm_info *ki,
 				    struct perf_sample *sample,
 				    bool sample_self);
 
@@ -159,6 +161,7 @@ struct hist_entry *hists__add_entry_ops(struct hists *hists,
 					struct symbol *sym_parent,
 					struct branch_info *bi,
 					struct mem_info *mi,
+					struct kvm_info *ki,
 					struct perf_sample *sample,
 					bool sample_self);
 
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 2d791b04379a..43dd6472fa50 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -23,6 +23,10 @@ struct event_key {
 	struct exit_reasons_table *exit_reasons;
 };
 
+struct kvm_info {
+	char name[KVM_EVENT_NAME_LEN];
+};
+
 struct kvm_event_stats {
 	u64 time;
 	struct stats stats;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index d79a100e5999..22f437c3476f 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -144,6 +144,7 @@ struct hist_entry {
 	struct hists		*hists;
 	struct mem_info		*mem_info;
 	struct block_info	*block_info;
+	struct kvm_info		*kvm_info;
 	void			*raw_data;
 	u32			raw_size;
 	int			num_res;
-- 
2.34.1

