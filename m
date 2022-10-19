Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858B9604A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJSPEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiJSPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:04:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B1B18F0DC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:58:30 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DU0x5O5I9RpJgy/cp3SLsKJQ2S1+Cvd/4SG5pk09kAc=;
        b=lhmCsfzj24k5pXS6vMkayCOEXN89OO2hYrf+P3pHZY5Uc8awoFzbR1WNxWz89ah1Wl1RJN
        UtRafmMxB4eq47PUYX0qE2iORN8YW29s5ZnDfrP5jUKQPiiyl4BNEdt9VvwdqdaVebgWrb
        bjZCQqAwv1M/BpWVepcDcISB+HPBPTj0gP6x8ICe9SgTAdYYirF4m5oN4aE32nHj/+shau
        ApH8MIYM3AoxDo4z+waCfLB1Q2K4qJzeHe88mx4a6J5z85iJKei38O6MWBubQO7AXt30+1
        D7HS2H/ONTFe2WaUqzkK+DuLx4bmh5Ovx8UXvnjyCaGMkNqsEVxcRb6DwDCd/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DU0x5O5I9RpJgy/cp3SLsKJQ2S1+Cvd/4SG5pk09kAc=;
        b=l2g6FH6uxwNCpKlJ/oJ3Rl3UvT/3LcZFXUfEnwTA1nqbmIeYdpPfA8BOJpqZVkKkmgCGoD
        RO2dZOsG0h0CK+AA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH printk v2 06/38] tty: nfcon: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:28 +0206
Message-Id: <20221019145600.1282823-7-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace (console->flags & CON_ENABLED) usage with console_is_enabled().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/m68k/emu/nfcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index 557d60867f98..c542fc2b121f 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -49,7 +49,7 @@ static void nfcon_write(struct console *con, const char *str,
 static struct tty_driver *nfcon_device(struct console *con, int *index)
 {
 	*index = 0;
-	return (con->flags & CON_ENABLED) ? nfcon_tty_driver : NULL;
+	return console_is_enabled(con) ? nfcon_tty_driver : NULL;
 }
 
 static struct console nf_console = {
@@ -151,7 +151,7 @@ static int __init nfcon_init(void)
 
 	nfcon_tty_driver = driver;
 
-	if (!(nf_console.flags & CON_ENABLED))
+	if (!console_is_enabled(&nf_console))
 		register_console(&nf_console);
 
 	return 0;
-- 
2.30.2

