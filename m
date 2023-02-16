Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5326991EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjBPKmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBPKmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:42:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D61552A9;
        Thu, 16 Feb 2023 02:41:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676544072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FGPeHUbLlmmqkr0P1pwps1dugoZJJLLHDOT/GDe1Nmo=;
        b=LtIBgBC83GPPA9ZI9wLPFWhXnDuEWCAubVFEJ4Ik+5pPtrsAI+F7oDr0cdKteV+IuTk6ch
        r9NQ819jtF4NcydIV/hmAsnMeQen5uWKMVrLIzgqRIt5uRsf4Ai6IhrhytTW1Fg6ESq41A
        1MwdYRJxVB8DwWL9weS4tvPzXXmJuFe28AQMw+L6jUCW45PaVm8hasrizXMIqBwSUdNrIj
        GjEF08SCPdjjaPnOIwTN2AaPsHkYyfQrHVKHKEfFM98318SeWs9U61j/UlPhTYTYl2ja3a
        61SyBIow5rl/FVxuhIknpd7N80wf+Cg8dfkYT0oOhiyEQ3T4LMinzMioDAYURA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676544072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=FGPeHUbLlmmqkr0P1pwps1dugoZJJLLHDOT/GDe1Nmo=;
        b=K07MjVO9TDdxC5rio4jkaV41qIqL8XVvHEx5EbLxcDWj0LOtAXRI6Y2tCOuDa6wk9ON1oo
        4ZRvHMhJhGW3jJCg==
To:     Clark Williams <williams@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH 5.15-rt] printk: ignore consoles without write() callback
Date:   Thu, 16 Feb 2023 11:45:58 +0106
Message-ID: <87zg9d99mp.fsf@jogness.linutronix.de>
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
write() or write_atomic() since there is no way those consoles can
flush their output.

Link: https://lore.kernel.org/lkml/878rgy37f5.fsf@jogness.linutronix.de
Fixes: 8782b1ef4125 ("printk: move console printing to kthreads")
Reported-by: Michael Thalmeier <michael.thalmeier@hale.at>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 This is only a problem for the PREEMPT_RT tree. Mainline does not have
 this problem.

 kernel/printk/printk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7f27cfee283e..752afe88b5b4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2343,6 +2343,10 @@ static int printk_kthread_func(void *data)
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
@@ -3737,6 +3741,8 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 		for_each_console(con) {
 			if (!(con->flags & CON_ENABLED))
 				continue;
+			if (!con->write && !con->write_atomic)
+				continue;
 			printk_seq = read_console_seq(con);
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
-- 
2.30.2
