Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4544D74FFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGLGxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjGLGw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:52:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B139DC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:52:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57704af0e64so69444477b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689144773; x=1691736773;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y/xEXbInlbT/mWlE+l7wvB8yv7wRGOs96AGe4Pwk5fs=;
        b=gebAwvel5szqUUFm9xDJ9B6JG8HuRDc6wDQp6f5xICBCCEHHzJH+84wytnFGd2KxG1
         U7b1aydvyh6BVXn5dlel2aMv0uVvRmuzqqVYLo83KiQ1UX1qCBC6AIUxYnwfkV4ORFfB
         ns8Gb1Fn97E21Wmfb2nRru6rmKBFRbAjEkTYkL86cs5NqVYexz0rxWJASxwVGPK8br8N
         Wb0gsLZrabD8MeqkrfTQOLSvIGjY5lOvFvpkNoKF79Jx3Gvvz3zZWB/YaRJ+piFEAGyt
         wOzKkk+Lo4e1XC9mTndAzl5NTnBWMHQDdDUu02hQszNI3sWaEE81PSOzPiCQt3VgPBwn
         BWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689144773; x=1691736773;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/xEXbInlbT/mWlE+l7wvB8yv7wRGOs96AGe4Pwk5fs=;
        b=BaWqCXynCkPLHCnBrm+qrI3Wrb6YZuafyK8endOMoP0QRuYqI9AQ6TIDShVAETNzEn
         Z2Hf3/XN6y8E+EpwNfTshqUibHzuN0wnEYMW0pphFAmWsyUs7SwK/coL7hcDBWIu4P5n
         OiQAto8EuEFd7WBNttf+mffm+JDJEoCPSoetEXDpvU2r+o8gsHSNmY1wF04/sMF98rtU
         8PUJsvZSJnQnbiMYADSrij00xf7iCMsGoFrwHasbKtto17umY5TambdhBvKope9JVbQz
         rmgD4zbr0Frf7ELvrlhcqHOzJ8qGnqi772buubbXx3i/er/i7uQxeO2VKJVfhVFeHyiV
         im1A==
X-Gm-Message-State: ABy/qLZWQrHYQL8Q1Gasi0gIAe/IdObslteSNNzSJunoTH8ZSRo8Z74E
        AQ1ckGw1VfwybFkmmEpwCkSJKvLYgHyA
X-Google-Smtp-Source: APBJJlGYOB+tzfAur3zuZF33qiFoQQ9JvWC0LENO29amDw6ZfvkTZnqGcnmJD2Oo/AuhU94vvM4fDKZkYMZb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:9d6e:a38f:b398:c8b4])
 (user=irogers job=sendgmr) by 2002:a05:6902:508:b0:c4b:6ed6:6147 with SMTP id
 x8-20020a056902050800b00c4b6ed66147mr164772ybs.9.1689144773629; Tue, 11 Jul
 2023 23:52:53 -0700 (PDT)
Date:   Tue, 11 Jul 2023 23:52:50 -0700
Message-Id: <20230712065250.1450306-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Subject: [PATCH v1] perf parse-events: Avoid segv if PMU lookup fails for
 legacy cache terms
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libfuzzer found the following command could segv:
```
$ perf stat -e cpu/L2,L2/ true
```
This is because the L2 term rewrites the perf_event_attr type to
PERF_TYPE_HW_CACHE which then fails the PMU lookup for the second
legacy cache term.

The new failure is consistent with repeated hardware terms:
```
$ perf stat -e cpu/L2,L2/ true
event syntax error: 'cpu/L2,L2/'
                            \___ Failed to find PMU for type 3

Initial error:
event syntax error: 'cpu/L2,L2/'
                            \___ Failed to find PMU for type 3
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
$ perf stat -e cpu/cycles,cycles/ true
event syntax error: 'cpu/cycles,cycles/'
                                \___ Failed to find PMU for type 0

Initial error:
event syntax error: 'cpu/cycles,cycles/'
                                \___ Failed to find PMU for type 0
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5dcfbf316bf6..acde097e327c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1216,6 +1216,14 @@ static int config_term_pmu(struct perf_event_attr *attr,
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) {
 		const struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 
+		if (!pmu) {
+			char *err_str;
+
+			if (asprintf(&err_str, "Failed to find PMU for type %d", attr->type) >= 0)
+				parse_events_error__handle(err, term->err_term,
+							   err_str, /*help=*/NULL);
+			return -EINVAL;
+		}
 		if (perf_pmu__supports_legacy_cache(pmu)) {
 			attr->type = PERF_TYPE_HW_CACHE;
 			return parse_events__decode_legacy_cache(term->config, pmu->type,
-- 
2.41.0.390.g38632f3daf-goog

