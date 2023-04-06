Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D9A6DA658
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjDFXyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjDFXyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:54:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8238C83D1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:54:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c67-20020a254e46000000b00b88f1fd158fso12562949ybb.17
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680825252;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H6P8DEdnqlAjDS13bckAJnWyKK1GSCIBz/LMGwih+20=;
        b=W313JjATJDEdFIwneOWSc/FxfuW3JjuWTxSlzz7qCRYiA0eeEgn7lMwAOxjoFJs9Xt
         UdK1gUe9Fg1xfurIhFTCoKsD7Aq/h6OBpNNu3QAsO2IrP1T+4FMr+ZkSfE+uUz8xLWS4
         PoXxhD10zqoLwRN1EdDZTdIEcVL7czoj7i3cR2J9A1o5Ss61TyEPXbpUUV1+YSd8sBEJ
         iqlCYx091j4WriVxVzgAY9XKUtZaIKge1XJoFZFTzfUIkNYlBKSAAhwdOV/TYhGPdQjW
         Tsx+zLbXDFZI11oOKuj7LOJtiN8YBkY+s7yGU1Cttn8lEHnT43TxayfOvcIRQqDCwG5d
         9obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680825252;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6P8DEdnqlAjDS13bckAJnWyKK1GSCIBz/LMGwih+20=;
        b=RpnYFGyi7Dl0pIFuH1GyDhVwqbutGq30APXu9VHGOYYFCjIa84AEZEmwbw43tYSqTf
         7UyV9nMe2Es9mBTx7FpO/nxrQp2JqFfCIX/jp+vbSOmcdeedP7IFKvfZ8zvNjjWjISV9
         yo6RS+tNdwQetUB4ptvX3uWyYaKqTojuJUsB50HYSplcKwXd4NR3Uh9+MBnRQ0F9LV/C
         RCAw/kI9dT1Ju+OVYWyv+l/kKmSGah1ZBH3iclAioGyjmC7R/fVMgFcJFFTpoDDHosA/
         986gLw6DJbEclyYghwYWribV31z22Yw+KaFp4vQimPk9SSWI/IkSuwELcKG+muolGcfO
         9lsA==
X-Gm-Message-State: AAQBX9fxstwdZogUayPJQHg7DfML+bFob39nhYQ3PssiRK85TS9F2vcB
        lKAjZFifO5GXMwMTacOqhDfuF9GLYhW4
X-Google-Smtp-Source: AKy350ZUk5q2a1NYVrJlCfXNOzpQcmg4VR6E4uqsxkp/fC3yKmj52iJD2CxhLVeuWQ43I8VDAsotDmIJR1r2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:939d:185a:97bb:59ee])
 (user=irogers job=sendgmr) by 2002:a81:b724:0:b0:54c:2785:4281 with SMTP id
 v36-20020a81b724000000b0054c27854281mr34487ywh.6.1680825252828; Thu, 06 Apr
 2023 16:54:12 -0700 (PDT)
Date:   Thu,  6 Apr 2023 16:52:56 -0700
In-Reply-To: <20230406235256.2768773-1-irogers@google.com>
Message-Id: <20230406235256.2768773-3-irogers@google.com>
Mime-Version: 1.0
References: <20230406235256.2768773-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1 3/3] perf pmu: Sort and remove duplicates using json PMU name
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
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may have a lot of copies of a particular uncore PMU, such as
uncore_cha_0 to uncore_cha_59 on Intel sapphirerapids. The json events
may match each of PMUs and so the events are copied to it. In perf
list this means we see the same json event 60 times as events on
different PMUs don't have duplicates removed. There are 284 uncore_cha
events on sapphirerapids. Rather than use the PMU's name to sort and
remove duplicates, use the json PMU name. This reduces the 60 copies
back down to 1 and has the side effect of speeding things like the
"perf all PMU test" shell test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 47 ++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 00714f560643..03da1cdfa869 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1556,7 +1556,7 @@ static int cmp_sevent(const void *a, const void *b)
 {
 	const struct sevent *as = a;
 	const struct sevent *bs = b;
-	const char *a_pmu_name, *b_pmu_name;
+	const char *a_pmu_name = NULL, *b_pmu_name = NULL;
 	const char *a_name = "//", *a_desc = NULL, *a_topic = "";
 	const char *b_name = "//", *b_desc = NULL, *b_topic = "";
 	int ret;
@@ -1565,11 +1565,13 @@ static int cmp_sevent(const void *a, const void *b)
 		a_name = as->event->name;
 		a_desc = as->event->desc;
 		a_topic = as->event->topic ?: "";
+		a_pmu_name = as->event->pmu_name;
 	}
 	if (bs->event) {
 		b_name = bs->event->name;
 		b_desc = bs->event->desc;
 		b_topic = bs->event->topic ?: "";
+		b_pmu_name = bs->event->pmu_name;
 	}
 	/* Put extra events last. */
 	if (!!a_desc != !!b_desc)
@@ -1585,11 +1587,13 @@ static int cmp_sevent(const void *a, const void *b)
 		return as->is_cpu ? -1 : 1;
 
 	/* Order by PMU name. */
-	a_pmu_name = as->pmu->name ?: "";
-	b_pmu_name = bs->pmu->name ?: "";
-	ret = strcmp(a_pmu_name, b_pmu_name);
-	if (ret)
-		return ret;
+	if (as->pmu != bs->pmu) {
+		a_pmu_name = a_pmu_name ?: (as->pmu->name ?: "");
+		b_pmu_name = b_pmu_name ?: (bs->pmu->name ?: "");
+		ret = strcmp(a_pmu_name, b_pmu_name);
+		if (ret)
+			return ret;
+	}
 
 	/* Order by event name. */
 	return strcmp(a_name, b_name);
@@ -1603,17 +1607,26 @@ bool is_pmu_core(const char *name)
 static bool pmu_alias_is_duplicate(struct sevent *alias_a,
 				   struct sevent *alias_b)
 {
-	const char *a_pmu_name, *b_pmu_name;
-	const char *a_name = alias_a->event ? alias_a->event->name : "//";
-	const char *b_name = alias_b->event ? alias_b->event->name : "//";
+	const char *a_pmu_name = NULL, *b_pmu_name = NULL;
+	const char *a_name = "//", *b_name = "//";
+
+
+	if (alias_a->event) {
+		a_name = alias_a->event->name;
+		a_pmu_name = alias_a->event->pmu_name;
+	}
+	if (alias_b->event) {
+		b_name = alias_b->event->name;
+		b_pmu_name = alias_b->event->pmu_name;
+	}
 
 	/* Different names -> never duplicates */
 	if (strcmp(a_name, b_name))
 		return false;
 
 	/* Don't remove duplicates for different PMUs */
-	a_pmu_name = alias_a->pmu->name ?: "";
-	b_pmu_name = alias_b->pmu->name ?: "";
+	a_pmu_name = a_pmu_name ?: (alias_a->pmu->name ?: "");
+	b_pmu_name = b_pmu_name ?: (alias_b->pmu->name ?: "");
 	return strcmp(a_pmu_name, b_pmu_name) == 0;
 }
 
@@ -1662,7 +1675,8 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 	for (j = 0; j < len; j++) {
 		const char *name, *alias = NULL, *scale_unit = NULL,
 			*desc = NULL, *long_desc = NULL,
-			*encoding_desc = NULL, *topic = NULL;
+			*encoding_desc = NULL, *topic = NULL,
+			*pmu_name = NULL;
 		bool deprecated = false;
 		size_t buf_used;
 
@@ -1672,7 +1686,8 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 
 		if (!aliases[j].event) {
 			/* A selectable event. */
-			buf_used = snprintf(buf, sizeof(buf), "%s//", aliases[j].pmu->name) + 1;
+			pmu_name = aliases[j].pmu->name;
+			buf_used = snprintf(buf, sizeof(buf), "%s//", pmu_name) + 1;
 			name = buf;
 		} else {
 			if (aliases[j].event->desc) {
@@ -1687,6 +1702,7 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 				}
 				buf_used = strlen(buf) + 1;
 			}
+			pmu_name = aliases[j].event->pmu_name ?: (aliases[j].pmu->name ?: "");
 			if (strlen(aliases[j].event->unit) || aliases[j].event->scale != 1.0) {
 				scale_unit = buf + buf_used;
 				buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
@@ -1698,12 +1714,11 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 			topic = aliases[j].event->topic;
 			encoding_desc = buf + buf_used;
 			buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
-					"%s/%s/", aliases[j].pmu->name,
-					aliases[j].event->str) + 1;
+					"%s/%s/", pmu_name, aliases[j].event->str) + 1;
 			deprecated = aliases[j].event->deprecated;
 		}
 		print_cb->print_event(print_state,
-				aliases[j].pmu->name,
+				pmu_name,
 				topic,
 				name,
 				alias,
-- 
2.40.0.577.gac1e443424-goog

