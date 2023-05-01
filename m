Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07536F2F00
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 09:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjEAHJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 03:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjEAHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 03:09:21 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555A6E73;
        Mon,  1 May 2023 00:09:20 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-24782fdb652so1481380a91.3;
        Mon, 01 May 2023 00:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682924960; x=1685516960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oXzCHkPVzfdyNI8ZpISMiW3mCklkBJxfojR5sxAR7M=;
        b=LttXlsl/I/+AbsXyE7PU+SjQyHK3M3JOsUPlj34Kxbf1yUDcqVoompubFz+xejFq1O
         ZA0hcLSnzBprSNa64XBHOyvTJbCBANPXa2XjKEWM3PraN9GnjppN0c5RTxkLaTUXRDuV
         EgfoxZ9mwrAWT1n6VhVPHbLyrD6mGjJl1K48Z7X29K61yE7jsSu48D5qfbxgSDhkWWIr
         F2NX78prbWez/t49h73wX0TZcQNB3YKjUr604n71JVFBBUcMV/KT2g0w7ltkpVpNXplU
         QCSS0C7PwhcLFw5f+i6QbaPSebHeKY6WMpQuvOkac1EqPojIS2qnR0W4x/LYL7+aGtUq
         0mvA==
X-Gm-Message-State: AC+VfDwFa8u1jdeepNmGJcnOuq3Gh/QZUdOdrDKZd3y0o5XIPlr7dgFo
        6buSxsBI6JA62vglM1cfeLY=
X-Google-Smtp-Source: ACHHUZ6wKFrE1oYQ4GnWrOD+A6I5OlR0cqVC13ZUyQKKNXxSj+DcMgEUDQE/PxRHcCpvJiWLGfpScg==
X-Received: by 2002:a17:90b:f98:b0:246:9932:18a2 with SMTP id ft24-20020a17090b0f9800b00246993218a2mr13203123pjb.31.1682924959595;
        Mon, 01 May 2023 00:09:19 -0700 (PDT)
Received: from localhost ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id ls17-20020a17090b351100b0023a9564763bsm18590746pjb.29.2023.05.01.00.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 00:09:18 -0700 (PDT)
From:   Hongyu Xie <xiehongyu1@kylinos.cn>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH -next] serial: pl011: set UART011_CR_RXE in pl011_set_termios after port shutdown
Date:   Mon,  1 May 2023 15:09:09 +0800
Message-Id: <20230501070909.1144547-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART011_CR_RXE is set in pl011_startup() during normal initialization, and
cleared by pl011_disable_uart() during port shutdown.

You can use a none-console port in poll mode like kgdboc does with
tty_find_polling_driver() after a port shutdown. But pl011_startup() is not
called in tty_find_polling_driver(). So you need to set UART011_CR_RXE to
reenable receive function.

Not sure setting UART011_CR_RXE in pl011_set_termios() is a good idea
through.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/tty/serial/amba-pl011.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d8c2f3455eeb..c5c3f4674459 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2166,6 +2166,13 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * ----------^----------^----------^----------^-----
 	 */
 	pl011_write_lcr_h(uap, lcr_h);
+
+	/*
+	 * Receive was disabled by pl011_disable_uart during shutdown.
+	 * Need to reenable receive if you need to use a tty_driver
+	 * returns from tty_find_polling_driver() after a port shutdown.
+	 */
+	old_cr |= UART011_CR_RXE;
 	pl011_write(old_cr, uap, REG_CR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
2.34.1

