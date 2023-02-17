Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5569A766
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBQItj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBQIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:49:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94B360FBC;
        Fri, 17 Feb 2023 00:49:06 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676623739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Czz+UHh2RKqC0X5s5ts/z+bv6kppSAX6QrGQ9OL6ABY=;
        b=wvuqpxkIB0VrV2LcTVU2Wi30d5sSFvifaNA+3Xd88OiaEXcI5Rt51oaNY+pvldLFFaDHQz
        blAphOBmB3Nb2EUj9G0song9CoAoQdnSDugsBm9TVVmjy10MQvT0ZY2xYRsrtzouqr8M8R
        htf2cwsOOIXCXEfjU9ZZoDW9iJK/t8LAPxoljBDAuR003/hchocIFLRCWMkPaNAC9Z2XCT
        06i1j5yksQ6SWp4NAvI42/FESx/lXSYrqUxqeOFCIVOR1ruiaitfUbkxhAxrUG0xv1rHYn
        KUqSNDWgp/bcEh6veB+3uACjTkW69kZ/3eLIebbIqv5rdHCeoHPWZbLmk7oULA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676623739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Czz+UHh2RKqC0X5s5ts/z+bv6kppSAX6QrGQ9OL6ABY=;
        b=tEJu6DkB9Ss4EirYoTFw2klYU/t8BT4+cyusElaV0JHdVXXUKxOCsExKE/ha8/CAQkJ1YH
        PAfRzkN736E5AcCw==
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH 5.10-rt] printk: ignore consoles without write() callback
In-Reply-To: <87bkls65pf.fsf@jogness.linutronix.de>
References: <87zg9d99mp.fsf@jogness.linutronix.de>
 <Y+5ftWNKMv9WJTXT@linutronix.de> <87bkls65pf.fsf@jogness.linutronix.de>
Date:   Fri, 17 Feb 2023 09:53:44 +0106
Message-ID: <878rgw65lb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ttynull driver does not provide an implementation for the write()
callback. This leads to a NULL pointer dereference in the related
printing kthread, which assumes it can call that callback.

Do not create kthreads for consoles that do not implement the write()
callback. Also, for pr_flush(), ignore consoles that do not implement
write() or write_atomic(), since there is no way those consoles can
flush their output.

Link: https://lore.kernel.org/lkml/1831554214.546921.1676479103702.JavaMail.zimbra@hale.at
Reported-by: Michael Thalmeier <michael.thalmeier@hale.at>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d2205872304d..64747c72fbea 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2267,6 +2267,10 @@ static int printk_kthread_func(void *data)
 /* Must be called within console_lock(). */
 static void start_printk_kthread(struct console *con)
 {
+	/* No need to start a printing thread if the console cannot print. */
+	if (!con->write)
+		return;
+
 	con->thread = kthread_run(printk_kthread_func, con,
 				  "pr/%s%d", con->name, con->index);
 	if (IS_ERR(con->thread)) {
@@ -3566,6 +3570,8 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 		for_each_console(con) {
 			if (!(con->flags & CON_ENABLED))
 				continue;
+			if (!con->write && !con->write_atomic)
+				continue;
 			printk_seq = atomic64_read(&con->printk_seq);
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
-- 
2.30.2
