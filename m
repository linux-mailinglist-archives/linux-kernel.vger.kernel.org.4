Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBCE662C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjAIRCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbjAIRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:02:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE913FA1C;
        Mon,  9 Jan 2023 09:02:09 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:02:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673283728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ggc5s/AUOJb6WBoojUyLj8xOxWF8GBO4FCRQAIYsA54=;
        b=jf1HuaJfcMoeEQ0UywwE2ZUtRfOm1y2ODC8hUkhUDLcmBn/iVmlaFHhA+zxftYFOKN3Fgy
        LzhNLoGQw7tW68oCHajUbUQ+Zg2xz5a3E869Fp4qXfvtLvhu7nHyLrU6JkvhdCwvnyaX//
        go4pyMxJZT343uJ68hbfuK5kot8Do/aq3QG/nZeW2QrTB5Nv2gNYGzJFZnY5/WR2yQcpev
        s6N9IiaFVTtXLjr3x2ruHgPxbjmHjqPjxXSSeUGNo+zJMZB9ZGQ6BsPZtbx6uSP0K3us/B
        HohHjieOuxd9S5rMM+jM/8uORMMF0YLv2UUJWyCmYsxptGhiktGdfDkEl3VBWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673283728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ggc5s/AUOJb6WBoojUyLj8xOxWF8GBO4FCRQAIYsA54=;
        b=2fWGnmnYSuK5njW1UJCfbNoGbtVFPc9uvEe4YVtZGRgvacB93J9uhScF0INZxUqfyZ54L2
        bf4M3XvQrHghS+AA==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Change the layout of perf_sample_data
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221229204101.1099430-1-namhyung@kernel.org>
References: <20221229204101.1099430-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167328372777.4906.7014321017745723533.tip-bot2@tip-bot2>
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

Commit-ID:     7bdb1767bf011c7f6065ac483ad2f00e434c3979
Gitweb:        https://git.kernel.org/tip/7bdb1767bf011c7f6065ac483ad2f00e434c3979
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 29 Dec 2022 12:40:59 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:22:09 +01:00

perf/core: Change the layout of perf_sample_data

The layout of perf_sample_data is designed to minimize cache-line
access.  The perf_sample_data_init() used to initialize a couple of
fields unconditionally so they were placed together at the head.

But it's changed now to set the fields according to the actual
sample_type flags.  The main user (the perf tools) sets the IP, TID,
TIME, PERIOD always.  Also group relevant fields like addr, phys_addr
and data_page_size.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20221229204101.1099430-1-namhyung@kernel.org
---
 include/linux/perf_event.h | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ad92ad3..03949d0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1098,47 +1098,51 @@ extern u64 perf_event_read_value(struct perf_event *event,
 
 struct perf_sample_data {
 	/*
-	 * Fields set by perf_sample_data_init(), group so as to
-	 * minimize the cachelines touched.
+	 * Fields set by perf_sample_data_init() unconditionally,
+	 * group so as to minimize the cachelines touched.
 	 */
 	u64				sample_flags;
 	u64				period;
 
 	/*
-	 * The other fields, optionally {set,used} by
-	 * perf_{prepare,output}_sample().
+	 * Fields commonly set by __perf_event_header__init_id(),
+	 * group so as to minimize the cachelines touched.
 	 */
-	struct perf_branch_stack	*br_stack;
-	union perf_sample_weight	weight;
-	union  perf_mem_data_src	data_src;
-	u64				txn;
-	u64				addr;
-	struct perf_raw_record		*raw;
-
 	u64				type;
-	u64				ip;
 	struct {
 		u32	pid;
 		u32	tid;
 	}				tid_entry;
 	u64				time;
 	u64				id;
-	u64				stream_id;
 	struct {
 		u32	cpu;
 		u32	reserved;
 	}				cpu_entry;
+
+	/*
+	 * The other fields, optionally {set,used} by
+	 * perf_{prepare,output}_sample().
+	 */
+	u64				ip;
 	struct perf_callchain_entry	*callchain;
-	u64				aux_size;
+	struct perf_raw_record		*raw;
+	struct perf_branch_stack	*br_stack;
+	union perf_sample_weight	weight;
+	union  perf_mem_data_src	data_src;
+	u64				txn;
 
 	struct perf_regs		regs_user;
 	struct perf_regs		regs_intr;
 	u64				stack_user_size;
 
-	u64				phys_addr;
+	u64				stream_id;
 	u64				cgroup;
+	u64				addr;
+	u64				phys_addr;
 	u64				data_page_size;
 	u64				code_page_size;
+	u64				aux_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
