Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB169B589
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBQWct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBQWco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:32:44 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4C5F83D;
        Fri, 17 Feb 2023 14:32:42 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-17172b43531so2923308fac.1;
        Fri, 17 Feb 2023 14:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wv3uMFhrX0zu65zR8xr/Styloh6XLaktubY3Ad8zIsg=;
        b=y/dbRxG5648LIRZht1dH8wJzbypv8PGRVh6AtNhJzMmy+AjExNkocBAYLLXuAbYEFZ
         5WRqYQe/B9D7v3eZiOunrEkxGDQbmYH+Bf5shv49mG0vHlIXXZfisZsez4AXt2ZV9Vlr
         L/mLnneksZQscsLK36QTirsIKjawUQ1G4MpqI9ZMj2Ia52+OWIKGCgof4uNK0pM4fkwm
         /nqSwYI/hc2gnNhSDqLS8u9ljLsJWRL1Fhb31Pm53ohVAdJjEG6fmHCMzq8MW49DYOKg
         tqd06lxbM0qXxJDKxy57vhEPS0qZwZT6XH3eceDCIGyAVsM/mfokQAGnQ/nhC1rKqzn8
         C7IQ==
X-Gm-Message-State: AO0yUKVr6k/XXv9tTjFVT7+A81trcbr2iojuNLD+AMsQ7wd1tDZkO3Z4
        MjhMyFxTb9N0Vdd7G+ZZ9m5LcxbFwA==
X-Google-Smtp-Source: AK7set+NZKF/D5gc26VeXney/Jw6ZpsS5O5nmUrb6A5H8yyRThctuCZCNYvA+6s3YJETvfxw08CH4w==
X-Received: by 2002:a05:6870:a414:b0:16e:3b9e:b75b with SMTP id m20-20020a056870a41400b0016e3b9eb75bmr1549538oal.8.1676673161847;
        Fri, 17 Feb 2023 14:32:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ef5-20020a0568701a8500b00152c52608dbsm1223926oab.34.2023.02.17.14.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 14:32:41 -0800 (PST)
Received: (nullmailer pid 1684710 invoked by uid 1000);
        Fri, 17 Feb 2023 22:32:38 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Feb 2023 16:32:11 -0600
Subject: [PATCH v5 2/2] perf: Add support for perf_event_attr::config3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220914-arm-perf-tool-spe1-2-v2-v5-2-2cf5210b2f77@kernel.org>
References: <20220914-arm-perf-tool-spe1-2-v2-v5-0-2cf5210b2f77@kernel.org>
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v5-0-2cf5210b2f77@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event_attr has gained a new field, config3, so add support for it
extending the existing configN support.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v5:
 - Rebase on v6.2-rc1

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
index 5973f46c2375..a2ae92736aac 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -944,6 +944,7 @@ static const char *config_term_names[__PARSE_EVENTS__TERM_TYPE_NR] = {
 	[PARSE_EVENTS__TERM_TYPE_CONFIG]		= "config",
 	[PARSE_EVENTS__TERM_TYPE_CONFIG1]		= "config1",
 	[PARSE_EVENTS__TERM_TYPE_CONFIG2]		= "config2",
+	[PARSE_EVENTS__TERM_TYPE_CONFIG3]		= "config3",
 	[PARSE_EVENTS__TERM_TYPE_NAME]			= "name",
 	[PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD]		= "period",
 	[PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ]		= "freq",
@@ -983,6 +984,7 @@ config_term_avail(int term_type, struct parse_events_error *err)
 	case PARSE_EVENTS__TERM_TYPE_CONFIG:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 	case PARSE_EVENTS__TERM_TYPE_CONFIG2:
+	case PARSE_EVENTS__TERM_TYPE_CONFIG3:
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
@@ -1028,6 +1030,10 @@ do {									   \
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
index 07df7bb7b042..34db4870a56b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -60,6 +60,7 @@ enum {
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
index 03284059175f..2d9a0c35c6c3 100644
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
2.39.1

