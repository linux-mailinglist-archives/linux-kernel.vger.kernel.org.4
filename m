Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682ED61F53C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiKGORQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiKGOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CC71CFF6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4n04ln6Ch/hdvzpbKZeVJtV0DW7GpBDW/64Z1krMb78=;
        b=fjFDBOuExj6AkzrBAgwGsZMWcQG7o8pcYxBeiRO9Hv5/MET+Urn/iU0k73K8KQVlMlUNpM
        FY+dleU7ocJj0ji81DsotW8vyOMG0D5M1iG7cmDJAaecNz7sH9SRPGHJJCmZcQBb+npM5o
        lJ0doKia/xvyGmtxJ5kwiPyMJtZqOe0h2Z2CxI35d7hqo2qKdthMC3yWtHOGMY88eLckEs
        1Tz8RmJZ/H8/5654j9UFU19pDfIJWfawwbZHcQB+sptO2JpX6Oamb+OWlXEAFBWqGuOX3P
        n7AnRlDjpaJEB/ZcSIAtzUA/p3z/pTCXdt5NGwFbE/98sWE93QhtL7XkWfWFEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4n04ln6Ch/hdvzpbKZeVJtV0DW7GpBDW/64Z1krMb78=;
        b=i2mJNvHheKNDa4WvDo4khjz/Y4qbCG/JXNJubnpudAH/q8vUufrKnKB9RlhTArcA9d3SNr
        EtHCyjWatvPZE0AQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 05/40] printk: fix setting first seq for consoles
Date:   Mon,  7 Nov 2022 15:22:03 +0106
Message-Id: <20221107141638.3790965-6-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
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
 kernel/printk/printk.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 173f46a29252..8974523f3107 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3222,14 +3222,26 @@ void register_console(struct console *newcon)
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
+		 * If an enabled boot console is not caught up, start with
+		 * that message instead. That boot console will be
+		 * unregistered shortly and may be the same device.
+		 */
+		for_each_console(con) {
+			if ((con->flags & (CON_BOOT | CON_ENABLED)) == (CON_BOOT | CON_ENABLED) &&
+			    con->seq < newcon->seq) {
+				newcon->seq = con->seq;
+			}
+		}
 	}
 
 	/*
-- 
2.30.2

