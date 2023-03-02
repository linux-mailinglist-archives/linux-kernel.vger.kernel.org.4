Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5F06A89EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCBT6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCBT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDF48E2C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:48 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvKO9QqGXwAvVE6Dd+q4rL71MFOGdvNMhIjt6NWB61k=;
        b=xFmMnktcYtR/SAZFBChYvEhtDZGN55+DFpfBQ+HJzArF1j0HI23kXWoElF+Gvt3BtANk/+
        V6XnfIrpIEk7ejTRN5LumMy+rIXq3tK3qfLvCFaoaJRbKMqMMB5W4D1bK86Mw5RfVQyzJg
        2a1DMgF6egBp0+/MrTz5W1AqGuw1ZTk5EahdmeCO6pQTgCGViY9n31TiApFUUELd4GJpiL
        tMaBN2Sl5BA5ipbeifYsl4upBKT+pYhgAHlKXO6PCrMig28NwnMcZmDzQbwld8wNNen8aB
        tQgRcGGob4kxd3V/aZf7IPn5Rwj55/dTl22xE3jVDfZz8AW1BTefuw/XNzP5WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SvKO9QqGXwAvVE6Dd+q4rL71MFOGdvNMhIjt6NWB61k=;
        b=hBrxnupy7aV7oa6D6dncweUttM+48UeatpUZwYCzkqwHf63e8pswDSzMZvamlboPdEXVu6
        Yzjl1f7QfkTMSvBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 13/18] printk: nobkl: Add write context storage for atomic writes
Date:   Thu,  2 Mar 2023 21:02:13 +0106
Message-Id: <20230302195618.156940-14-john.ogness@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

The number of consoles is unknown at compile time and allocating
write contexts on stack in emergency/panic situations is not desired
either.

Allocate a write context array (one for each priority level) along
with the per CPU output buffers, thus allowing atomic contexts on
multiple CPUs and priority levels to execute simultaneously without
clobbering each other's write context.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h  | 2 ++
 kernel/printk/internal.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 710f1e72cd0f..089a94a3dd8d 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -222,6 +222,7 @@ struct cons_state {
  * @CONS_PRIO_NORMAL:		Regular printk
  * @CONS_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
  * @CONS_PRIO_PANIC:		Panic output
+ * @CONS_PRIO_MAX:		The number of priority levels
  *
  * Emergency output can carefully takeover the console even without consent
  * of the owner, ideally only when @cons_state::unsafe is not set. Panic
@@ -234,6 +235,7 @@ enum cons_prio {
 	CONS_PRIO_NORMAL,
 	CONS_PRIO_EMERGENCY,
 	CONS_PRIO_PANIC,
+	CONS_PRIO_MAX,
 };
 
 struct console;
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index a72402c1ac93..a417e3992b7a 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -181,11 +181,16 @@ struct printk_message {
 
 /**
  * struct cons_context_data - console context data
+ * @wctxt:		Write context per priority level
  * @pbufs:		Buffer for storing the text
  *
  * Used for early boot and for per CPU data.
+ *
+ * The write contexts are allocated to avoid having them on stack, e.g. in
+ * warn() or panic().
  */
 struct cons_context_data {
+	struct cons_write_context	wctxt[CONS_PRIO_MAX];
 	struct printk_buffers		pbufs;
 };
 
-- 
2.30.2

