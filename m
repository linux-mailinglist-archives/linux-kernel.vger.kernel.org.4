Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD66A89EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCBT6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjCBT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEFB474D7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:50 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbylHEX9bZ2Zz2vO7zrZ8IqoDnUW9FIGTcOLhEnljfc=;
        b=SzIhebPlt8K1wgUDVQ2Wh7Tb6U0elzXDwN42e+qk6p2+KJA3FqCB72QdiDFkqN5Rz6hN+m
        HKUcbOR5LpLtLiX997qg9iueEXEFKN2UXb/CWtgNW8XLZYrbBmNQB8+Lu3RVnl2iThp0Ki
        DxsgqYmPYbWJfh2LqkjcVungwPE368w3ZQk6iDdxTq6zrYi/NaWzsyVo4dN03fhx+tw/G2
        zPj6I4tuLNqgFTurakY8dVCGSaciIMuQ73HQmFp+JtFzviEiZhie9xMdGN3uK++J4f5h64
        ZqTPB4S/Jt49sYX3tuTfBXSn1jkPLjqsJeJYRi9k/xiBbIlj9PzEhMOTAJb0Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbylHEX9bZ2Zz2vO7zrZ8IqoDnUW9FIGTcOLhEnljfc=;
        b=VYNs/XHznKBn3ldggoAmpbvOhFfxFE91NmiYSlRyerxEjdw7bcVdX12/MvvF6kyEsz17Ug
        cnhlnMwLs693aCDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 15/18] printk: nobkl: Stop threads on shutdown/reboot
Date:   Thu,  2 Mar 2023 21:02:15 +0106
Message-Id: <20230302195618.156940-16-john.ogness@linutronix.de>
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

Register a syscore_ops shutdown function to stop all threaded
printers on shutdown/reboot. This allows printk to transition back
to atomic printing in order to provide a robust mechanism for
outputting the final messages.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_nobkl.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index 001a1ca9793f..53989c8f1dbc 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
+#include <linux/syscore_ops.h>
 #include "printk_ringbuffer.h"
 #include "internal.h"
 /*
@@ -1763,3 +1764,33 @@ void cons_nobkl_cleanup(struct console *con)
 	cons_state_set(con, CON_STATE_REQ, &state);
 	cons_free_percpu_data(con);
 }
+
+/**
+ * printk_kthread_shutdown - shutdown all threaded printers
+ *
+ * On system shutdown all threaded printers are stopped. This allows printk
+ * to transition back to atomic printing, thus providing a robust mechanism
+ * for the final shutdown/reboot messages to be output.
+ */
+static void printk_kthread_shutdown(void)
+{
+	struct console *con;
+
+	console_list_lock();
+	for_each_console(con) {
+		if (con->flags & CON_NO_BKL)
+			cons_kthread_stop(con);
+	}
+	console_list_unlock();
+}
+
+static struct syscore_ops printk_syscore_ops = {
+	.shutdown = printk_kthread_shutdown,
+};
+
+static int __init printk_init_ops(void)
+{
+	register_syscore_ops(&printk_syscore_ops);
+	return 0;
+}
+device_initcall(printk_init_ops);
-- 
2.30.2

