Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5CA6278C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbiKNJK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiKNJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:10:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7BACEA;
        Mon, 14 Nov 2022 01:10:18 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:10:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668417016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flibQ14geqBtHOZ1ZdsLp9+eqkvU+IBQCYejrpRxmlM=;
        b=Fu+1KDPBwhpGK4tizlig/AS7Wz+jSvcjnMilQaXRuO9iR/QfWYnLKMqVlTuBwL5WneQfn7
        P47j0H3kZAXNBJyx69qzQBR34IbvfE1F4Zg3ophy1wjYJTnGfpGcV1E6q2GP8ZhdgiW0NE
        dKMxG99dDoeM2spqVhajubawLMQJHkO8qdYOFZetZZgvZ75Eu9HLrnqB7VV8+J01SdDVVU
        MU9/eB0G+kdZDwBU3jN2HLzKrBkVDXI4iLMFVvEDY+qzxbymW0X0nf6kgBnZU7cgXxu2hP
        088njtygSn9D+hoXsMuDhZFg0OrnRU9iPYs/CeOjfJLLEQPZn2yejWU1KpnPQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668417016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flibQ14geqBtHOZ1ZdsLp9+eqkvU+IBQCYejrpRxmlM=;
        b=WCbXEb6IhTvLN7iLukqTlSpjzhTB6BIxIW9yy4uY77MgUwd2wPzhgnG8AsmT0sKxcG1fbF
        p3ZNB95x7oKw0WCQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] rseq: Use pr_warn_once() when deprecated/unknown
 ABI flags are encountered
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221102130635.7379-1-mathieu.desnoyers@efficios.com>
References: <20221102130635.7379-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <166841701553.4906.1749822907973997217.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     448dca8c88755b768552e19bd1618be34ef6d1ff
Gitweb:        https://git.kernel.org/tip/448dca8c88755b768552e19bd1618be34ef6d1ff
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Wed, 02 Nov 2022 09:06:35 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Nov 2022 09:58:32 +01:00

rseq: Use pr_warn_once() when deprecated/unknown ABI flags are encountered

These commits use WARN_ON_ONCE() and kill the offending processes when
deprecated and unknown flags are encountered:

commit c17a6ff93213 ("rseq: Kill process when unknown flags are encountered in ABI structures")
commit 0190e4198e47 ("rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_* flags")

The WARN_ON_ONCE() triggered by userspace input prevents use of
Syzkaller to fuzz the rseq system call.

Replace this WARN_ON_ONCE() by pr_warn_once() messages which contain
actually useful information.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lkml.kernel.org/r/20221102130635.7379-1-mathieu.desnoyers@efficios.com
---
 kernel/rseq.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index bda8175..d38ab94 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -171,12 +171,27 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	return 0;
 }
 
+static bool rseq_warn_flags(const char *str, u32 flags)
+{
+	u32 test_flags;
+
+	if (!flags)
+		return false;
+	test_flags = flags & RSEQ_CS_NO_RESTART_FLAGS;
+	if (test_flags)
+		pr_warn_once("Deprecated flags (%u) in %s ABI structure", test_flags, str);
+	test_flags = flags & ~RSEQ_CS_NO_RESTART_FLAGS;
+	if (test_flags)
+		pr_warn_once("Unknown flags (%u) in %s ABI structure", test_flags, str);
+	return true;
+}
+
 static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 {
 	u32 flags, event_mask;
 	int ret;
 
-	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
+	if (rseq_warn_flags("rseq_cs", cs_flags))
 		return -EINVAL;
 
 	/* Get thread flags. */
@@ -184,7 +199,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	if (ret)
 		return ret;
 
-	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS) || flags)
+	if (rseq_warn_flags("rseq", flags))
 		return -EINVAL;
 
 	/*
