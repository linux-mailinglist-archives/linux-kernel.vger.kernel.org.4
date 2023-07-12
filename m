Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3269875015C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjGLIYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjGLIXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9326E268C;
        Wed, 12 Jul 2023 01:19:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD93861708;
        Wed, 12 Jul 2023 08:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD0EC433C7;
        Wed, 12 Jul 2023 08:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689149911;
        bh=aEbQE/95bLmaIJXD58eaBIN7aIIW9TD36vMUZ0da4Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgNauHljB8hl+pCWp/zUNsk0i0/72wyCOEOkux4CCU/8y+D5Ii2xIPdxbL19YAOLi
         Xj+t2svognh/QreTszJCzcw+fd2Oa0Ylja49QFEQDCK+iAIBNm0Qh7ZxI/1ErTrg8y
         xk64/BYbvrpns99RSskGsMz/Fk3YbGx3+hJtQ0fGDFBwqtEdT6EjgLkTsn4gqCg/kJ
         PR32J3FPBQRspkqyxeifoLYbuF51QOilRwvbG2EMMMbBOQFeNS9tlhyUmeR7es1MNd
         i2y+MLaMV+j/O1Arj6rCg0obhlVdmW+sDYOsSbq4EnkA8Ph7qbNcLVjEgtk4KSZ+6L
         00kDU+3kImj2w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/10] serial: pass state to __uart_start() directly
Date:   Wed, 12 Jul 2023 10:18:08 +0200
Message-ID: <20230712081811.29004-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712081811.29004-1-jirislaby@kernel.org>
References: <20230712081811.29004-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__uart_start() does not need a tty struct. It works only with
uart_state. So pass the latter directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index bef507cb804c..306ea1a560e6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -133,9 +133,8 @@ static void uart_stop(struct tty_struct *tty)
 	uart_port_unlock(port, flags);
 }
 
-static void __uart_start(struct tty_struct *tty)
+static void __uart_start(struct uart_state *state)
 {
-	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->uart_port;
 	struct serial_port_device *port_dev;
 	int err;
@@ -170,7 +169,7 @@ static void uart_start(struct tty_struct *tty)
 	unsigned long flags;
 
 	port = uart_port_lock(state, flags);
-	__uart_start(tty);
+	__uart_start(state);
 	uart_port_unlock(port, flags);
 }
 
@@ -239,7 +238,7 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 		if (!old_hw_stopped)
 			uport->ops->stop_tx(uport);
 		else
-			__uart_start(tty);
+			__uart_start(state);
 	}
 	spin_unlock_irq(&uport->lock);
 }
@@ -619,7 +618,7 @@ static int uart_write(struct tty_struct *tty,
 		ret += c;
 	}
 
-	__uart_start(tty);
+	__uart_start(state);
 	uart_port_unlock(port, flags);
 	return ret;
 }
-- 
2.41.0

