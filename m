Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4161F59F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiKGOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiKGOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:17:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6125F1D331
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:57 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuuuTA4YWeOsJFG5PLdantkjarf2V1vxrJ2SuyPt64s=;
        b=Ad8er1f7f8T+qnj0Gixt4/Eb+4c4OBJuex8lcfrI6Qt9I87cz3Yhpp3wFd3F8c5QAakGi7
        n0yYpOb0XzwK6fAjOBesCSJAdkcc9KpXBouFayqOhvycH3D3yadGi/NrkdtoGLbncezA5X
        YjxkitS3+oQNxU51jX06dua+f/JTR0XVGlDIr8XnD/7XQCOkEkGQV7za9feSO1p2qDYB97
        UumWZEnga12d8kYgQTwG2oUlZ8itzYhywnpRTKu8Ks8TF1Bk4XdZtBxWxmXB+X1cV+LfUg
        IEtga3BtJP43iP9Aa+RQ9n71Ed9jlHvrLDju9BL47ap7+sIADoEpSefIdM/kVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuuuTA4YWeOsJFG5PLdantkjarf2V1vxrJ2SuyPt64s=;
        b=zK+1fRr2slLJAgCrOQ92XALV5x6DkTtyLpaf7GZ9DoHDzskWr2XYcAOYzCFmWcOd1UDl2W
        031PveM/i8gqIXAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH printk v3 34/40] tty: tty_io: use console_list_lock for list synchronization
Date:   Mon,  7 Nov 2022 15:22:32 +0106
Message-Id: <20221107141638.3790965-35-john.ogness@linutronix.de>
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

