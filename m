Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8FD610A84
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJ1GnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJ1GmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9815615A97C;
        Thu, 27 Oct 2022 23:42:12 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVGJkT4iKEULGX5K8Wk145BS8aZjYc/x4p+MSpuBY2E=;
        b=k4bPGUAdiWGbCjgvPGrSSVm7XQGETT9gUXBkmgLlvHWso94PEsLyZzAsDh2BiUtDe9CeG/
        njvVK+BMENjAKP+XB2luBkhpEJPw1OLB9vlEwgZiKOvaIBcMpy4RCdW9YR5FDvV3Ay35Fh
        YRTaG26gETjkyh55q2VaxwEWIBYeBHfISRcowwQWZNx6XqAeeg5+YE7TIvP10BNM7bv7t7
        TanOkWHgUJbVHnUc15/fxBAgBq5ogsZ9etnyZ6YXQiq6EsPp2lehuJHYyQ7aDZfpHOT4FW
        szwA3S356yhqwnSBHRvVu0xy3hRCAAt6pAKz+DrJRiuucM0E606t67ak29KYjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVGJkT4iKEULGX5K8Wk145BS8aZjYc/x4p+MSpuBY2E=;
        b=2h0VVEM/KgEDWN+z4J8xFQ2M8MRqCBdJQ7a2nH7NSugogvmHz3cvn0R9sYg38/te5c+2DR
        OCtK2RRCgZ+p36AQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Always clear user_cpus_ptr in do_set_cpus_allowed()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220922180041.1768141-6-longman@redhat.com>
References: <20220922180041.1768141-6-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <166693932997.29415.5377039389023064362.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     851a723e45d1c4c8f6f7b0d2cfbc5f53690bb4e9
Gitweb:        https://git.kernel.org/tip/851a723e45d1c4c8f6f7b0d2cfbc5f53690bb4e9
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 22 Sep 2022 14:00:41 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:22 +02:00

sched: Always clear user_cpus_ptr in do_set_cpus_allowed()

The do_set_cpus_allowed() function is used by either kthread_bind() or
select_fallback_rq(). In both cases the user affinity (if any) should be
destroyed too.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220922180041.1768141-6-longman@redhat.com
---
 kernel/sched/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 283bdbd..87c9cdf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2593,14 +2593,20 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		set_next_task(rq, p);
 }
 
+/*
+ * Used for kthread_bind() and select_fallback_rq(), in both cases the user
+ * affinity (if any) should be destroyed too.
+ */
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
 	struct affinity_context ac = {
 		.new_mask  = new_mask,
-		.flags     = 0,
+		.user_mask = NULL,
+		.flags     = SCA_USER,	/* clear the user requested mask */
 	};
 
 	__do_set_cpus_allowed(p, &ac);
+	kfree(ac.user_mask);
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
