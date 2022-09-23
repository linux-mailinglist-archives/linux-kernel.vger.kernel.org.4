Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399FA5E80BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiIWRcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIWRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:32:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0836C14DAFA;
        Fri, 23 Sep 2022 10:32:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u69so876810pgd.2;
        Fri, 23 Sep 2022 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=pZtpDw8g2Ig311Mibhr8MbvmenDJsBQuKJmWvsuyeVE=;
        b=GEF9dIXv7Sy/4KA9vyHhg4UBazeUuMCkcNr1yavfRFikVeYm/tdt3orkNywerR13hk
         GmxiSUchGPEnhgktSYe4ikJfPTQykQKkqtLSkahh+H6su2xSJCO4kA6GYl1IkHkMilhM
         +i7wXTLUcspvmldldRSKWWZNnGXe5jmnUjYSIktSGG2sCZ4FTyPfHogCy1q51J64GdHH
         RBjbW+rAxW6YtSKnlfbP//KaKr2I4lHmb9y8z5d44/BWwItXKXpeFPlqBAIl3abKWueT
         csJ4milWjA35ymqfrScnjpEbm6BGqrdbI+7qkM+UtEymU4EjTHKajehuOq0hYTBp2NDJ
         Rsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=pZtpDw8g2Ig311Mibhr8MbvmenDJsBQuKJmWvsuyeVE=;
        b=pKDxt8aKtiDiVwmvWpmJkxiJsgRW3SrUQoncNP2cA4T2L4miPYszyyM3ab+RhEuBtS
         wnJSUR34eZQQoYe7fMHWeu1c5YCNXApkpl7AUoOKxCbJgyhhS+T1Tqndu08eKKd6GUMG
         RIvNfBqd+LYDCS8fPzUUC8D6Ru0hQ9sv22vhwHpNOhLDGfO5uGwpqdsBRlTI0WfdFYBI
         I2u6wnf8rc+7/l8A5NoooJya+kkgu1rCUQcA7eojP8dgOJy+44nj8D4DuHgcYXx9842D
         DsogqdmJI/NqHb0szoMIGVM/+J2rXBOlGiobH1ykdAPZAvm8dgBGdEZ1oa+9yECx+syl
         aTag==
X-Gm-Message-State: ACrzQf2jseNRlVPQwdc4H9r4TmEjV2Ru9Zs1v4st+8r2leMDZo1Wp4K3
        xCP+boF3IELuwNGSfKPmLF3WFGZ2ENo=
X-Google-Smtp-Source: AMsMyM6vsJ7lPsmwFX9RiouzZyqmsaj6SMQb8Jf6n6vBen1wJDf8Q3PdmI1JL4bEskuzatwvJL1QTg==
X-Received: by 2002:a05:6a00:1253:b0:546:3d50:3284 with SMTP id u19-20020a056a00125300b005463d503284mr10197877pfi.72.1663954324222;
        Fri, 23 Sep 2022 10:32:04 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:c716:a857:50ee:f56e])
        by smtp.gmail.com with ESMTPSA id 9-20020a621409000000b0053e6eae9668sm6719499pfu.2.2022.09.23.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:32:03 -0700 (PDT)
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
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/4] perf record: Fix a segfault in record__read_lost_samples()
Date:   Fri, 23 Sep 2022 10:31:39 -0700
Message-Id: <20220923173142.805896-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220923173142.805896-1-namhyung@kernel.org>
References: <20220923173142.805896-1-namhyung@kernel.org>
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

When it fails to open events record__open() returns without setting the
session->evlist.  Then it gets a segfault in the function trying to read
lost sample counts.  You can easily reproduce it as a normal user like:

  $ perf record -p 1 true
  ...
  perf: Segmentation fault
  ...

Skip the function if it has no evlist.  And add more protection for evsels
which are not properly initialized.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 741e763436ca..f4f1619199e5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1888,6 +1888,10 @@ static void record__read_lost_samples(struct record *rec)
 	struct perf_record_lost_samples *lost;
 	struct evsel *evsel;
 
+	/* there was an error during record__open */
+	if (session->evlist == NULL)
+		return;
+
 	lost = zalloc(PERF_SAMPLE_MAX_SIZE);
 	if (lost == NULL) {
 		pr_debug("Memory allocation failed\n");
@@ -1899,6 +1903,8 @@ static void record__read_lost_samples(struct record *rec)
 	evlist__for_each_entry(session->evlist, evsel) {
 		struct xyarray *xy = evsel->core.sample_id;
 
+		if (xy == NULL || evsel->core.fd == NULL)
+			continue;
 		if (xyarray__max_x(evsel->core.fd) != xyarray__max_x(xy) ||
 		    xyarray__max_y(evsel->core.fd) != xyarray__max_y(xy)) {
 			pr_debug("Unmatched FD vs. sample ID: skip reading LOST count\n");
-- 
2.37.3.998.g577e59143f-goog

