Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E271D62C445
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiKPQZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiKPQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD8558023;
        Wed, 16 Nov 2022 08:22:12 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6cWj091YR59AcrR/13CETRi+pH3BIcbTfvrd6iofMY=;
        b=3khnPpY+/0fVbClsRREkWs+Q0rzC4dedV7WP9ZYEJeza3chK230FUcVWmGWZWi1f1bhKyB
        fEyERbPaQyvmfBXggZEKkfr3zRQAv9j8vm+Jm1CSdYHYaUI878LYiSxaZBkgYEdU7VUwZf
        XTC8wpcneFOj9epONio+fEkm/kmfZRM+BgzHRQ3fYJMoOxhoRulDRrWT5jId6d8uNHOHhc
        J9yfIl/8aHl5bX32DTboKW286Y8/ZWbtCHcjonQIObk1Fznbhbyknyc68CVCthdwJcVx4O
        dAbw47J/ZTIxqoSQPE3Lwhm8znog0lnFqpZXChRtuniK/s+a9+v3ETRX6DRoSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d6cWj091YR59AcrR/13CETRi+pH3BIcbTfvrd6iofMY=;
        b=hFnbxyizVoAFtF6UneYybCMMjmZEAsRbkbgOmUKZJnHjqlNXWF0OaEpllQoZiooagRT1M1
        uPmVcrJryP7t0XDA==
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
Subject: [PATCH printk v5 28/40] tty: serial: samsung_tty: use console_is_registered()
Date:   Wed, 16 Nov 2022 17:27:40 +0106
Message-Id: <20221116162152.193147-29-john.ogness@linutronix.de>
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
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 77d1363029f5..9c252c9ca95a 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1732,7 +1732,7 @@ static void __init s3c24xx_serial_register_console(void)
 
 static void s3c24xx_serial_unregister_console(void)
 {
-	if (s3c24xx_serial_console.flags & CON_ENABLED)
+	if (console_is_registered(&s3c24xx_serial_console))
 		unregister_console(&s3c24xx_serial_console);
 }
 
-- 
2.30.2

