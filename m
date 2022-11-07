Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE43361F577
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiKGOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiKGOQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B541CFF1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:53 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kStKa0WjYDeKLxGc8aWMlTa8ztLKd7SaO/mrohxpQTE=;
        b=pz/gQ/1sVexBvgNtGDYjCRgwbJbEvU2eH4YV9pYimdcqvWP2I+B1duvHeKAbgYv5Lr07fJ
        3nSzyHqOLORAovjTQxpM5UWGC5xmpELupKsgitL24XB/k/6CbYqbdrByQjGVG32ntimIJ1
        USj7SHbao60ntXl7F0B8/Dgf2I0ETZl2HOE6SvWVzvw6syMMJ7jkBNFcCqtzk2ci0rb/h/
        nzelv8Zhcyl2iQtUuncRNBpI6lOSso410y4Bkv7m8+4KFJrOnAiON98KbP8i6OKblxuMiU
        1Npm/OYCrsXehm0v8UpG8OKzvnQOtYRcwsNbXQ+4ALpv4hu7eoaYI7SzAqD/Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kStKa0WjYDeKLxGc8aWMlTa8ztLKd7SaO/mrohxpQTE=;
        b=l5i2HOU0W5lz3c3aPgWHXD4IoEYHwPnmVudjTMsP1yxWvp9K9lwAxVDh5Sa/IY4JgVQe+k
        TL9RD2dZn3zPqhDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH printk v3 26/40] tty: hvc: use console_is_registered()
Date:   Mon,  7 Nov 2022 15:22:24 +0106
Message-Id: <20221107141638.3790965-27-john.ogness@linutronix.de>
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

