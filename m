Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E85626BF0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiKLVWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiKLVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:47 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A7515738;
        Sat, 12 Nov 2022 13:21:41 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id e15so4887341qts.1;
        Sat, 12 Nov 2022 13:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7F9S0T1jHPDEpUbaqxSzeQEs/x70iRlU8Bxi6Hwul4=;
        b=M7PJUojqhBgBIoTiJebAXTjImoD1KkEFisgCsYlzPUNHuCQRlkjwR9stkG9PF7z0x/
         BZzqxU1PyElsSgNZpC+9oRV1gbQ/4Duo2N8VEEs8aD+rr3CjwB3d9OKRrfmoX7gZh6pe
         dZAG/kNmGWEYbtBjN9gHSwEviFgjbCHJHizx9XpyRWyT8yLDlDpCoVq6azmZcUY/nE+z
         hVSUA5ykZpvZ4FZZJ7+Qv5hLruFoE6NiqIEHxAct9r9hscqzri+4WDCrrcjgpt8KtHSW
         0fy/c/UYYrlXcqi9RsSuK2YpRLGMM2jXGNf03ZIcCY3x89HQBXB4QyJ7sb5vJtjrq7Kl
         hcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7F9S0T1jHPDEpUbaqxSzeQEs/x70iRlU8Bxi6Hwul4=;
        b=xV+hnMKd4iMm8ZhJHE7iFWOY/SL4DEFA+Ic0IJIzAbwDoEt6ylNgouDwG4sszt89oJ
         0IcFbJQBMph6gvMxp0NeOPtaDURyh2RhbDsJDWLFQycd8w4PRr6XM/bmv5kZNVximjrG
         BpZsw9pOJ+G7quV02eVNK4YC272JDyw93bN3qZHhR8p9GqWwIIYi6d7TvZgyFIigkkRE
         3SZYoqdgUeptwIbvDI6/RJcPyaHV7cEcJXGds7d3aRKanAoMl8MtZzJsmWYhyrjBd54O
         ExesEy+6NZfmu4mI8eRCRsBeaLLUCPJEIQeZnpHveXbzl4Dbes614B3d4n0XObxWqHMr
         IaCw==
X-Gm-Message-State: ANoB5pmFTX4YcweYKZKVQotjq53CLY6CrvannIMk6V52Qj9ob1MeYDzp
        xhXTnWirwgG9Oi+BWP8ccoS8tymzwulirQ==
X-Google-Smtp-Source: AA0mqf43IC6vi/w6Ldd2KMRXHNrZv5G/4wrr5jT0RwmAm99lfaLg8z5ejQAZqHR5ZPHhiZH1/pTjuw==
X-Received: by 2002:a05:622a:1714:b0:3a5:2029:df77 with SMTP id h20-20020a05622a171400b003a52029df77mr6659600qtk.225.1668288101159;
        Sat, 12 Nov 2022 13:21:41 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:40 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 10/14] serial: liteuart: separate rx loop from poll timer
Date:   Sat, 12 Nov 2022 16:21:21 -0500
Message-Id: <20221112212125.448824-11-gsomlo@gmail.com>
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

Convert the rx loop into its own dedicated function, and (for now)
call it from the poll timer. This is in preparation for adding irq
support to the receive path.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 974da0f73257..172ac190ba2f 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -67,10 +67,8 @@ static struct uart_driver liteuart_driver = {
 #endif
 };
 
-static void liteuart_timer(struct timer_list *t)
+static void liteuart_rx_chars(struct uart_port *port)
 {
-	struct liteuart_port *uart = from_timer(uart, t, timer);
-	struct uart_port *port = &uart->port;
 	unsigned char __iomem *membase = port->membase;
 	unsigned int status, ch;
 
@@ -87,6 +85,14 @@ static void liteuart_timer(struct timer_list *t)
 	}
 
 	tty_flip_buffer_push(&port->state->port);
+}
+
+static void liteuart_timer(struct timer_list *t)
+{
+	struct liteuart_port *uart = from_timer(uart, t, timer);
+	struct uart_port *port = &uart->port;
+
+	liteuart_rx_chars(port);
 
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
-- 
2.37.3

