Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7375E5603
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiIUWAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiIUWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:00:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7069F192
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:00:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p18so6990208plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=j0va7krgV7/g9Lii87TKXRgUicSqhC8GOveBHYxKC54=;
        b=XIrEA0dqHYAK/YBt+pXZsLKe78TVhB4zzNf8pgGjvLX1vSHzoOhusBebnVeQVYHYDc
         7ddtgS90x0iKEW4p4oMGkbYBApQdx5buv4sEDs+Y+174s9bPeUaSqryOXRg5atf95qL7
         2zhw+q/dQAQNllGB58A5KDHsIcVI8hhv4kJ2bJaHlW1BWJEmKzS+WItmFqFJHvVQgiHQ
         DtOfzFojyAg2q4MAhrHamJK7nRXL2j1xVoJMkDCYrq/YAt4A2xT7w63hMU6n8ZCFWvPn
         wdhwqYH2XvYS1Ysc2aLYP+ju08/6X8hkdi0xcTEtbOwI2x4E8iLu78O5me+60hNoKoll
         nfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=j0va7krgV7/g9Lii87TKXRgUicSqhC8GOveBHYxKC54=;
        b=XHL6dkM6x0k5i9v168Jn4G06g4Bvkz9ShrYYMLQTI+xbveSmy8alTfur8GvZBap8Ua
         cVvA0q3Vm2dD0n7k/VEawRyDHEt81GlWS59i/Idr5lzsIDOi9QoiiMNbtohnCTj1P+7P
         v+8RH/ZCwRSXLrAtX4azTlWIgIfJd1xmUWx7BGzn4hgVfrUyHVdxFL2NQqGpQhsOYrpJ
         +ZBtLSN+kafHVUAdRuHqo+EXTEvWtfwewktAJImlUPk9sMGdf0kENZJxsjb0wtrxUw0H
         2BbhiaCpPP7rZ8ndiepcqkW9GiwAl3PQNDGUUCik52EWGoLkQntU3kskRUvZxdV2tBVn
         7+pg==
X-Gm-Message-State: ACrzQf2dvfy+LQHsBYPgrbr4mBA3OINmpwKzCe1EEsqLaHMIzcn2yy/H
        RsbAJPlzWgN/Bq446SGEbhA=
X-Google-Smtp-Source: AMsMyM73/BjHh/3YiSZq1C0uvR8cQE/48I9SZYJxwZ1bCzBeScU2k2E8mZ6C6b2y9pf6h7y/PGDiyg==
X-Received: by 2002:a17:902:e74f:b0:176:e68f:f902 with SMTP id p15-20020a170902e74f00b00176e68ff902mr285653plf.41.1663797640976;
        Wed, 21 Sep 2022 15:00:40 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:8bcd:ba5c:3c6b:4140])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090300d400b0017693722e7dsm2520554plc.6.2022.09.21.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:00:40 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/2] perf: Use sample_flags for addr
Date:   Wed, 21 Sep 2022 15:00:31 -0700
Message-Id: <20220921220032.2858517-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new sample_flags to indicate whether the addr field is filled by
the PMU driver.  As most PMU drivers pass 0, it can set the flag only if
it has a non-zero value.  And use 0 in perf_sample_output() if it's not
filled already.

Cc: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/intel/ds.c | 8 ++++++--
 include/linux/perf_event.h | 8 ++++++--
 kernel/events/core.c       | 5 +++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4ba6ab6d0d92..d2e9ff16f6ed 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1621,8 +1621,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 
 
 	if ((sample_type & PERF_SAMPLE_ADDR_TYPE) &&
-	    x86_pmu.intel_cap.pebs_format >= 1)
+	    x86_pmu.intel_cap.pebs_format >= 1) {
 		data->addr = pebs->dla;
+		data->sample_flags |= PERF_SAMPLE_ADDR;
+	}
 
 	if (x86_pmu.intel_cap.pebs_format >= 2) {
 		/* Only set the TSX weight when no memory weight. */
@@ -1783,8 +1785,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			data->sample_flags |= PERF_SAMPLE_DATA_SRC;
 		}
 
-		if (sample_type & PERF_SAMPLE_ADDR_TYPE)
+		if (sample_type & PERF_SAMPLE_ADDR_TYPE) {
 			data->addr = meminfo->address;
+			data->sample_flags |= PERF_SAMPLE_ADDR;
+		}
 
 		if (sample_type & PERF_SAMPLE_TRANSACTION) {
 			data->txn = intel_get_tsx_transaction(meminfo->tsx_tuning,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 368bdc4f563f..f4a13579b0e8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1028,7 +1028,6 @@ struct perf_sample_data {
 	 * minimize the cachelines touched.
 	 */
 	u64				sample_flags;
-	u64				addr;
 	struct perf_raw_record		*raw;
 	u64				period;
 
@@ -1040,6 +1039,7 @@ struct perf_sample_data {
 	union perf_sample_weight	weight;
 	union  perf_mem_data_src	data_src;
 	u64				txn;
+	u64				addr;
 
 	u64				type;
 	u64				ip;
@@ -1079,9 +1079,13 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 {
 	/* remaining struct members initialized in perf_prepare_sample() */
 	data->sample_flags = 0;
-	data->addr = addr;
 	data->raw  = NULL;
 	data->period = period;
+
+	if (addr) {
+		data->addr = addr;
+		data->sample_flags |= PERF_SAMPLE_ADDR;
+	}
 }
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c07e9a3ea94c..a91f74db9fe9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7414,6 +7414,11 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (filtered_sample_type & PERF_SAMPLE_TRANSACTION)
 		data->txn = 0;
 
+	if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_DATA_PAGE_SIZE)) {
+		if (filtered_sample_type & PERF_SAMPLE_ADDR)
+			data->addr = 0;
+	}
+
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		/* regs dump ABI info */
 		int size = sizeof(u64);
-- 
2.37.3.968.ga6b4b080e4-goog

