Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77605604A79
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiJSPFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbiJSPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:04:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1153D1C5A5F;
        Wed, 19 Oct 2022 07:58:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECvJGB97Hla1u507jwp5akWm1qCQ1lChgjmZWmbHvAU=;
        b=U0BupZGCQHaRq+D5r1dZHhQ+O1tvmXp1DO3geOOs8K5K2OV5M7k0FFEhZuxAaivxGr3jDh
        LfFdNYEVY3ONqrvO31yQDmC4pv9lZbZ65u9VWYnvToQk3eYero1RZj02ZbuD6ghbDhttP0
        lJA7ZTAiSL9vkXIVlIyBZZR4P+kilPLa8KiUKPFUDOhCgL35CEuVqTijttmO8iVFoUk9ik
        0QsrUBkBSsE14vhvOIsyklFwXFJO8kecQ310Ish2cbJIx3/4N2ekjBu0ZcTA+w6OhfiRcy
        m3ozY+le97N9+MO4n35Tyllx9o4l3z7cTXJQyGh2O7btDGrwSYIhS/VdcnmDdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECvJGB97Hla1u507jwp5akWm1qCQ1lChgjmZWmbHvAU=;
        b=GI/hKiJLWVa+vepqZzJ+pH7neoD0sTcrbTqVtFMsZA/DipeGp5quDMaKAppqq2BiIO9vW2
        5J+fk9L/z5Q+9zDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH printk v2 14/38] tty: serial: samsung_tty: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:36 +0206
Message-Id: <20221019145600.1282823-15-john.ogness@linutronix.de>
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
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 77d1363029f5..8142a0e53ffa 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1732,7 +1732,7 @@ static void __init s3c24xx_serial_register_console(void)
 
 static void s3c24xx_serial_unregister_console(void)
 {
-	if (s3c24xx_serial_console.flags & CON_ENABLED)
+	if (console_is_enabled(&s3c24xx_serial_console))
 		unregister_console(&s3c24xx_serial_console);
 }
 
-- 
2.30.2

