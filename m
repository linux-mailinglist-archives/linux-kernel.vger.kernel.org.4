Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3B64E1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiLOT2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiLOT23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:28:29 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98E84B986;
        Thu, 15 Dec 2022 11:28:28 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n4so47874plp.1;
        Thu, 15 Dec 2022 11:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SWq8tpcCrwysvBsmnobWfCEN7jq3OKGDHoAjUmZcKM=;
        b=aI78gKJvL9S+95167GkI3Ge1ockEbEzp6hvrNPojeC288sACCfBe0NfmVWti/N6Qra
         z4PwACXjYHvbob9q1bOpJx39/U8LDs+vQxdT7QWb3jMkdQhb0/efj5n6SjPqwcsvzfla
         ajcrukOfh0ikfnFu0QObh1O4VLNk1FnlXRSnpZKRYu/qQ7lgyu1WCsBbLq+lR49wkMh9
         M73PoOxV6lhJROKx4UNK81Vc1Zr5v90FbtUiYeV4uLvsLoScPPhNiDIrGvc/dDb2aXNB
         +v3NkQtUNyqZD3vCHf32vrQYYjbDr5T7WpfFhf/Ke3owKbPfx0KkvXWuI2/7As6O89Y8
         eRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2SWq8tpcCrwysvBsmnobWfCEN7jq3OKGDHoAjUmZcKM=;
        b=cb95U2ZbXl1xtLadDkjJNz8swlIjSLAHr0PH3bY9ghzvCxdxpu2BHWhce4bwQihHL5
         13oTQrKktUQAPIQfHCxyTUzYfrhv/CeznPMA2uOKAduECy6Qu3RwuapkgPJNbAIjLAtl
         Ihj0pU3BY90T+83tqXmxNL+D6QipOJ5n4VfSI6YZbvTSSAKczg3Wm0WqNyz/D55z41yq
         vS56HaAN+CorBg5c3ObzF6wPjf86ONxXHzxFGCXW3v9ii1A//WiWFUKcu3mjxDUvNvdQ
         yfSvI7ZaU8pX4veQ6rkTi8TfXK7mgeGCjSb8RgdJjOe4VKhtAogBlFHwalUFryYJGUKh
         CaYg==
X-Gm-Message-State: ANoB5plIinCPsC7sUI3RcxJ4IXM2KdwwxDjnLK5UvA+JVg7RdCm5d/jF
        QYU/LY7rV7AZAqAqhnSTtUQ=
X-Google-Smtp-Source: AA0mqf6zi7kYyr9raMdbSzI8wyUMKPLqfFq/52pamjhXxaXRct+BGGIiFpFX/cdZWJIA+F8BeouW3g==
X-Received: by 2002:a17:90a:348e:b0:219:8cbb:c158 with SMTP id p14-20020a17090a348e00b002198cbbc158mr30920771pjb.5.1671132507614;
        Thu, 15 Dec 2022 11:28:27 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ecc1:3e44:be34:129c])
        by smtp.gmail.com with ESMTPSA id ep14-20020a17090ae64e00b00219cf5c3829sm3475129pjb.57.2022.12.15.11.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:28:27 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 6/9] perf hist: Add perf_hpp_fmt->init() callback
Date:   Thu, 15 Dec 2022 11:28:14 -0800
Message-Id: <20221215192817.2734573-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221215192817.2734573-1-namhyung@kernel.org>
References: <20221215192817.2734573-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __hists__insert_output_entry(), it calls fmt->sort() for dynamic
entries with NULL to update column width for tracepoint fields.
But it's a hacky abuse of the sort callback, better to have a proper
callback for that.  I'll add more use cases later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/hist.c | 10 +++++-----
 tools/perf/util/hist.h |  1 +
 tools/perf/util/sort.c | 31 ++++++++++++++++++++++++++-----
 tools/perf/util/sort.h |  1 +
 4 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 17a05e943b44..b6e4b4edde43 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1781,8 +1781,8 @@ static void hierarchy_insert_output_entry(struct rb_root_cached *root,
 
 	/* update column width of dynamic entry */
 	perf_hpp_list__for_each_sort_list(he->hpp_list, fmt) {
-		if (perf_hpp__is_dynamic_entry(fmt))
-			fmt->sort(fmt, he, NULL);
+		if (fmt->init)
+			fmt->init(fmt, he);
 	}
 }
 
@@ -1879,10 +1879,10 @@ static void __hists__insert_output_entry(struct rb_root_cached *entries,
 	rb_link_node(&he->rb_node, parent, p);
 	rb_insert_color_cached(&he->rb_node, entries, leftmost);
 
+	/* update column width of dynamic entries */
 	perf_hpp_list__for_each_sort_list(&perf_hpp_list, fmt) {
-		if (perf_hpp__is_dynamic_entry(fmt) &&
-		    perf_hpp__defined_dynamic_entry(fmt, he->hists))
-			fmt->sort(fmt, he, NULL);  /* update column width */
+		if (fmt->init)
+			fmt->init(fmt, he);
 	}
 }
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index ebd8a8f783ee..d93a4e510dc7 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -272,6 +272,7 @@ struct perf_hpp_fmt {
 		      struct hists *hists, int line, int *span);
 	int (*width)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		     struct hists *hists);
+	void (*init)(struct perf_hpp_fmt *fmt, struct hist_entry *he);
 	int (*color)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		     struct hist_entry *he);
 	int (*entry)(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0ecc2cb13792..f6333b3dca35 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2251,6 +2251,19 @@ static void hse_free(struct perf_hpp_fmt *fmt)
 	free(hse);
 }
 
+static void hse_init(struct perf_hpp_fmt *fmt, struct hist_entry *he)
+{
+	struct hpp_sort_entry *hse;
+
+	if (!perf_hpp__is_sort_entry(fmt))
+		return;
+
+	hse = container_of(fmt, struct hpp_sort_entry, hpp);
+
+	if (hse->se->se_init)
+		hse->se->se_init(he);
+}
+
 static struct hpp_sort_entry *
 __sort_dimension__alloc_hpp(struct sort_dimension *sd, int level)
 {
@@ -2274,6 +2287,7 @@ __sort_dimension__alloc_hpp(struct sort_dimension *sd, int level)
 	hse->hpp.sort = __sort__hpp_sort;
 	hse->hpp.equal = __sort__hpp_equal;
 	hse->hpp.free = hse_free;
+	hse->hpp.init = hse_init;
 
 	INIT_LIST_HEAD(&hse->hpp.list);
 	INIT_LIST_HEAD(&hse->hpp.sort_list);
@@ -2556,11 +2570,6 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
 
 	hde = container_of(fmt, struct hpp_dynamic_entry, hpp);
 
-	if (b == NULL) {
-		update_dynamic_len(hde, a);
-		return 0;
-	}
-
 	field = hde->field;
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		unsigned long long dyn;
@@ -2610,6 +2619,17 @@ static void hde_free(struct perf_hpp_fmt *fmt)
 	free(hde);
 }
 
+static void __sort__hde_init(struct perf_hpp_fmt *fmt, struct hist_entry *he)
+{
+	struct hpp_dynamic_entry *hde;
+
+	if (!perf_hpp__is_dynamic_entry(fmt))
+		return;
+
+	hde = container_of(fmt, struct hpp_dynamic_entry, hpp);
+	update_dynamic_len(hde, he);
+}
+
 static struct hpp_dynamic_entry *
 __alloc_dynamic_entry(struct evsel *evsel, struct tep_format_field *field,
 		      int level)
@@ -2632,6 +2652,7 @@ __alloc_dynamic_entry(struct evsel *evsel, struct tep_format_field *field,
 	hde->hpp.entry  = __sort__hde_entry;
 	hde->hpp.color  = NULL;
 
+	hde->hpp.init = __sort__hde_init;
 	hde->hpp.cmp = __sort__hde_cmp;
 	hde->hpp.collapse = __sort__hde_cmp;
 	hde->hpp.sort = __sort__hde_cmp;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 04ff8b61a2a7..921715e6aec4 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -282,6 +282,7 @@ struct sort_entry {
 	int	(*se_snprintf)(struct hist_entry *he, char *bf, size_t size,
 			       unsigned int width);
 	int	(*se_filter)(struct hist_entry *he, int type, const void *arg);
+	void	(*se_init)(struct hist_entry *he);
 	u8	se_width_idx;
 };
 
-- 
2.39.0.314.g84b9a713c41-goog

