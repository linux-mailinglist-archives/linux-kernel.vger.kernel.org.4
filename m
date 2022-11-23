Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70A7635F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiKWNZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiKWNYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:25 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A8742CA;
        Wed, 23 Nov 2022 05:05:10 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l15so11135793qtv.4;
        Wed, 23 Nov 2022 05:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT54MJUH8hXwVTeBLM7UDa2q//81cRvBtk4+Tr+w4wU=;
        b=OrS640M1kZVAfPr1Tkxs7MkXbXxZBpyfICSz8cyGXbu5hKVFm4jqALHrRPoYSu1mDb
         Pe+XxNe/jnB/XWJoNcz0Nvw7R5gvvexqhR/rmIRQTZY7abIs4/BgIuCZXaJqJVhBExmi
         NY/qW0fXWszaXTZ089EkolGhWVoXrh18DoSLU/tRwJS2mLLH+9b90/hBXkr3KtQpFg63
         yutEfY4IZk0TJg7ODdndUaTGStYYy+g/epDl2E6kNnrNbYIOzO5TrmJxNX+y5/TQTxRc
         hjg3aUEbXw/HehYwvnajoBhvAYukj0zVORnHtSsUm+FF+XwnCSf3vAmwMrcZZI72MJEV
         BnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yT54MJUH8hXwVTeBLM7UDa2q//81cRvBtk4+Tr+w4wU=;
        b=zX8aqV6V98MZ5KVbehrsJiyyB8OgfiWuUBW7bNeopO+ANPuf4UQ6OR4Og52f6PEzXL
         68jQzMDaz7w1HDe4Bt/OJRd1ABCZdxbcfXekDenORAqR6SFWigK/fJYoBDNyQkCh247X
         tghjmIOTe/WkeiNcluI/RswrmEqw27dAnA37xirCNAgzgW6nfId2FQeX8E2dS4BjrOFJ
         GRusHdfaDtTVQnn4ZYCyoQVm9B30u56rQJMxSgG3pDW7Yl36D+yJgHmmzcFMMr5c4G14
         ODZTowvWePvSTermfItmCXMTdcV8h5WZa7zICSmCbH0f8twve0pNvSGE2YE1uBnei2wZ
         9S6g==
X-Gm-Message-State: ANoB5pmMlvcIe+mtome+lQGVwhKPsWSuoTtnSe4grO1Dg45DgA88scKq
        4CKZSHE+MajLW96nOt9MquIrVs7fJ6njrw==
X-Google-Smtp-Source: AA0mqf6pLiwCCpkEiKr8jlCwnBC9uwE0eCQOg6ibYFpJVsN56xL9dT7FT/2awtdO0/Jw6pRwQgY+hg==
X-Received: by 2002:ac8:4e47:0:b0:3a5:c306:324 with SMTP id e7-20020ac84e47000000b003a5c3060324mr10053895qtw.116.1669208708590;
        Wed, 23 Nov 2022 05:05:08 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:07 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 01/14] serial: liteuart: use KBUILD_MODNAME as driver name
Date:   Wed, 23 Nov 2022 08:04:47 -0500
Message-Id: <20221123130500.1030189-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123130500.1030189-1-gsomlo@gmail.com>
References: <20221123130500.1030189-1-gsomlo@gmail.com>
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
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/liteuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 062812fe1b09..db898751ffe3 100644
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
@@ -321,7 +321,7 @@ static struct platform_driver liteuart_platform_driver = {
 	.probe = liteuart_probe,
 	.remove = liteuart_remove,
 	.driver = {
-		.name = "liteuart",
+		.name = KBUILD_MODNAME,
 		.of_match_table = liteuart_of_match,
 	},
 };
@@ -367,7 +367,7 @@ static int liteuart_console_setup(struct console *co, char *options)
 }
 
 static struct console liteuart_console = {
-	.name = "liteuart",
+	.name = KBUILD_MODNAME,
 	.write = liteuart_console_write,
 	.device = uart_console_device,
 	.setup = liteuart_console_setup,
-- 
2.38.1

