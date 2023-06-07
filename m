Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6454572532D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbjFGFCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjFGFCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:02:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECEAA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:02:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb05f0e6ef9so10535351276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 22:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686114122; x=1688706122;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ikiqQuTZUJiABEoiUDyLUaakiCQM83ZBVgIUJ5qyiw=;
        b=n2XMZRp5Bhjmhnf1S7FOdeGul2K9HH1o1TAnJwUhWb9F6vmziwkWV6fdF2lI0p533B
         5GOT5AyErh8jVZ59k3YBHwfAxFO3fyhOCVGdHLmIaZPpzfvkdeojUsmmJJ05IHPsFCgB
         te03hoMvX1btHIiA5whK5kbe/eZ7KRGl3Dsyp/h0acEPNPi6mD7ojbjncT+eoGIRnv2W
         zag/KXcJDcGV3+24y9FiynmTW6LgZhcdShPNKO+qvHNy3TontHHuhAPeqgSWxNkntcBL
         h4ZEtkb+XNmulicM133xPFaLtmZk7/qvXW2fWFQJQhju+MseCuZB4CwCd4QyBEyHvrvH
         uwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686114122; x=1688706122;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ikiqQuTZUJiABEoiUDyLUaakiCQM83ZBVgIUJ5qyiw=;
        b=Zdmb6oU6R8RoNtqNMcngqYcTDGwLLTqPjDjc2xvhSN6bP/daffp48B6fHlE7cK4MtP
         dYjxLrHC2YTkUYvlG5fBka30faKwhvqz+Jch+o6Qqz7yiRybkKcQn4YlwWtcBvMPwY3g
         L4E7RDpb4u+LdcALyDZcnFeSavmVfYITGHQBi0GqaN33ssXuf/zL9zLRFMH+nyzkZ3jD
         O/oN44xSI0Qj04/NWKPyg5jK4OQOvzXLbpWxn5vEnNAaL6kQPE4O9ahpLMVOma5L9n09
         zW5W2FGZs0k2Swg3H9IvrDTVBT3FBAPfw1BxmpLmdX6eZkl6/uezEDyveOwq3hAWv4dV
         UsIA==
X-Gm-Message-State: AC+VfDyZYSXpEvyCD9kqpVgAcMYMWDhKL9GF/37baPrpna9JUyrm3E2s
        JZEsOGoliUxIrNVqlI5EanrWWmP1uOvu
X-Google-Smtp-Source: ACHHUZ491PewUGRspEK6o4fbP8WWZS2GrSxlW/3LEce2E79lrob6kU82jnQTpePQ2QSMvfvryDhahMawa3NP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:124f:b0:ba8:2e68:7715 with SMTP
 id t15-20020a056902124f00b00ba82e687715mr2405214ybu.2.1686114122502; Tue, 06
 Jun 2023 22:02:02 -0700 (PDT)
Date:   Tue,  6 Jun 2023 22:01:47 -0700
In-Reply-To: <20230607050148.3248353-1-irogers@google.com>
Message-Id: <20230607050148.3248353-3-irogers@google.com>
Mime-Version: 1.0
References: <20230607050148.3248353-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 2/2] perf top: Add exit routine for main thread
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
        Andres Freund <andres@anarazel.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add exit_process_thread that reverses init_process_thread. This avoids
leak sanitizer reporting memory leaks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 99010dfa5760..c363c04e16df 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -392,7 +392,7 @@ static void prompt_percent(int *target, const char *msg)
 
 static void perf_top__prompt_symbol(struct perf_top *top, const char *msg)
 {
-	char *buf = malloc(0), *p;
+	char *buf = NULL, *p;
 	struct hist_entry *syme = top->sym_filter_entry, *n, *found = NULL;
 	struct hists *hists = evsel__hists(top->sym_evsel);
 	struct rb_node *next;
@@ -1227,6 +1227,14 @@ static void init_process_thread(struct perf_top *top)
 	cond_init(&top->qe.cond);
 }
 
+static void exit_process_thread(struct perf_top *top)
+{
+	ordered_events__free(&top->qe.data[0]);
+	ordered_events__free(&top->qe.data[1]);
+	mutex_destroy(&top->qe.mutex);
+	cond_destroy(&top->qe.cond);
+}
+
 static int __cmd_top(struct perf_top *top)
 {
 	struct record_opts *opts = &top->record_opts;
@@ -1357,6 +1365,7 @@ static int __cmd_top(struct perf_top *top)
 	cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
 	perf_set_singlethreaded();
+	exit_process_thread(top);
 	return ret;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

