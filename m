Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6E62C43D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiKPQZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiKPQWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195CE56EEC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:10 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoAi/IMpBqhMANDygn8dBGFjZ2GQ0xeR1eRQRwl7/a4=;
        b=3DQ4ybTOYcFtmwITLSHIYeVyVwnAXkGWFQW/4sJDsRLNKaCHLDRnlfSlMsgSfYPJL06aU6
        HObqr0W9cSaKt1dPrg88oy2FnVMdizwcMqHQh/H9lJHeqvg7UgarLJvkZW/wof37+IqYp0
        PUM5sQ0uYjBDY8iSw0ByaONYCNjofDYn38xrzQcO68QqVPwBLsAzqSolO9quGnzP4IqYSL
        Kw7JHvV4ZuZra98V5OSvbL4vcRlGBWHVUS9pmiBj7zVX8jdPOPuJHOJ0O0mq2VO3o03dXo
        bvMpC71N/uhuEhtU7QQaUNzrCbgtikuD2C5DSalmb+Zl1yXI7vuDI9zlf/D9Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoAi/IMpBqhMANDygn8dBGFjZ2GQ0xeR1eRQRwl7/a4=;
        b=BAcrakEpk8MQUdoOPQfpxF5sGvK4lMHn3g/fTME1TCNLAdTunomPlI5CyDW0olh1v3Kiq5
        +U26bZuftwKQNSBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH printk v5 25/40] tty: hvc: use console_is_registered()
Date:   Wed, 16 Nov 2022 17:27:37 +0106
Message-Id: <20221116162152.193147-26-john.ogness@linutronix.de>
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

It is not reliable to check for CON_ENABLED in order to identify if a
console is registered. Use console_is_registered() instead.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/hvc/hvc_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 4802cfaa107f..a683e21df19c 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -264,8 +264,8 @@ static void hvc_port_destruct(struct tty_port *port)
 
 static void hvc_check_console(int index)
 {
-	/* Already enabled, bail out */
-	if (hvc_console.flags & CON_ENABLED)
+	/* Already registered, bail out */
+	if (console_is_registered(&hvc_console))
 		return;
 
  	/* If this index is what the user requested, then register
-- 
2.30.2

