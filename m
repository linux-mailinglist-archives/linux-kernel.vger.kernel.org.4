Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF9862C42C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiKPQXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiKPQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC2747311
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:06 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhhJ4NEYDrYYk962PRI1KO7CTDJYZ90BsmoX/yxQ/gI=;
        b=lRDydq5FRZTnwLjVZHwb0EFCh4BnmAql/o3iD/Qhwm+z4zzC7IEwqkBDf2PopO8HzRgRB9
        rYWm/6nGUKDvhLD52VVku54Wzv3n+RpLJ1VYDeXtDYnm81qg/kqn67NNDxXntUC4ZqHj5T
        76kg6Qu3zH/jNH7WI5zmxvWp96rFCt2IpIJ+lqpcQXLaI32egKpudioKS2bXTKJOOFx/kM
        l5yZrET/CWXg6D0NcF1jzBUJuVzPtFCyqGSgcctEYxK5uPOnTXkovYxcy0G++vcVykd5DO
        sYa/WzWP4KKm77GyhziPCSDqiwU5LZi+ZHnuBvk8ZXMJoicHCDGCmFB3idMIEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhhJ4NEYDrYYk962PRI1KO7CTDJYZ90BsmoX/yxQ/gI=;
        b=bY0sIjstLLp8P/5/imQZ/AMuPiIf5JzcDLwL9jC+9b1Sxa18frPcCl9+jZamwRBFbekt5C
        rWE6Za9htWGPuTAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 17/40] printk: console_is_usable: use console_srcu_read_flags
Date:   Wed, 16 Nov 2022 17:27:29 +0106
Message-Id: <20221116162152.193147-18-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6666cc27a014..75951c4bda05 100644
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

