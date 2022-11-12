Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72A8626BDE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiKLVVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbiKLVVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:34 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BB815805;
        Sat, 12 Nov 2022 13:21:33 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g10so5333772qkl.6;
        Sat, 12 Nov 2022 13:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQFfyExI23+erN827zqnus+ZsfTP6ThOACFwJyPon2s=;
        b=UCtUwLwVmjQTkvMKmyJiNoDcBXr9dYQHOD9QEoW9/jb3JDLVq81xuclgbQVti+hvhH
         A6omZZIxoEmUd+vrSCcsIfjfjlhVgV2sj5hc/ZeGSFizKmhwwzDBEPha6gdjYtQDFUgZ
         KYFQQCsyTJLuOZ3ixLkxCYzsnJN5rrzm+wAqzyXGj98vJKSyP0ISuzl3G2S9G8JNuinw
         XELTeQDb5/GlzSmIjQMjXpFocijdOmvBS7jFtyHwpFl/PLLSqQLJFbWeyK+xPCND2n/X
         Yw8tpDdRaL/Kx6Cb9ZUVPZQ2Jtbtlx5nAvIbcApBZ7jPaz8MYcCSbVnZa6JI41ZpOg1S
         eikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQFfyExI23+erN827zqnus+ZsfTP6ThOACFwJyPon2s=;
        b=d4+iZ61ZdXMH8t9YrXYgAyHMT+9IrBRcYhsrKpvp+AMxstA36UsS9tDZTdPQ7AEwi5
         E1X+/Am7TJvtyqrkZzM5WBkowp2SFqBFm5/Byluw/jLZTFtax/Era2eelcko1rdOx7qn
         6+Y1f88EEtUWL3jbDqadYjZzo+6iay/fTlfiWaz/Q/0Z/7x8sVD3duc5Ch2CBGo6hMnl
         rfX7GvPndjhPhmQVCek5itG8S8sR3uLzrAdcZjLnPb6IqBxb8XJHAw+LfNJBwcfHlzTM
         3lnMnW1LJDo3qetGPv4cKJYrmQUvW1vHFr8F51jTJWLozTQHLWijgMLG8VWvL1SnHYkY
         pSmA==
X-Gm-Message-State: ANoB5pnWP7RRnj1FIXMhhuQm3/K7vy3aCZFWMo3bJLkYCaeMWJr9KI3l
        oifXoHYtCXxghcyBX2Oe/B1w7GYcLgYxLg==
X-Google-Smtp-Source: AA0mqf5mIDwSQg434DYAbJrxqAJx+WwbbWg4rmtusH7B3nDTOX2gzQhIAcSpCehsoG7JrKwtVOvqUg==
X-Received: by 2002:a37:54c3:0:b0:6fa:4749:cbe3 with SMTP id i186-20020a3754c3000000b006fa4749cbe3mr6106929qkb.171.1668288092320;
        Sat, 12 Nov 2022 13:21:32 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:31 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 01/14] serial: liteuart: use KBUILD_MODNAME as driver name
Date:   Sat, 12 Nov 2022 16:21:12 -0500
Message-Id: <20221112212125.448824-2-gsomlo@gmail.com>
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

Replace hard-coded instances of "liteuart" with KBUILD_MODNAME.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 4c0604325ee9..32b81bd03d0c 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -57,7 +57,7 @@ static struct console liteuart_console;
 
 static struct uart_driver liteuart_driver = {
 	.owner = THIS_MODULE,
-	.driver_name = "liteuart",
+	.driver_name = KBUILD_MODNAME,
 	.dev_name = "ttyLXU",
 	.major = 0,
 	.minor = 0,
@@ -322,7 +322,7 @@ static struct platform_driver liteuart_platform_driver = {
 	.probe = liteuart_probe,
 	.remove = liteuart_remove,
 	.driver = {
-		.name = "liteuart",
+		.name = KBUILD_MODNAME,
 		.of_match_table = liteuart_of_match,
 	},
 };
@@ -368,7 +368,7 @@ static int liteuart_console_setup(struct console *co, char *options)
 }
 
 static struct console liteuart_console = {
-	.name = "liteuart",
+	.name = KBUILD_MODNAME,
 	.write = liteuart_console_write,
 	.device = uart_console_device,
 	.setup = liteuart_console_setup,
-- 
2.37.3

