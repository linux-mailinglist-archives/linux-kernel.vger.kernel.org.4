Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5662C413
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiKPQWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiKPQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B6D26495
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:02 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXztAQTlLoZJohd2YWLlNMXfDo93BSWHA8w8Mma17HQ=;
        b=yAhjS6EMHDwR29tHfXch75ulrWxpc1Dllv4e1A6L/CRuj3qaC6My52J05yB5LS9GYDty3S
        YbJygu6L8FxPUC3xceTSgU17KYRVnrlWuB69bhLpPC403se7hEx4Y0zChaqnPgAjnfE3oW
        Cr/u+gUpRuLp3lgAm6HWu80ooQi1vkv9JOU4lFDi94Hh4ol3jEk7tlMEzm3JYwypNq3QvI
        ZZEEWOZ3w5ptvZASYNKSNKyz7XCQb8XSV3fsXq+BPK9moc2EAkkxEE8VuOtAMaVnvNRPZv
        rSa3L1G9AM+0MYYCxgUVlc+6a/gZgm8lmIXcpscIaLPQ4b5XlBe7RIvfGCgKOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXztAQTlLoZJohd2YWLlNMXfDo93BSWHA8w8Mma17HQ=;
        b=J45KvR1CKJPOFPEjopi9x5va7WC/8qt7O7J18LAFBh1vT0vVGDJioBw26YKvI+8Sp5ai6K
        rFudH5T5A87CiaAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 06/40] printk: fix setting first seq for consoles
Date:   Wed, 16 Nov 2022 17:27:18 +0106
Message-Id: <20221116162152.193147-7-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
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

It used to be that all consoles were synchronized with respect to
which message they were printing. After commit a699449bb13b ("printk:
refactor and rework printing logic"), all consoles have their own
@seq for tracking which message they are on. That commit also changed
how the initial sequence number was chosen. Instead of choosing the
next non-printed message, it chose the sequence number of the next
message that will be added to the ringbuffer.

That change created a possibility that a non-boot console taking over
for a boot console might skip messages if the boot console was behind
and did not have a chance to catch up before being unregistered.

Since it is not known which boot console is the same device, flush
all consoles and, if necessary, start with the message of the enabled
boot console that is the furthest behind. If no boot consoles are
enabled, begin with the next message that will be added to the
ringbuffer.

Also, since boot consoles are meant to be used at boot time, handle
them the same as CON_PRINTBUFFER to ensure that no initial messages
are skipped.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 50 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 31d9d1cf8682..c84654444a02 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3131,16 +3131,56 @@ static void try_enable_default_console(struct console *newcon)
 	       (con->flags & CON_BOOT) ? "boot" : "",	\
 	       con->name, con->index, ##__VA_ARGS__)
 
-static void console_init_seq(struct console *newcon)
+static void console_init_seq(struct console *newcon, bool bootcon_registered)
 {
-	if (newcon->flags & CON_PRINTBUFFER) {
+	struct console *con;
+	bool handover;
+
+	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
 		/* Get a consistent copy of @syslog_seq. */
 		mutex_lock(&syslog_lock);
 		newcon->seq = syslog_seq;
 		mutex_unlock(&syslog_lock);
 	} else {
-		/* Begin with next message. */
+		/* Begin with next message added to ringbuffer. */
 		newcon->seq = prb_next_seq(prb);
+
+		/*
+		 * If any enabled boot consoles are due to be unregistered
+		 * shortly, some may not be caught up and may be the same
+		 * device as @newcon. Since it is not known which boot console
+		 * is the same device, flush all consoles and, if necessary,
+		 * start with the message of the enabled boot console that is
+		 * the furthest behind.
+		 */
+		if (bootcon_registered && !keep_bootcon) {
+			/*
+			 * Flush all consoles and set the console to start at
+			 * the next unprinted sequence number.
+			 */
+			if (!console_flush_all(true, &newcon->seq, &handover)) {
+				/*
+				 * Flushing failed. Just choose the lowest
+				 * sequence of the enabled boot consoles.
+				 */
+
+				/*
+				 * If there was a handover, this context no
+				 * longer holds the console_lock.
+				 */
+				if (handover)
+					console_lock();
+
+				newcon->seq = prb_next_seq(prb);
+				for_each_console(con) {
+					if ((con->flags & CON_BOOT) &&
+					    (con->flags & CON_ENABLED) &&
+					    con->seq < newcon->seq) {
+						newcon->seq = con->seq;
+					}
+				}
+			}
+		}
 	}
 }
 
@@ -3235,13 +3275,13 @@ void register_console(struct console *newcon)
 	}
 
 	newcon->dropped = 0;
-	console_init_seq(newcon);
+	console_lock();
+	console_init_seq(newcon, bootcon_registered);
 
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
 	 */
-	console_lock();
 	if (hlist_empty(&console_list)) {
 		/* Ensure CON_CONSDEV is always set for the head. */
 		newcon->flags |= CON_CONSDEV;
-- 
2.30.2

