Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC35E8B8F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiIXKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiIXKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40B3EE32;
        Sat, 24 Sep 2022 03:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF8560BB9;
        Sat, 24 Sep 2022 10:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AAAC433C1;
        Sat, 24 Sep 2022 10:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664016245;
        bh=aiDjtGcub9TCH2Zjr7EGsrufP9lbe/sjAusroWPF83U=;
        h=From:To:Cc:Subject:Date:From;
        b=JxbZHCwcGlguzXoumgpZIEHUCy97ZKx3zzCz4liJ3+mMigUXDff6LmnEk0mWi6tLL
         GRKmT2EiynmzAUPX2d61mKeOT3qv+AL490cuq5OgAfTb/XponJKwEvJLo/M/MwLreM
         pYsEvVCXq8RbCPoEWoRsgPeaOg5BK7sceGO/3CXY5Y6jm5vwqUYboOCGV0tLKZI5Lo
         zSYwvzuBME8ydqHB78G4+Rxuenab7h5wSlTY3r2vPVH8gtPCv0zoFrRVMMmMATQUDq
         JpOmC46f33DcxEISg9U0FEh9pWHlA0wtKLRIlhmsxpiQ8YrKkGlrY/rP9WCOT0cNrX
         yyogV6r7afwJw==
Received: by pali.im (Postfix)
        id 071018A2; Sat, 24 Sep 2022 12:44:03 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: Fix restoring termios speed after suspend
Date:   Sat, 24 Sep 2022 12:43:24 +0200
Message-Id: <20220924104324.4035-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit edc6afc54968 ("tty: switch to ktermios and new framework")
termios speed is no longer stored only in c_cflag member but also in new
additional c_ispeed and c_ospeed members. If BOTHER flag is set in c_cflag
then termios speed is stored only in these new members.

Since commit 027b57170bf8 ("serial: core: Fix initializing and restoring
termios speed") termios speed is available also in struct console.

So properly restore also c_ispeed and c_ospeed members after suspend to fix
restoring termios speed which is not represented by Bnnn constant.

Fixes: 4516d50aabed ("serial: 8250: Use canary to restart console after suspend")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/tty/serial/8250/8250_port.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 39b35a61958c..441f317c55af 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3314,8 +3314,13 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	unsigned int baud, quot, frac = 0;
 
 	termios.c_cflag = port->cons->cflag;
-	if (port->state->port.tty && termios.c_cflag == 0)
+	termios.c_ispeed = port->cons->ispeed;
+	termios.c_ospeed = port->cons->ospeed;
+	if (port->state->port.tty && termios.c_cflag == 0) {
 		termios.c_cflag = port->state->port.tty->termios.c_cflag;
+		termios.c_ispeed = port->state->port.tty->termios.c_ispeed;
+		termios.c_ospeed = port->state->port.tty->termios.c_ospeed;
+	}
 
 	baud = serial8250_get_baud_rate(port, &termios, NULL);
 	quot = serial8250_get_divisor(port, baud, &frac);
-- 
2.20.1

