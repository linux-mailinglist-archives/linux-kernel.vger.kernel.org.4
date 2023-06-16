Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4969D7328F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbjFPHdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245219AbjFPHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:32:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F803A8D;
        Fri, 16 Jun 2023 00:32:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25e820b8bc1so336653a91.1;
        Fri, 16 Jun 2023 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686900735; x=1689492735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWGWhFdNFnQmNe1jiV8vMMxLsZzrXaix4YBiXlabS0E=;
        b=DRRQtr0VgJV/ySp/YbqiODXhW0yheiWiY5emon5iu1kh1636Oo1jwJcH5YsL3wL0tI
         OOBW0jCmy0Ovdr9Zz5E+AmObIduOVjoatKbzOW6MnzCSKfiV1jIr8qzCteFRe4IjvW+t
         BJSXtRJVf27SP5olDyLJ3AMidsgXoJfRk46cwKhS/1ysYeMYwaR5S4JChkZV5rnLli43
         CFEagZj7oMDt/QTqBaClBvfw3vQG0cL9s0VUaE5CQwPXtsZbR5l3s5IEXtaNLBbVRAk2
         7Z254noW4nzxr2EtmYMBoA3qt17hRRl+ZhMXJZlPyQxsJ5LgWrt0fGsvF8VkjohwC47I
         gwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686900735; x=1689492735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JWGWhFdNFnQmNe1jiV8vMMxLsZzrXaix4YBiXlabS0E=;
        b=g00txs9cDe2aYDIpIAPuFnV3CWMDfxmZrzqr/jwRWxEFus/AR31FjeuBrNcZTVw6du
         7JGlm12MDtwnupBc+wt8cQXNz6NCdbqkHWQd7VDTcMf8JnrfWe+l4IKaO1fO+MprUeAz
         +S7yhbFqwDJVCVAzCpn92xmHXemqw1uYiXvOrxsB7eor6lFr93pdtOCtzNU9btN+9Alx
         Lcc629Mm0wDAVCcbRSAb3A52cEvSBAtSbnb8tP0500H5VLM3QjFislS778L5T3EcNBCQ
         G5sQVRxXoniftfoRcqwfDMzG8bXPLf+DfxzfjKy2wP7qlgGT3Sm9Wxmmmy+OVM6gdtXz
         28RQ==
X-Gm-Message-State: AC+VfDzx9GI4Faq3aLUTMKiu2J5oRAYeoPjA8wA7EQCeY7TgtBiR8VZt
        /xgysW10GJaY5k0tu3pI4TI=
X-Google-Smtp-Source: ACHHUZ5kJa0MCuDeIk0jP7y4xGt7pFtaHc+fO7+gF2T0mOn89TpBz6GkFEMmcnraZw0WLgCJfDJLZA==
X-Received: by 2002:a17:90a:ce04:b0:25b:fcbb:62ba with SMTP id f4-20020a17090ace0400b0025bfcbb62bamr848395pju.45.1686900735135;
        Fri, 16 Jun 2023 00:32:15 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:6cbb:2c15:7306:b23])
        by smtp.gmail.com with ESMTPSA id gz10-20020a17090b0eca00b00256b67208b1sm715245pjb.56.2023.06.16.00.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 00:32:14 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/2] perf stat: Show average value on multiple runs
Date:   Fri, 16 Jun 2023 00:32:11 -0700
Message-ID: <20230616073211.1057936-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230616073211.1057936-1-namhyung@kernel.org>
References: <20230616073211.1057936-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When -r option is used, perf stat runs the command multiple times and
update stats in the evsel->stats.res_stats for global aggregation.  But
the value is never used and the value it prints at the end is just the
value from the last run.  I think we should print the average number of
multiple runs.

Add evlist__copy_res_stats() to update the aggr counter (for display)
using the values in the evsel->stats.res_stats.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  5 ++++-
 tools/perf/util/stat.c    | 22 ++++++++++++++++++++++
 tools/perf/util/stat.h    |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e549862f90f0..42f84975a4d5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2829,8 +2829,11 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
-	if (!forever && status != -1 && (!interval || stat_config.summary))
+	if (!forever && status != -1 && (!interval || stat_config.summary)) {
+		if (stat_config.run_count > 1)
+			evlist__copy_res_stats(&stat_config, evsel_list);
 		print_counters(NULL, argc, argv);
+	}
 
 	evlist__finalize_ctlfd(evsel_list);
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0f7b8a8cdea6..967e583392c7 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -264,6 +264,28 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist)
 		evsel__copy_prev_raw_counts(evsel);
 }
 
+static void evsel__copy_res_stats(struct evsel *evsel)
+{
+	struct perf_stat_evsel *ps = evsel->stats;
+
+	/*
+	 * For GLOBAL aggregation mode, it updates the counts for each run
+	 * in the evsel->stats.res_stats.  See perf_stat_process_counter().
+	 */
+	*ps->aggr[0].counts.values = avg_stats(&ps->res_stats);
+}
+
+void evlist__copy_res_stats(struct perf_stat_config *config, struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	if (config->aggr_mode != AGGR_GLOBAL)
+		return;
+
+	evlist__for_each_entry(evlist, evsel)
+		evsel__copy_res_stats(evsel);
+}
+
 static size_t pkg_id_hash(long __key, void *ctx __maybe_unused)
 {
 	uint64_t *key = (uint64_t *) __key;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 7abff7cbb5a1..1cbc26b587ba 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -182,6 +182,7 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
 
 int evlist__alloc_aggr_stats(struct evlist *evlist, int nr_aggr);
 void evlist__reset_aggr_stats(struct evlist *evlist);
+void evlist__copy_res_stats(struct perf_stat_config *config, struct evlist *evlist);
 
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
-- 
2.41.0.162.gfafddb0af9-goog

