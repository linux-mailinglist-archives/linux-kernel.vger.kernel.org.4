Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9A5B3269
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiIIIxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiIIIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC2642E9;
        Fri,  9 Sep 2022 01:52:45 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8gXRgbP3W4liUT+JmVQ6Zc7HdIptENQvpioZS0wZpsM=;
        b=SFN2KFK93ASQUyBGYjB1OErWyhh/lIGEg25YbrI3Ai6vPAu06saG1HgnXn3esSixHbof+I
        plBf7BbQuTNNRzfqogbbOrkp5fBcZOa/Q/zC2CEO6pcCXLrjQj11dN2egPRXsIetvilZMB
        YQ+MxCQlgp++mcrbF9DhJ5pIdlTfi+4mJZ0tInYWCk5E/ehSRvwyq4sOO6gdUTv0QI5qvN
        LPL0XoNT3++prJHbfzh0uiff05O/H6RYl3NmGYEfgEvpQzyHhPl4UpsIhlgCdmAeof6ay0
        Q/ZcuMwsp8ZJbR3hL11fKGaQtBEL35AMg8NAgJk56013mM3J5Ncbp3+zt4Vv2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713564;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8gXRgbP3W4liUT+JmVQ6Zc7HdIptENQvpioZS0wZpsM=;
        b=N5/F+rlNYC5Glj3SghUAp8lUl/BobRI4NmFCR3maLVKfrvpi0o1U94v7NB497G9jVnkrqo
        6G4bzRk5lIPVvyDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add a few assertions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166271356280.401.12499695044219675825.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f3c0eba287049237b23d1300376768293eb89e69
Gitweb:        https://git.kernel.org/tip/f3c0eba287049237b23d1300376768293eb89e69
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 02 Sep 2022 18:48:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:01 +02:00

perf: Add a few assertions

While auditing 6b959ba22d34 ("perf/core: Fix reentry problem in
perf_output_read_group()") a few spots were found that wanted
assertions.

Notable for_each_sibling_event() relies on exclusion from
modification. This would normally be holding either ctx->lock or
ctx->mutex, however due to how things are constructed disabling IRQs
is a valid and sufficient substitute for ctx->lock.

Another possible site to add assertions would be the various
pmu::{add,del,read,..}() methods, but that's not trivially expressable
in C -- the best option is wrappers, but those are easy enough to
forget.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/perf_event.h | 17 +++++++++++++++++
 kernel/events/core.c       |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f88cb31..368bdc4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -61,6 +61,7 @@ struct perf_guest_info_callbacks {
 #include <linux/refcount.h>
 #include <linux/security.h>
 #include <linux/static_call.h>
+#include <linux/lockdep.h>
 #include <asm/local.h>
 
 struct perf_callchain_entry {
@@ -634,7 +635,23 @@ struct pmu_event_list {
 	struct list_head	list;
 };
 
+/*
+ * event->sibling_list is modified whole holding both ctx->lock and ctx->mutex
+ * as such iteration must hold either lock. However, since ctx->lock is an IRQ
+ * safe lock, and is only held by the CPU doing the modification, having IRQs
+ * disabled is sufficient since it will hold-off the IPIs.
+ */
+#ifdef CONFIG_PROVE_LOCKING
+#define lockdep_assert_event_ctx(event)				\
+	WARN_ON_ONCE(__lockdep_enabled &&			\
+		     (this_cpu_read(hardirqs_enabled) ||	\
+		      lockdep_is_held(&(event)->ctx->mutex) != LOCK_STATE_HELD))
+#else
+#define lockdep_assert_event_ctx(event)
+#endif
+
 #define for_each_sibling_event(sibling, event)			\
+	lockdep_assert_event_ctx(event);			\
 	if ((event)->group_leader == (event))			\
 		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 00389d5..3e90e45 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1468,6 +1468,8 @@ static void __update_context_time(struct perf_event_context *ctx, bool adv)
 {
 	u64 now = perf_clock();
 
+	lockdep_assert_held(&ctx->lock);
+
 	if (adv)
 		ctx->time += now - ctx->timestamp;
 	ctx->timestamp = now;
