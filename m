Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9AB7402F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjF0SLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjF0SLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:11:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443002D4C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:11:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bf0ba82473dso6701151276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889472; x=1690481472;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xtK5HWFrotXOQTFAtNsXMiJLnjczB0bKaJqMYYAdAw=;
        b=oW5Nw8CaZlguvVXnWXrJCyRqJYAVwXXD99hYzQcoeE0ITiJM35Lhadh3q6zb4/iv8L
         LoLj3jARhvxaEXR1qszm5BP0ezvL+QzCCPMkgm+gR4yzm8M5lJBpsBruMpzcd0QxMDGC
         9nXx9hQDzbvTPEnkSVw5s1VEb+umG92l809VG8DurQ+Xy7t7oMFKn1YpVU6FybqjB2Bw
         5VUxTLUK7TetoD1OEK5cWJsqz7xJDR/G9ibr3Vt9AnKV1tRlGAnt2g6ryGS5+TyOK6xU
         Qrbcwl/ESPNFj7fYUM1Dpw/RsKAA5q37hivFSgqyIRIjX4cOXaSIPy+eMqildaC4hcPs
         Xz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889472; x=1690481472;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xtK5HWFrotXOQTFAtNsXMiJLnjczB0bKaJqMYYAdAw=;
        b=fBQAcR0YHjF5gA52558/BCLIhp3D7Oxvg33umA0c73gH8+GD430Y6jsWYNwPkYl83o
         +Y/1uUvjjF1X83Jua1ri/GzIW4SjFeDRLOIRsLEI7hJh2kMkF82yKW3t9n/gOxU0W2ch
         Gt39jx+XGgsV0XDRD/U3SBICCowuGjcQpJJw/mM5GYk7a9oqcC/DuGK41iq+xsiRBdFR
         OmFNntj1wNEm+Og51e24s4Ekkygui/9dDDQ7kzOmaZK1/oM6uuCgbEyYExtbSCqrSCfP
         +etZJCOMAZf3QC5mFXZZuA3GAEtg7AsPywaF8MHb1rhLuDuVfid8VLGZsSIeAZ+HYp4k
         xryQ==
X-Gm-Message-State: AC+VfDxwaMQpDmZOTKidVYgdwleU1gRAmj3QyvfiuP0aObYla6YJe6SE
        WUmRgxMFNzE5ApbpM70JRdUoU3k3Q0LY
X-Google-Smtp-Source: ACHHUZ7rpFDD6/goG6mY4Mg+AjnbBdtPEAm8hqbeCCfMPVjJsYX0ztNDVCSjsbxN1b7sm3KW4MtRFbHUFpTz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a25:c943:0:b0:c15:42bf:22f with SMTP id
 z64-20020a25c943000000b00c1542bf022fmr3603446ybf.9.1687889472210; Tue, 27 Jun
 2023 11:11:12 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:30 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-14-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 13/13] perf parse-events: Remove ABORT_ON
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

Prefer informative messages rather than none with ABORT_ON. Document
one failure mode and add an error message for another.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 844646752462..454577f7aff6 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -22,12 +22,6 @@
 
 void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
 
-#define ABORT_ON(val) \
-do { \
-	if (val) \
-		YYABORT; \
-} while (0)
-
 #define PE_ABORT(val) \
 do { \
 	if (val == -ENOMEM) \
@@ -618,7 +612,9 @@ PE_RAW opt_event_config
 		YYNOMEM;
 	errno = 0;
 	num = strtoull($1 + 1, NULL, 16);
-	ABORT_ON(errno);
+	/* Given the lexer will only give [a-fA-F0-9]+ a failure here should be impossible. */
+	if (errno)
+		YYABORT;
 	free($1);
 	err = parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, num, $2,
 				       /*wildcard=*/false);
@@ -978,7 +974,17 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
 {
 	struct parse_events_array array;
 
-	ABORT_ON($3 < $1);
+	if ($3 < $1) {
+		struct parse_events_state *parse_state = _parse_state;
+		struct parse_events_error *error = parse_state->error;
+		char *err_str;
+
+		if (asprintf(&err_str, "Expected '%ld' to be less-than '%ld'", $3, $1) < 0)
+			err_str = NULL;
+
+		parse_events_error__handle(error, @1.first_column, err_str, NULL);
+		YYABORT;
+	}
 	array.nr_ranges = 1;
 	array.ranges = malloc(sizeof(array.ranges[0]));
 	if (!array.ranges)
-- 
2.41.0.162.gfafddb0af9-goog

