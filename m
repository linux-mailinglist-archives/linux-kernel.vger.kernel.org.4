Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8FF604A84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJSPGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJSPER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:04:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6B413FDDA;
        Wed, 19 Oct 2022 07:59:04 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROOYEsR0MhxheCxKtRPcb2mfw4k8DWEDO6Xw87lE788=;
        b=dj7K4xySpq7whNrvoUhtROBd4luyoKbpg6xTwFwhdIXZhbdt5NpgczLROroEXs3PgPR5nV
        6HyH+7+1+Yrdno3e7XSvm+Rjun5P+yUigjsQD0kip44MepJ/Q022Y5oOoN2gaVaa8YRfl2
        6KkfTfDFLG8D29GLh1KJj/8usWDl8staheqlg16yBFk55WoMgh3s8R3HdP3566EXWHdGH6
        o7Jh2LwVPpRUpZwQ1KaXB7R3RaCUqh3kXswyT6GrZvNhezCCaXRsvfm77BMTZHoEQMPfxJ
        d6S8ayitsuWXl06xJ3vmxP14O6b/Blx/0zYuHK1UiScgBw0QdiyNqqvsWRpJLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROOYEsR0MhxheCxKtRPcb2mfw4k8DWEDO6Xw87lE788=;
        b=ryuSpo1BnIE5ZnNgWQJ91gufZbr2BMikTU+gIGl5WJJn0EfZEC0dlR7JSp8t5SfbRRzeKa
        qe9zWCaaaGZeIqAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH printk v2 18/38] usb: early: xhci-dbc: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:40 +0206
Message-Id: <20221019145600.1282823-19-john.ogness@linutronix.de>
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

Replace (console->flags & CON_ENABLED) usage with console_is_enabled().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/usb/early/xhci-dbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index bfb7e2b85299..b1a9c393160b 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -927,7 +927,7 @@ void __init early_xdbc_register_console(void)
 
 static void xdbc_unregister_console(void)
 {
-	if (early_xdbc_console.flags & CON_ENABLED)
+	if (console_is_enabled(&early_xdbc_console))
 		unregister_console(&early_xdbc_console);
 }
 
-- 
2.30.2

