Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1109362C44C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiKPQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbiKPQWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8293758BD5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:14 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuuuTA4YWeOsJFG5PLdantkjarf2V1vxrJ2SuyPt64s=;
        b=GqEDEE3zp/IRKIG7fVAtRnGyQYw8WjwWd4Q42w/o6PvPKiYO/I2UO9DeTHM3FJ0AKO0jvp
        LdOOd6uoG+vhbGCFBO7LBcXhhdAUApmgiQs0vuidLt14ucgw4AvLmW3ELjtEKxLG3N4KGx
        Q+9wx4UCYMejQEuvs0LMZiYK45HlAH2uV2vbxLpNjLMnhI4VYzHLHvp7JVcTvWg9ZPaU4Y
        qBnwFK9fzDv3qO7YojD6nmxsxJ6UqqxLGW+8ec2hNQOjRHVhBBr3T21cpJRNKBLJGbDGij
        w/e68WEuDCriejd7+eCTKF+cvy9G5bS5T0Z2sVAKmxN7wYRNwAe3135cVf0Dhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuuuTA4YWeOsJFG5PLdantkjarf2V1vxrJ2SuyPt64s=;
        b=cWNjqkiifbJnp+I8ut0vwNHx0n+1msAV6ALZLKMXEExGS/PVCCHSzpewmPRNwZytzWeWNm
        pETM9jyn9FGbzaBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH printk v5 33/40] tty: tty_io: use console_list_lock for list synchronization
Date:   Wed, 16 Nov 2022 17:27:45 +0106
Message-Id: <20221116162152.193147-34-john.ogness@linutronix.de>
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

show_cons_active() uses the console_lock to gather information
on registered consoles. It requires that no consoles are unregistered
until it is finished. The console_list_lock should be used because
list synchronization responsibility will be removed from the
console_lock in a later change.

Note, the console_lock is still needed to serialize the device()
callback with other console operations.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/tty_io.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ee4da2fec328..cafdff575716 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3527,16 +3527,13 @@ static ssize_t show_cons_active(struct device *dev,
 	ssize_t count = 0;
 
 	/*
-	 * Hold the console_lock to guarantee that no consoles are
+	 * Hold the console_list_lock to guarantee that no consoles are
 	 * unregistered until all console processing is complete.
 	 * This also allows safe traversal of the console list and
 	 * race-free reading of @flags.
-	 *
-	 * Take console_lock to serialize device() callback with
-	 * other console operations. For example, fg_console is
-	 * modified under console_lock when switching vt.
 	 */
-	console_lock();
+	console_list_lock();
+
 	for_each_console(c) {
 		if (!c->device)
 			continue;
@@ -3548,6 +3545,13 @@ static ssize_t show_cons_active(struct device *dev,
 		if (i >= ARRAY_SIZE(cs))
 			break;
 	}
+
+	/*
+	 * Take console_lock to serialize device() callback with
+	 * other console operations. For example, fg_console is
+	 * modified under console_lock when switching vt.
+	 */
+	console_lock();
 	while (i--) {
 		int index = cs[i]->index;
 		struct tty_driver *drv = cs[i]->device(cs[i], &index);
@@ -3563,6 +3567,8 @@ static ssize_t show_cons_active(struct device *dev,
 	}
 	console_unlock();
 
+	console_list_unlock();
+
 	return count;
 }
 static DEVICE_ATTR(active, S_IRUGO, show_cons_active, NULL);
-- 
2.30.2

