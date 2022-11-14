Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8C62854E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiKNQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbiKNQ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA13102C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:41 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEhKO0dJc2f16pdA5isP3tyKiWxAMb8gJwHLg9bJtvU=;
        b=fED6VtmDED6MuLvYHCpr7jg0s8uQ4ubFuV+VJrDBURlb+sRmrPLVdZhbCg7C9vkvldCcZC
        O3jnP3sS40Xc/9Nl61qOPe4tQo5M701OfeqSfviyYjbM9aVF5lpkSd4rH9cAes5ZiqmRXV
        qSC0fmcpzoHohSsnvCqpR2jm74hLpeXfas4Urmb+nz47yUrVVMWUckuYe0K6QhSQ0thxYe
        Do4tLzYO/CeZJ4lQo1ewHWpTh8mj47O/uroIOAzyntCZsQtDNfsDD/JIDWJTssmb6VX7O6
        7zwiYUW4aXXfoFUuEEQfPo3tGoBVRNEWeL66ULaqMgc89bm5V3SqUuiZVWBb3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEhKO0dJc2f16pdA5isP3tyKiWxAMb8gJwHLg9bJtvU=;
        b=X+VenatF4kHSWTowXfqC0zSVEJludzZYKhc6X1KeZyez9dy82GgAGpy+a7Avhfw9vUOvoe
        nAz42aPySqUAAZDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH printk v4 12/39] um: kmsg_dumper: use srcu console list iterator
Date:   Mon, 14 Nov 2022 17:35:05 +0106
Message-Id: <20221114162932.141883-13-john.ogness@linutronix.de>
In-Reply-To: <20221114162932.141883-1-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
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

Rather than using the console_lock to guarantee safe console list
traversal, use srcu console list iteration.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 arch/um/kernel/kmsg_dump.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 40abf1e9ccb1..427dd5a61a38 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -16,29 +16,26 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	struct console *con;
 	unsigned long flags;
 	size_t len = 0;
+	int cookie;
 
 	/*
 	 * If no consoles are available to output crash information, dump
 	 * the kmsg buffer to stdout.
 	 */
 
-	if (!console_trylock())
-		return;
-
-	for_each_console(con) {
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
 		/*
 		 * The ttynull console and disabled consoles are ignored
 		 * since they cannot output. All other consoles are
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    (con->flags & CON_ENABLED)) {
+		    (console_srcu_read_flags(con) & CON_ENABLED)) {
 			break;
 		}
 	}
-
-	console_unlock();
-
+	console_srcu_read_unlock(cookie);
 	if (con)
 		return;
 
-- 
2.30.2

