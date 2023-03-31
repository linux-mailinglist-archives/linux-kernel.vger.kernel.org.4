Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D482F6D2975
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjCaUaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCaU36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:29:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DB01A473;
        Fri, 31 Mar 2023 13:29:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o2so22393318plg.4;
        Fri, 31 Mar 2023 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294596; x=1682886596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYLcbGcSpDsJ6OJqWj4Xn7XRp6fiJcNPcFrLyu2WCoE=;
        b=oad0BYHUDzSkNBpOlyfUkLXc2FssNytWVUcfWpzbnbu2DAVp2rl7MCpfe82iKxzwOy
         EeeG4Z5UbpoUrko0DG24q2CidqbuBlw4K2Mx7OpclYJmrtPPpZvqmxHhQgELexYh7A9+
         3kKX7VFC2BAAF6yDNQX8ZaFgs/iZGg9oaCOTLi2hNWnfsEG7zyGjlzLItSQ8DmNbWB9z
         raaeBa+5P0JtoqnaZwhi+Bp0TWYwUr/caa9erQ5nSNGJU8V39NZMO3OopiEAlI86gjyX
         pmI9cR+dy5/klfLnGdjMcyqMh/z9AUufvub+AFHO8v6DOOgDm4T1aGSzeJoNPZZ3mDJG
         uSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294596; x=1682886596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYLcbGcSpDsJ6OJqWj4Xn7XRp6fiJcNPcFrLyu2WCoE=;
        b=1EdQs7LiVNS/GbbL3dUjBCPlIIA09/yRee5ismJ6LTW/PSjHPEXRtEW2j9fDmrSxwb
         hSuzLb5BB1egg9j7QBXI1Gj5g1DEw9IG5uAAAlq0IkakljjD9D07ZgzavJrWwP2KovZX
         XA4SSXdF/7nE/tgMBgbIZeqxnrcmXzSEMUIsIhZ1PrZSROlRT+LQJFTB0cNcymmA/vyX
         SQB1IYXHXNHVkLKNZ0xzMZ3Pk8nFXfJqJi82h/U47wJsaJsD1uXoBPWOs1BKAmqGh2TE
         cE5RgSUUHJ3HPaLpUIa0VwB2lIsAiCLK58bZO9hV/L4lfX+HOuc6PxQW93gvAZpDCb11
         yCHg==
X-Gm-Message-State: AAQBX9cBNe2YWl1Ib6lx/XNHR7scGiQX5SDLThiDCnIzQH66h8xfiEZ8
        3nUaMg8LFLWrfvjMfhHkbFg=
X-Google-Smtp-Source: AKy350ZcEji4uaR1p6lgxzaA12AZiN5GHsf6CZ6J375Iq8kmhHeBSVuDkGCSZ2qpAVVcEf58HLQ42A==
X-Received: by 2002:a17:902:db03:b0:1a1:b15a:d916 with SMTP id m3-20020a170902db0300b001a1b15ad916mr35911481plx.3.1680294596038;
        Fri, 31 Mar 2023 13:29:56 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:5cfb:ad2c:e6f5:d42f])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a1dc2be791sm1916803plo.259.2023.03.31.13.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:29:55 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 3/9] perf pmu: Add perf_pmu__destroy() function
Date:   Fri, 31 Mar 2023 13:29:43 -0700
Message-Id: <20230331202949.810326-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331202949.810326-1-namhyung@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems there's no function to delete the perf pmu struct.  Add the
perf_pmu__destroy() to do the job.  While at it, add some more helper
functions to delete pmu aliases and caps.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/pmu.c | 50 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e3aae731bd6f..b112606f36ec 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -300,6 +300,16 @@ void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
 	free(newalias);
 }
 
+static void perf_pmu__del_aliases(struct perf_pmu *pmu)
+{
+	struct perf_pmu_alias *alias, *tmp;
+
+	list_for_each_entry_safe(alias, tmp, &pmu->aliases, list) {
+		list_del(&alias->list);
+		perf_pmu_free_alias(alias);
+	}
+}
+
 /* Merge an alias, search in alias list. If this name is already
  * present merge both of them to combine all information.
  */
@@ -921,6 +931,8 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
 
 	if (is_hybrid)
 		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
+	else
+		INIT_LIST_HEAD(&pmu->hybrid_list);
 
 	pmu->default_config = perf_pmu__get_default_config(pmu);
 
@@ -1750,6 +1762,18 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
 	return -ENOMEM;
 }
 
+static void perf_pmu__del_caps(struct perf_pmu *pmu)
+{
+	struct perf_pmu_caps *caps, *tmp;
+
+	list_for_each_entry_safe(caps, tmp, &pmu->caps, list) {
+		list_del(&caps->list);
+		free(caps->name);
+		free(caps->value);
+		free(caps);
+	}
+}
+
 /*
  * Reading/parsing the given pmu capabilities, which should be located at:
  * /sys/bus/event_source/devices/<dev>/caps as sysfs group attributes.
@@ -1932,3 +1956,29 @@ int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 		return 0;
 	return scnprintf(buf, size, "%s%s/%s", base_path, pmu_name, filename);
 }
+
+static void perf_pmu__delete(struct perf_pmu *pmu)
+{
+	perf_pmu__del_formats(&pmu->format);
+	perf_pmu__del_aliases(pmu);
+	perf_pmu__del_caps(pmu);
+
+	perf_cpu_map__put(pmu->cpus);
+
+	free(pmu->default_config);
+	free(pmu->name);
+	free(pmu->alias_name);
+	free(pmu);
+}
+
+void perf_pmu__destroy(void)
+{
+	struct perf_pmu *pmu, *tmp;
+
+	list_for_each_entry_safe(pmu, tmp, &pmus, list) {
+		list_del(&pmu->list);
+		list_del(&pmu->hybrid_list);
+
+		perf_pmu__delete(pmu);
+	}
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 24cf69ab32cd..72fd5de334c0 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -259,4 +259,6 @@ int perf_pmu__pathname_scnprintf(char *buf, size_t size,
 				 const char *pmu_name, const char *filename);
 FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
 
+void perf_pmu__destroy(void);
+
 #endif /* __PMU_H */
-- 
2.40.0.348.gf938b09366-goog

