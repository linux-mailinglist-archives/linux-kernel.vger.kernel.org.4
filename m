Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B45626BED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiKLVWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiKLVVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:41 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4115A36;
        Sat, 12 Nov 2022 13:21:40 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id d7so2946169qkk.3;
        Sat, 12 Nov 2022 13:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysSI5FqkSkAdCqfOrlzY0olMSzKAxmyo3p2qEMQhEV8=;
        b=ZeyUCP31FCfmExvkf6Z0PI3w/Y3U89wZ6yeeShdpc9LKg74ByWcgDc6K2MlMp+L3vp
         aBgE7tlx/NrajJNENJ9ZTtfQ10AICFYsDmvDmhMx/P991C/a+GfbpSWFs3/GGTXPzaja
         GVTA5/NjS8EbKhFKOR9T6LQXFaMpgcY/5uY5a5xC/jVJTLHlublOHO77C0L47/GPoIlX
         OIe4k0j/iqWSv7jPkEoTUu8nfuhrhGaJJaN8GWQV9SzWP0bISpZjZmNw6ropLOkOQd27
         oG8ZNmZ5eki4OWdErFlGDEXGg25/AW8fzcFHwZYehthrg2ZWjMwZB8AN305JrfodBWX5
         uZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysSI5FqkSkAdCqfOrlzY0olMSzKAxmyo3p2qEMQhEV8=;
        b=NFx3Q8hRDD7WAItUEaY0zPwq8uc6LQVMz5XyilYCTkajX7aF8NvdFvFun0tRGamEHi
         PH3+C0NTQ2UsUSn2YXA4chMi0nh5KQ0Iktp0vc4A14NxIFw1eDTKsyBST0YFRcqo0bVD
         9ZCqW7GEUapDR0QKa+UTUgtt0nl4E/MrmKCKJ15YDzq22za17xHGbZxx8uppqrzA5kyJ
         6Tq3AzkT5/4HyisM5GcZb+zhj0ZIzB5GmoKjYVbVybPR6H1Q7wovQgYP5HHBpDYV9RE2
         6w/dQ8OyZrKKo6iIJ4MIUETVxnaUQXKHah07Uwmwm3iMtlaw8P5x7N1NwlYNQGUQn5so
         y6+A==
X-Gm-Message-State: ANoB5pmz9yW7qFb69i0MrnyYkAcxwVVXhcqVjsFtwzfJWENGOjY55Pot
        5OYOqOrwCGmc1lDYkXZNCCDkIqseI1VLTQ==
X-Google-Smtp-Source: AA0mqf72dmQ34/r2PT7PVsQdiLQttJYIn7qr+jCqsdUHzdd5vAjMZom7J6AkmdwZFn0vjw5wbj39uQ==
X-Received: by 2002:a05:620a:179f:b0:6fa:3f37:5af with SMTP id ay31-20020a05620a179f00b006fa3f3705afmr6091048qkb.572.1668288099339;
        Sat, 12 Nov 2022 13:21:39 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:39 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 08/14] serial: liteuart: simplify passing of uart_insert_char() flag
Date:   Sat, 12 Nov 2022 16:21:19 -0500
Message-Id: <20221112212125.448824-9-gsomlo@gmail.com>
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

Simply provide the hard-coded TTY_NORMAL flag to uart_insert_char()
directly -- no need to dedicate a variable for that exclusive purpose.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index b5ab48aa35cf..e9e99d6b5fef 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -72,7 +72,6 @@ static void liteuart_timer(struct timer_list *t)
 	struct liteuart_port *uart = from_timer(uart, t, timer);
 	struct uart_port *port = &uart->port;
 	unsigned char __iomem *membase = port->membase;
-	unsigned int flg = TTY_NORMAL;
 	int ch;
 	unsigned long status;
 
@@ -85,7 +84,7 @@ static void liteuart_timer(struct timer_list *t)
 
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
-			uart_insert_char(port, status, 0, ch, flg);
+			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
 	}
 
 	tty_flip_buffer_push(&port->state->port);
-- 
2.37.3

