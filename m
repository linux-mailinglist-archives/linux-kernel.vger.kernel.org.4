Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05415B4A84
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiIJW3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiIJW2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B3245073
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:11 -0700 (PDT)
Message-ID: <20220910222301.768132577@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JqcsLWC6gxaWGeg5CMWoSHMARcCM/7NtJ9JVFHbkB74=;
        b=P/dWLzqGeqQY8S/RnzXbC64UH3URSghq7Y3ZVCkGkIhqwzTzwlbwkt0JeqazXgDZY0rjX8
        31Gp6Z08fdIK08gkRvoIi4ETjETtkV6z0C0NmKkMHogpMeJy2vYxGoRH/KWs3wHpbq7a1Y
        S0GZMVJrPYc5vUEmcuwp6HmizXwx1pW8GHol6JGwagjAhF7fKgWMNXz9Xnm9UN9o8HfLJa
        LNUdr6nGGhIFAB9uPuLS1H+3Fb0WCUEGNrjC0H/ii4ia6MREYdRuQf3O1o6XAPlGpx86s5
        uFui+Be2sWuoM+2Et5FSBRY8FikYmu8SbPejkvnO1u1rSAdBQF1a01Q/79rGww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JqcsLWC6gxaWGeg5CMWoSHMARcCM/7NtJ9JVFHbkB74=;
        b=YHdw8QBVrwHqZWy1VBRJddoteQPTLQPLoE6jmf31gvgUazLp6T4f+B103nzG08ihPvh3Qw
        KbcfTZ52sA2hlwDA==
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Ogness <jogness@linutronix.de>
Subject: [patch RFC 24/29] printk: Put seq and dropped into cons_text_desc
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:09 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-BKL consoles have atomic sequence tracking which is not
compatible with the legacy consoles.

Put sequence and dropped message count into struct cons_text_desc, let
cons_fill_outbuf() operate on the seq/dropped fields and let the call sites
handle the update to the corresponding fields in struct console.

This allows sharing cons_fill_outbuf() between the two worlds. For the
legacy consoles this is not more or less racy than the existing code.

Co-Developed-by: John Ogness <jogness@linutronix.de>
Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h |    2 ++
 kernel/printk/printk.c  |   25 ++++++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -232,6 +232,7 @@ struct cons_text_buf {
  * @txtbuf:		Pointer to buffer for storing the text
  * @outbuf:		Pointer to the position in @buffer for
  *			writing it out to the device
+ * @seq:		The sequence requested
  * @dropped:		The dropped count
  * @len:		Message length
  * @extmsg:		Select extended format printing
@@ -239,6 +240,7 @@ struct cons_text_buf {
 struct cons_outbuf_desc {
 	struct cons_text_buf	*txtbuf;
 	char			*outbuf;
+	u64			seq;
 	unsigned long		dropped;
 	unsigned int		len;
 	bool			extmsg;
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2740,7 +2740,7 @@ static void cons_print_dropped(struct co
  * If it is NULL then records have been dropped or skipped and con->seq
  * has been forwarded so the caller can try to print the next record.
  */
-static bool cons_fill_outbuf(struct console *con, struct cons_outbuf_desc *desc)
+static bool cons_fill_outbuf(struct cons_outbuf_desc *desc)
 {
 	static int panic_console_dropped;
 
@@ -2755,12 +2755,12 @@ static bool cons_fill_outbuf(struct cons
 
 	prb_rec_init_rd(&r, &info, txtbuf->text, CONSOLE_LOG_MAX);
 
-	if (!prb_read_valid(prb, con->seq, &r))
+	if (!prb_read_valid(prb, desc->seq, &r))
 		return false;
 
-	if (con->seq != r.info->seq) {
-		con->dropped += r.info->seq - con->seq;
-		con->seq = r.info->seq;
+	if (desc->seq != r.info->seq) {
+		desc->dropped += r.info->seq - desc->seq;
+		desc->seq = r.info->seq;
 		if (panic_in_progress() && panic_console_dropped++ > 10) {
 			suppress_panic_printk = 1;
 			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
@@ -2769,7 +2769,7 @@ static bool cons_fill_outbuf(struct cons
 
 	/* Skip record that has level above the console loglevel. */
 	if (suppress_message_printing(r.info->level)) {
-		con->seq++;
+		desc->seq++;
 		return true;
 	}
 
@@ -2789,9 +2789,7 @@ static bool cons_fill_outbuf(struct cons
 
 		desc->len = len;
 		desc->outbuf = txtbuf->text;
-		desc->dropped = con->dropped;
 		cons_print_dropped(desc);
-		con->dropped = desc->dropped;
 	}
 
 	return true;
@@ -2820,16 +2818,21 @@ static bool console_emit_next_record(str
 				     bool *handover, bool extmsg)
 {
 	struct cons_outbuf_desc desc = {
-		.txtbuf	= txtbuf,
-		.extmsg = extmsg,
+		.txtbuf		= txtbuf,
+		.extmsg		= extmsg,
+		.seq		= con->seq,
+		.dropped	= con->dropped,
 	};
 	unsigned long flags;
 
 	*handover = false;
 
-	if (!cons_fill_outbuf(con, &desc))
+	if (!cons_fill_outbuf(&desc))
 		return false;
 
+	con->seq = desc.seq;
+	con->dropped = desc.dropped;
+
 	if (!desc.outbuf)
 		goto skip;
 

