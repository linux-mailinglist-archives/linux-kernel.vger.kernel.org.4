Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C8B662C07
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAIRCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbjAIRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:02:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AE03FA1B;
        Mon,  9 Jan 2023 09:02:08 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:02:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673283727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RqvY0nZ53Ev1fKsm+wsJ7IJW7g25Ot+ctkp/1+36tBM=;
        b=EONpgTzu9S99sbZRju1yTx1vICWR+qyAhxaax4MY2rQsIOfhB7np40EotBTCU5PN85PsFw
        apiwl47rZnYf1+RccyugsEAxgO+n6vqI9ynmeizG6LS6H4lyQFPU64rn81sLWsgk4p6lmH
        UJ3PtP4/miZ64lTzoZ7Zhl8+l+B/ET/DaKqBSLdanCYQziXAFBQhMCtYq1FMjgBZExAoKN
        TYRomFdHeZ1xUGnqqeYgsguihLAEHV94mnDVM684Y0tLbQC+rgCtNP5XnYANprPjGSj3dX
        FFrUareax1wYf1DP588eZzFQZo/msq3BSpk4UkLxRSmxNEWMz1fy2R7gXLO90w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673283727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RqvY0nZ53Ev1fKsm+wsJ7IJW7g25Ot+ctkp/1+36tBM=;
        b=m8c9nyuP/Cg6jpykiSsANOV+jjVIxn5/5L8E4i6ztz7TBHJNkddJugu3Qct9ThofZHMiRy
        z97tc5gHan0k6gBA==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Save calculated sample data size
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221229204101.1099430-3-namhyung@kernel.org>
References: <20221229204101.1099430-3-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <167328372716.4906.7029023036298572576.tip-bot2@tip-bot2>
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

Commit-ID:     0ecc518e5c1a83fbfc6262d20d0df289eafc2207
Gitweb:        https://git.kernel.org/tip/0ecc518e5c1a83fbfc6262d20d0df289eafc2207
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 29 Dec 2022 12:41:01 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 12:22:09 +01:00

perf/core: Save calculated sample data size

To avoid duplicate work in perf_prepare_sample(), save the final header
size in data->saved_size.  It's initialized to 0 and set to an actual
value at the end of perf_prepare_sample().

If it sees a non-zero value that means it's the second time of the call
and it knows the sample data is populated already.  So update the header
size with the data->saved_size and bail out.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20221229204101.1099430-3-namhyung@kernel.org
---
 include/linux/perf_event.h |  2 ++
 kernel/events/core.c       | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 03949d0..656b6ea 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1103,6 +1103,7 @@ struct perf_sample_data {
 	 */
 	u64				sample_flags;
 	u64				period;
+	u64				saved_size;
 
 	/*
 	 * Fields commonly set by __perf_event_header__init_id(),
@@ -1158,6 +1159,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	/* remaining struct members initialized in perf_prepare_sample() */
 	data->sample_flags = PERF_SAMPLE_PERIOD;
 	data->period = period;
+	data->saved_size = 0;
 
 	if (addr) {
 		data->addr = addr;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 70bff8a..dac4d76 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7576,6 +7576,15 @@ void perf_prepare_sample(struct perf_event_header *header,
 	header->misc |= perf_misc_flags(regs);
 
 	/*
+	 * If it called perf_prepare_sample() already, it set the all data fields
+	 * and recorded the final size to data->saved_size.
+	 */
+	if (data->saved_size) {
+		header->size = data->saved_size;
+		return;
+	}
+
+	/*
 	 * Clear the sample flags that have already been done by the
 	 * PMU driver.
 	 */
@@ -7796,6 +7805,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 	 * do here next.
 	 */
 	WARN_ON_ONCE(header->size & 7);
+
+	data->saved_size = header->size;
 }
 
 static __always_inline int
