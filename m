Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118166A89E1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCBT6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCBT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62044474DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:44 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2i344YuQotLWLLh6A7EkhSEbuMCwNrp9Bq5Z1X7/c0=;
        b=YMCQ3Q5j0mLRMU57xKPv0P3mSbWo0Ywjx2iCdMhsDuTXc1VGeoD7OhwB3PZioa1Q6rBV5x
        op9kGRs7DNY2tbQ+m6gUZxo8isQ4uWQzwqGlv4d2PFhAfuJbrKmW0oigkvHuDDS0mEYedn
        K09hhIZChvrQnP6jg13NnsoxEYMUXKke8zh/k3+wNURrPYkk1hC1Wp9WTHo2lLesvw8qiq
        2yzsCgLNrX30Ebq2zr+YcKqFBwTlbsBWY1TltUhSJqP5LyVMzHRBX1djhklF0Q5sCoHXcH
        CTFE6ChYtFsBfkrRFpCI9O/wU7BaD4JQkDUqKq9HeQuz8WjxVSm6Pz53lSXeHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2i344YuQotLWLLh6A7EkhSEbuMCwNrp9Bq5Z1X7/c0=;
        b=6LDiB0rmVnvPOZP6uR2CnybeIo6zVvSY0985uqwkaHrhDpNtH84j+OHtP7kKDCT1pBWMmC
        Vrc8je4gESeoJrDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 03/18] printk: Consolidate console deferred printing
Date:   Thu,  2 Mar 2023 21:02:03 +0106
Message-Id: <20230302195618.156940-4-john.ogness@linutronix.de>
In-Reply-To: <20230302195618.156940-1-john.ogness@linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printig to consoles can be deferred for several reasons:

- explicitly with printk_deferred()
- printk() in NMI context
- recursive printk() calls

The current implementation is not consistent. For printk_deferred(),
irq work is scheduled twice. For NMI und recursive, panic CPU
suppression and caller delays are not properly enforced.

Correct these inconsistencies by consolidating the deferred printing
code so that vprintk_deferred() is the toplevel function for
deferred printing and vprintk_emit() will perform whichever irq_work
queueing is appropriate.

Also add kerneldoc for wake_up_klogd() and defer_console_output() to
clarify their differences and appropriate usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c      | 31 ++++++++++++++++++++++++-------
 kernel/printk/printk_safe.c |  9 ++-------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 84af038292d9..bdeaf12e0bd2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2321,7 +2321,10 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	wake_up_klogd();
+	if (in_sched)
+		defer_console_output();
+	else
+		wake_up_klogd();
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
@@ -3811,11 +3814,30 @@ static void __wake_up_klogd(int val)
 	preempt_enable();
 }
 
+/**
+ * wake_up_klogd - Wake kernel logging daemon
+ *
+ * Use this function when new records have been added to the ringbuffer
+ * and the console printing for those records is handled elsewhere. In
+ * this case only the logging daemon needs to be woken.
+ *
+ * Context: Any context.
+ */
 void wake_up_klogd(void)
 {
 	__wake_up_klogd(PRINTK_PENDING_WAKEUP);
 }
 
+/**
+ * defer_console_output - Wake kernel logging daemon and trigger
+ *	console printing in a deferred context
+ *
+ * Use this function when new records have been added to the ringbuffer
+ * but the current context is unable to perform the console printing.
+ * This function also wakes the logging daemon.
+ *
+ * Context: Any context.
+ */
 void defer_console_output(void)
 {
 	/*
@@ -3832,12 +3854,7 @@ void printk_trigger_flush(void)
 
 int vprintk_deferred(const char *fmt, va_list args)
 {
-	int r;
-
-	r = vprintk_emit(0, LOGLEVEL_SCHED, NULL, fmt, args);
-	defer_console_output();
-
-	return r;
+	return vprintk_emit(0, LOGLEVEL_SCHED, NULL, fmt, args);
 }
 
 int _printk_deferred(const char *fmt, ...)
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index ef0f9a2044da..6d10927a07d8 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -38,13 +38,8 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if (this_cpu_read(printk_context) || in_nmi()) {
-		int len;
-
-		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
-		defer_console_output();
-		return len;
-	}
+	if (this_cpu_read(printk_context) || in_nmi())
+		return vprintk_deferred(fmt, args);
 
 	/* No obstacles. */
 	return vprintk_default(fmt, args);
-- 
2.30.2

