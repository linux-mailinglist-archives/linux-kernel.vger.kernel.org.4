Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E04623855
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiKJApU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiKJApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:45:06 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD0310B68;
        Wed,  9 Nov 2022 16:45:04 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id g10so295278qkl.6;
        Wed, 09 Nov 2022 16:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WawqzZk7R2Fk2wsVcJJHQ6DiWGY8oW1x9eP6skVjzc=;
        b=BouGuuFJgYKQlwMFnLgGAomksp6JBXvMmPKLTxSZ4G+wA3ulfHAPluhAeShcJ1lOp3
         Sr2sZnNvNVX6XYeSEzxSpYNap/O2tMf/fJRnhmKTI0OWk1M+jvCYdbxEIwTCG7Jhlwdc
         vXFE/Z+vKHdgInLez+Io5DllqAz0hwdb799amr/myCmGoKsFJW00gNClTvumZrI+lh5k
         WvKMoLXpGBHR83oIF4lXM3W2xAAOAR7Mj/GLWKNUxT/2XcoXqKyaxHWyYpEIkwQ2aJVN
         7UN1dwNzmIyQpCqBy9x6KTzU+OQOwD94cGF81nhjI8adYczgVTYWshljVGCsEJF79ZJO
         9FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WawqzZk7R2Fk2wsVcJJHQ6DiWGY8oW1x9eP6skVjzc=;
        b=bQdzd7XbDzlCatWIT/BPjspo7DTUs2Or7EciUAlXdNP6tNwH7B14mx7utbr56OCpHF
         FvnWFEc3K2Y2xWVe2ed5Cd8TJRnUGC9Eo+cTRH6vvSd7Pws82pgTBLKPbxeyHEAu+ajS
         uceMXl+ZNz9sxrK7o9xnb4kZ9/p8bNJ+5TmbH9YwM4wnj1uN8Y9JoIlK0DqkRmMLt5lp
         RTlWqeySF5wlUgJyk2lPwsqa+HX2CDWsnbg+eRGfll3/NM3ABJA7fNZwN85Tzb7Xppw9
         jmLZ4KEgrhI7VQbmzaEjsS5cWHpcNkSxyiWlGby3xcJ5asWSx1EITLn5Pa9OIwsu1OOc
         HZXQ==
X-Gm-Message-State: ACrzQf00zlz94FaPQTjooie8VfnmcpWrIUwcPow/wvd3JiBTEbT38VFO
        Vjs0eDBpsAHYYBzlZ2sQE50sUghE/7OzpA==
X-Google-Smtp-Source: AMsMyM7naaYh/kH/pOdwL/hcMy/xDCGY2DWQcT5gUgeEmxZgAwrBEqfdvgYDPqjwrrc0pSD2LfRITw==
X-Received: by 2002:a05:620a:13db:b0:6fa:28c5:e06 with SMTP id g27-20020a05620a13db00b006fa28c50e06mr41372617qkl.629.1668041103435;
        Wed, 09 Nov 2022 16:45:03 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a12a100b006eeb3165565sm11678506qki.80.2022.11.09.16.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:45:02 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v2 4/7] serial: liteuart: don't set unused port fields
Date:   Wed,  9 Nov 2022 19:44:47 -0500
Message-Id: <20221110004450.772768-5-gsomlo@gmail.com>
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

