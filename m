Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4115D62C421
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiKPQXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiKPQWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EF849B6B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:05 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEhKO0dJc2f16pdA5isP3tyKiWxAMb8gJwHLg9bJtvU=;
        b=oIuBdriz4JcEynWjZAm586o5EvapOAFjcQM7Y2h/jaFjTqDiY6uPhp8aLR8nBjL3sNQ3Dd
        wHZzRlW7PVlMFZSrjuZBAdlaxGYKCPXOLT+eJt0Bx/Bf77XSVU/Sdj0fUXPID4f2JKMYWO
        xth7HR45tX4LCgAiYQR9UtjW3xY/OwKJbQ+MTsyvDkIBwVQsRDJgcmxvXQmLUsb4ji4IMo
        1l0xna2GGygbTY1KnRexudbFu2wA9TeXsj853JqPUmudt8ywLyxwW5Iiqh0Ree6FU5BaTz
        iM41PTKy8qkj5y2nB37PhrfFjKOUabUIaaJMqZLYTWFwtJKpjb3tdQms5EUKig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEhKO0dJc2f16pdA5isP3tyKiWxAMb8gJwHLg9bJtvU=;
        b=OZ7EGuhsAVFVp8NSWYxYiCIDMCwa1My5MhuROv6LAzBXyKI2zB/l2XJjq2B5TvLEf2EdaF
        XZjkrE4iliwyN5CQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH printk v5 13/40] um: kmsg_dumper: use srcu console list iterator
Date:   Wed, 16 Nov 2022 17:27:25 +0106
Message-Id: <20221116162152.193147-14-john.ogness@linutronix.de>
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

