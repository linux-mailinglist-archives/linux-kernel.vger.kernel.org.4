Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF387628543
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbiKNQ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbiKNQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B037810AC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:37 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pEuSpcGiXYy1rNkif2p1RcLRxWAuPnhCpMJ3boeNpjg=;
        b=N/bsqRcka6hlDrx/SlwGRNAsEbFEBXRjQwbdRoXt4hlze32AZsQt/rhmkNMken4IpcG54I
        +KvWEBHaer8/Gei53H6l+GCecFD4I7gidtMF6CWblJihnzxQzE5DwB42jQlbFiI1d7JifO
        hFuuAyVPpFY967KrUNNJmdGq8x356zKRjK8THEwPyuHhFB2E7udRjbXnkVyFPxcQxw1HqS
        B124lIIlpqwf3zgW5+iBRgUIoTHePgLGxtl5xlRRnuNpgcLJeXVGdEkcps40nCTPWHz7+L
        /hurUZ2DPWtDUY2bh67wq39C+NuG0oiArgS1VEasLsceGezG9sOlOXjveNMh1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pEuSpcGiXYy1rNkif2p1RcLRxWAuPnhCpMJ3boeNpjg=;
        b=rsJm1DNOHkXtPr/zx3jxXiVx0pONhvzTAgITQSLoTexSWFuCX4rsVZoPheeJfALDD322mU
        Ob7/pqdT1WRODLCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 04/39] printk: register_console: use "registered" for variable names
Date:   Mon, 14 Nov 2022 17:34:57 +0106
Message-Id: <20221114162932.141883-5-john.ogness@linutronix.de>
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

The @bootcon_enabled and @realcon_enabled local variables actually
represent if such console types are registered. In general there
has been a confusion about enabled vs. registered. Incorrectly
naming such variables promotes such confusion.

Rename the variables to _registered.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 173f46a29252..3d449dfb1ed6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3156,8 +3156,8 @@ static void try_enable_default_console(struct console *newcon)
 void register_console(struct console *newcon)
 {
 	struct console *con;
-	bool bootcon_enabled = false;
-	bool realcon_enabled = false;
+	bool bootcon_registered = false;
+	bool realcon_registered = false;
 	int err;
 
 	for_each_console(con) {
@@ -3168,13 +3168,13 @@ void register_console(struct console *newcon)
 
 	for_each_console(con) {
 		if (con->flags & CON_BOOT)
-			bootcon_enabled = true;
+			bootcon_registered = true;
 		else
-			realcon_enabled = true;
+			realcon_registered = true;
 	}
 
 	/* Do not register boot consoles when there already is a real one. */
-	if (newcon->flags & CON_BOOT && realcon_enabled) {
+	if ((newcon->flags & CON_BOOT) && realcon_registered) {
 		pr_info("Too late to register bootconsole %s%d\n",
 			newcon->name, newcon->index);
 		return;
@@ -3216,7 +3216,7 @@ void register_console(struct console *newcon)
 	 * the real console are the same physical device, it's annoying to
 	 * see the beginning boot messages twice
 	 */
-	if (bootcon_enabled &&
+	if (bootcon_registered &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV)) {
 		newcon->flags &= ~CON_PRINTBUFFER;
 	}
@@ -3268,7 +3268,7 @@ void register_console(struct console *newcon)
 	 * went to the bootconsole (that they do not see on the real console)
 	 */
 	con_printk(KERN_INFO, newcon, "enabled\n");
-	if (bootcon_enabled &&
+	if (bootcon_registered &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
 		struct hlist_node *tmp;
-- 
2.30.2

