Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1FD722F93
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjFETRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjFETQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B2212D;
        Mon,  5 Jun 2023 12:16:21 -0700 (PDT)
Date:   Mon, 05 Jun 2023 19:16:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685992580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAjdy4YUOyODKcWZ3AOAw0qX0fpe0TW3Otvb753dxbo=;
        b=Rd6WF+8b0Cal7UibVB3V1K3ADiY/jADUDPXcQkNXDbxPAA0RY65YVTBH9PEikckdndj9c+
        mWeJV6axX7mSJIuTtIYdEpu1GovL+HzDUlpYtpN3Cik+g9FwqtyBQh9v/8AjbiH4KCm3sm
        e3b0LzsZvjMBSZRwWH2gechQRTVkTWLjqaD1McVpK2vKnoKpvwWLY+1mtYvN9CSP1L2Ni6
        LzxYpLAgjtKV5MmgCa0o5apZQJYu9toJEJD2AgiohVUmVMrcAlh1gyGhweZ14UoyeuCIr6
        VLdZuWKDzn8xBvQFr0NQQ35WjwmWYLTSA06FcPGlAoFBpDJTtQ1/5zidq+OJAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685992580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAjdy4YUOyODKcWZ3AOAw0qX0fpe0TW3Otvb753dxbo=;
        b=/zzdP4qQ0GUbENgfjsYZp5j/nMTZgqcrXzG2q1hykZYFIA5P+/STTMsYc/pBBlLRDw3OjI
        ujCz+QnxSgm1lDAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] time/sched_clock: Provide sched_clock_noinstr()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230519102715.302350330@infradead.org>
References: <20230519102715.302350330@infradead.org>
MIME-Version: 1.0
Message-ID: <168599257949.404.407131671587396524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5949a68c73444d89b171703b67ff04fc4d6059c1
Gitweb:        https://git.kernel.org/tip/5949a68c73444d89b171703b67ff04fc4d6059c1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 May 2023 12:21:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 21:11:04 +02:00

time/sched_clock: Provide sched_clock_noinstr()

With the intent to provide local_clock_noinstr(), a variant of
local_clock() that's safe to be called from noinstr code (with the
assumption that any such code will already be non-preemptible),
prepare for things by providing a noinstr sched_clock_noinstr() function.

Specifically, preempt_enable_*() calls out to schedule(), which upsets
noinstr validation efforts.

As such, pull out the preempt_{dis,en}able_notrace() requirements from
the sched_clock_read() implementations by explicitly providing it in
the sched_clock() function.

This further requires said sched_clock_read() functions to be noinstr
themselves, for ARCH_WANTS_NO_INSTR users. See the next few patches.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>  # Hyper-V
Link: https://lore.kernel.org/r/20230519102715.302350330@infradead.org
---
 kernel/time/sched_clock.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index e8f2fb0..68d6c11 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -64,7 +64,7 @@ static struct clock_data cd ____cacheline_aligned = {
 	.actual_read_sched_clock = jiffy_sched_clock_read,
 };
 
-static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
+static __always_inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 {
 	return (cyc * mult) >> shift;
 }
@@ -80,23 +80,33 @@ notrace int sched_clock_read_retry(unsigned int seq)
 	return raw_read_seqcount_latch_retry(&cd.seq, seq);
 }
 
-unsigned long long notrace sched_clock(void)
+unsigned long long noinstr sched_clock_noinstr(void)
 {
-	u64 cyc, res;
-	unsigned int seq;
 	struct clock_read_data *rd;
+	unsigned int seq;
+	u64 cyc, res;
 
 	do {
-		rd = sched_clock_read_begin(&seq);
+		seq = raw_read_seqcount_latch(&cd.seq);
+		rd = cd.read_data + (seq & 1);
 
 		cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
 		      rd->sched_clock_mask;
 		res = rd->epoch_ns + cyc_to_ns(cyc, rd->mult, rd->shift);
-	} while (sched_clock_read_retry(seq));
+	} while (raw_read_seqcount_latch_retry(&cd.seq, seq));
 
 	return res;
 }
 
+unsigned long long notrace sched_clock(void)
+{
+	unsigned long long ns;
+	preempt_disable_notrace();
+	ns = sched_clock_noinstr();
+	preempt_enable_notrace();
+	return ns;
+}
+
 /*
  * Updating the data required to read the clock.
  *
