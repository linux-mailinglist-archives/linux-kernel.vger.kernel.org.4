Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D06E168F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDMVkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDMVkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:40:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463139005;
        Thu, 13 Apr 2023 14:40:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o2so16428573plg.4;
        Thu, 13 Apr 2023 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681422009; x=1684014009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4wjW+ICiBYhAXWT8jlIW5tMq7BAmws/agXTmM0sEf/A=;
        b=mfEdYFxeAv2Zb/5yz1BfnB/S/Mj36XuCxt/PAYVbkGeJF1IMDH1KaMdt0VZbbcOHio
         bZgfptFhLPbllViMHf2gQUY5rIemPcEkZmyXqhGJrgXd3fljHDKHXTvkf1PZkhIiCN/G
         IVUoZWmRoqynN244jlGV2GZw2e/QPYYbjb44iirpFPcy3qdCAZ54pUDCwOdStusBZw91
         1cqr7fEiYR21I2w8JPcnQOAZcfXrrJybLYHRGN2PZnGp/b2dg8SeNNa5gTxVJ++NOhKE
         /+9i1BrNTFaYYLLGLtMYNkJl2XFDE2T80jYT8pUbtBD1PmzP8WVUTRYI74U8as3Plfyz
         P4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681422009; x=1684014009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wjW+ICiBYhAXWT8jlIW5tMq7BAmws/agXTmM0sEf/A=;
        b=igAHEvue1pTCSTiUwjW+qTTTG8dwkxx9MlsNSF8rvgiveKuv/eFocpihvegXZaMe7u
         OzuBaG0nC0e8l5YcOQrNpAtqrAevw0J+8H0lQRhm7kdEqx1UsagAiwoVg6Y1u7uFH6a4
         /vMqZ919ORnYCLJNGW+dCiaUSMMur7wfEMTORyiUsASVEaog8qqVc9zzhOmU7pDsC6Ui
         mdHhfR6yksAw5V2rfCjJLQObgI7pPx5N1+akpM5bbMmlU2hLH/sNyMQdewg6U7Tr7Pb6
         EUt6N/QspAWc1pGyZVAhS1lEBmDpCWMccD5S+NzQ4DvbSZvluK1D0UI05zC0h0/ziWJL
         R6AQ==
X-Gm-Message-State: AAQBX9clzkka0JJgcnASEKs+JwcijSbJlKE+KjUTKdm0fWemKtyrHzas
        lwAI7NW1DT7UBmLZ5UAmfKqK3ZcK9aV5AA==
X-Google-Smtp-Source: AKy350aOiLag/vfqhyKPGQJ9LYBSgNYP3LzidL4WacrkS8SuTTCcTP/MCPMHZ8pRHrzM2qh9YbkSeQ==
X-Received: by 2002:a05:6a20:4a22:b0:d9:8b07:eb08 with SMTP id fr34-20020a056a204a2200b000d98b07eb08mr2644681pzb.21.1681422009186;
        Thu, 13 Apr 2023 14:40:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7880d000000b0063a0f06f1ffsm1809865pfo.122.2023.04.13.14.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 14:40:08 -0700 (PDT)
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
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH] serial: 8250: Add missing wakeup event reporting
Date:   Thu, 13 Apr 2023 14:39:54 -0700
Message-Id: <20230413213957.1985949-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
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

An 8250 UART configured as a wake-up source would not have reported
itself through sysfs as being the source of wake-up, correct that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
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

