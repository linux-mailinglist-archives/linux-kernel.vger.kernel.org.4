Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C9A61D7E1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 07:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKEGDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 02:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiKEGBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 02:01:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFDB3123B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 23:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF0060A67
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 06:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD9DC433D6;
        Sat,  5 Nov 2022 06:01:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1orCFl-007Oya-1Q;
        Sat, 05 Nov 2022 02:02:01 -0400
Message-ID: <20221105060201.271193974@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 05 Nov 2022 02:00:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4a 35/38] timers: hangcheck: Use timer_shutdown_sync() before a module is
 released
References: <20221105060024.598488967@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a module is released, timer_shutdown_sync() must be called on its
timers.

Also fixed some whitespace issues in the line after.

Link: https://lore.kernel.org/all/20221104054053.431922658@goodmis.org/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/char/hangcheck-timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
index 4181bcc1c796..783a86bfca69 100644
--- a/drivers/char/hangcheck-timer.c
+++ b/drivers/char/hangcheck-timer.c
@@ -167,8 +167,8 @@ static int __init hangcheck_init(void)
 
 static void __exit hangcheck_exit(void)
 {
-	del_timer_sync(&hangcheck_ticktock);
-        printk("Hangcheck: Stopped hangcheck timer.\n");
+	timer_shutdown_sync(&hangcheck_ticktock);
+	printk("Hangcheck: Stopped hangcheck timer.\n");
 }
 
 module_init(hangcheck_init);
-- 
2.35.1
