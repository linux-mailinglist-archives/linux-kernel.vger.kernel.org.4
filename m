Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AFF5B4A81
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiIJW2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiIJW1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C243311
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:49 -0700 (PDT)
Message-ID: <20220910222300.966724916@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dUt7YWFMhjrMP4Qpw0W8vZndSNzlNorKm2KfwhLmlGk=;
        b=ZpGAMzk+By9q2iPr47fY+/daL7Pha5lvv2nOYLh97IzQ9DzVrzYq3Lq+QdyQokBlPs3Yvd
        ImRl/mHBqiLHGEPYTId7/dj6oxqq7qpGD1g0uIUo6lTUhkAKPUjAHaHFfloPIskY07i7XW
        e3KAXvvfKkYpYyGQmhByzFg1TqejB2pOe+NrM88nR+xNoxxxVis9T2plynwWfrjpeP0BEy
        4BSI6p4oKx4yjtUwnwj+EfONM1qq1v+pL899ch6yuTeEx51yiOFLIP1xGYl2F4lDBwtZyi
        YAFEiVdncj9YK5OAzqqZkJK2q41kU+mDey6Rk5Aky5dXzifGt4HfBx6mAVljaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dUt7YWFMhjrMP4Qpw0W8vZndSNzlNorKm2KfwhLmlGk=;
        b=JHvCvb5+eSydfHBwY6ELO4EIf6T3okWVuaIDiFOwC4ey9m1xP4iBb2VHfDiiKy6CEoOHN2
        IdDp66ONAbAPoBAA==
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
Subject: [patch RFC 10/29] kgbd: Pretend that console list walk is safe
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:47 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a special list iterator macro for KGDB to allow unprotected list
walks and add a few comments to explain the hope based approach.

Preperatory change for changing the console list to hlist and adding
lockdep asserts to regular list walks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/tty/serial/kgdboc.c |    5 ++++-
 include/linux/console.h     |   12 +++++++++++-
 kernel/debug/kdb/kdb_io.c   |    7 ++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -462,10 +462,13 @@ static void kgdboc_earlycon_pre_exp_hand
 	 * we have no other choice so we keep using it.  Since not all
 	 * serial drivers might be OK with this, print a warning once per
 	 * boot if we detect this case.
+	 *
+	 * Pretend that walking the console list is safe...
 	 */
-	for_each_console(con)
+	for_each_console_kgdb(con) {
 		if (con == kgdboc_earlycon_io_ops.cons)
 			return;
+	}
 
 	already_warned = true;
 	pr_warn("kgdboc_earlycon is still using bootconsole\n");
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -184,7 +184,17 @@ extern void console_list_unlock(void);
  * Requires console_lock to be held which guarantees that the
  * list is immutable.
  */
-#define for_each_console(con)						\
+#define for_each_console(con) \
+	for (con = console_drivers; con != NULL; con = con->next)
+
+/**
+ * for_each_console_kgdb() - Iterator over registered consoles for KGDB
+ * @con:	struct console pointer used as loop cursor
+ *
+ * Has no serialization requirements and KGDB pretends that this is safe.
+ * Don't use outside of the KGDB fairy tale land!
+ */
+#define for_each_console_kgdb(con)				\
 	for (con = console_drivers; con != NULL; con = con->next)
 
 extern int console_set_on_cmdline;
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -558,7 +558,12 @@ static void kdb_msg_write(const char *ms
 		cp++;
 	}
 
-	for_each_console(c) {
+	/*
+	 * This is a completely unprotected list walk designed by the
+	 * wishful thinking departement. See the oops_inprogress comment
+	 * below - especially the encourage section...
+	 */
+	for_each_console_kgdb(c) {
 		if (!(c->flags & CON_ENABLED))
 			continue;
 		if (c == dbg_io_ops->cons)

