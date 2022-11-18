Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8397F62F85B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbiKROzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiKROzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:24 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FE122B2D;
        Fri, 18 Nov 2022 06:55:22 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id j6so3456380qvn.12;
        Fri, 18 Nov 2022 06:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsrpgSLIetjSSjQsdPnxAm+guc7zGDde8lk1A/5OW7U=;
        b=JxbL2TO9MYg3jHvTXDWDKZM08/lu66n2AgnhlFtglU5DcxT8ymqJcGGSvjqLdBjl8L
         Hr0YNz8ivgAMv5S25GF7nZQOtvLm5yBH3YKTpDyZNtrst/pBcddc9CinYVsW6OAug8BL
         gMjVGZvWWlFhdTkqoyAdbV51oTYLYIJLRocAR1h3lpt0KuCYo4oVLm7bA5pGFvGaw2Oi
         lBy/AAvoSKP8m1VQeiXo3Byd8YOmM+TUrxqbRnVYBCSDi/SwnSACj5+YTVWhS0ubI2ux
         ZoTxDq3+eqeGwv/3W+Juq7JSk+eAuSlUXmNp9KggugeOdoGD7Re/rsO7y8BWCinLmR1v
         FRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsrpgSLIetjSSjQsdPnxAm+guc7zGDde8lk1A/5OW7U=;
        b=zE74yWO2wLTPkAUr0v9Hb4ZVt+oUCrwCyVJHf8JaHa1hSklsOjSsI7wujTuuCzCfOO
         uqj6C5ZO2h3Gsge0S9nxpOsr1JGgVZ+8a4dqj1BM28Ny0cRnQ+gt4bfIreinn/txFJal
         4Z/60C9DbTT09RQ+7rbmOWUjk0Z6qymSmrTWQnwM1euJdp/xEMFEpqjxzpY555YgWqn1
         5B1xna/eI6PIyy85Tz416ZXG5Fe7jL+sy/Go1F+ECQ0cl1hd6KuV9WQSm4UZMORSA1v0
         bwTQ90O1i4bRh89w10YU0G5KI7N1JussibSD70nDPbnryw43jA71Gf9i70ZDDxdisuyP
         svnQ==
X-Gm-Message-State: ANoB5pngjii2rXFT3x3FwTfePwhVUDwLe5dMSrbLl6zBcSaGv0DBSBR0
        sFlSGpKaMPU2LNJG7PAcanDAIoSBRGVZZw==
X-Google-Smtp-Source: AA0mqf7jJDPXK7d3O7cddfJBUlp5P0XVwy2XhV2fvw1NwkYu0kFJ5Hm8uX3BpcnHNx9jkqJmmsWCRg==
X-Received: by 2002:a0c:e90a:0:b0:4b4:8037:1303 with SMTP id a10-20020a0ce90a000000b004b480371303mr7046931qvo.16.1668783321015;
        Fri, 18 Nov 2022 06:55:21 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:20 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 01/14] serial: liteuart: use KBUILD_MODNAME as driver name
Date:   Fri, 18 Nov 2022 09:54:59 -0500
Message-Id: <20221118145512.509950-2-gsomlo@gmail.com>
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

Replace hard-coded instances of "liteuart" with KBUILD_MODNAME.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
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

