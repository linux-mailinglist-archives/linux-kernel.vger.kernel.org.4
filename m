Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89E05F534E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJEL0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJEL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:26:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22D45B7AE;
        Wed,  5 Oct 2022 04:26:44 -0700 (PDT)
Date:   Wed, 05 Oct 2022 11:26:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664969202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ej3UBlGQFDLBvEmuT13sjKtZ9lSjk7GO7M5troNJt9Y=;
        b=Nrnva0LfxW8uydoUizRaTU0/JjDe0c6gFBuybTbFjtWqIqujAhoTQdlA8Llp+SG62dJhNt
        jSNcENz+ty5NFbrn3R1t1hrCn89slkauiFmY4GmNszw55DKHy59/BG9EpRMhrKRQpL3jHF
        7fUGJLgxoXF49EZ+/OpKKItvF1cUVErpMfK1DGR291Tm0kT0XjD/0nYO5v4h0FIBgXQ9e3
        UVxcF7rre95Sg/hpSVTBv8Eo9GiUl0WOtidUp6EhSVlLFSzeuWzlN53KIU22hLrXB+c3nN
        k9M+e1tZx8NINCbcKGxDykL83w3P6c22PIhSSm8mcCVq8VCTOW3a/pT62dSNFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664969202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ej3UBlGQFDLBvEmuT13sjKtZ9lSjk7GO7M5troNJt9Y=;
        b=FEPe00S5sbTR+qoKwrMJ0UC2uO3CnQM9XxYv3KSwPrGv05XHWnQ/00ESzc4HIBa+KiCta4
        rpjyHkaEeKfdRDDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/hw_breakpoint: Annotate tsk->perf_event_mutex
 vs ctx->mutex
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166496920036.401.9244922544094908473.tip-bot2@tip-bot2>
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

Commit-ID:     82aad7ff7ac25c8cf09d491ae23b9823f1901486
Gitweb:        https://git.kernel.org/tip/82aad7ff7ac25c8cf09d491ae23b9823f1901486
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 04 Oct 2022 12:20:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 04 Oct 2022 13:32:09 +02:00

perf/hw_breakpoint: Annotate tsk->perf_event_mutex vs ctx->mutex

Perf fuzzer gifted a lockdep splat:

  perf_event_init_context()
    mutex_lock(parent_ctx->mutex);			(B)
    inherit_task_group()
      inherit_group()
        inherit_event()
          perf_event_alloc()
            perf_try_init_event() := hw_breakpoint_event_init()
              register_perf_hw_breakpoint()
                mutex_lock(child->perf_event_mutex);	(A)

Which is against the normal (documented) order. Now, this is a false
positive in that child is not published yet, but also inherited events
never end up on ->perf_event_list.

Annotate this one away.

Fixes: 0912037fec11 ("perf/hw_breakpoint: Reduce contention with large number of tasks")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/hw_breakpoint.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 7ef0e98..c379770 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -117,7 +117,17 @@ static struct mutex *bp_constraints_lock(struct perf_event *bp)
 	struct mutex *tsk_mtx = get_task_bps_mutex(bp);
 
 	if (tsk_mtx) {
-		mutex_lock(tsk_mtx);
+		/*
+		 * Fully analogous to the perf_try_init_event() nesting
+		 * argument in the comment near perf_event_ctx_lock_nested();
+		 * this child->perf_event_mutex cannot ever deadlock against
+		 * the parent->perf_event_mutex usage from
+		 * perf_event_task_{en,dis}able().
+		 *
+		 * Specifically, inherited events will never occur on
+		 * ->perf_event_list.
+		 */
+		mutex_lock_nested(tsk_mtx, SINGLE_DEPTH_NESTING);
 		percpu_down_read(&bp_cpuinfo_sem);
 	} else {
 		percpu_down_write(&bp_cpuinfo_sem);
