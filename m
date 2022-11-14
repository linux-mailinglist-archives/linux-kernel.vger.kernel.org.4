Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16C5628548
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiKNQaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiKNQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCB01090
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:39 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhPw3XXoH9XRWJswk/JBlglPwpWkjXWTrlT44qUapxw=;
        b=Q1SMMXuyxOWvBY4wLKbn6h5Ayn+3VnUgAJcz69djjTklbRksAE1N3c4XVMpOJtSekBo4HY
        CCmB6g/foSeYLFibrh7Uyxx8C86o3zjranTjmXECfC6cMBJ2aSLX7gB0UizVZVxOv3JvPY
        J5Ssv+H1AkQYBOXEqsf5JDpMEqWQoQ9PIpE84wRFAeddZvaMYCbj2hcFnKLG/lhdU1N0bH
        AxeNLePgmpp1h1Ff70eyoEXZ4dingPBZcY2PYsG+2udfVG/P7ad4gxFnURrJdE1vy6G7Ot
        RQsEcIBFSkvbKkmbMUQFf7H6ujxGmvtL8i3/gJiWZ2sNI60XOKQ1Qsjas0qPtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhPw3XXoH9XRWJswk/JBlglPwpWkjXWTrlT44qUapxw=;
        b=mcYx8biVkymW58t1QdV6MJQytDsSYwFv4bMvSNwMxW/UleRJ4Bh4P2+T+QkcYr7QJUtST6
        9S69gAfrZxGJM7AA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 05/39] printk: fix setting first seq for consoles
Date:   Mon, 14 Nov 2022 17:34:58 +0106
Message-Id: <20221114162932.141883-6-john.ogness@linutronix.de>
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

Since it is not possible to know which boot console a console is
taking over, use the lowest @seq of all the enabled boot consoles. If
no boot consoles are available/enabled, begin with the next message
that will be added to the ringbuffer.

Also, since boot consoles are meant to be used at boot time, handle
them the same as CON_PRINTBUFFER to ensure that no initial messages
are skipped.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3d449dfb1ed6..8dbf3461cba0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3222,14 +3222,31 @@ void register_console(struct console *newcon)
 	}
 
 	newcon->dropped = 0;
-	if (newcon->flags & CON_PRINTBUFFER) {
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
+		 * is the same device, start with the message of the enabled
+		 * boot console that is the furthest behind.
+		 */
+		if (bootcon_registered && !keep_bootcon) {
+			for_each_console(con) {
+				if ((con->flags & CON_BOOT) &&
+				    (con->flags & CON_ENABLED) &&
+				    con->seq < newcon->seq) {
+					newcon->seq = con->seq;
+				}
+			}
+		}
 	}
 
 	/*
-- 
2.30.2

