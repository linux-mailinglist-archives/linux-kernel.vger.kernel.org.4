Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB6635F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiKWNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiKWNYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:30 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12472108;
        Wed, 23 Nov 2022 05:05:17 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id fz10so11143739qtb.3;
        Wed, 23 Nov 2022 05:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1Tl0HGYmBQgunxqIx5qBf7AmLCZ0WuUkgihwlDEofA=;
        b=D4BkXz76qCExjjZYdj2ikQCU5ZuLT8HL2oP+1XE5XFphzoMUfFrkDWxKQ1s9mRcFVi
         RHAjr87y2Q8wjWdqSGE4dmx1Ll9WhwUAFXJmyaVwswgxHclpX00FooVPY+IUilw/hTx4
         8rN78ufFPPyTYtKtylmEMCcDNJ0qr46MVOA8qQwXj/ry3n0w9waTeo0Y8wwlmf4WXzyi
         ymrppKDFftCOVFHopIjmNwq5N53HiG0wD/5IObt6XpG6u8y53zEO+GeKhqLOrNIRBuva
         EaQMpRi7NUsbYO1unenkuicewhOZ5w7uOuc5i0HcNZ/thKCdU0xeGAfTOFYB803B/1bH
         GcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1Tl0HGYmBQgunxqIx5qBf7AmLCZ0WuUkgihwlDEofA=;
        b=GSu7bRtZI6QJdLaU0cwBoL/94atk3DQddRZSLLzG3k4crBVU4GLX3UFldYWoh7vKzE
         C4NlDKnWPcDNFmcj4+jXPgI0d0cUGzJvvtZszGLyV11MZl1XW7fYtYnnVjyvntvYEzTa
         SvdcicH/Dn42w3Ns2cSW+XmpBYfWVKM8V8rKaeSDIVhWZrPUmqYzlwdXOZZmX9Za5KpJ
         eyUud8PHSKW0bc97f+f+HsBIcN0EnXlackETCJUki308kwy8VPP9rZpiG89Gis6De83Y
         aoySO0gZeCmPopeMrKraL8SeoDDxNBS3SM03B9bZdIomH9rA7NUu7pds5qaxvFBHVTDo
         J8bQ==
X-Gm-Message-State: ANoB5pmkPQnhMm1n9HOatVNuzsXnRF27Jmvy8bsxkMzb+1NPIj/+rZ0X
        EMRR7xi+H6KwPHhcqXouMGotAnblocH0ag==
X-Google-Smtp-Source: AA0mqf403sy2smtjSXqo4YbW+70Uxwg/WEbeTXEDTmS+fpDrX/APNzTByfBTSuwaf1sEMSrSS2cwzQ==
X-Received: by 2002:ac8:4745:0:b0:35c:ecf9:dd49 with SMTP id k5-20020ac84745000000b0035cecf9dd49mr8381530qtp.333.1669208716545;
        Wed, 23 Nov 2022 05:05:16 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:16 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 08/14] serial: liteuart: simplify passing of uart_insert_char() flag
Date:   Wed, 23 Nov 2022 08:04:54 -0500
Message-Id: <20221123130500.1030189-9-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123130500.1030189-1-gsomlo@gmail.com>
References: <20221123130500.1030189-1-gsomlo@gmail.com>
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
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
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

