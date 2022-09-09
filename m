Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F54C5B32B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiIIJBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiIIJAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FF4B49C;
        Fri,  9 Sep 2022 02:00:23 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fr4lyg1zrSz+KpMdOvNbFEn8x3a3A6YtamtKHraJALw=;
        b=hHLvd/+W7aQGWi8y9fkkW/UL3GGaBWEXD+2xqdYffCWbNaBVw124/ZpIhvrueYPkPJWUmx
        rOD7ln12zU4cNGCUq4tgA3HB8Vx6L4FcwCbhr4S72lWxG31fPdnEiy0QkquVlN5hwdwwhy
        cZFBUppgpIOwA0W5A23fq4UUp0iBExVcxupjDI4yYvMnfzPcg2h/QvzSwns62uYq13A9lL
        8MflK4ufjTsV1jrTKQGtnywPpOIW0a6aTKjJzozXYmJWMpLKPSeXtQC82CyqonI0SU4lp+
        fUeYgPMUNlc0YGMDOmClT30LtxQo4mKwDjMRSIAKp4dCHrgQjzjBDdaoiw3QwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fr4lyg1zrSz+KpMdOvNbFEn8x3a3A6YtamtKHraJALw=;
        b=8tBkVt5tobos77F3l2RI68l8RZSKGXD7YXCHg51j9HTFRkGwt7SgU2/VhLJdjmtaoHjk0v
        Px9ipvHiLEWs7IDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/completion: Add wait_for_completion_state()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220822114648.922711674@infradead.org>
References: <20220822114648.922711674@infradead.org>
MIME-Version: 1.0
Message-ID: <166271402041.401.4778195645762030513.tip-bot2@tip-bot2>
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

Commit-ID:     929659acea03db6411a32de9037abab9f856f586
Gitweb:        https://git.kernel.org/tip/929659acea03db6411a32de9037abab9f856f586
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Aug 2022 13:18:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:49 +02:00

sched/completion: Add wait_for_completion_state()

Allows waiting with a custom @state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220822114648.922711674@infradead.org
---
 include/linux/completion.h |  1 +
 kernel/sched/completion.c  | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 51d9ab0..62b32b1 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -103,6 +103,7 @@ extern void wait_for_completion(struct completion *);
 extern void wait_for_completion_io(struct completion *);
 extern int wait_for_completion_interruptible(struct completion *x);
 extern int wait_for_completion_killable(struct completion *x);
+extern int wait_for_completion_state(struct completion *x, unsigned int state);
 extern unsigned long wait_for_completion_timeout(struct completion *x,
 						   unsigned long timeout);
 extern unsigned long wait_for_completion_io_timeout(struct completion *x,
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 35f15c2..d57a5c1 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -204,6 +204,7 @@ EXPORT_SYMBOL(wait_for_completion_io_timeout);
 int __sched wait_for_completion_interruptible(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE);
+
 	if (t == -ERESTARTSYS)
 		return t;
 	return 0;
@@ -241,12 +242,23 @@ EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
 int __sched wait_for_completion_killable(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_KILLABLE);
+
 	if (t == -ERESTARTSYS)
 		return t;
 	return 0;
 }
 EXPORT_SYMBOL(wait_for_completion_killable);
 
+int __sched wait_for_completion_state(struct completion *x, unsigned int state)
+{
+	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
+
+	if (t == -ERESTARTSYS)
+		return t;
+	return 0;
+}
+EXPORT_SYMBOL(wait_for_completion_state);
+
 /**
  * wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
  * @x:  holds the state of this particular completion
