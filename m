Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F6673F388
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjF0EhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjF0EgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:36:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABC4213A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5700861af1bso57938477b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840547; x=1690432547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xtK5HWFrotXOQTFAtNsXMiJLnjczB0bKaJqMYYAdAw=;
        b=dq8Z6/zkvj5AhkzyvCcePMaY/4TJVw6FKcFL0Grg7cTDpD7U97mANBasuEHRqq5E6J
         CeQG3laHxYsRQCw3jJIaAi640DkEL7fgTvW22VJ8WDVgEl+4NX2s598D87gax6gGuSoB
         5hMicurS2TR9HLtZr0Wd1+mVC7zxtAjFXsaOKbM0in3upafjoLIvGDv/bWUYVrx7xhKU
         cqHeiQZ1IEWQgkzY5fGck0b2h+bdXDUYdfXp4LE7J8DEVN8XccrdNwldcj6O43u/1TpF
         Z9PZyLuTNMg27UDpArpdutfeETdpMIdn7hEG+m84SMTDXzgW2+FoZUTV0XQUDCUMEpna
         RnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840547; x=1690432547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xtK5HWFrotXOQTFAtNsXMiJLnjczB0bKaJqMYYAdAw=;
        b=mI+OkGHWGahHp2lov3LUpwg03fHK0IqtkyKS+ZjA42wLPVLMVrym3rc5BrPbBiHcRT
         rK5q1tvuBTU7uaYd5SyBT1U5XzGfmvqZyEbcqKSkxEhD63JXkN+zT84tdY2/sbbZa3jB
         XPtSeNEEm7aM0Gc2c/S+dVSM9YSEGRjIkkRTAwlXMDpby3YZPwXLmqCLESJWNyUMTfBP
         kpVUag7F4luSwaw0otXYZvRPHJ+ZLDz2EUYOzAua0YoupPhy7cI90/MCGcWfPwHMRAxL
         hoPor/s+L+n8Ghb0qO1oaIPagMc3VAgdezguO4yDpNdJll3iwLpCOvCDugCxf1tWydgj
         JT6Q==
X-Gm-Message-State: AC+VfDx9pOuqISr9Qm2i06gLLm+r910rgjXNJXaL+uMg2XctymTisY4B
        ArTgL7gQNSW53oa98Bn/qnv8lMSw2W07
X-Google-Smtp-Source: ACHHUZ7GCRaJQ8Zjv8j32ZTbpzp8/lqeBYs2D+DAkuQ/ELDVxl53n8Ud2bKcAn8g+26DHXYGmXXZ/pEJnOgt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:b344:0:b0:56d:25f3:f940 with SMTP id
 r65-20020a81b344000000b0056d25f3f940mr13876270ywh.10.1687840547041; Mon, 26
 Jun 2023 21:35:47 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:58 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-14-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 13/13] perf parse-events: Remove ABORT_ON
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

