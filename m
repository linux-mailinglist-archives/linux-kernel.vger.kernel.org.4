Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E0262C449
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiKPQZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbiKPQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB558025;
        Wed, 16 Nov 2022 08:22:13 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqonCTPpfZXjo2LPJFdK8fQ8y1w5Fa/kW7qM4AbVqk0=;
        b=OgkpFCVaiSeO+LQ/j6+zQtq0n6iDywSpXysWk+wGMxn5NY8Lpi6yEZG29Hs13yIGUGGf7R
        IovDJ3VKpFrFu0ZT3784+ms4boN8yY81gPMPLxy5VLgxm9VswgG4LDSV6RwpCD6M18PPQ3
        DyvuO05Uo5p96U8R2Agq2vPpwEMV8YpJCMOK2BdOpY5PZsYXMaM19hhfMKY/s3owD+3a5k
        O/HcKUBHgAWTZQjptpPfbkxfcF3tdywNkKIjcDhE2kwOn6GOZFG+EbEt0l4AsvopEYk96q
        N4BTImkK5B+on64cfPxFCgcXeQozIy0aoaIyDk++6N4dgk7GQcfgKy1so48+ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqonCTPpfZXjo2LPJFdK8fQ8y1w5Fa/kW7qM4AbVqk0=;
        b=JV6AAcU+EGEfeBSOpHE/d0qAz6Prk9Itjm/unhVn8fP0nUKjQJimz54c1dr/2zk1crSuUF
        XRu1eOSeIs9uzyBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH printk v5 30/40] usb: early: xhci-dbc: use console_is_registered()
Date:   Wed, 16 Nov 2022 17:27:42 +0106
Message-Id: <20221116162152.193147-31-john.ogness@linutronix.de>
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
 drivers/usb/early/xhci-dbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index bfb7e2b85299..797047154820 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -927,7 +927,7 @@ void __init early_xdbc_register_console(void)
 
 static void xdbc_unregister_console(void)
 {
-	if (early_xdbc_console.flags & CON_ENABLED)
+	if (console_is_registered(&early_xdbc_console))
 		unregister_console(&early_xdbc_console);
 }
 
-- 
2.30.2

