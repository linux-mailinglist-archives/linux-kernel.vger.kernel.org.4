Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0261F599
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiKGOTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiKGORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:17:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96F21D0DE;
        Mon,  7 Nov 2022 06:16:55 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihos3kVL43GcNnwvRQa8EAkart8aw0DgSI6lBkWbDJU=;
        b=DuF+bg8yJFtPqiLv6Lzgpcy64Jm33Cwtcx+KWAV2sOjl/URNXsG3YczPD3PcntqIncaoNm
        3L02VXPjSR0TLj81YxGQ6LZTk2ZUQgybRBMeGeMQDocitnvSD5SblrY1yZr8k9abFb8bmg
        gAhPc5V5zOLxiZVcFHsLlxF9SQpoJ+RG1/ECiIUdLg5WUvgKJQrcwqG9k2eHQzP8MRYPm4
        MIiW7DQ1W4OFrx0lTMbt7t5JTV6Gg5M9AyPUvsoYVKdwCRoXfjlbxoSD96u2v1M/DZD9Qq
        xv2lLd2kENVAJNMJ/kje/5OI0ZYJ6COhsYtTUrsTB9jcA1Y/3Yh5grch75ZZ0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihos3kVL43GcNnwvRQa8EAkart8aw0DgSI6lBkWbDJU=;
        b=tNP8S8uaOeL8Ez4ZLxuS/B4XuCm99BrOZr9dwAEZbjlXPrmbmY57RQ59QmcB9FIUCSSctq
        i2jivdb3ZSpw5PDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH printk v3 31/40] usb: early: xhci-dbc: use console_is_registered()
Date:   Mon,  7 Nov 2022 15:22:29 +0106
Message-Id: <20221107141638.3790965-32-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
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

