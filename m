Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E266D5B8F82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiINUJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiINUJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:09:22 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E624BA62;
        Wed, 14 Sep 2022 13:09:18 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id e35-20020a9d01a6000000b0065798eb8754so2010407ote.2;
        Wed, 14 Sep 2022 13:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=R5fWkUGSllbljMyohKjOADaVD57INk7xkRNpWDPkOt0=;
        b=mZb72/JPvQruJdNYi5zHMpRSvmGdi2ILYlEI+e9d5fugu8gEl7/+vKBBy8brxvn7Nx
         lHLTdNoFGPXmmHXcHR5IHM7eJ86hGDEjMGaDngK8j0Tmtas6TJmlZwHeXfTWHht8IqN/
         L3pFqNk/n4AK1phCKPNBhO5JroHzRcAyeGU8oZ4oEU4114J2MtaN2ggxhJ5LNHsAQeJ7
         yTcRfuxWPF0efVsl5yIziCsRmndvDF8vYN5RA5jHrZr/Q3McpFTasLFxZrdJy11HfwnH
         YgnizsEvLDAtYQz6jSftE9CLECnqvWjb7/3hYIFauuswv4RodQhNPQ39YHksSw9GqjC5
         /e8Q==
X-Gm-Message-State: ACgBeo1d7p1bXYLJaFEC7o3Whf6+WfhvpwsZtlRmabib21xglXbxEG3y
        DW3TwCw0TG7K6Z1jjYfwzw==
X-Google-Smtp-Source: AA6agR4MQNquEqL/zMORmCUfESJlcG7PS6+eAYSZD3635/Ofh9iaTcX0F9LYOQmnsCMTpysw+mlRMg==
X-Received: by 2002:a9d:4715:0:b0:655:d20b:48fe with SMTP id a21-20020a9d4715000000b00655d20b48femr7933327otf.297.1663186157195;
        Wed, 14 Sep 2022 13:09:17 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id r22-20020a544896000000b0033a37114eb0sm6745050oic.19.2022.09.14.13.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 13:09:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Sep 2022 15:08:36 -0500
Subject: [PATCH v3 3/3] perf: Add support for perf_event_attr::config3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220914-arm-perf-tool-spe1-2-v2-v3-3-8189fc04dcc6@kernel.org>
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
index 2a0d1415dd55..6943a11b822c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1274,6 +1274,9 @@ static int pmu_config_term(const char *pmu_name,
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
b4 0.10.0-dev
