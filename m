Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FFD628563
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiKNQbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbiKNQaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131552408B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WuCvNpqsWpwV49S5/EiT2Eu/MmVMQdF6U0k8ms+rMbY=;
        b=Zq0ro6+RhBlIobVqcIjZKMHr+lsqn6RTbq/4EyeR2al6yeBAOLsUfwzHagX+OpThdDIYBn
        VZE/aYWC5cQ2/vx6ZAu1VmP+hab3UZ2YzY8SRYMvGEpYirjn96qqYewSqaotEIlUpyiZWd
        IdQnf2z4Dl6VKKpJ0mR1B4RNgDMnd6gDXi2CXWK5KPeM/1YpW/I0R6dEMqeFNtiwt2WYzs
        uU3lC8oWM6eohQfmqBlXdguZVOt/A0f6HQHlDRgq63C98P5PZU1stTY4muku6/skYgBZDW
        RekqyMf3j5W+N8/ukW2hKWe3aGXXoLYUBBeQX8j4E1y6LWIhHkhGsiyOzWca+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WuCvNpqsWpwV49S5/EiT2Eu/MmVMQdF6U0k8ms+rMbY=;
        b=jh/yhRRxZqyoNHCJ+pkEaPo+hN6JlHwv8X7cSv17o/jCQ4k5FSxhxITDL1Zg48QnQj2yIj
        DwyFvVmfj7sDM+DA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH printk v4 22/39] tty: nfcon: use console_is_registered()
Date:   Mon, 14 Nov 2022 17:35:15 +0106
Message-Id: <20221114162932.141883-23-john.ogness@linutronix.de>
In-Reply-To: <20221114162932.141883-1-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
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

Currently CON_ENABLED is being (mis)used to identify if the console
has been registered. This is not reliable because it can be set even
though registration failed or it can be unset, even though the console
is registered. Use console_is_registered() instead.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/m68k/emu/nfcon.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index 557d60867f98..6fdc13610565 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -49,7 +49,7 @@ static void nfcon_write(struct console *con, const char *str,
 static struct tty_driver *nfcon_device(struct console *con, int *index)
 {
 	*index = 0;
-	return (con->flags & CON_ENABLED) ? nfcon_tty_driver : NULL;
+	return console_is_registered(con) ? nfcon_tty_driver : NULL;
 }
 
 static struct console nf_console = {
@@ -107,6 +107,11 @@ static int __init nf_debug_setup(char *arg)
 
 	stderr_id = nf_get_id("NF_STDERR");
 	if (stderr_id) {
+		/*
+		 * The console will be enabled when debug=nfcon is specified
+		 * as a kernel parameter. Since this is a non-standard way
+		 * of enabling consoles, it must be explicitly enabled.
+		 */
 		nf_console.flags |= CON_ENABLED;
 		register_console(&nf_console);
 	}
@@ -151,7 +156,7 @@ static int __init nfcon_init(void)
 
 	nfcon_tty_driver = driver;
 
-	if (!(nf_console.flags & CON_ENABLED))
+	if (!console_is_registered(&nf_console))
 		register_console(&nf_console);
 
 	return 0;
-- 
2.30.2

