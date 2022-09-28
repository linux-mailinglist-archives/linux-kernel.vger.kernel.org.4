Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90115ED582
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiI1G6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiI1G53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:57:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF19E68C;
        Tue, 27 Sep 2022 23:57:25 -0700 (PDT)
Date:   Wed, 28 Sep 2022 06:57:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664348243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0Y1yQ9BhuRCSCMO1panr5YNLkexoW/peOxW4bcpB1A=;
        b=ggPvGTw7JX26D5si9ADHi1U0uV1V9m6hf2Kf0plmGLNZ1N8uJmbFgkQ1q8zhjcv9bdW9gO
        R3xXralDmrlSS2ShtMogRflcfg/m+c4SlnR/bRqv12DzCRMm1Yokjv615A9Hwdx+PXTXyd
        gj4rafmNa4XJZXcTVSJJVJy8qCFSh/9kDUYoyjzC3CnDkhsWHESPld8j0tYOVtRoAKuU26
        KarqpsKvY1BYUzW89fmQlnZ9unmQO8DaxxpGk0PHeawij1GCH0wkrojcQ16WP/ChdUySsb
        ErQsPWmzhOEoVJxsB2o4p3zyoQ4E6qa1VSScyJLdcg0tFhjvC69xdUa/mCORrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664348243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0Y1yQ9BhuRCSCMO1panr5YNLkexoW/peOxW4bcpB1A=;
        b=ZkfBD8mG/9AmPKnsUYwdpVbWN42hOEWgHguntZ3p9muGCZFAh0WvqPATq4VD8tINceiRV6
        KLMimonlbLhnwPDQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Use sample_flags for addr
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220921220032.2858517-1-namhyung@kernel.org>
References: <20220921220032.2858517-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <166434824254.401.581163246945360838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7b084630153152239d84990ac4540c2dd360186f
Gitweb:        https://git.kernel.org/tip/7b084630153152239d84990ac4540c2dd360186f
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 21 Sep 2022 15:00:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Sep 2022 22:50:24 +02:00

perf: Use sample_flags for addr

Use the new sample_flags to indicate whether the addr field is filled by
the PMU driver.  As most PMU drivers pass 0, it can set the flag only if
it has a non-zero value.  And use 0 in perf_sample_output() if it's not
filled already.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220921220032.2858517-1-namhyung@kernel.org
---
 arch/x86/events/intel/ds.c | 8 ++++++--
 include/linux/perf_event.h | 8 ++++++--
 kernel/events/core.c       | 5 +++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4ba6ab6..d2e9ff1 100644
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
index 368bdc4..f4a1357 100644
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
index c07e9a3..a91f74d 100644
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
