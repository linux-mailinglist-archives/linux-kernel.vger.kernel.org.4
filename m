Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68073F385
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjF0Egh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjF0EgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:36:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202CD1718
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd69ee0edacso5436860276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840540; x=1690432540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmcwCCrzohBexPPxiwkNS29383WCu9lx0QPsW2KVyZ4=;
        b=dX0nzwKDmwRLRzUElRbb/ZUhU8CqDyxurklThpje/xh9AZe7uPANzlcnjMfd3Nphxa
         Feqs7E72EoJkDBbOEX4ndFRoShyAYkJujZwyfhO1l0BBwA3Gs2u84tlmKI2znvCpOvp/
         vCcjREuJgs2pJyJlWRCpukXwBO1MPUhGPrdg4gHR/QMtKMD6FsrCfo+0PU6C3sAzWV+h
         zZxLMQMNDhyZ6p9vVplVkJdASPfquPFGTb7pVzuvBqIZLNvhD94Og/PMKu8UPtxgdudB
         6fjGTRzje7pmiDFVUrksxcOstqsnJ2L4AE5B3/lV6jQBMF+ctiJPrlDEsfkLzv215Rse
         00OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840540; x=1690432540;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmcwCCrzohBexPPxiwkNS29383WCu9lx0QPsW2KVyZ4=;
        b=cqQIxnYM8D3jvYNjoPOuTPWTWQTulMGkm7nDAf2iPt904D9TLHEi/VOL3sgcSdQFtR
         XIzUSIqnqDdbbLmTZN5OwPVza1lQ3YCWwlXQyjAY/a+ZdMDdXoLcoLpLOnuTdinsdOzU
         DQe1dtbfLs/1AGtGPvQWcKj+oX+gZPGb2e1/ztcd8DbiFGqFukRoBdee+Zhz5uHAhnXr
         J8RiZv8+rlZDA7apAMcImUG2SDQ/9B41GgJSfAWQgF7i9cT43+NPtp0AP/UySNaA+8uX
         jY0BiYvwOdZseC+V2yrCWFhkwZdVoUBtGM/Cj5NwPkD3SnjRvffwMq+mMW3Q8pqh5v/K
         px8w==
X-Gm-Message-State: AC+VfDwBg7lnlkJkDZnxM7vPRfQRixQ6R9RPSEdORNCVjar6pkSLMSgt
        mhlzaZ3apw0QdB13MdFgimW9539kXIUu
X-Google-Smtp-Source: ACHHUZ6Ij9UVX+Y1eE/fAeD49qeUrfoIUY5V8xWSHMepARTJgN2SMH/Cpx4WFc7JhU4gPkhTdXdvWdR9wDWu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:e0c6:0:b0:bc7:f6af:8cff with SMTP id
 x189-20020a25e0c6000000b00bc7f6af8cffmr14521026ybg.2.1687840540338; Mon, 26
 Jun 2023 21:35:40 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:55 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-11-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 10/13] perf parse-events: Additional error reporting
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When no events or PMUs match report an error for event_pmu:

Before:
```
$ perf stat -e 'asdfasdf' -a sleep 1
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

After:
```
$ perf stat -e 'asdfasdf' -a sleep 1
event syntax error: 'asdfasdf'
                     \___ Bad event name

Unabled to find PMU or event on a PMU of 'asdfasdf'
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

Fixes the inadvertent removal when hybrid parsing was modified.

Fixes: ("70c90e4a6b2f perf parse-events: Avoid scanning PMUs before parsing")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f090a85c4518..a636a7db6e6f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -291,7 +291,6 @@ PE_NAME opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list = NULL, *orig_terms = NULL, *terms= NULL;
-	struct parse_events_error *error = parse_state->error;
 	char *pattern = NULL;
 
 #define CLEANUP						\
@@ -303,9 +302,6 @@ PE_NAME opt_pmu_config
 		free(pattern);				\
 	} while(0)
 
-	if (error)
-		error->idx = @1.first_column;
-
 	if (parse_events_copy_term_list($2, &orig_terms)) {
 		CLEANUP;
 		YYNOMEM;
@@ -360,6 +356,14 @@ PE_NAME opt_pmu_config
 			$2 = NULL;
 		}
 		if (!ok) {
+			struct parse_events_error *error = parse_state->error;
+			char *help;
+
+			if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
+				help = NULL;
+			parse_events_error__handle(error, @1.first_column,
+						   strdup("Bad event or PMU"),
+						   help);
 			CLEANUP;
 			YYABORT;
 		}
@@ -376,9 +380,18 @@ PE_NAME sep_dc
 	int err;
 
 	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
-	free($1);
-	if (err < 0)
+	if (err < 0) {
+		struct parse_events_state *parse_state = _parse_state;
+		struct parse_events_error *error = parse_state->error;
+		char *help;
+
+		if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
+			help = NULL;
+		parse_events_error__handle(error, @1.first_column, strdup("Bad event name"), help);
+		free($1);
 		PE_ABORT(err);
+	}
+	free($1);
 	$$ = list;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

