Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73D9604A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiJSPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiJSPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09281125015;
        Wed, 19 Oct 2022 07:59:13 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdvxHOKwRIeI8BiM8k+rYwU/Yx30rZAhLXmKb87AiP8=;
        b=YJM/Q8Y/iU41nYJhp3ruJ3GZbQPygcVKdQtdGfYKzTF62VPMx1mnPM9tcgyukJ54yaBxZA
        GVrkuBdRj36R50zyHRbByxcwzeIkJ2CitT346w2Db5zH5yWwwEieG+szD/pwmPecMyCI1h
        0OEDEw9VNJtjb26YQe62EHk5Rwz/lbk5LQrNjCrzvDvUiIssEVgWHSJaoJO/87vO/A/kOf
        XaEI1oeCR6s/TkWDLLjt70+k/1a69wPsRy2nuUIWcbB/Vtekle1QbRVEcd04sjNyqVuA0D
        1WVA1iDuqI9sMaCvV7EaPS+iAWUQOLFn2okif3uEEF9aGgVMzxDui9lC/dsqAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdvxHOKwRIeI8BiM8k+rYwU/Yx30rZAhLXmKb87AiP8=;
        b=8EnO9qClCf1jaZEbNBimixqghlBQ62awKnPSz1PmBmcugCl3Z+v0WMz2rs+IIgPUeCv/Ol
        Snw30DIMiYbGmfDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: [PATCH printk v2 34/38] serial: kgdboc: use console_list_lock instead of console_lock
Date:   Wed, 19 Oct 2022 17:01:56 +0206
Message-Id: <20221019145600.1282823-35-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
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

kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
are unregistered until the kgdboc_earlycon is setup. The console_list_lock
should be used instead because list synchronization repsponsibility will
be removed from the console_lock in a later change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/kgdboc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 48000666789a..0d85596aebe2 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -547,13 +547,13 @@ static int __init kgdboc_earlycon_init(char *opt)
 	 */
 
 	/*
-	 * Hold the console_lock to guarantee that no consoles are
+	 * Hold the console_list_lock to guarantee that no consoles are
 	 * unregistered until the kgdboc_earlycon setup is complete.
 	 * Trapping the exit() callback relies on exit() not being
 	 * called until the trap is setup. This also allows safe
 	 * traversal of the console list.
 	 */
-	console_lock();
+	console_list_lock();
 	for_each_console(con) {
 		if (con->write && con->read &&
 		    (console_is_enabled(con) || (con->flags & CON_BOOT)) &&
@@ -595,7 +595,7 @@ static int __init kgdboc_earlycon_init(char *opt)
 	}
 
 unlock:
-	console_unlock();
+	console_list_unlock();
 
 	/* Non-zero means malformed option so we always return zero */
 	return 0;
-- 
2.30.2

