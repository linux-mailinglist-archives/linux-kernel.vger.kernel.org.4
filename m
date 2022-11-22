Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D0B634518
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiKVUEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKVUEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:04:34 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07687555;
        Tue, 22 Nov 2022 12:04:34 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id c8so10813725qvn.10;
        Tue, 22 Nov 2022 12:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61Z18t82jU1MA8k0PNZCPTqH7mPoyuwaJmcl38kpxd4=;
        b=owtbID1UVgFRck/SJsX0leFMA9T3IXcLmD+2vrOQI9OwiQUyQk51RsXDoU0EeTvdyU
         XYZuRVE+fT8+Ugh75GOD1EuAfFdMwgSonfjNiDU7Yb1/9VydhgWyfJnnAf2lojU+nrb8
         5ZrcunkbBuGOaDraUO2L8TQm1DBqQUocsQYNEilNc1C5AQ0K1kKRTgk1frG1uWnuBqmJ
         QhATR8RIhfGGkyaPD9enP8AvX8YicWQLr0acobynYWdbmBBx7Dhcz5zNOmzP1SbYDGKl
         2bIYhmYYBll6kAF4IsFNCXzDt9UqseVUSq/6Tbh1nG8okCbbq26eGa8w5/eP6Bump/zU
         J7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61Z18t82jU1MA8k0PNZCPTqH7mPoyuwaJmcl38kpxd4=;
        b=FrqwwzsSRf2iV7AYtZfa2MMQugexfystHhuFP0G9dFgZ4g8KDvj3IldSAxrjC2z3eK
         Kl0Fy1VTarEzc0lkK31PrIqM1iKkLkOi5cy22kWkKXM8+QvePvKarbtAJTWz/wn6KZgJ
         RJo52y/ToyVD/DuzubRaiyHjjEiKFl2ue1Jx5bdz4NWAjSsTuDFShs1O6XNxQmFiOz8i
         MRmWirwhlaMgHJsu+7wYuNtQqzk6WO8z2VjnUBoljy+r5rDzJv1bhbkhn3OJPCNvku0E
         44Keo/0p+ZDr7+WSmWhOLAx4SdcdmwQMXlwU2oTTAUC9P4frevsONYJN2iqdoR8eGkZt
         nPZg==
X-Gm-Message-State: ANoB5pmDpkqHI7ASlIHzoZkMjyPjqTNVXWevFyQsSP/Ocr1IT9ZPM2/6
        E8Da5rFJosd4gmkufUwiWVxmv3U/vVtBfQ==
X-Google-Smtp-Source: AA0mqf5xtlKMOncS7PF97qD+tvkSPX0zgxuUPR4Ug8k2+sWIVCleUWMEfFp3rjvdT2r5u7tGX+fKSw==
X-Received: by 2002:a05:6214:3387:b0:4c6:90b1:dd96 with SMTP id mv7-20020a056214338700b004c690b1dd96mr4723935qvb.10.1669147472810;
        Tue, 22 Nov 2022 12:04:32 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm10266137qkd.57.2022.11.22.12.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:04:32 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tklauser@distanz.ch,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        cbouatmailru@gmail.com, geert@linux-m68k.org
Subject: [PATCH] serial: altera_uart: fix locking in polling mode
Date:   Tue, 22 Nov 2022 15:04:26 -0500
Message-Id: <20221122200426.888349-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since altera_uart_interrupt() may also be called from
a poll timer in "serving_softirq" context, use
spin_[lock_irqsave|unlock_irqrestore] variants, which
are appropriate for both softirq and hardware interrupt
contexts.

Fixes: 2f8b9c15cd88 ("altera_uart: Add support for polling mode (IRQ-less)")
Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---

I used this driver as a sorce of inspiration for adding IRQ support to
the LiteX LiteUART, and this topic came up during review. So I thought
it might be helpful to fix it here as well!

 drivers/tty/serial/altera_uart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 316074bb23e9..9ce3d24af536 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -259,16 +259,17 @@ static irqreturn_t altera_uart_interrupt(int irq, void *data)
 {
 	struct uart_port *port = data;
 	struct altera_uart *pp = container_of(port, struct altera_uart, port);
+	unsigned long flags;
 	unsigned int isr;
 
 	isr = altera_uart_readl(port, ALTERA_UART_STATUS_REG) & pp->imr;
 
-	spin_lock(&port->lock);
+	spin_lock_irqsave(&port->lock, flags);
 	if (isr & ALTERA_UART_STATUS_RRDY_MSK)
 		altera_uart_rx_chars(port);
 	if (isr & ALTERA_UART_STATUS_TRDY_MSK)
 		altera_uart_tx_chars(port);
-	spin_unlock(&port->lock);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	return IRQ_RETVAL(isr);
 }
-- 
2.38.1

