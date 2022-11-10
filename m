Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BE962384C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiKJApH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiKJApC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:45:02 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A819210B4B;
        Wed,  9 Nov 2022 16:45:01 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id u7so408116qvn.13;
        Wed, 09 Nov 2022 16:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQFfyExI23+erN827zqnus+ZsfTP6ThOACFwJyPon2s=;
        b=SNYDT/SMvRejywXSJ+dWJo3s/8vCoANtLeDa+6OQcWqhZi1Kx5sbK/a5LZkBm25UQE
         KVLQ4gxfOgmjYbr0xkDZX8CVB4DR4uPV5OuqDcRNRcuZnH6EUTYCpqqCU0VDZFhnDpoQ
         246T7+gVZx8TFnIlo9V/v2pOMiJqgCSnalSeq9zMwZyknIcWz1RA71+uOlPgH2ggHjKc
         qWf59WQRQeWFl+y6ik1M2CMd+WQEWm7GEGwnSyqZkZW8ElZTLMFHXPv8Ia/2jJzo/d0t
         TDV42PmGbsn5C4mVHq9zVKHKcVLTUu8FtMOYnEuz9H9xS1lODgDuV1nXx+7DuNDGsZTA
         gJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQFfyExI23+erN827zqnus+ZsfTP6ThOACFwJyPon2s=;
        b=Cu8VRwfONfDvGnsDSXpN0+yz0wbrfiUKhm4PMQ51BiPpoOK+ztCkKSDmnISAX4gXOa
         k5XaXW3t77uuvR2kLJxjbm5lfwx8CCtlfPN9UnTLM/3iip+c4onnnGogpZHRj8h/jXNK
         NeWqNz8tpW6/aB9XaU1qRqxHimEGXw9sqs5oeopED8jnp4vVP7gG9vfBh4cpr1Ce0z6U
         jeGkHZJTmC8ZF0MsM1h6s/e+BDNHugCFxQ6+NnzRWaI/VYT978PlHHF6QS86F3UgMaMq
         J1G/7ZRgwtOtw6mERyS+eHpXbeeNpweq0XRlbT7L2VfXy1jPwqN1ibuiSrRwTMgTdkRG
         HlMg==
X-Gm-Message-State: ACrzQf230rozK0AGCW7y3Bs/+F8pj7uQSoj1vtdrN8bfRuNlszV5V0A7
        PWHKu1xIfpleC8Cxv28sBcRlgUb6FVlBVQ==
X-Google-Smtp-Source: AMsMyM4kjEnIc6J+mSVI8wjSpmopwyPwJs7mTig0oZLpwj+yhHI+XMdvv7L49yVpPh2C3lyANAcfMQ==
X-Received: by 2002:a05:6214:37c5:b0:4bb:bf0e:ca65 with SMTP id nj5-20020a05621437c500b004bbbf0eca65mr57881922qvb.17.1668041100536;
        Wed, 09 Nov 2022 16:45:00 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a12a100b006eeb3165565sm11678506qki.80.2022.11.09.16.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:45:00 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v2 1/7] serial: liteuart: use KBUILD_MODNAME as driver name
Date:   Wed,  9 Nov 2022 19:44:44 -0500
Message-Id: <20221110004450.772768-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110004450.772768-1-gsomlo@gmail.com>
References: <20221110004450.772768-1-gsomlo@gmail.com>
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

