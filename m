Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F65633798
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiKVIzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiKVIzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:55:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B09829C88
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:55:32 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669107330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WHpMFQ3nTDIAnDhdGTOVqww/Tpb7qPsjpJRCRXT0sZg=;
        b=e42iyoX1Y1pobvlJl/4/5733Fcvpd/RZVQKgYOq8jAqmuFBuvxk85+fhXQjWIH4lCCLzs0
        +CxPXp3/j/b5BrtgF4bP81tNXVxk5srbgu+aHXlxjom8xmJkQXvx8wvgdafLdouDf2pilZ
        tyBQS5SQfQhlEWJbzWhz0cvoT/QRv/90B3W9l5sxQpHyx77ltlEooeCP4a2WaoFnKr0+p6
        nGQY3HvQvg/sfukZn9cxwfAO4PYvdC6SseXM8caHxdAF3RUv//XemXdB4oqKUT1mLKiN+f
        IkVJ37Vi3xiOSrqJr65+nlS/0j6bqtqWLBC2lLRbxJus/Vqg1u8U2AHvXe4/xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669107330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WHpMFQ3nTDIAnDhdGTOVqww/Tpb7qPsjpJRCRXT0sZg=;
        b=ONYwZcqCk+x/QIhXQ3Q/hCg5Yua1/fEFiBBJAQFviouHMZdGgAqRqWRM/EaIBnXJp0UbT5
        dgGx3NKb+KgaNpDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH printk] printk: htmldocs: add missing description
In-Reply-To: <20221122181052.75618842@canb.auug.org.au>
References: <20221122181052.75618842@canb.auug.org.au>
Date:   Tue, 22 Nov 2022 10:01:23 +0106
Message-ID: <87zgcjpdvo.fsf@jogness.linutronix.de>
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

Variable and return descriptions were missing from the SRCU read
lock functions. Add them.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Fix htmldocs build warning as reported by Stephen [0]. Thanks Stephen!

 [0] https://lore.kernel.org/lkml/20221122181052.75618842@canb.auug.org.au

 kernel/printk/printk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 503d55ccc835..9ec101766471 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL(console_list_unlock);
  * Use for_each_console_srcu() to iterate the console list
  *
  * Context: Any context.
+ * Return: A cookie to pass to console_srcu_read_unlock().
  */
 int console_srcu_read_lock(void)
 {
@@ -292,6 +293,7 @@ EXPORT_SYMBOL(console_srcu_read_lock);
 /**
  * console_srcu_read_unlock - Unregister an old reader from
  *	the SRCU-protected console list
+ * @cookie: cookie returned from console_srcu_read_lock()
  *
  * Counterpart to console_srcu_read_lock()
  */
-- 
2.30.2
