Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB1628555
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbiKNQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbiKNQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A1B1D329
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:42 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15kv2lfD0mZOWcVuclsvK9b1h/ynFw4leTYyP0YL6rw=;
        b=okh6A5QlkjpXnF9pvfDJcTztMcEqPE2ZSnWcrrxa3D8kuKAc8UTMRdT0c1hkuitjBXNNDM
        jhHlWRLXkX8q9iegblR2CQvjQgraDlaLGzqYlVGZUtAz/peO9lIHwhcH7h1SfDRDWjE0Jo
        pADbPTE4O44NqmyRyRKpjdsMVrW2yKAmXFF9mR03SnaMxDiX6ShaX066yswHAj21BHuVaf
        nvUjYGkkyBujbFZc+zxYh+0ZoO2NgyKwLLgfFWY11jLxO5ZPI50GRVptsLOOlyWfGYmQZu
        ex+5XtJByUT6RcllQbiHE3xIW2f2CcmN4+kl12Xb5IVcrAfkXFDOIC8rtAp0yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15kv2lfD0mZOWcVuclsvK9b1h/ynFw4leTYyP0YL6rw=;
        b=OQIMQpLs1oTaVmqPcyzpUCH3snN/rsTE4GnEQR/mf0gHB+XdIdbvEWEUX7kbVh7tAr4HIb
        PFUVAyeQcHj6mwBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 16/39] printk: console_is_usable: use console_srcu_read_flags
Date:   Mon, 14 Nov 2022 17:35:09 +0106
Message-Id: <20221114162932.141883-17-john.ogness@linutronix.de>
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

All users of console_is_usable() are SRCU iterators. Use the
appropriate wrapper function to locklessly read the flags.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3d9e5bb1a50b..bc563972e468 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2708,11 +2708,13 @@ static bool abandon_console_lock_in_panic(void)
  * Check if the given console is currently capable and allowed to print
  * records.
  *
- * Requires the console_lock.
+ * Requires the console_srcu_read_lock.
  */
 static inline bool console_is_usable(struct console *con)
 {
-	if (!(con->flags & CON_ENABLED))
+	short flags = console_srcu_read_flags(con);
+
+	if (!(flags & CON_ENABLED))
 		return false;
 
 	if (!con->write)
@@ -2723,8 +2725,7 @@ static inline bool console_is_usable(struct console *con)
 	 * allocated. So unless they're explicitly marked as being able to
 	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
 	 */
-	if (!cpu_online(raw_smp_processor_id()) &&
-	    !(con->flags & CON_ANYTIME))
+	if (!cpu_online(raw_smp_processor_id()) && !(flags & CON_ANYTIME))
 		return false;
 
 	return true;
-- 
2.30.2

