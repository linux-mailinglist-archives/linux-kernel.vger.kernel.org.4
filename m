Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BF4626BE6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiKLVV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbiKLVVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:41 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C128315801;
        Sat, 12 Nov 2022 13:21:38 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id k4so5327058qkj.8;
        Sat, 12 Nov 2022 13:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffs7WthYcxxlp9KpB8gp7rdODwrO1odw2XTkcOVFYl0=;
        b=fu7M1MXORgQuaanuE/aWKr8EMJsr5jPdK4A9VgySyuFCJO9sus1ArdI+0pstFJuIUx
         /F87VjCTbqCD4c8EGTxzDnFvPRKFqOBY+v04r6u+K2K++MbayeZ0ecNf21RqnaJODqui
         SGwH98YVuq9LG8Q0jmuEwatdnHC9n+JmTfWWxeOo01Z8g3aPmOnET1AOFYzbMWkH5OS1
         2Rioc67FOg5aIpRARvQbWWPWyQA5ph3uD4a7cnKxZUbv/6QE+gVzkA6ZN7EqCt1v3oIy
         /4hK3F7ed/6eAC5L+Q0IadSDF4lCVEd4pOsFRtPW2OAobjrjwFPLem8te15I7vkebhUw
         nfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffs7WthYcxxlp9KpB8gp7rdODwrO1odw2XTkcOVFYl0=;
        b=5d3+hZtuVeLpXNv9Jn+MQeZekyvygDW5OWT4aSHfG9EacfJ19YUirrTfBtcrWd1VCg
         eOYMM0vMEkrA/0TBElHYSRfdPHRmyqKmpD/zsiTlVr1twCLSJJy4OUxTjklIz/OBb8Tx
         zo9d9+2VvM4h8IYifzTGbYg/tV80GdNHs33iwFVuUlkkEccuVcNxxz4gULWhwfrYeqSf
         cYkDKYxrtGAtOCCiS3QR4OuTVhRY/LWDv7+pBi+iaCsAK3Hy4eG4aIrwjNppmFRh/mVj
         CMVLHARRmIoxAw1cv8UBzN2PtIUHtO4xk4PVvTw1cgvZrNAlITNJm2UboyQ2qwvL00EH
         KlPg==
X-Gm-Message-State: ANoB5pnk6JP8RTt8noZSQ7QS7uaDWM8pD9wCBinCGicbh9cC5o2hzEtu
        u92U8Nb/ci5P2CvxVxkD+r6I1i1J/RJFuA==
X-Google-Smtp-Source: AA0mqf4qBL9Vzk4md+k5YMO8+Uv/GJn2OwiCn8KzO3ZC9M65uUOVgmJ1XZWJCF5Q3MqHLemOQRXGLA==
X-Received: by 2002:a05:620a:892:b0:6f9:60e1:bd7c with SMTP id b18-20020a05620a089200b006f960e1bd7cmr6128970qka.412.1668288097461;
        Sat, 12 Nov 2022 13:21:37 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:37 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 06/14] serial: liteuart: move tty_flip_buffer_push() out of rx loop
Date:   Sat, 12 Nov 2022 16:21:17 -0500
Message-Id: <20221112212125.448824-7-gsomlo@gmail.com>
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

Calling tty_flip_buffer_push() for each individual received character
is overkill. Move it out of the rx loop, and only call it once per
set of characters received together.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 047d5ad32e13..ff3486860989 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -86,10 +86,10 @@ static void liteuart_timer(struct timer_list *t)
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
 			uart_insert_char(port, status, 0, ch, flg);
-
-		tty_flip_buffer_push(&port->state->port);
 	}
 
+	tty_flip_buffer_push(&port->state->port);
+
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
 
-- 
2.37.3

