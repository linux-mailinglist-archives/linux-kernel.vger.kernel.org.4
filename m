Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B304B62F883
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbiKRO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbiKROzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:55 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE5F9039B;
        Fri, 18 Nov 2022 06:55:31 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z6so3234573qtv.5;
        Fri, 18 Nov 2022 06:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbM5jPqWMW+ZSl/JSR0+XTeoHUgjIND5CEiOvEuQtSk=;
        b=GO5XIRVY3x9RdL55NnA8PngWVaDXsqI9T1T/b11sfZgpJngu5v08iloaPW19QQeifV
         yxem8RM3oI0zCrOGX9rFOWu9Rw64mCx6XzV2hpXwuB/dNbm9JiaVlU/xIlXM0ldWMKpw
         eZCIG0JOBIx36PAdMVGBTvP9zNAUI8KevkTuedMV7aP1fJxZAxv4HSj/GnRyQfwSmVgi
         cQFaCgmqjNxRmOQXUXwJt7WGZNEtVDNa7/mDDwUKXfXsakhnEe631N8iVeBcUKHIX0K+
         QucWCFxoABT8BP1MXrZC1tZrM4Jlts9uCRGp+U1IFgpGduehWI7OElSTClEJOlVZUPE6
         lh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbM5jPqWMW+ZSl/JSR0+XTeoHUgjIND5CEiOvEuQtSk=;
        b=WUGgyzkP+tRuHaVHEKs8iom24OW+k4AemT2MAI6Rpd3PuMyeXnN49IXzFpJKZ/KGo0
         UlhdIeQz8bPZkNsSproZMPb/ok2Xjx+IFL/LfgsKU8NN1GaAV/TSsMuEYSnH8aUDplo0
         XXNTe5+w7fULpfxmiPKzhiNEZstUYlqsOftNAdrOZSGGnwMgP4GqC/X3Nfvx+vjTCNoC
         TUEETtqx43KGLXvbaDbHKWx/vbvfd9FQCvyj1QRbvVEOTUe7MIasxM7mJAO9cel4y2gK
         /RpqUjSQLXRYniNU7nPz095eMid6NPM3W0pk7etuOKzPpNVCpNk4faeOjiAD2V/prujq
         +tAA==
X-Gm-Message-State: ANoB5pkufEEhBnhbAiZTqjbyUVMIrs3xNRUVeBfNGupQGEFPRIN2qGyr
        9f378oGhIXcAe4P1Ph6FCwEz2r/vUOZl6g==
X-Google-Smtp-Source: AA0mqf6qFHB/S0QNgRixez0SkUNC7WBwWxkKrFo5b2ojSC0K9hwGP84M6zKK6LcqZBliWkhsHq9L2w==
X-Received: by 2002:ac8:43ca:0:b0:3a5:4c53:8923 with SMTP id w10-20020ac843ca000000b003a54c538923mr6891308qtn.267.1668783330005;
        Fri, 18 Nov 2022 06:55:30 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:29 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 08/14] serial: liteuart: simplify passing of uart_insert_char() flag
Date:   Fri, 18 Nov 2022 09:55:06 -0500
Message-Id: <20221118145512.509950-9-gsomlo@gmail.com>
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

Simply provide the hard-coded TTY_NORMAL flag to uart_insert_char()
directly -- no need to dedicate a variable for that exclusive purpose.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index c90ab65fbdcf..81aa7c1da73c 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -73,7 +73,6 @@ static void liteuart_timer(struct timer_list *t)
 	struct liteuart_port *uart = from_timer(uart, t, timer);
 	struct uart_port *port = &uart->port;
 	unsigned char __iomem *membase = port->membase;
-	unsigned int flg = TTY_NORMAL;
 	int ch;
 	unsigned long status;
 
@@ -86,7 +85,7 @@ static void liteuart_timer(struct timer_list *t)
 
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
-			uart_insert_char(port, status, 0, ch, flg);
+			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
 	}
 
 	tty_flip_buffer_push(&port->state->port);
-- 
2.38.1

