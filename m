Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42A65ED588
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiI1G6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiI1G53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:57:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF8861DA;
        Tue, 27 Sep 2022 23:57:24 -0700 (PDT)
Date:   Wed, 28 Sep 2022 06:57:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664348242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFu7nnk8kMBWwPl8IqyP7zFs+hVguPmywV5EeUtNqpw=;
        b=4K2MfT1u5yqhpnlmZGdVIKOfHvpX0dVlS5F56tzzK4sOjgLqV8WZ8nXRUUbMLc9H5Sarv2
        0CgMtD6SJJ9/EV8J8GpNto7MCE3QuPiIylp7vCXTcSOIPuugsEEsK+9FPuct40kBHcCqai
        ESItFhhd5KmmzIPhTxSE3/p6WlxR6w0GryG+uc4O3SsTtgUvox2SfalxNMT/dl83PW5HOo
        3EPfcpmSlhBt2hlwxKrVhj0Og31wF2UoxtgN5iJQyYR3Ygyhl9ylN7ln07BP4G3HQBhA63
        i/dONP5USHwZ7qWoSlUiOKpSjlqq1lDzTWXkTsvHIOgoOWnvnAeyLe6rmdraWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664348242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFu7nnk8kMBWwPl8IqyP7zFs+hVguPmywV5EeUtNqpw=;
        b=/f6kngUCsOvIdxGMSVM//dmP1l1Dfc+L6jRu4mBGIHb9IM5gvv3Mkz/svwhFtoCchv3LTs
        xmkwruj7Br2XrvAQ==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Use sample_flags for raw_data
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220921220032.2858517-2-namhyung@kernel.org>
References: <20220921220032.2858517-2-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <166434824149.401.4361243714612738808.tip-bot2@tip-bot2>
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

Commit-ID:     838d9bb62d132ec3baf1b5aba2e95ef9a7a9a3cd
Gitweb:        https://git.kernel.org/tip/838d9bb62d132ec3baf1b5aba2e95ef9a7a9a3cd
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 21 Sep 2022 15:00:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Sep 2022 22:50:24 +02:00

perf: Use sample_flags for raw_data

Use the new sample_flags to indicate whether the raw data field is
filled by the PMU driver.  Although it could check with the NULL,
follow the same rule with other fields.

Remove the raw field from the perf_sample_data_init() to minimize
the number of cache lines touched.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220921220032.2858517-2-namhyung@kernel.org
---
 arch/s390/kernel/perf_cpum_cf.c    | 1 +
 arch/s390/kernel/perf_pai_crypto.c | 1 +
 arch/x86/events/amd/ibs.c          | 1 +
 include/linux/perf_event.h         | 5 ++---
 kernel/events/core.c               | 3 ++-
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index f7dd3c8..f043a7f 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -664,6 +664,7 @@ static int cfdiag_push_sample(struct perf_event *event,
 		raw.frag.data = cpuhw->stop;
 		raw.size = raw.frag.size;
 		data.raw = &raw;
+		data.sample_flags |= PERF_SAMPLE_RAW;
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index b38b4ae..6826e2a 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -366,6 +366,7 @@ static int paicrypt_push_sample(void)
 		raw.frag.data = cpump->save;
 		raw.size = raw.frag.size;
 		data.raw = &raw;
+		data.sample_flags |= PERF_SAMPLE_RAW;
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index ce5720b..c29a006 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -781,6 +781,7 @@ fail:
 			},
 		};
 		data.raw = &raw;
+		data.sample_flags |= PERF_SAMPLE_RAW;
 	}
 
 	/*
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f4a1357..e9b151c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1028,7 +1028,6 @@ struct perf_sample_data {
 	 * minimize the cachelines touched.
 	 */
 	u64				sample_flags;
-	struct perf_raw_record		*raw;
 	u64				period;
 
 	/*
@@ -1040,6 +1039,7 @@ struct perf_sample_data {
 	union  perf_mem_data_src	data_src;
 	u64				txn;
 	u64				addr;
+	struct perf_raw_record		*raw;
 
 	u64				type;
 	u64				ip;
@@ -1078,8 +1078,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 					 u64 addr, u64 period)
 {
 	/* remaining struct members initialized in perf_prepare_sample() */
-	data->sample_flags = 0;
-	data->raw  = NULL;
+	data->sample_flags = PERF_SAMPLE_PERIOD;
 	data->period = period;
 
 	if (addr) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a91f74d..04e19a8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7332,7 +7332,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 		struct perf_raw_record *raw = data->raw;
 		int size;
 
-		if (raw) {
+		if (raw && (data->sample_flags & PERF_SAMPLE_RAW)) {
 			struct perf_raw_frag *frag = &raw->frag;
 			u32 sum = 0;
 
@@ -7348,6 +7348,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			frag->pad = raw->size - sum;
 		} else {
 			size = sizeof(u64);
+			data->raw = NULL;
 		}
 
 		header->size += size;
