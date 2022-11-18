Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2962F890
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiKRO5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbiKRO4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:56:35 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42F7920A2;
        Fri, 18 Nov 2022 06:55:39 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a27so3225764qtw.10;
        Fri, 18 Nov 2022 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BliqB5y9lA08eGEUpUyNwFtHyZtVgSAM/9v6990Yi+I=;
        b=aJW4brjkSIkLfQZLvYXAq8qVsqz1uAFSncEJoomTSS2e/GovkwHLlDuuY0QR4ekMPM
         Y9iDI8US+1xSf3pdQktgzTovRTsLThmd2jYBO7lYVvXXn19Mp8/0M8VPpLFqZhssrlnO
         6/cikSGa1wcjc1AzxKMNQNLT+BPcOTi0LTL8gPJHGYBurBR9FMkJI4N4LFG8VK5ge25Q
         yweJ7ahBWsnSVtWJJ0lhdHHu+1UQuGRKMBerXyUUfhnNMxNcZB3T6sXcAfFofvXDz42A
         tKL0WgBai79Y+CcOFdqAVgpbre0beTTZxJ3uKeXOg6jVazATVvecZV0+2bfgCuOxa9/n
         PPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BliqB5y9lA08eGEUpUyNwFtHyZtVgSAM/9v6990Yi+I=;
        b=EKMkWRS3dcTgvnXZDnZ8hkyiVWUcw5o0+m6VE6kULC8yiMbpLdhM+MeIXNKhHk1YCG
         f4xk0SgZhGFgtUKh7goXUDzGRIEjppMMOshGapnKK1/KmmRA4luxgGvhXrR0mzTitYe8
         6drhQZLXCPFYrsiHbheTzTxwPc/Lgbapxk8h6b3U9s1i5WwcRo/ILUOGQvk8D0T19M3g
         CGsiIRQ+A6ErZ9CgbsxRW1AeNSiJWCT8cyPvWTrP71Z1DZg7Zihdk2TnXvw3bwMNX06p
         /+EPehxt0YXKobJUcfGHHa2Shdxv/PKw6Skk6tGe6kUmTOIpBEgOpmNx8E0Cfv+4Yb71
         T0kQ==
X-Gm-Message-State: ANoB5pnkiF8c3P1ZA7oaJyv/0/NIi8tJX0GYMGPVeW3rmKqGb0ZL55id
        qdFlEQm2Zq7o/9RcNHJH6yMpoNZq4u9dcA==
X-Google-Smtp-Source: AA0mqf4fmkewuIslqpZDLV4wd7h3yRE+aNyY9PZ9dB8Wr/YFaYHjyGcPq+Y2FETKWcmqJwOLVku/HA==
X-Received: by 2002:a05:622a:260d:b0:3a5:829a:7e92 with SMTP id ci13-20020a05622a260d00b003a5829a7e92mr6710164qtb.528.1668783338604;
        Fri, 18 Nov 2022 06:55:38 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:37 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 14/14] serial: liteuart: move polling putchar() function
Date:   Fri, 18 Nov 2022 09:55:12 -0500
Message-Id: <20221118145512.509950-15-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118145512.509950-1-gsomlo@gmail.com>
References: <20221118145512.509950-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The polling liteuart_putchar() function is only called from methods
conditionally enabled by CONFIG_SERIAL_LITEUART_CONSOLE. Move its
definition closer to the console code where it is dependent on the
same config option.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 850125870efb..47d12bb1b9e0 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -70,14 +70,6 @@ static struct uart_driver liteuart_driver = {
 #endif
 };
 
-static void liteuart_putchar(struct uart_port *port, unsigned char ch)
-{
-	while (litex_read8(port->membase + OFF_TXFULL))
-		cpu_relax();
-
-	litex_write8(port->membase + OFF_RXTX, ch);
-}
-
 static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
@@ -372,6 +364,14 @@ static struct platform_driver liteuart_platform_driver = {
 
 #ifdef CONFIG_SERIAL_LITEUART_CONSOLE
 
+static void liteuart_putchar(struct uart_port *port, unsigned char ch)
+{
+	while (litex_read8(port->membase + OFF_TXFULL))
+		cpu_relax();
+
+	litex_write8(port->membase + OFF_RXTX, ch);
+}
+
 static void liteuart_console_write(struct console *co, const char *s,
 	unsigned int count)
 {
-- 
2.38.1

