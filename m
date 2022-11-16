Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC75362C15A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiKPOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiKPOtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:23 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911D1CB2A;
        Wed, 16 Nov 2022 06:49:22 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z1so11723202qkl.9;
        Wed, 16 Nov 2022 06:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zatoQ8/a+60T2AmPXnfE9c4vLIYDpN6MzKVzyD4F9Ww=;
        b=LrbuARdq6SFzMwJAQQC0f/+7AU6V4HH0DWEhvf24Odg7fYKrq07HsMHcSZWyFXZgn6
         srh6Ys0opE9worUgikHmBph2tdgAEC74sryJOixXQ0nnGLr2jLyZ8oTre2i9b3uEkyL0
         5Zu+woROpu3r3tUwnvwY2vWDZ8RYjCtOvcrUrXqDhudskSLEF6bxBgI7tx0HU7kjPD+7
         E/JoMxf6bH9A7WFBcdFU92Ix6hWUQeEVaE5AzCO6o/ax9/9WlCQKr+dgtLn52oVlIcmq
         NGob1zMzoU3OnlT+9JZ8yinkCEAOGJpJzbH4smXKoVmzye5N9lo/IzxG2dCjBCyfSE6P
         KfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zatoQ8/a+60T2AmPXnfE9c4vLIYDpN6MzKVzyD4F9Ww=;
        b=5RGcPGIuA8UOjCG8iJWxlYBp3kh2WghNvoxrcO8Hdkq6zEDBEgn6HE7MBYCWLjaoPi
         Ji9+kJDBPwVnnoPqWfBTZIcjNTRg3L0x+wVqXTAkQWhQicEwSjmKMx6x9z9twhJyIb4g
         Ig3pJhegLVt8mNK2VP0LsMJorEQ5ATF20ihDmvo1ymYEWRXtZmQauoLj28LKMslPXpdZ
         xLxTzmheN7cJDjr6bGTTkkIQ5lO5SRgPPo7wqs2MPXB/1dhMYXYfXLwd1YI1gBF22qlG
         wxJiv8YOGmnbJ6TheR0sc+a9AHPqO0gYXGATjI13WrFRmqgW8fwVsEBku64Qxnr4S8dx
         kaPw==
X-Gm-Message-State: ANoB5pnZmH0KtIYZIXUWjm2/vsUUSqzjutSzB/7WK4dBz9Wx85YhozhX
        h0GHVuDhkkoGS6DeWZ7OOvYMPP9DLn6lDg==
X-Google-Smtp-Source: AA0mqf7tqDWFNci9vaPK2mIsCnn/fu7b+2VRhfFHAzaZMmze2QKGLJqR8wLOrfjijzq8tCrj5i+QEQ==
X-Received: by 2002:a05:620a:68e:b0:6fa:124e:d8aa with SMTP id f14-20020a05620a068e00b006fa124ed8aamr19945966qkh.604.1668610161101;
        Wed, 16 Nov 2022 06:49:21 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:20 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 05/14] serial: liteuart: minor style fix in liteuart_init()
Date:   Wed, 16 Nov 2022 09:48:59 -0500
Message-Id: <20221116144908.234154-6-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
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

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index c6eb7eba5af8..1e3429bcc2ad 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -397,12 +397,10 @@ static int __init liteuart_init(void)
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
2.38.1

