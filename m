Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21D05B4A87
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiIJWa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiIJW3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:29:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1284362D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:16 -0700 (PDT)
Message-ID: <20220910222301.939249419@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1gLj17SVnYEqJIpQXxtTYqtNvfOkCPZwAPnJd+DRrik=;
        b=eEVBRaEBQWd/tHXCwHaKJwdtLXqBe1gkIMqlIfFXi/TOnbKB6kpVOYZmWDZvB/fhRTVwSm
        UqhqOwvxvakJv1KsCkZG5qUq35E8kPz5Htuo0dFY8AVvIATpufeqxac/KfAT3ay8v9udmC
        W6ulZcXKomKLQrQTnf2iWT44OAhbLoTC6tsYZKiGNyfcq7yEQJlFuWQ7ulbib6R2AYU/la
        O4LLXGimYc4qowbG9KDPpFJ0UuJQNqfIwRCGfzynW9jvAb8DvghDLRxkG98YDF0lQIf1y6
        8ugoonVE6y6Fywz0SV5r+//r2Y1PiGpBHvygvgn9qhFzDeXcYtwBfQobuR9kjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1gLj17SVnYEqJIpQXxtTYqtNvfOkCPZwAPnJd+DRrik=;
        b=npjxPp0NuVdubxR6QH6WlgL8ozDbJVxX7Sr4Lxr7gb1jAaYUjKSfONfYaDEwkstcLjN4t8
        1v7MnWA0br5mUCAA==
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
Subject: [patch RFC 27/29] printk: Add write context storage for atomic writes
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:13 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <jogness@linutronix.de>

The number of consoles is unknown at compile time and allocating write
contexts on stack in emergency/panic situations is not desired either.

Allocate a write context array (one for each priority level) along with
the per CPU output buffers.

Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -253,6 +253,7 @@ struct cons_outbuf_desc {
  * @CONS_PRIO_NORMAL:		Regular printk
  * @CONS_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
  * @CONS_PRIO_PANIC:		Panic output
+ * @CONS_PRIO_MAX:		The number of priority levels
  *
  * Emergency output can carefully takeover the console even without consent
  * of the owner, ideally only when @cons_state::unsafe is not set. Panic
@@ -265,6 +266,7 @@ enum cons_prio {
 	CONS_PRIO_NORMAL,
 	CONS_PRIO_EMERGENCY,
 	CONS_PRIO_PANIC,
+	CONS_PRIO_MAX,
 };
 
 struct console;
@@ -327,12 +329,17 @@ struct cons_write_context {
 
 /**
  * struct cons_context_data - console context data
+ * @wctxt:		Write context per priority level
  * @txtbuf:		Buffer for storing the text
  *
  * Used for early boot embedded into struct console and for
  * per CPU data.
+ *
+ * The write contexts are allocated to avoid having them on stack, e.g. in
+ * warn() or panic().
  */
 struct cons_context_data {
+	struct cons_write_context	wctxt[CONS_PRIO_MAX];
 	struct cons_text_buf		txtbuf;
 };
 

