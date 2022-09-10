Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6C5B4A97
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiIJW2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiIJW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451CE386BB
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:45 -0700 (PDT)
Message-ID: <20220910222300.783722057@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qpkzU9jb2bUdUHq2NpoLCHahRoEppPCszhdtWaetok8=;
        b=Q6FVsyN/aJPyaEMuDxaRx7BVOK/OdIH7OuX/5QVTCOaJweRNfq+PLpIlbtCYrmH8czzipW
        Ffe1xBqjVTt7jF7Jf69FyGvI6kcRZnwwlaxPrvZeFuMYx2F6HupmXkh87NEqnhZHETvAHD
        t1rrMhiMpsDfK2YCvBtJ6q55CboiRILNeovjxFswLgoxdGAGpl2JRNwfOS2+VadZcvHNJ1
        ZSJgP4D9/PYfYhrX5GSm/qi/9+fm+6fbUTwKQ/CZNCbXfpnBLxLvkjNPUJIDzcrsLeimPL
        Fb+yjpvRYxBTnEsoWFS1zvb3Pt//tJdLoHmAxsF1QkdN5A8BeWACNdOI4TYmTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qpkzU9jb2bUdUHq2NpoLCHahRoEppPCszhdtWaetok8=;
        b=3Op6elz2aAwBiSirIUTeSnN+bV+QJFO7RDUgLF/qUrjJvCbRTMmHxz8MjqUn7xw5sZOaPe
        LRgRKZoTruScC6Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [patch RFC 07/29] printk: Convert console list walks for readers to list lock
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Facilities which expose console information to sysfs or procfs can use the
new list protection to keep the list stable. No need to hold console lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/tty/tty_io.c   |    6 +++---
 fs/proc/consoles.c     |    6 +++---
 kernel/printk/printk.c |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3535,8 +3535,8 @@ static ssize_t show_cons_active(struct d
 	struct console *c;
 	ssize_t count = 0;
 
-	console_lock();
-	for_each_console(c) {
+	console_list_lock();
+	for_each_registered_console(c) {
 		if (!c->device)
 			continue;
 		if (!c->write)
@@ -3560,7 +3560,7 @@ static ssize_t show_cons_active(struct d
 
 		count += sprintf(buf + count, "%c", i ? ' ':'\n');
 	}
-	console_unlock();
+	console_list_unlock();
 
 	return count;
 }
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -63,8 +63,8 @@ static void *c_start(struct seq_file *m,
 	struct console *con;
 	loff_t off = 0;
 
-	console_lock();
-	for_each_console(con)
+	console_list_lock();
+	for_each_registered_console(con)
 		if (off++ == *pos)
 			break;
 
@@ -80,7 +80,7 @@ static void *c_next(struct seq_file *m,
 
 static void c_stop(struct seq_file *m, void *v)
 {
-	console_unlock();
+	console_list_unlock();
 }
 
 static const struct seq_operations consoles_op = {
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2985,18 +2985,18 @@ void console_flush_on_panic(enum con_flu
  */
 struct tty_driver *console_device(int *index)
 {
-	struct console *c;
 	struct tty_driver *driver = NULL;
+	struct console *c;
 
-	console_lock();
-	for_each_console(c) {
+	console_list_lock();
+	for_each_registered_console(c) {
 		if (!c->device)
 			continue;
 		driver = c->device(c, index);
 		if (driver)
 			break;
 	}
-	console_unlock();
+	console_list_unlock();
 	return driver;
 }
 

