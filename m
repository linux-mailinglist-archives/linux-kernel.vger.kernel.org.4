Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8AB62F873
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbiKRO4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbiKROzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:54 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF81F4D5DF;
        Fri, 18 Nov 2022 06:55:29 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c15so3228730qtw.8;
        Fri, 18 Nov 2022 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0pSt1+sCUSY6i1VSOZXSpAW8agas2OEhVBqCQWzkeE=;
        b=R9Bgyj8bVN0gqArNwUY85N4usQBEGIvGapXuruakZ5sxlcrzsL8LSW/iWF+a/kfMco
         7F8NJrhdPoT7p7Huv6Aijfl//LqBc0FqFUUTTJc6eho51zd2AwDXax3SpJDBhcblSUr8
         tcOkTuJxhri/65tPWWHusz8nylYgEwAZ+jE0VvvW2zU4YNb6Psr3WEQ8Ybu4fw8Nen4P
         nsgj6V9iw80FMCX2CJZh6/d05R4t5IHJ9UtDDVrSWtDZjyjXqH6aC9VdT8KIPhnmoOky
         dgBouW0QdV2XWubg7D6IQYK1/nRe1q7KrXXvHSABmnRIwSW8RPbLX7/Ip4VolGu4liar
         Q8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0pSt1+sCUSY6i1VSOZXSpAW8agas2OEhVBqCQWzkeE=;
        b=lVqvvhJpxG582Jb537kXFWLmD0W/4WBoq2hRVfQcLf8vM8HTMuO1YoJLA4iqpi0rbw
         qy/Lx1gWrdmQSEBaj1AMzcMKGa9iLl8dJK854mQ/mjM3akH2kbIDA+NuIJwwT+Ez1XO9
         BEyV5Bl8bndhsh7ZJUSiEnKlThgZnj9bvrZJyACeHPWlmJxVh+iCAKYIXstUfO4NU2DW
         Bs2XNrT0UDne4rErOxBUinE0JQFtDBxNbIHwwsXu3F936RZ7WGswq65MMmY4gywe68+u
         jlzs8YMMGLRUrWWu3MS+P/PSaHJY/aoTHnjHXvna9e9KfN9zo6yqllTZC/c00It08rFI
         crqg==
X-Gm-Message-State: ANoB5pnnXiwbX1jtFxJVNKa8uySYIJ+6fH/7HgXf4qT2Ly0rP11SRqla
        l+YU4orNB+1xZgx8zECnV7b8K/t6RTLgxA==
X-Google-Smtp-Source: AA0mqf7tBvFUiniBYdY72rHRROD0khCO2CZZaeOol9ZbjMRxTU2begFqKFBbBpK/I1GQIDpxOqM5Zg==
X-Received: by 2002:a05:622a:4d94:b0:3a5:fb6c:d96a with SMTP id ff20-20020a05622a4d9400b003a5fb6cd96amr6939954qtb.185.1668783328614;
        Fri, 18 Nov 2022 06:55:28 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:28 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 07/14] serial: liteuart: rx loop should only ack rx events
Date:   Fri, 18 Nov 2022 09:55:05 -0500
Message-Id: <20221118145512.509950-8-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118145512.509950-1-gsomlo@gmail.com>
References: <20221118145512.509950-1-gsomlo@gmail.com>
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

While receiving characters, it is necessary to acknowledge each one
by writing to the EV_PENDING register's EV_RX bit. Ensure we do not
also gratuitously set the EV_TX bit in the process.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 81a86c5eb393..c90ab65fbdcf 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -82,7 +82,7 @@ static void liteuart_timer(struct timer_list *t)
 		port->icount.rx++;
 
 		/* necessary for RXEMPTY to refresh its value */
-		litex_write8(membase + OFF_EV_PENDING, EV_TX | EV_RX);
+		litex_write8(membase + OFF_EV_PENDING, EV_RX);
 
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
-- 
2.38.1

