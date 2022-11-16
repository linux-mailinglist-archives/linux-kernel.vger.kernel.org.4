Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E1862C411
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiKPQWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiKPQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719E1D135
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:02 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EN1ltT10tlp5gUO3+3LVGUGiufYOOsSefqI80mCBCpE=;
        b=WPdwLGjnnt1bS979u4sLT0ES6LFDbMLi7N2xzKnRQME44bqQm+SOt+o5g2PwviFi9WijgQ
        RBb99RpeWmpU9pVxhWLn5g66mzj8Ocxc8dWM4RCKpQHhvxbxNzcIZuIOLNtX4Ddq5/xqjd
        NisGFQFP3XCrWtP/mk6vRNtLLMH7AL/G2UeWNJraDyaD4cJI6YU6+Ge5bnxJojjX9RLEEA
        jyERdZM67/YAMRMSdktHvTio9Z2FIdZLscXeK2LYEV2DzMUADw1ejELcWjZq+ilM2Gu/ZJ
        C97woYLBDyIb0aFxgyHR2ZSZsTM696G7/qQ7d2Ue8Hpy9mjFHTtyWAhF5d7XMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EN1ltT10tlp5gUO3+3LVGUGiufYOOsSefqI80mCBCpE=;
        b=J+8IXAJxUIi+rarf9xER0OU8t61+ODSJX3QmJ+F9MmZjZaJ14ftCmAo1TTl3sNy7gPAlD9
        364wszigXArpVzDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 05/40] printk: move @seq initialization to helper
Date:   Wed, 16 Nov 2022 17:27:17 +0106
Message-Id: <20221116162152.193147-6-john.ogness@linutronix.de>
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

The code to initialize @seq for a new console needs to consider
more factors when choosing an initial value. Move the code into
a helper function console_init_seq() "as is" so this code can
be expanded without causing register_console() to become too
long. A later commit will implement the additional code.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3d449dfb1ed6..31d9d1cf8682 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3131,6 +3131,19 @@ static void try_enable_default_console(struct console *newcon)
 	       (con->flags & CON_BOOT) ? "boot" : "",	\
 	       con->name, con->index, ##__VA_ARGS__)
 
+static void console_init_seq(struct console *newcon)
+{
+	if (newcon->flags & CON_PRINTBUFFER) {
+		/* Get a consistent copy of @syslog_seq. */
+		mutex_lock(&syslog_lock);
+		newcon->seq = syslog_seq;
+		mutex_unlock(&syslog_lock);
+	} else {
+		/* Begin with next message. */
+		newcon->seq = prb_next_seq(prb);
+	}
+}
+
 #define console_first()				\
 	hlist_entry(console_list.first, struct console, node)
 
@@ -3222,15 +3235,7 @@ void register_console(struct console *newcon)
 	}
 
 	newcon->dropped = 0;
-	if (newcon->flags & CON_PRINTBUFFER) {
-		/* Get a consistent copy of @syslog_seq. */
-		mutex_lock(&syslog_lock);
-		newcon->seq = syslog_seq;
-		mutex_unlock(&syslog_lock);
-	} else {
-		/* Begin with next message. */
-		newcon->seq = prb_next_seq(prb);
-	}
+	console_init_seq(newcon);
 
 	/*
 	 * Put this console in the list - keep the
-- 
2.30.2

