Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E47626BEF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiKLVWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiKLVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:47 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541E16591;
        Sat, 12 Nov 2022 13:21:41 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x18so5339982qki.4;
        Sat, 12 Nov 2022 13:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/vT56mbrwM9r6/VHK5niKCx7aUlk+R45UC8FZrUKyA=;
        b=LRpW5kHwxusY1glBj850u+y7jQrP+SZ4AoSXheoTDc/JGlIHoxkT9bc9bSuF7S3jLG
         /Ki2s9AkagchVVQJKhqcLhqIJvS4JR2XP+ReMt6Bpb2zDphebqhcEJE28YAsy7+mzuzj
         xoE2gD6w9NnGjXVWDkiBH+SEhS1KKDzOi8btIjN/Wvu8HAewxJakolR80VC9wH9kINiu
         Y1i0J5D2pZ6aFQ40qaYrEidgql8uVwWmxBPfD9nETNI/gkeJLLw8ouXePznGbijjXwV4
         XFOV+sWwQhWcARjjRQsGclr8rtPhwofxeyX+486E/S337wFeDIEUwuQwVrvNRb7LjobI
         4rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/vT56mbrwM9r6/VHK5niKCx7aUlk+R45UC8FZrUKyA=;
        b=tno0HuZgkOUlrKmM18UVTRAzP1KtlZ/krUACK7wwJm3LsuMayshTT/A6VDN3cEpxJm
         JX03x14Ac5ETaPCY0Wkfi+eVbzOmNnB7bbuqIaM+2j4rfEdS3nv6ey2yJtJjQC/XGUvl
         HGvcvvDZir6KLtsckUXx+OXRFmvj9pqJIUsGhLfLSviZXEwA0N/gIU+D0EyRlmqpcjWc
         w6FxCFQ6djRHRo6PxZ2kyrG7DsHFMhQppcQ1t0VMvwxqg4aIxID2JjMoGsAAXle2JrCB
         0s434Lc1Pidat8iGr3l/k46+uqD69ZvS3IPiL/ld1FiqQPVeqzj0Aog6vZBLZNCnRkXi
         ue1w==
X-Gm-Message-State: ANoB5pnn0oj6GK98SKOx8GMavCiP4qXlzL+WezBwUmrjRLJ5QXzN4T22
        Q0jRMQx+xNIlU9V4MdsFJvA0S3c9ZakG1Q==
X-Google-Smtp-Source: AA0mqf4YaY9nZ6a3ag/GiPM1XvnCMeIf/MoycyD5j0uRqMGYw6uQhwWYdONqr7yCei+iuU7KszQ/3Q==
X-Received: by 2002:a05:620a:a15:b0:6fa:19c4:a6c7 with SMTP id i21-20020a05620a0a1500b006fa19c4a6c7mr6192955qka.51.1668288100251;
        Sat, 12 Nov 2022 13:21:40 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:39 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 09/14] serial: liteuart: fix rx loop variable types
Date:   Sat, 12 Nov 2022 16:21:20 -0500
Message-Id: <20221112212125.448824-10-gsomlo@gmail.com>
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

Update variable types to match the signature of uart_insert_char()
which consumes them.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index e9e99d6b5fef..974da0f73257 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -72,8 +72,7 @@ static void liteuart_timer(struct timer_list *t)
 	struct liteuart_port *uart = from_timer(uart, t, timer);
 	struct uart_port *port = &uart->port;
 	unsigned char __iomem *membase = port->membase;
-	int ch;
-	unsigned long status;
+	unsigned int status, ch;
 
 	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
 		ch = litex_read8(membase + OFF_RXTX);
-- 
2.37.3

