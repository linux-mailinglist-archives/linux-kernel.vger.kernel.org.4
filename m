Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF36A89DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCBT6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCBT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61787474D7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:44 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RiY4OM6UJRNz/WSBX/5KTZe1S/q7JPH46lONkiG6+g=;
        b=Y//5m69smqt/3rvjKkJp+AlCiSiSrJ2hIBzpHRCpeJXg/jOSGUYgrqzG6OPRuopLBUgI93
        drFPLWbNUW/fRZlcONLMavFXa5Ibf1mkU0drw9z2KBEmFfJsksGvn1r5BQExYV/wcjj/D9
        Lhx/bq9/xUikhZhko9k7557OS/3qwp2w3O2W9RgfQBrbQwwcZUi7nOQVxdn6PbbK0ZVTNR
        p9N6Y1bTFLq74dYQ9u4Iv62cwBG27Gy0I7yiG8WBav5uqHe7as38pYd49SanoYvV+CQl1N
        f4tx5rN4Cndz1RU2q5bwq6uoZMmD4xhgtDWyLhUarNHhzL1TuU+ycaxQ+E++iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RiY4OM6UJRNz/WSBX/5KTZe1S/q7JPH46lONkiG6+g=;
        b=5mkIXmg8E1wb4LxyOtqUWqr3pPJWzahz+3aLJVXlzhMk3YTSTUrSC36xyMS9fCgNetkQGg
        J14n8LFF4jHNUMBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 02/18] printk: Add NMI check to down_trylock_console_sem()
Date:   Thu,  2 Mar 2023 21:02:02 +0106
Message-Id: <20230302195618.156940-3-john.ogness@linutronix.de>
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

The printk path is NMI safe because it only adds content to the
buffer and then triggers the delayed output via irq_work. If the
console is flushed or unblanked (on panic) from NMI then it can
deadlock in down_trylock_console_sem() because the semaphore is not
NMI safe.

Avoid try-locking the console from NMI and assume it failed.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 40c5f4170ac7..84af038292d9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -318,6 +318,10 @@ static int __down_trylock_console_sem(unsigned long ip)
 	int lock_failed;
 	unsigned long flags;
 
+	/* Semaphores are not NMI-safe. */
+	if (in_nmi())
+		return 1;
+
 	/*
 	 * Here and in __up_console_sem() we need to be in safe mode,
 	 * because spindump/WARN/etc from under console ->lock will
-- 
2.30.2

