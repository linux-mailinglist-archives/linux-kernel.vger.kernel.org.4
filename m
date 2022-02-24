Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30276A1602
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBXEqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBXEqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:46:22 -0500
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 20:46:18 PST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25E351F87
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:46:18 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 2C44310189CFC;
        Fri, 24 Feb 2023 05:40:34 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id EA28561CE0A1;
        Fri, 24 Feb 2023 05:40:33 +0100 (CET)
X-Mailbox-Line: From 13e4bdf7677924c689a70d0b7ad970a3255a8d41 Mon Sep 17 00:00:00 2001
Message-Id: <13e4bdf7677924c689a70d0b7ad970a3255a8d41.1677213245.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 24 Feb 2022 05:40:33 +0100
Subject: [PATCH for-6.4] printk: Unregister boot consoles on register of 1st
 real console
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code comment preceding register_console() claims that:

   "There are two types of consoles - bootconsoles (early_printk) and
    "real" consoles (everything which is not a bootconsole) which are
    handled differently. [...]
    As soon as a "real" console is registered, all bootconsoles
    will be unregistered automatically."

But that's not what the code does:  The code unregisters bootconsoles
only when the *preferred* console registers, i.e. the last one on the
command line.  If that console's driver never registers (e.g. because
it is disabled in the kernel config), bootconsoles stay around
indefinitely.  Should the command line contain both a bootconsole as
well as a real console on the same serial port, all messages are logged
twice once the real console registers.

Moreover, the log buffer is replayed once the real console registers
even though the messages were already emitted by the bootconsole.

Amend the code to be congruent with the above-quoted code comment and
thereby avoid these issues.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 kernel/printk/printk.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd0c9f913940..f89e865c6b23 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3423,10 +3423,8 @@ void register_console(struct console *newcon)
 	 * the real console are the same physical device, it's annoying to
 	 * see the beginning boot messages twice
 	 */
-	if (bootcon_registered &&
-	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV)) {
+	if (bootcon_registered && !(newcon->flags & CON_BOOT))
 		newcon->flags &= ~CON_PRINTBUFFER;
-	}
 
 	newcon->dropped = 0;
 	console_init_seq(newcon, bootcon_registered);
@@ -3465,8 +3463,7 @@ void register_console(struct console *newcon)
 	 * went to the bootconsole (that they do not see on the real console)
 	 */
 	con_printk(KERN_INFO, newcon, "enabled\n");
-	if (bootcon_registered &&
-	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
+	if (bootcon_registered && !(newcon->flags & CON_BOOT) &&
 	    !keep_bootcon) {
 		struct hlist_node *tmp;
 
-- 
2.39.1

