Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD4A750155
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjGLIXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjGLIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:22:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3E71991;
        Wed, 12 Jul 2023 01:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272AF61705;
        Wed, 12 Jul 2023 08:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD42C433CB;
        Wed, 12 Jul 2023 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689149914;
        bh=NmZo37R2Do8+gUN/CTL7QlHhRjljc9eEJn9MgddAxlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0ZYOWTolBfdVbmvcJLW0kuU/YHGQLABeXDvJy843kVDdYrMlWYetFNp8wAijaAND
         O/YIAkrPtZOlX9o33gzsWuKi/Vp6wW9sVt9PjJfO0ZFGxZj9+GubblfHTB7oFl2Mhp
         uahbph3Mz//vZ+56BmDaE2uiZghfePlCgNUIpSHTb84WvIEHx34ZP6zCLPPDY1SGEr
         npEYCQwS6DSDfkOJlmKr3nOUGEY9xW5dwxvtPkJx1ocrDaO95LGALi3lCTvJrNPQhw
         maVb8mr8WL8aEKDRqBu3LwHU9/WRPP2TDFtinXBQBJWh3whcHNdzzLQGtRrHOHDkfZ
         yIuIzjDu1EzRw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/10] serial: omap-serial: remove flag from serial_omap_rdi()
Date:   Wed, 12 Jul 2023 10:18:10 +0200
Message-ID: <20230712081811.29004-10-jirislaby@kernel.org>
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

The local 'flag' variable carries only TTY_NORMAL. So use that constant
directly and drop the variable.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/omap-serial.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 82d35dbbfa6c..16ab7ea07fa3 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -499,7 +499,6 @@ static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
 static void serial_omap_rdi(struct uart_omap_port *up, unsigned int lsr)
 {
 	unsigned char ch = 0;
-	unsigned int flag;
 
 	if (!(lsr & UART_LSR_DR))
 		return;
@@ -512,13 +511,12 @@ static void serial_omap_rdi(struct uart_omap_port *up, unsigned int lsr)
 		return;
 	}
 
-	flag = TTY_NORMAL;
 	up->port.icount.rx++;
 
 	if (uart_handle_sysrq_char(&up->port, ch))
 		return;
 
-	uart_insert_char(&up->port, lsr, UART_LSR_OE, ch, flag);
+	uart_insert_char(&up->port, lsr, UART_LSR_OE, ch, TTY_NORMAL);
 }
 
 /**
-- 
2.41.0

