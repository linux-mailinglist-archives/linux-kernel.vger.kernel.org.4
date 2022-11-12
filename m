Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82740626BE4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiKLVVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiKLVVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:37 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1896E15805;
        Sat, 12 Nov 2022 13:21:36 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id h10so5668091qvq.7;
        Sat, 12 Nov 2022 13:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WawqzZk7R2Fk2wsVcJJHQ6DiWGY8oW1x9eP6skVjzc=;
        b=erGeth7XdHfXrFpCTX/lYo73hGW1D0dqNev6FMVSG8CXXdRMZY3tyotII4xjilTBnY
         DUwUs6FCzhgnK/+2inHdJR4d5Fqr0tzu+z0KP4/OfNsMpduXbPI+5LsCmgi/R884m74x
         ktisuAj80uxFVLsCExMjSCtXIYOR3B9gwTWRBGQL8Wu3KNsutn9jKvV5OBHA2khtu1zd
         ZhLbcrELCGQSBxlQcAaDqcHtUrgFoRgKj7KH0j6n/3HseYf2xcqsVBjCUS2KlgruBQto
         eeXACw+hW92+l04OVRSlsE1cd0D+9YuAIUj1eKSQAKNzCGX0nXRtkC+JJJhzriIZgfvI
         QkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WawqzZk7R2Fk2wsVcJJHQ6DiWGY8oW1x9eP6skVjzc=;
        b=Mk+aDpZX2sB483Z7XacpiVTBvKsay5cuv9RmzuBitr5HPeOwUDggKlNZON20n0pMs7
         JrR/3ku7oXMZAHkhAPSTS2yKaA5isqnGmF7f7lYKSJOm1MuduXcgPIldU6C/W7B6Ppek
         cjnuC0J54r0npiljrljRrCHE1DkPmqSM8Kgf3yJsY1j0eA5S6bnt95zC9MJBfSJVK9Wn
         ajaj8bSucmNWz5gpTjgJCC/x/E1DtzcAfNM3c5VqhVk4OVAbW4vVzNktUFywLYsDLGg/
         klhT6DKWgoomw9qRVkAadxbPVIy7nDYRw+Bf08UHtNHoAR1ZZpSY2Zjcx9B8y4LNhO83
         KBuw==
X-Gm-Message-State: ANoB5pkzapBo7WYQ+hWNHd9ec9JibjkJhBhHWyQbSVOTof/WiHlE+W0G
        tyAuDsF8Ie+s7GkQzrlIeKDMD0hSZaUD6w==
X-Google-Smtp-Source: AA0mqf7Pkj08SSSJd6Z6HZd8iDuwDEZjc08P8XHOy/so1Qh0m/rm9iPzJHBVOd+8RwstHE1QrdfIbQ==
X-Received: by 2002:a0c:f951:0:b0:4bb:b2b1:c10f with SMTP id i17-20020a0cf951000000b004bbb2b1c10fmr7204628qvo.64.1668288095476;
        Sat, 12 Nov 2022 13:21:35 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:35 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 04/14] serial: liteuart: don't set unused port fields
Date:   Sat, 12 Nov 2022 16:21:15 -0500
Message-Id: <20221112212125.448824-5-gsomlo@gmail.com>
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

Remove regshift and iobase port fields, since they are unused
by the driver.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 90f6280c5452..5b684fd198b7 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -264,9 +264,7 @@ static int liteuart_probe(struct platform_device *pdev)
 	port->iotype = UPIO_MEM;
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->ops = &liteuart_ops;
-	port->regshift = 2;
 	port->fifosize = 16;
-	port->iobase = 1;
 	port->type = PORT_UNKNOWN;
 	port->line = dev_id;
 	spin_lock_init(&port->lock);
-- 
2.37.3

