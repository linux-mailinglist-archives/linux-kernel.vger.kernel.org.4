Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D153626BF7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiKLVWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiKLVWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:22:01 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911C119013;
        Sat, 12 Nov 2022 13:21:45 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id e15so4887413qts.1;
        Sat, 12 Nov 2022 13:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NCT7lY3J4rHEmB/eCMozFwPMR+2ENWLul3W/EW/Ce8=;
        b=ibBpN+mSBrLOruOHKikiQOy1KhKqal2y5bUcjXK4ClO1BHI2gzyH4zxhWvr14HLmtj
         aVcfH3Qd6G27BpBpmWlIyzjJGeUZ5QabY+U/uyl/QrZpraxCO7yYR/1tRDYlK7YTnOx9
         AaEpn5kCukLOB3mJlw778PfWrLuvvIEHRjWvwbHHJuP/3KOf7rvS4e6gR58PlCX5tApD
         Mj2yTab+sc8N4mbgrCx8Q8pP9jteZ9U3DDcXgUBkJOUf7tqs6AWXx3Ljg7XQ6nHexUCB
         3kYXez+RbpGpEXrrPilWX6q0GGXwRxaeetxJZSmHh/BWV08BOTi26YYOSXKyT1fgCLOD
         d7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NCT7lY3J4rHEmB/eCMozFwPMR+2ENWLul3W/EW/Ce8=;
        b=ejdLDZgqZDSBch7ozxThNUlzg8G7Zm0m9DLBz04k/6UIhk0CDSTu88KQy1qACON5Oh
         P7AMFoSi4aljHPgMDBH5Qpc1uyEoHNAcjNbhNAVe0FVv9+Tqbvrzh9MD4GnvU6f9B9CD
         eDGxQZL15SPGGot3A9L1S6jgF1nO8Gosp66ULVmmGkNydw3eXpy7YQ+Kt15KPojrMJyn
         1KJxRdWGWPzhD/RyIjDacbeLn6AkPDIBYaYg3FFolE3cG4d8kqwShn5ikF1rZgfgR6WO
         W/V+0ja5YSY450tdNgjOer4abzjTgbxbUQnaQ5rFkyO14EPHps/bmDjHFyLWtyjK6klM
         1NVw==
X-Gm-Message-State: ANoB5pktSJIY2SfYAaYTHr/Bhi+UurH9/E1rfZ49fzRC9snfxO6A/oGN
        pSuTfD63HYmMp1u8UzXRxmLA++cbocos/w==
X-Google-Smtp-Source: AA0mqf4kGIjc6Cyy47M1gqYvdf3SoZIo7BjrXdBvoBI3boGlCxQookuql8wSIQfiQ5csBfaoARLkYQ==
X-Received: by 2002:a05:622a:1c0d:b0:3a5:21f0:39f0 with SMTP id bq13-20020a05622a1c0d00b003a521f039f0mr6848653qtb.10.1668288104961;
        Sat, 12 Nov 2022 13:21:44 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:44 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 14/14] serial: liteuart: move polling putchar() function
Date:   Sat, 12 Nov 2022 16:21:25 -0500
Message-Id: <20221112212125.448824-15-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221112212125.448824-1-gsomlo@gmail.com>
References: <20221112212125.448824-1-gsomlo@gmail.com>
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

The polling liteuart_putchar() function is only called from methods
conditionally enabled by CONFIG_SERIAL_LITEUART_CONSOLE. Move its
definition closer to the console code where it is dependent on the
same config option.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 307c27398e30..767c356e60c9 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -69,14 +69,6 @@ static struct uart_driver liteuart_driver = {
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
 static void liteuart_stop_tx(struct uart_port *port)
 {
 	if (port->irq) {
@@ -389,6 +381,14 @@ static struct platform_driver liteuart_platform_driver = {
 
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
2.37.3

