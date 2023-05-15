Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82126702592
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbjEOG61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjEOG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:58:08 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF1199F
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:57:09 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:3f77:5127:1ef7:f210])
        by xavier.telenet-ops.be with bizsmtp
        id wux62900P5WeK8L01ux6o4; Mon, 15 May 2023 08:57:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pyS8e-002Dc8-Gm;
        Mon, 15 May 2023 08:57:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pyS8o-007EMC-BW;
        Mon, 15 May 2023 08:57:06 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: omap: Move uart_write() inside PM section
Date:   Mon, 15 May 2023 08:57:06 +0200
Message-Id: <20230515065706.1723477-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is not set (e.g. m68k/allmodconfig):

    drivers/tty/serial/8250/8250_omap.c:169:13: error: ‘uart_write’ defined but not used [-Werror=unused-function]
      169 | static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
	  |             ^~~~~~~~~~

Fix tis by moving uart_write() inside the existing section protected
by #ifdef CONFIG_PM.

Reported-by: noreply@ellerman.id.au
Link: http://kisskb.ellerman.id.au/kisskb/buildresult/14925095/
Fixes: 398cecc24846e867 ("serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/8250/8250_omap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 5c093dfcee1d53bb..6bd15089fa67383f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -166,11 +166,6 @@ static u32 uart_read(struct omap8250_priv *priv, u32 reg)
 	return readl(priv->membase + (reg << OMAP_UART_REGSHIFT));
 }
 
-static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
-{
-	writel(val, priv->membase + (reg << OMAP_UART_REGSHIFT));
-}
-
 /*
  * Called on runtime PM resume path from omap8250_restore_regs(), and
  * omap8250_set_mctrl().
@@ -1637,6 +1632,11 @@ static int omap8250_lost_context(struct uart_8250_port *up)
 	return 0;
 }
 
+static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
+{
+	writel(val, priv->membase + (reg << OMAP_UART_REGSHIFT));
+}
+
 /* TODO: in future, this should happen via API in drivers/reset/ */
 static int omap8250_soft_reset(struct device *dev)
 {
-- 
2.34.1

