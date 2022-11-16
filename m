Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2BB62C154
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiKPOth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiKPOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:21 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADFF17591;
        Wed, 16 Nov 2022 06:49:20 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id l2so10778276qtq.11;
        Wed, 16 Nov 2022 06:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8oSxODvpRIImTN9WHVpow16OveWT9zKoAdC7TS4/4Y=;
        b=Z/dN35ea+TIYbEA+K48zz3U7DxsC/uAXx0Ruizd5Ilc247/2QqRuu1uFgJLcUoTjQ3
         bbK0cR187nnwQ+ynN52KiR4plFCNl2M4EQRdzaw+8FZDec7GfI96xXtiGxfSWWyDIVeI
         UJamh4pZ9ZJQ4w8Kbt9gVElJMmFe1Srkbn+v6ZMhauJdrdxsJ15YGeMHDAWG7jBZACo/
         WfsaknvZ+/DWOZGR+OV9mERYM6R/79Jkc7UCZ4kV5yFGuTPmeZF51mkiASDshOakoRuf
         4mCi6I26hdtLYF13O1zdBhzlPJbZPraf95XPXQ0DSqkCblkDd6RlVw8nRwvbYmrXEU8u
         eFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8oSxODvpRIImTN9WHVpow16OveWT9zKoAdC7TS4/4Y=;
        b=Pfq287c7BcvP3pBn98d+Mu453GxFSXT8eLnSl3UWhbwLx3uAoxYU3KiIjyjrSFBv5T
         i/y5qXg1T0Vnwr8sNfeR3fKhJ42eV9zSDPSBL/JqViINxU3GfXX4fw8O73m9ZKVJnNqp
         0qFRkc0vjdqBX0cKqjSwaVrFcDd/oV9CQhM504++Ia1uhljMCL3y0Axh/zkOmC8Zx1lD
         jdpeMYIOkCzjBDrH3/t/p4nsYf0dvNSuyCQKkQsCjlK+ZYiuvHEZyAHGDDqj9f8Ldwhp
         YMRxYOw/sAPUbFPLN2sEEmoTSIfUlmSN/al04d8YK9UAQnQIVs3WwBTYB96P3pQ/Cmwp
         w7CQ==
X-Gm-Message-State: ANoB5pk5lfV/RHXldJ4oS1IAyXYOJqdqKjtwsyUrJr2dshnPkjwWAf29
        6Vi/bnewn6R+cetZIEMVhYi/kpZb+OUJAw==
X-Google-Smtp-Source: AA0mqf5KEKBsMJtKTeY6BGNgK+mKAmegil/eoNd/1TQxn2HprDs+OKOP7zMepUh7WRpxFdxkpukyLw==
X-Received: by 2002:ac8:1411:0:b0:3a5:4a19:c543 with SMTP id k17-20020ac81411000000b003a54a19c543mr20576044qtj.126.1668610159040;
        Wed, 16 Nov 2022 06:49:19 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:18 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 03/14] serial: liteuart: remove unused uart_ops stubs
Date:   Wed, 16 Nov 2022 09:48:57 -0500
Message-Id: <20221116144908.234154-4-gsomlo@gmail.com>
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

Remove stub uart_ops methods that are not called unconditionally
from serial_core.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Changes since v3:
  - no longer adding gratuitous comment to liteuart_stop_tx,
    removed later on in the series

 drivers/tty/serial/liteuart.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 18c1eb315ee9..989a4f8d5bd4 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -154,11 +154,6 @@ static void liteuart_stop_rx(struct uart_port *port)
 	del_timer(&uart->timer);
 }
 
-static void liteuart_break_ctl(struct uart_port *port, int break_state)
-{
-	/* LiteUART doesn't support sending break signal */
-}
-
 static int liteuart_startup(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
@@ -197,15 +192,6 @@ static const char *liteuart_type(struct uart_port *port)
 	return "liteuart";
 }
 
-static void liteuart_release_port(struct uart_port *port)
-{
-}
-
-static int liteuart_request_port(struct uart_port *port)
-{
-	return 0;
-}
-
 static void liteuart_config_port(struct uart_port *port, int flags)
 {
 	/*
@@ -232,13 +218,10 @@ static const struct uart_ops liteuart_ops = {
 	.stop_tx	= liteuart_stop_tx,
 	.start_tx	= liteuart_start_tx,
 	.stop_rx	= liteuart_stop_rx,
-	.break_ctl	= liteuart_break_ctl,
 	.startup	= liteuart_startup,
 	.shutdown	= liteuart_shutdown,
 	.set_termios	= liteuart_set_termios,
 	.type		= liteuart_type,
-	.release_port	= liteuart_release_port,
-	.request_port	= liteuart_request_port,
 	.config_port	= liteuart_config_port,
 	.verify_port	= liteuart_verify_port,
 };
-- 
2.38.1

