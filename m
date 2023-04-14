Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ACB6E28EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjDNRC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDNRCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:02:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386814C06;
        Fri, 14 Apr 2023 10:02:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w11so19439892pjh.5;
        Fri, 14 Apr 2023 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681491770; x=1684083770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4982OWHBZFhKv5G5U9s7PCqJchTkqnqBTBjMwU+qIoM=;
        b=AKABNLwNp2FFLU0n3xMsC2JflB03vvtj1T3GTLay/ZkfhxW9UaUayh7gSQVbzAMZq2
         zU7YdBx55xiMa0W3499dZivNG3AWfpQxNwSRuTVe34hV/vDcsTvJ7V92JN7bFaIUSL4o
         gQNW4UioKlixgBP1jIoWWhrGEzzFCW1aEQlqfZf6UAgQRunKNgLUl+f9Bebo8RYN4GqS
         lX13cKrP1gnfX5f5VLgvhdVPjqwFkbmFq8GvZRS3UNEo8C3oh1MXSIR3s0MCXnirPl4a
         SrBbSH39o0AzW2xqj6DlDPuK5NgluYYaCMAcALsocsmwohCN0m8Pn0+80zVRhx7SoBjf
         AWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681491770; x=1684083770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4982OWHBZFhKv5G5U9s7PCqJchTkqnqBTBjMwU+qIoM=;
        b=M9jAzSYJ40UD3oBFLjmI3xy9vHCSfWeilV55DhFls/f8Cx4lnCvF5nrMojlwIhDZXY
         bBBiCZ1zl24DzPhNrISl/RnY/THDH2coRGOax/9j6OU5aVb4sjSrH5lgaAHPmfLohQMz
         SGw6VNA4NZmrqN1CsDTilCaXMWbgzXh5vUfwJ4pulKKVOnPtC/D2aMxEFu7YCZAzyetL
         3XGHYpJmoW1nrQgP6vl2le0dgCMbBLQS7smTxsY21Zh2q+d2WUcTv3atNDotvheXYwii
         X6hvUPPNmnt0R4ZICMc9zuXhX+oCZblf1OgcLipl4BMVWO4Dov8FDesuyGWCRZQdMo5d
         sXWw==
X-Gm-Message-State: AAQBX9dFPyHd7rJKM8ly4VK2jJ9ugdLkbd0xbteqLEOleuSM8dIgHU9h
        dl8tCe45N02ZYyRnBbhXVAXoBMvSsxXxrQ==
X-Google-Smtp-Source: AKy350ZGzpLaL1wGYb0Z+uFCylT8WrWM+ZvFm1RF6KgTGa2eSNliC8e7nCR8cXPuw1/GVPIKVJTFkg==
X-Received: by 2002:a17:903:1252:b0:1a2:7d:8a8d with SMTP id u18-20020a170903125200b001a2007d8a8dmr3840441plh.57.1681491769102;
        Fri, 14 Apr 2023 10:02:49 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090add8e00b0024702e7c80fsm3137129pjv.23.2023.04.14.10.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:02:48 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     opendmb@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH v2] serial: 8250: Add missing wakeup event reporting
Date:   Fri, 14 Apr 2023 10:02:39 -0700
Message-Id: <20230414170241.2016255-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An 8250 UART configured as a wake-up source would not have reported
itself through sysfs as being the source of wake-up, correct that.

Fixes: b3b708fa2780 ("wake up from a serial port")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- added Fixes: tag

 drivers/tty/serial/8250/8250_port.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index dfbc501cf9d1..fe8d79c4ae95 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -15,6 +15,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/sysrq.h>
@@ -1932,6 +1933,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
 	unsigned long flags;
 	u16 status;
@@ -1957,6 +1959,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
+		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
-- 
2.34.1

