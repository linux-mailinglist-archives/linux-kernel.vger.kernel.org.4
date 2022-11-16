Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815DA62C43A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiKPQYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiKPQWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4655C56EE3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:09 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6b5NfOqKhbCO1n0vtfDs0FHEhscqKbHgSYvxQsImbM=;
        b=IBcr1RxLLQMeyECtbEihD5+SDG2qe7fRWjloWrZA2o4slYup3U8euFE14aIPz1HRHxa183
        CoHwh0r1nnCCq/kVLBav99fCpMmwf8HbZod20k0BgxGL3/QduwfUoc1od2xf8BJO7CCnvD
        ygTXemlU10X5pYiBYBpz+zh3Tvr8uDTkvgrL2EfBOOHirNL1k0XkHhbx0MT2by9Y+1+P3j
        ScpGGGr3ZzrLsRGMSh2ggRF5U/snEVrx5Dg4KAcbJvvvDqKhlIJ/B/vLWWNT5/AMv17/2+
        TvXximoOPlAMtZWKZ/+Li4h/lLdlVYU1BqLOiJ08cZqYOylus+X8wJZkoC3Jcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6b5NfOqKhbCO1n0vtfDs0FHEhscqKbHgSYvxQsImbM=;
        b=aCdGy65F2gyHzwQcJS4XmrabRrVViXls9okyGZ3p0ecSnxm0D+X6Mq6XYE9k0CGaxAQFeW
        TyAwIYANT63+pfBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH printk v5 23/40] tty: nfcon: use console_is_registered()
Date:   Wed, 16 Nov 2022 17:27:35 +0106
Message-Id: <20221116162152.193147-24-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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

