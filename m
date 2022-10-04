Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED625F4999
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJDTMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJDTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:12:48 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263253FED1;
        Tue,  4 Oct 2022 12:12:47 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l5so15368760oif.7;
        Tue, 04 Oct 2022 12:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=plxfpmdSiYxEjBBgPR80VDYlPmqh5dHuVln8TbghOIQ=;
        b=V4LD7g1/i6O48LQWJvC0tSbzpN+imOOntbyKlTMGvJjK9WIz6R6oRpkHq/Wim3l71H
         +sFNWiH7OEHnuCJZsEMRxTgYLedJoyeciLfB+w5b11KL1yaJCSN5vdgVBnKppw2mAEy4
         k0bx6taQ5vIQCTLA9RdqnlxO3pZ3ZJy138qAqr4Y4bzzUzGW0+Vv+v7M5V+YcMZ8PhLl
         689Ok1JmGi7bG8JvN1FWBeiKlk6sWZbv1GAthPsbfykMLWMkYnDd7wx1oDoh+jA1A5cv
         3lzAZDfIiDNtcFzNbbOQGJJmhnQC8lBOxroQRqVh27ERg+SDogOJm1tmUcW6c6qvo81q
         tliw==
X-Gm-Message-State: ACrzQf2s/Nk5LS6x3ycpTXs+ukrTiqXwLpPiK+qVpnY+poBgM3raTl6Y
        1YaKPmo9LoXn2NZhyBMue3gICO3+1Q==
X-Google-Smtp-Source: AMsMyM5Gm2KDYxEsmkv3cYXbxUUdMnL9o89RElJvpEUiYC7cx3/R+5tG95/a41nSO0M+EA5VzRUuiA==
X-Received: by 2002:a05:6808:130d:b0:351:8aa4:fd8 with SMTP id y13-20020a056808130d00b003518aa40fd8mr579597oiv.74.1664910766132;
        Tue, 04 Oct 2022 12:12:46 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id q206-20020acaf2d7000000b003507c386a4asm3296336oih.40.2022.10.04.12.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:12:42 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 04 Oct 2022 14:12:35 -0500
Subject: [PATCH v4 1/3] perf: Skip and warn on unknown format 'configN' attrs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220914-arm-perf-tool-spe1-2-v2-v4-1-83c098e6212e@kernel.org>
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

If the kernel exposes a new perf_event_attr field in a format attr, perf
will return an error stating the specified PMU can't be found. For
example, a format attr with 'config3:0-63' causes an error as config3 is
unknown to perf. This causes a compatibility issue between a newer
kernel with older perf tool.

Before this change with a kernel adding 'config3' I get:

$ perf record -e arm_spe// -- true
event syntax error: 'arm_spe//'
                     \___ Cannot find PMU `arm_spe'. Missing kernel support?
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
available events

After this change, I get:

$ perf record -e arm_spe// -- true
WARNING: 'arm_spe_0' format 'inv_event_filter' requires 'perf_event_attr::config3' which is not supported by this version of perf!
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.091 MB perf.data ]

To support unknown configN formats, rework the YACC implementation to
pass any config[0-9]+ format to perf_pmu__new_format() to handle with a
warning.

Cc: stable@vger.kernel.org
Tested-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
 - Skip format list check for fake pmu

v3:
 - https://lore.kernel.org/r/20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org
 - Move warning from format scanning to when PMU is selected
 - Add and use PERF_PMU_FORMAT_VALUE_CONFIG_END

v2:
 - https://lore.kernel.org/all/20220909204509.2169512-1-robh@kernel.org/
 - Rework YACC code to handle configN formats in C code
 - Add a warning when an unknown configN attr is found

v1:
 - https://lore.kernel.org/all/20220901184709.2179309-1-robh@kernel.org/
---
 tools/perf/util/parse-events.c |  3 +++
 tools/perf/util/pmu.c          | 17 +++++++++++++++++
 tools/perf/util/pmu.h          |  2 ++
 tools/perf/util/pmu.l          |  2 --
 tools/perf/util/pmu.y          | 15 ++++-----------
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f05e15acd33f..e2305fca0f95 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -215,6 +215,9 @@ __add_event(struct list_head *list, int *idx,
 	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
 			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
 
+	if (pmu)
+		perf_pmu__warn_invalid_formats(pmu);
+
 	if (pmu && attr->type == PERF_TYPE_RAW)
 		perf_pmu__warn_invalid_config(pmu, attr->config, name);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 89655d53117a..82455b073c2f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1005,6 +1005,23 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
 	return NULL;
 }
 
+void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
+{
+	struct perf_pmu_format *format;
+
+	/* fake pmu doesn't have format list */
+	if (pmu == &perf_pmu__fake)
+		return;
+
+	list_for_each_entry(format, &pmu->format, list)
+		if (format->value >= PERF_PMU_FORMAT_VALUE_CONFIG_END) {
+			pr_warning("WARNING: '%s' format '%s' requires 'perf_event_attr::config%d'"
+				   "which is not supported by this version of perf!\n",
+				   pmu->name, format->name, format->value);
+			return;
+		}
+}
+
 static struct perf_pmu *pmu_find(const char *name)
 {
 	struct perf_pmu *pmu;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index a7b0f9507510..68e15c38ae71 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -17,6 +17,7 @@ enum {
 	PERF_PMU_FORMAT_VALUE_CONFIG,
 	PERF_PMU_FORMAT_VALUE_CONFIG1,
 	PERF_PMU_FORMAT_VALUE_CONFIG2,
+	PERF_PMU_FORMAT_VALUE_CONFIG_END,
 };
 
 #define PERF_PMU_FORMAT_BITS 64
@@ -139,6 +140,7 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 				   const char *name);
+void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
 
 bool perf_pmu__has_hybrid(void);
 int perf_pmu__match(char *pattern, char *name, char *tok);
diff --git a/tools/perf/util/pmu.l b/tools/perf/util/pmu.l
index a15d9fbd7c0e..58b4926cfaca 100644
--- a/tools/perf/util/pmu.l
+++ b/tools/perf/util/pmu.l
@@ -27,8 +27,6 @@ num_dec         [0-9]+
 
 {num_dec}	{ return value(10); }
 config		{ return PP_CONFIG; }
-config1		{ return PP_CONFIG1; }
-config2		{ return PP_CONFIG2; }
 -		{ return '-'; }
 :		{ return ':'; }
 ,		{ return ','; }
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index bfd7e8509869..283efe059819 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -20,7 +20,7 @@ do { \
 
 %}
 
-%token PP_CONFIG PP_CONFIG1 PP_CONFIG2
+%token PP_CONFIG
 %token PP_VALUE PP_ERROR
 %type <num> PP_VALUE
 %type <bits> bit_term
@@ -47,18 +47,11 @@ PP_CONFIG ':' bits
 				      $3));
 }
 |
-PP_CONFIG1 ':' bits
+PP_CONFIG PP_VALUE ':' bits
 {
 	ABORT_ON(perf_pmu__new_format(format, name,
-				      PERF_PMU_FORMAT_VALUE_CONFIG1,
-				      $3));
-}
-|
-PP_CONFIG2 ':' bits
-{
-	ABORT_ON(perf_pmu__new_format(format, name,
-				      PERF_PMU_FORMAT_VALUE_CONFIG2,
-				      $3));
+				      $2,
+				      $4));
 }
 
 bits:

-- 
b4 0.11.0-dev
