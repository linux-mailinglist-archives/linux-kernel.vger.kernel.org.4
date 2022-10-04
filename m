Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795285F499B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJDTND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJDTMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:12:55 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DA58080;
        Tue,  4 Oct 2022 12:12:53 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id d64so15382719oia.9;
        Tue, 04 Oct 2022 12:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Npf77P9lkPbujhnSXyowlipi0F47IbjBYbqXJzE7RUQ=;
        b=6xCHpEJ4z+soHR+dGdw3BdCwel5hDHqymC7GXN/FgAV3NFW4XoOa6CtuaizS9xrLWV
         0cL3NQGPos+x5S3QU1gtGK7AJLKfNkd1+b2TBTT3kj+Mjra5e7ubhgzgmnG/sOl/MIoB
         0DsLAGV/OJCtk0aHHtGJDrWIYsj1r28m4fzWT0D9QywQ9ci2z0NH+zVhXELDevjjYrZq
         kPQ3w/4wY/Ki4ITUAdhBWvv3vPzfBxZoiQznX134Ow1U+zg31v20mAM5d01momzMnZCO
         M/X/fxh+LmlWku25JlpU87sq3b4gUzH/T/8uqlU9KEM2Un1twE4fjuLKiQh2wBVxbgow
         TwYg==
X-Gm-Message-State: ACrzQf0aBDyBsgfQxhRxLYHDGBiv4WwxARz7OKT0ClExnqI0slzyGP6g
        lYLekRoT4GidySYALM5396alql+EGg==
X-Google-Smtp-Source: AMsMyM7rN0SoiUtw1ElL6i7bUkA6SdJHtezc7Ayg6eZjpEZobCoiR0qlZtdCN+nz2HfcK9e5ceqN0g==
X-Received: by 2002:a05:6808:1588:b0:34f:ba9c:7931 with SMTP id t8-20020a056808158800b0034fba9c7931mr562381oiw.137.1664910772406;
        Tue, 04 Oct 2022 12:12:52 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id q206-20020acaf2d7000000b003507c386a4asm3296336oih.40.2022.10.04.12.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:12:50 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 04 Oct 2022 14:12:37 -0500
Subject: [PATCH v4 3/3] perf: Add support for perf_event_attr::config3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220914-arm-perf-tool-spe1-2-v2-v4-3-83c098e6212e@kernel.org>
References: <20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org>
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event_attr has gained a new field, config3, so add support for it
extending the existing configN support.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This patch is dependent on the kernel side landing first.

v4:
 - Add config3 to event parsing tests
---
 tools/perf/tests/parse-events.c | 13 ++++++++++++-
 tools/perf/util/parse-events.c  |  6 ++++++
 tools/perf/util/parse-events.h  |  1 +
 tools/perf/util/parse-events.l  |  1 +
 tools/perf/util/pmu.c           |  3 +++
 tools/perf/util/pmu.h           |  1 +
 6 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 459afdb256a1..ddd5bdfe5723 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -444,6 +444,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong config",    10 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong config1",    1 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2",    3 == evsel->core.attr.config2);
+	TEST_ASSERT_VAL("wrong config3",    0 == evsel->core.attr.config3);
 	/*
 	 * The period value gets configured within evlist__config,
 	 * while this test executes only parse events method.
@@ -464,6 +465,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong config1", 0 == evsel->core.attr.config1);
 	TEST_ASSERT_VAL("wrong config2", 0 == evsel->core.attr.config2);
+	TEST_ASSERT_VAL("wrong config3", 0 == evsel->core.attr.config3);
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
@@ -625,6 +627,15 @@ static int test__checkterms_simple(struct list_head *terms)
 	TEST_ASSERT_VAL("wrong val", term->val.num == 3);
 	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config2"));
 
+	/* config3=4 */
+	term = list_entry(term->list.next, struct parse_events_term, list);
+	TEST_ASSERT_VAL("wrong type term",
+			term->type_term == PARSE_EVENTS__TERM_TYPE_CONFIG3);
+	TEST_ASSERT_VAL("wrong type val",
+			term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
+	TEST_ASSERT_VAL("wrong val", term->val.num == 4);
+	TEST_ASSERT_VAL("wrong config", !strcmp(term->config, "config3"));
+
 	/* umask=1*/
 	term = list_entry(term->list.next, struct parse_events_term, list);
 	TEST_ASSERT_VAL("wrong type term",
@@ -1983,7 +1994,7 @@ struct terms_test {
 
 static const struct terms_test test__terms[] = {
 	[0] = {
-		.str   = "config=10,config1,config2=3,umask=1,read,r0xead",
+		.str   = "config=10,config1,config2=3,config3=4,umask=1,read,r0xead",
 		.check = test__checkterms_simple,
 	},
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e2305fca0f95..c843434981d0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -913,6 +913,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_CONFIG]		= "config",
 	[PARSE_EVENTS__TERM_TYPE_CONFIG1]		= "config1",
 	[PARSE_EVENTS__TERM_TYPE_CONFIG2]		= "config2",
+	[PARSE_EVENTS__TERM_TYPE_CONFIG3]		= "config3",
 	[PARSE_EVENTS__TERM_TYPE_NAME]			= "name",
 	[PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD]		= "period",
 	[PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ]		= "freq",
@@ -952,6 +953,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
 	case PARSE_EVENTS__TERM_TYPE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
+	case PARSE_EVENTS__TERM_TYPE_CONFIG3:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
@@ -997,6 +999,10 @@ do {									   \
 		CHECK_TYPE_VAL(NUM);
 		attr->config2 = term->val.num;
 		break;
+	case PARSE_EVENTS__TERM_TYPE_CONFIG3:
+		CHECK_TYPE_VAL(NUM);
+		attr->config3 = term->val.num;
+		break;
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 		CHECK_TYPE_VAL(NUM);
 		break;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 7e6a601d9cd0..fa9460900abf 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -59,6 +59,7 @@ enum {
 	PARSE_EVENTS__TERM_TYPE_CONFIG,
 	PARSE_EVENTS__TERM_TYPE_CONFIG1,
 	PARSE_EVENTS__TERM_TYPE_CONFIG2,
+	PARSE_EVENTS__TERM_TYPE_CONFIG3,
 	PARSE_EVENTS__TERM_TYPE_NAME,
 	PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD,
 	PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ,
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 3a9ce96c8bce..51fe0a9fb3de 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -285,6 +285,7 @@ modifier_bp	[rwx]{1,3}
 config			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG); }
 config1			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG1); }
 config2			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG2); }
+config3			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG3); }
 name			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NAME); }
 period			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD); }
 freq			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ); }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 82455b073c2f..9c0a4b9973a4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1278,6 +1278,9 @@ static int pmu_config_term(const char *pmu_name,
 	case PERF_PMU_FORMAT_VALUE_CONFIG2:
 		vp = &attr->config2;
 		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG3:
+		vp = &attr->config3;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 68e15c38ae71..2e6bd1bf304a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -17,6 +17,7 @@ enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
 	PERF_PMU_FORMAT_VALUE_CONFIG1,
 	PERF_PMU_FORMAT_VALUE_CONFIG2,
+	PERF_PMU_FORMAT_VALUE_CONFIG3,
 	PERF_PMU_FORMAT_VALUE_CONFIG_END,
 };
 

-- 
b4 0.11.0-dev
