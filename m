Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AB571908E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjFAChG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFAChC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:37:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42CC101
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:36:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-556011695d1so4626987b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685587012; x=1688179012;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Un+d9bbUUo6eEPh9c0X/g9yc3mMd6V9G/fsRspSIKFQ=;
        b=WDHOMUBimLBjijATPaSZrfFdO/tqHc6mI4Z/rvpnqjOOam8G4SaD4TBifOq0qfIfFr
         7jGx+dw8fJHUX02UvgWlPS2lGTM7eEKoyRRMdo6L+C9VWQogmOcyeaCj5bDF1T/Jbykx
         HqUjHzC4v6PzfO4COYaFJ/pkvn8kAwO/btUG6lbHH1iSvcWf05D5nqgjmH6eickavmmS
         3Eqss/OdpEa3HXJvnCSTMal81ujG8rupihX0h1OqAfNljEhI/LK7Z6X0cuYtY6inKofr
         sAilyePm+tT5QOG+BcmJDxAJ9zzYqYGUhoznv9e+k3/leTk9DqsiXmW1jDCCWrzgL/r+
         XZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685587012; x=1688179012;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Un+d9bbUUo6eEPh9c0X/g9yc3mMd6V9G/fsRspSIKFQ=;
        b=lEIm2A8Xj2tYilkVQXnDQYyWND4iXWTavTp8V0LWxK/IT51GnpWU6fGFdGbzKxznX3
         UFdwgeUUD+sx1hfVuj57Q0hPXDIk0TSDZT07BZrZHkPKvrb1aGd/ihfG7SFGtvBuk3z2
         6nCMvptkQacUqnuGaXvByBep2hic7jYpzp/iIpEKxQI38BpJSecQXOgqDdY1CsBXeSdP
         HlBpCquL+qg1Zx+f8OE7PLXoi6ey9ywdiF3TXPyq0u58dC+RZfS5nSc9h1Bsk7fHEoJT
         TPBySCURJgzS9G3UiizGF5xxXmsU/NUGj0iDTIl4J8U4R9WoiQIThC/+KGTdAFO49j23
         Ev3A==
X-Gm-Message-State: AC+VfDwAc/0WC2DwNADdaXBl7iBuUCx/itj1SCICaSQcoieYXXCFik96
        Vyt5vg1ux0uge/YQibU76JDaO/c3bfn0
X-Google-Smtp-Source: ACHHUZ4bFlhxm6tfUccKpil4vsQdmEyhfC1jgqvMA4NBA7QbbaTxBKR80pjeY5fYpBCR8e85xJPjJaNsC7g5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a344:94b4:9b8d:a089])
 (user=irogers job=sendgmr) by 2002:a81:ad45:0:b0:568:f4f8:6d59 with SMTP id
 l5-20020a81ad45000000b00568f4f86d59mr2024229ywk.3.1685587012083; Wed, 31 May
 2023 19:36:52 -0700 (PDT)
Date:   Wed, 31 May 2023 19:36:44 -0700
In-Reply-To: <20230601023644.587584-1-irogers@google.com>
Message-Id: <20230601023644.587584-2-irogers@google.com>
Mime-Version: 1.0
References: <20230601023644.587584-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 2/2] perf pmu: Warn about invalid config for all PMUs and configs
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
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Don't just check the raw PMU type, the only core PMU on homogeneous
x86, check raw and all dynamically added PMUs. Extend the
perf_pmu__warn_invalid_config to check all 4 config values. Rather
than process the format list once per event, store the computed masks
for each config value. Don't ignore the mask being zero, which is
likely for config2 and config3, add config_masks_present so config
values can be ignored only when no format information is present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 13 +++++++++---
 tools/perf/util/pmu.c          | 38 ++++++++++++++++++++++++----------
 tools/perf/util/pmu.h          | 13 +++++++++++-
 3 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7f047ac11168..9f60607b0d86 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -245,9 +245,16 @@ __add_event(struct list_head *list, int *idx,
 	if (pmu)
 		perf_pmu__warn_invalid_formats(pmu);
 
-	if (pmu && attr->type == PERF_TYPE_RAW)
-		perf_pmu__warn_invalid_config(pmu, attr->config, name);
-
+	if (pmu && (attr->type == PERF_TYPE_RAW || attr->type >= PERF_TYPE_MAX)) {
+		perf_pmu__warn_invalid_config(pmu, attr->config, name,
+					      PERF_PMU_FORMAT_VALUE_CONFIG, "config");
+		perf_pmu__warn_invalid_config(pmu, attr->config1, name,
+					      PERF_PMU_FORMAT_VALUE_CONFIG1, "config1");
+		perf_pmu__warn_invalid_config(pmu, attr->config2, name,
+					      PERF_PMU_FORMAT_VALUE_CONFIG2, "config2");
+		perf_pmu__warn_invalid_config(pmu, attr->config3, name,
+					      PERF_PMU_FORMAT_VALUE_CONFIG3, "config3");
+	}
 	if (init_attr)
 		event_attr_init(attr);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 204ce3f02e63..b0443406fd57 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1611,37 +1611,53 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 	return pmu->nr_caps;
 }
 
-void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
-				   const char *name)
+static void perf_pmu__compute_config_masks(struct perf_pmu *pmu)
 {
 	struct perf_pmu_format *format;
-	__u64 masks = 0, bits;
-	char buf[100];
-	unsigned int i;
+
+	if (pmu->config_masks_computed)
+		return;
 
 	list_for_each_entry(format, &pmu->format, list)	{
-		if (format->value != PERF_PMU_FORMAT_VALUE_CONFIG)
+		unsigned int i;
+		__u64 *mask;
+
+		if (format->value >= PERF_PMU_FORMAT_VALUE_CONFIG_END)
 			continue;
 
+		pmu->config_masks_present = true;
+		mask = &pmu->config_masks[format->value];
+
 		for_each_set_bit(i, format->bits, PERF_PMU_FORMAT_BITS)
-			masks |= 1ULL << i;
+			*mask |= 1ULL << i;
 	}
+	pmu->config_masks_computed = true;
+}
+
+void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
+				   const char *name, int config_num,
+				   const char *config_name)
+{
+	__u64 bits;
+	char buf[100];
+
+	perf_pmu__compute_config_masks(pmu);
 
 	/*
 	 * Kernel doesn't export any valid format bits.
 	 */
-	if (masks == 0)
+	if (!pmu->config_masks_present)
 		return;
 
-	bits = config & ~masks;
+	bits = config & ~pmu->config_masks[config_num];
 	if (bits == 0)
 		return;
 
 	bitmap_scnprintf((unsigned long *)&bits, sizeof(bits) * 8, buf, sizeof(buf));
 
-	pr_warning("WARNING: event '%s' not valid (bits %s of config "
+	pr_warning("WARNING: event '%s' not valid (bits %s of %s "
 		   "'%llx' not supported by kernel)!\n",
-		   name ?: "N/A", buf, config);
+		   name ?: "N/A", buf, config_name, config);
 }
 
 int perf_pmu__match(char *pattern, char *name, char *tok)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 7a1535dc1f12..d98b0feec022 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -81,6 +81,10 @@ struct perf_pmu {
 	 * perf_event_attr once.
 	 */
 	bool formats_checked;
+	/** @config_masks_present: Are there config format values? */
+	bool config_masks_present;
+	/** @config_masks_computed: Set when masks are lazily computed. */
+	bool config_masks_computed;
 	/**
 	 * @max_precise: Number of levels of :ppp precision supported by the
 	 * PMU, read from
@@ -125,6 +129,12 @@ struct perf_pmu {
 	/** @list: Element on pmus list in pmu.c. */
 	struct list_head list;
 
+	/**
+	 * @config_masks: Derived from the PMU's format data, bits that are
+	 * valid within the config value.
+	 */
+	__u64 config_masks[PERF_PMU_FORMAT_VALUE_CONFIG_END];
+
 	/**
 	 * @missing_features: Features to inhibit when events on this PMU are
 	 * opened.
@@ -255,7 +265,8 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
-				   const char *name);
+				   const char *name, int config_num,
+				   const char *config_name);
 void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
 
 int perf_pmu__match(char *pattern, char *name, char *tok);
-- 
2.41.0.rc0.172.g3f132b7071-goog

