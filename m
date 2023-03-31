Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D3C6D297B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjCaUak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjCaUaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:30:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1C22928;
        Fri, 31 Mar 2023 13:30:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so24637135pjz.1;
        Fri, 31 Mar 2023 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294605; x=1682886605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VszdLpAL7WqW9IxkGHXAfoIlaDcuh12lplT2Sv91rgM=;
        b=fJTPcqNjyxIKGGtqdvBiSEHrCMcmx8ZiItq9Z5trLCfiBkGu9Wm1Hbc18e7T+EJeiw
         LTe15kEhlp9pxxdNNl61QBW2DMakNHw307l9JIOqBuw9kje28RcSQ4i8qmiBF44zwioW
         OFRjZVuPkMuJBCPXgL1F2mT81a/nPDVnrfrCVPkfkOgyos8IaiBW4w4n3bU6R2WXkxgk
         0dQFIDMek5uVuVONmkqeYpuSR3zGi7ziZngQOqB8p22myN0BgFQiekaWATJTKLHy+pqI
         1s749Dlp50qjsCs0tVQJag9LNlhmeseuQd05FbxiIEvGMhoQMZ/+AeII2mGe2d3GS4GK
         4d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294605; x=1682886605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VszdLpAL7WqW9IxkGHXAfoIlaDcuh12lplT2Sv91rgM=;
        b=aeN0HurK0b5OuiMiBJx7jptIpamnla58kYU6IVuWmhzgWyWD2/qEHKaJhQ8a/oHBo7
         SGIwW+B/7KbghJbTpR2JIvHdL6rp07OqR4o9i88V0xKcP9VH0FZifo8I2S4hDm7QOWoM
         An9qjZg6zmJrw3N0SiMririv8Ju6XciLo4rLiQNAtdljXFdWI1ouri9uYF01gwKdwGnj
         PNUz6/eB7Q1uqAKS7q5Q+AOba9/9/dY9/Sh+jo7TjgHtCpG1iCqs6PsGZdmwJD5LHrLv
         MeLlkslFDGMF5DmQmpxe5IwIx0qBHmEs4SAAUXGt8Q518R5m6CG7Dub0GS1sKIM9o9Fm
         TSPQ==
X-Gm-Message-State: AAQBX9fEAdRRlv+lxyk/0oNnkVWvsiwzuZ0/pNs/fPCceO02NAPhRW1v
        YAWfWCODRev0v/rmVmEyEE8=
X-Google-Smtp-Source: AKy350arHlvmF6DIyZbkP9LcdFyyG3+qB4Th0ZjhnVAbe1BAKpnzxP1XVTMU1ToXoBk6tFW6Q5/Oxg==
X-Received: by 2002:a17:903:32d0:b0:19c:dbce:dce8 with SMTP id i16-20020a17090332d000b0019cdbcedce8mr31103443plr.15.1680294605042;
        Fri, 31 Mar 2023 13:30:05 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:5cfb:ad2c:e6f5:d42f])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a1dc2be791sm1916803plo.259.2023.03.31.13.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:30:04 -0700 (PDT)
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
Subject: [PATCH 9/9] perf intel-pt: Use perf_pmu__scan_file_at() if possible
Date:   Fri, 31 Mar 2023 13:29:49 -0700
Message-Id: <20230331202949.810326-10-namhyung@kernel.org>
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

Intel-PT calls perf_pmu__scan_file() a lot, let's use relative address
when it accesses multiple files at one place.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/util/intel-pt.c | 52 ++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 1e39a034cee9..2cff11de9d8a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -194,16 +194,19 @@ static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
 	int pos = 0;
 	u64 config;
 	char c;
+	int dirfd;
+
+	dirfd = perf_pmu__event_source_devices_fd();
 
 	pos += scnprintf(buf + pos, sizeof(buf) - pos, "tsc");
 
-	if (perf_pmu__scan_file(intel_pt_pmu, "caps/mtc", "%d",
-				&mtc) != 1)
+	if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "caps/mtc", "%d",
+				   &mtc) != 1)
 		mtc = 1;
 
 	if (mtc) {
-		if (perf_pmu__scan_file(intel_pt_pmu, "caps/mtc_periods", "%x",
-					&mtc_periods) != 1)
+		if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "caps/mtc_periods", "%x",
+					   &mtc_periods) != 1)
 			mtc_periods = 0;
 		if (mtc_periods) {
 			mtc_period = intel_pt_pick_bit(mtc_periods, 3);
@@ -212,13 +215,13 @@ static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
 		}
 	}
 
-	if (perf_pmu__scan_file(intel_pt_pmu, "caps/psb_cyc", "%d",
-				&psb_cyc) != 1)
+	if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "caps/psb_cyc", "%d",
+				   &psb_cyc) != 1)
 		psb_cyc = 1;
 
 	if (psb_cyc && mtc_periods) {
-		if (perf_pmu__scan_file(intel_pt_pmu, "caps/psb_periods", "%x",
-					&psb_periods) != 1)
+		if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "caps/psb_periods", "%x",
+					   &psb_periods) != 1)
 			psb_periods = 0;
 		if (psb_periods) {
 			psb_period = intel_pt_pick_bit(psb_periods, 3);
@@ -227,8 +230,8 @@ static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
 		}
 	}
 
-	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1 &&
-	    perf_pmu__scan_file(intel_pt_pmu, "format/branch", "%c", &c) == 1)
+	if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "format/pt", "%c", &c) == 1 &&
+	    perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "format/branch", "%c", &c) == 1)
 		pos += scnprintf(buf + pos, sizeof(buf) - pos, ",pt,branch");
 
 	pr_debug2("%s default config: %s\n", intel_pt_pmu->name, buf);
@@ -236,6 +239,7 @@ static u64 intel_pt_default_config(struct perf_pmu *intel_pt_pmu)
 	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format, buf,
 			     &config);
 
+	close(dirfd);
 	return config;
 }
 
@@ -488,7 +492,7 @@ static void intel_pt_valid_str(char *str, size_t len, u64 valid)
 	}
 }
 
-static int intel_pt_val_config_term(struct perf_pmu *intel_pt_pmu,
+static int intel_pt_val_config_term(struct perf_pmu *intel_pt_pmu, int dirfd,
 				    const char *caps, const char *name,
 				    const char *supported, u64 config)
 {
@@ -498,11 +502,11 @@ static int intel_pt_val_config_term(struct perf_pmu *intel_pt_pmu,
 	u64 bits;
 	int ok;
 
-	if (perf_pmu__scan_file(intel_pt_pmu, caps, "%llx", &valid) != 1)
+	if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, caps, "%llx", &valid) != 1)
 		valid = 0;
 
 	if (supported &&
-	    perf_pmu__scan_file(intel_pt_pmu, supported, "%d", &ok) == 1 && !ok)
+	    perf_pmu__scan_file_at(intel_pt_pmu, dirfd, supported, "%d", &ok) == 1 && !ok)
 		valid = 0;
 
 	valid |= 1;
@@ -531,37 +535,45 @@ static int intel_pt_val_config_term(struct perf_pmu *intel_pt_pmu,
 static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
 				    struct evsel *evsel)
 {
-	int err;
+	int err, dirfd;
 	char c;
 
 	if (!evsel)
 		return 0;
 
+	dirfd = perf_pmu__event_source_devices_fd();
+	if (dirfd < 0)
+		return dirfd;
+
 	/*
 	 * If supported, force pass-through config term (pt=1) even if user
 	 * sets pt=0, which avoids senseless kernel errors.
 	 */
-	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1 &&
+	if (perf_pmu__scan_file_at(intel_pt_pmu, dirfd, "format/pt", "%c", &c) == 1 &&
 	    !(evsel->core.attr.config & 1)) {
 		pr_warning("pt=0 doesn't make sense, forcing pt=1\n");
 		evsel->core.attr.config |= 1;
 	}
 
-	err = intel_pt_val_config_term(intel_pt_pmu, "caps/cycle_thresholds",
+	err = intel_pt_val_config_term(intel_pt_pmu, dirfd, "caps/cycle_thresholds",
 				       "cyc_thresh", "caps/psb_cyc",
 				       evsel->core.attr.config);
 	if (err)
-		return err;
+		goto out;
 
-	err = intel_pt_val_config_term(intel_pt_pmu, "caps/mtc_periods",
+	err = intel_pt_val_config_term(intel_pt_pmu, dirfd, "caps/mtc_periods",
 				       "mtc_period", "caps/mtc",
 				       evsel->core.attr.config);
 	if (err)
-		return err;
+		goto out;
 
-	return intel_pt_val_config_term(intel_pt_pmu, "caps/psb_periods",
+	err = intel_pt_val_config_term(intel_pt_pmu, dirfd, "caps/psb_periods",
 					"psb_period", "caps/psb_cyc",
 					evsel->core.attr.config);
+
+out:
+	close(dirfd);
+	return err;
 }
 
 static void intel_pt_config_sample_mode(struct perf_pmu *intel_pt_pmu,
-- 
2.40.0.348.gf938b09366-goog

