Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C48962EC10
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiKRCqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiKRCqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:46:43 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A890D8DA7C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:46:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f126-20020a255184000000b006cb2aebd124so3349358ybb.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xITCpZcF4nwGfP1Ql+gy2yQGBVVcw0DlrylPXUIjEo=;
        b=KbbIsbX/xQ3OKYKysQsfDcEbJsLtC8J9hseTic37VI66nFft/kxR1HrIrGswm44a7N
         4HL+ThwuRZXiglaka/LWYnHH4n5AA+JU4wKOLdPm7UtEp4DtGAUjaZfqB6uISgVspv/5
         43Z+/B+An0zilb5uNNfOO82g4igfY1EWygut0wdLhd0tww8r4BcriVN6NCdSrRIFnULH
         KPrR4iseTTqi6Vc1rtiozVqzaknXdkyAIm9qMSlORPt6o5jbNDxWprqbWqooAgKDnW47
         gLb0RMELjOFKVpUdSNXj37wjKkc1mOPrIT7ulYr0nnU4+Kun3rcq1jxndhjg8f42JPdA
         zaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xITCpZcF4nwGfP1Ql+gy2yQGBVVcw0DlrylPXUIjEo=;
        b=JTHWthAdxcytR0LGxRc9PMT09uHRV0icKmZHv8wQCY7F5AGwkm1MKpGZw94UySBCFX
         EqVXGP+g1LmacyxnUVu23IalfEsUFur27xi/U19XipbNUxx+mSwELqcSAXi3R6RD85Jr
         rGlFdPiFBXCmKWc9WUYgezjcfv4mnM2Et1CegqldUf+CiTd9uXyNfdKUrrs99u2WSVoj
         lRZhFSmDAcCWWyBp9s6Y/Mcc3iTrBfDF5zLB6v6NycHAEPZ6O//KBIYhW/nMosZ3dp14
         tHV8BGqI232Zw+M0TieGvMtnkjIXqU7XwElVdZOt9fve73mptHVc3tOscAkWYF3Q4Jgh
         CjeQ==
X-Gm-Message-State: ANoB5pnOy3lS713pAZ+x1MqmK9bdz8ABLb8eQSTumgUi1ZzOdAaikQ3F
        SSpUYdQTpKzkgAJK2mycWHs7KIel2A2U
X-Google-Smtp-Source: AA0mqf5PGwQsC4CfmwjWWAacF+9nRr4J3pCa9VD3B3Eam2h3OdxodVT4ueQM3iUQF8V5ylm+qUfJvTUZ5fh2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3f1e:c462:d6b8:fba8])
 (user=irogers job=sendgmr) by 2002:a25:8884:0:b0:6ca:49a6:bcd4 with SMTP id
 d4-20020a258884000000b006ca49a6bcd4mr4542128ybl.574.1668739600941; Thu, 17
 Nov 2022 18:46:40 -0800 (PST)
Date:   Thu, 17 Nov 2022 18:46:06 -0800
In-Reply-To: <20221118024607.409083-1-irogers@google.com>
Message-Id: <20221118024607.409083-3-irogers@google.com>
Mime-Version: 1.0
References: <20221118024607.409083-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 2/3] perf list: Json escape encoding improvements
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use strbuf to make the string under construction's length
unlimited. Use the format %s to mean a literal string copy and %S to
signify a need to escape the string. Add supported for escaping a
newline character.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 109 +++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index f3750331e8f6..137d73edb541 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -17,6 +17,7 @@
 #include "util/metricgroup.h"
 #include "util/string2.h"
 #include "util/strlist.h"
+#include "util/strbuf.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <linux/zalloc.h>
@@ -250,45 +251,56 @@ static void json_print_end(void *ps)
 	printf("%s]\n", print_state->need_sep ? "\n" : "");
 }
 
-static void fix_escape_printf(const char *fmt, ...)
+static void fix_escape_printf(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
-	char buf[2048];
-	size_t buf_pos = 0;
 
 	va_start(args, fmt);
+	strbuf_setlen(buf, 0);
 	for (size_t fmt_pos = 0; fmt_pos < strlen(fmt); fmt_pos++) {
 		switch (fmt[fmt_pos]) {
-		case '%': {
-			const char *s = va_arg(args, const char*);
-
+		case '%':
 			fmt_pos++;
-			assert(fmt[fmt_pos] == 's');
-			for (size_t s_pos = 0; s_pos < strlen(s); s_pos++) {
-				switch (s[s_pos]) {
-				case '\\':
-					__fallthrough;
-				case '\"':
-					buf[buf_pos++] = '\\';
-					assert(buf_pos < sizeof(buf));
-					__fallthrough;
-				default:
-					buf[buf_pos++] = s[s_pos];
-					assert(buf_pos < sizeof(buf));
-					break;
+			switch (fmt[fmt_pos]) {
+			case 's': {
+				const char *s = va_arg(args, const char*);
+
+				strbuf_addstr(buf, s);
+				break;
+			}
+			case 'S': {
+				const char *s = va_arg(args, const char*);
+
+				for (size_t s_pos = 0; s_pos < strlen(s); s_pos++) {
+					switch (s[s_pos]) {
+					case '\n':
+						strbuf_addstr(buf, "\\n");
+						break;
+					case '\\':
+						__fallthrough;
+					case '\"':
+						strbuf_addch(buf, '\\');
+						__fallthrough;
+					default:
+						strbuf_addch(buf, s[s_pos]);
+						break;
+					}
 				}
+				break;
+			}
+			default:
+				pr_err("Unexpected format character '%c'\n", fmt[fmt_pos]);
+				strbuf_addch(buf, '%');
+				strbuf_addch(buf, fmt[fmt_pos]);
 			}
 			break;
-		}
 		default:
-			buf[buf_pos++] = fmt[fmt_pos];
-			assert(buf_pos < sizeof(buf));
+			strbuf_addch(buf, fmt[fmt_pos]);
 			break;
 		}
 	}
 	va_end(args);
-	buf[buf_pos] = '\0';
-	fputs(buf, stdout);
+	fputs(buf->buf, stdout);
 }
 
 static void json_print_event(void *ps, const char *pmu_name, const char *topic,
@@ -301,62 +313,71 @@ static void json_print_event(void *ps, const char *pmu_name, const char *topic,
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
+	struct strbuf buf;
 
+	strbuf_init(&buf, 0);
 	printf("%s{\n", print_state->need_sep ? ",\n" : "");
 	print_state->need_sep = true;
 	if (pmu_name) {
-		fix_escape_printf("\t\"Unit\": \"%s\"", pmu_name);
+		fix_escape_printf(&buf, "\t\"Unit\": \"%S\"", pmu_name);
 		need_sep = true;
 	}
 	if (topic) {
-		fix_escape_printf("%s\t\"Topic\": \"%s\"", need_sep ? ",\n" : "", topic);
+		fix_escape_printf(&buf, "%s\t\"Topic\": \"%S\"", need_sep ? ",\n" : "", topic);
 		need_sep = true;
 	}
 	if (event_name) {
-		fix_escape_printf("%s\t\"EventName\": \"%s\"", need_sep ? ",\n" : "", event_name);
+		fix_escape_printf(&buf, "%s\t\"EventName\": \"%S\"", need_sep ? ",\n" : "",
+				  event_name);
 		need_sep = true;
 	}
 	if (event_alias && strlen(event_alias)) {
-		fix_escape_printf("%s\t\"EventAlias\": \"%s\"", need_sep ? ",\n" : "", event_alias);
+		fix_escape_printf(&buf, "%s\t\"EventAlias\": \"%S\"", need_sep ? ",\n" : "",
+				  event_alias);
 		need_sep = true;
 	}
 	if (scale_unit && strlen(scale_unit)) {
-		fix_escape_printf("%s\t\"ScaleUnit\": \"%s\"", need_sep ? ",\n" : "",
+		fix_escape_printf(&buf, "%s\t\"ScaleUnit\": \"%S\"", need_sep ? ",\n" : "",
 				  scale_unit);
 		need_sep = true;
 	}
 	if (event_type_desc) {
-		fix_escape_printf("%s\t\"EventType\": \"%s\"", need_sep ? ",\n" : "",
+		fix_escape_printf(&buf, "%s\t\"EventType\": \"%S\"", need_sep ? ",\n" : "",
 				  event_type_desc);
 		need_sep = true;
 	}
 	if (deprecated) {
-		fix_escape_printf("%s\t\"Deprecated\": \"%s\"", need_sep ? ",\n" : "",
+		fix_escape_printf(&buf, "%s\t\"Deprecated\": \"%S\"", need_sep ? ",\n" : "",
 				  deprecated ? "1" : "0");
 		need_sep = true;
 	}
 	if (desc) {
-		fix_escape_printf("%s\t\"BriefDescription\": \"%s\"", need_sep ? ",\n" : "", desc);
+		fix_escape_printf(&buf, "%s\t\"BriefDescription\": \"%S\"", need_sep ? ",\n" : "",
+				  desc);
 		need_sep = true;
 	}
 	if (long_desc) {
-		fix_escape_printf("%s\t\"PublicDescription\": \"%s\"", need_sep ? ",\n" : "",
+		fix_escape_printf(&buf, "%s\t\"PublicDescription\": \"%S\"", need_sep ? ",\n" : "",
 				  long_desc);
 		need_sep = true;
 	}
 	if (encoding_desc) {
-		fix_escape_printf("%s\t\"Encoding\": \"%s\"", need_sep ? ",\n" : "", encoding_desc);
+		fix_escape_printf(&buf, "%s\t\"Encoding\": \"%S\"", need_sep ? ",\n" : "",
+				  encoding_desc);
 		need_sep = true;
 	}
 	if (metric_name) {
-		fix_escape_printf("%s\t\"MetricName\": \"%s\"", need_sep ? ",\n" : "", metric_name);
+		fix_escape_printf(&buf, "%s\t\"MetricName\": \"%S\"", need_sep ? ",\n" : "",
+				  metric_name);
 		need_sep = true;
 	}
 	if (metric_expr) {
-		fix_escape_printf("%s\t\"MetricExpr\": \"%s\"", need_sep ? ",\n" : "", metric_expr);
+		fix_escape_printf(&buf, "%s\t\"MetricExpr\": \"%S\"", need_sep ? ",\n" : "",
+				  metric_expr);
 		need_sep = true;
 	}
 	printf("%s}", need_sep ? "\n" : "");
+	strbuf_release(&buf);
 }
 
 static void json_print_metric(void *ps __maybe_unused, const char *group,
@@ -366,35 +387,39 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 {
 	struct json_print_state *print_state = ps;
 	bool need_sep = false;
+	struct strbuf buf;
 
+	strbuf_init(&buf, 0);
 	printf("%s{\n", print_state->need_sep ? ",\n" : "");
 	print_state->need_sep = true;
 	if (group) {
-		fix_escape_printf("\t\"MetricGroup\": \"%s\"", group);
+		fix_escape_printf(&buf, "\t\"MetricGroup\": \"%S\"", group);
 		need_sep = true;
 	}
 	if (name) {
-		fix_escape_printf("%s\t\"MetricName\": \"%s\"", need_sep ? ",\n" : "", name);
+		fix_escape_printf(&buf, "%s\t\"MetricName\": \"%S\"", need_sep ? ",\n" : "", name);
 		need_sep = true;
 	}
 	if (expr) {
-		fix_escape_printf("%s\t\"MetricExpr\": \"%s\"", need_sep ? ",\n" : "", expr);
+		fix_escape_printf(&buf, "%s\t\"MetricExpr\": \"%S\"", need_sep ? ",\n" : "", expr);
 		need_sep = true;
 	}
 	if (unit) {
-		fix_escape_printf("%s\t\"ScaleUnit\": \"%s\"", need_sep ? ",\n" : "", unit);
+		fix_escape_printf(&buf, "%s\t\"ScaleUnit\": \"%S\"", need_sep ? ",\n" : "", unit);
 		need_sep = true;
 	}
 	if (desc) {
-		fix_escape_printf("%s\t\"BriefDescription\": \"%s\"", need_sep ? ",\n" : "", desc);
+		fix_escape_printf(&buf, "%s\t\"BriefDescription\": \"%S\"", need_sep ? ",\n" : "",
+				  desc);
 		need_sep = true;
 	}
 	if (long_desc) {
-		fix_escape_printf("%s\t\"PublicDescription\": \"%s\"", need_sep ? ",\n" : "",
+		fix_escape_printf(&buf, "%s\t\"PublicDescription\": \"%S\"", need_sep ? ",\n" : "",
 				  long_desc);
 		need_sep = true;
 	}
 	printf("%s}", need_sep ? "\n" : "");
+	strbuf_release(&buf);
 }
 
 int cmd_list(int argc, const char **argv)
-- 
2.38.1.584.g0f3c55d4c2-goog

