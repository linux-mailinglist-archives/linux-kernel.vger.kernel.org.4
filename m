Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1EA623857
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKJAp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKJApH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:45:07 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723801181C;
        Wed,  9 Nov 2022 16:45:05 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id x21so331809qkj.0;
        Wed, 09 Nov 2022 16:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MThhfi/+6K/LOJrqVDZeVBTVPExj3Q+f1CKmXTQaNyE=;
        b=DAHYdZZoIL7Pd0YKF9Mnb6+h8QIEevMKOBWXVhUndf3BAOgh7GrkrZJXPF/LEwPMcP
         mGFa+NGQxKvkOAAAOTjMOHmw7ig4oIYxZN50g7+QOu+TKxKUIIc57dkGBFeDPNq60OdI
         DaDkfeqnd/SeCg/A+WKzV66OyqLak6PuqlZDCJGcOkggQKYd4TQOEffxPpGpgtpFxfv9
         JgnFJqd1LKgOyKA8aSARWdblYHvoRAbQ7sTepOg4zlaozzTcLP8mMapnhYGZEpWo9D6V
         jadPyjx1WJ/5HvNA8Z5h7AA48phggj/nBE7w5GfkW/KGgJrvRvARvMVzLEKBa9Uf1/p5
         VQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MThhfi/+6K/LOJrqVDZeVBTVPExj3Q+f1CKmXTQaNyE=;
        b=0tdvO2zzPAAFhz8M1mwjR6Za7xO67qxGAGdG/zn5IchrcFNiBx993N8FgjGF/OvYC3
         xI8i3aUm9o2oweitBTmaHoJXzLSmU6bHVqSDiVMjZmbb9VrvQFeuaNb/CWD0149GQ41o
         47e83kSQSPFkJS6uQ4B8n9x+kkIQSMwfkPc7YHP2jZdp02lnsJ/uHYBhZZiLLv8gf9Js
         Tl0gmTFgcwj98DV8L1VHONfsfi4VoCR0pP2sGrbunzHojgmqZrgtUjwfgG8I0znbxb3h
         cW/w0ElR+yY0TCKB3Y9r67d0X5zC/jRFvoim6FvJFVHGw9vrbfnC5WYYzxRllGqCvYYp
         gSTA==
X-Gm-Message-State: ACrzQf2D2bISuJtGmvP343S1ZVoa969a6h46vfgAC4LjSk6qYNRQiMJ8
        32EF+JAJAZpjB9FD9ioU1qxwgKM31v8xjA==
X-Google-Smtp-Source: AMsMyM4NMUBf+oK46xU4WjC9cr4l9fZu1eJT+d+lR/Y3nOm87TRa6JUo8+7q+xRQjdPwptgk2m4Mvw==
X-Received: by 2002:a37:b6c4:0:b0:6fa:7c9f:edda with SMTP id g187-20020a37b6c4000000b006fa7c9feddamr24899601qkf.13.1668041104322;
        Wed, 09 Nov 2022 16:45:04 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a12a100b006eeb3165565sm11678506qki.80.2022.11.09.16.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:45:03 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v2 5/7] serial: liteuart: minor style fix in liteuart_init()
Date:   Wed,  9 Nov 2022 19:44:48 -0500
Message-Id: <20221110004450.772768-6-gsomlo@gmail.com>
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

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 5b684fd198b7..047d5ad32e13 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -398,12 +398,10 @@ static int __init liteuart_init(void)
 		return res;
 
 	res = platform_driver_register(&liteuart_platform_driver);
-	if (res) {
+	if (res)
 		uart_unregister_driver(&liteuart_driver);
-		return res;
-	}
 
-	return 0;
+	return res;
 }
 
 static void __exit liteuart_exit(void)
-- 
2.37.3

