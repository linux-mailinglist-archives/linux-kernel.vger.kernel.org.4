Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4B462C41C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiKPQWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiKPQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F56326F5;
        Wed, 16 Nov 2022 08:22:03 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OX8P8PjcP3et+B8RxGuAu/qJSUE13puFYmEXVzvc8MY=;
        b=CEddAbi3RzraEuQWrV50K39HBCaBs5n1hbnWKQvKdxtvYvNn7qth0mD3hPQU/k5IM6/6jI
        tsakH1BSYxyMEWSQ+SYJ0ZbSLVzyVLLN6/OuY208TtKzgXC6M7StlhGoOqITVvqEeeSE2M
        X8Is4GU+dlc+eKJOSLahx8apQ/7CBFU4io8nbjAZNv2xNFB/IGOy7i8ahbNIx2TlwkTdyz
        ibPl1VaO0F9fOd8M9cClH3/bgDQIBr7zIZlGTmpNxRMFTCwefsc+Ksw5eBzns2iBBhnSdp
        K1UNeEN6Iqb9zCaC3+k2B4ePn7UMXh2KRldr715r7YqNpg/80ijcaDxMTepW6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OX8P8PjcP3et+B8RxGuAu/qJSUE13puFYmEXVzvc8MY=;
        b=wWUGVs3m5zf238cl2T7E7PtRK7QDcJHWNVj1NK/JvMgbbu2/yMeyvExDpCJ6+ELC+PGYAH
        BBDa/hEaxQ3F/JAw==
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
Subject: [PATCH printk v5 08/40] tty: serial: kgdboc: document console_lock usage
Date:   Wed, 16 Nov 2022 17:27:20 +0106
Message-Id: <20221116162152.193147-9-john.ogness@linutronix.de>
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

kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
are unregistered until the kgdboc_earlycon is setup. This is necessary
because the trapping of the exit() callback assumes that the exit()
callback is not called before the trap is setup.

Explicitly document this non-typical console_lock usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/kgdboc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index e76f0186c335..5be381003e58 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -530,6 +530,14 @@ static int __init kgdboc_earlycon_init(char *opt)
 	 * Look for a matching console, or if the name was left blank just
 	 * pick the first one we find.
 	 */
+
+	/*
+	 * Hold the console_lock to guarantee that no consoles are
+	 * unregistered until the kgdboc_earlycon setup is complete.
+	 * Trapping the exit() callback relies on exit() not being
+	 * called until the trap is setup. This also allows safe
+	 * traversal of the console list and race-free reading of @flags.
+	 */
 	console_lock();
 	for_each_console(con) {
 		if (con->write && con->read &&
-- 
2.30.2

