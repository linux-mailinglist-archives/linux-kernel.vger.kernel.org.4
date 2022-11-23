Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602C5635F63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbiKWNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiKWNY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:28 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C39A272;
        Wed, 23 Nov 2022 05:05:12 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j6so12041867qvn.12;
        Wed, 23 Nov 2022 05:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVdo78SFIsBBZHYvKL7zL+YA2gnLBYhFIgwyV15stUU=;
        b=JFb5n8WtR8tW1eEYyeIAty8AVAAVJhoPuFzUIMQxTR5RBg+cKEFtGRrdAvocnLTjkg
         sWtd8N+Xncg+XJQAWEjmRDKhx7tdOYJHV9jwKSD+NdD1rMGFqO3j1U9H5wVCtx832QZW
         y9LL6/9x60rTlxiqlSA0VbrigTPXpSsPUD5Bg9Vn4gc4buYAlzNPjkHqkflPQQ2XGkfN
         cpD1dsYbe0HnZvAlKU3jg5/YiUdftbJVbR054w6EEPgM8Uy/EcvVjdyiQfNiW7ZOkPKB
         6dr0d+va+lVDmOYi2IBQVHxrgKTZamwZYDesohoeilqA4VICVxxet7PXz5Dppm36adBC
         13BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVdo78SFIsBBZHYvKL7zL+YA2gnLBYhFIgwyV15stUU=;
        b=2N8NyFRlX72ShhI2NXA+UCk4NHkogYlhWGH6gMMhTshXwVxtx14iGyByO8R5heOfrZ
         jt+8eyGbxOfCLBJGFdyYCPeSeS8iByIRWC61Pa4UokBq9mUI95aqSIgRIuiNM6WVwuj6
         YrALfYdTSo/1xTIoNnNGvOyV1dh71ef8SU8OR7TDMwJCjniDsKmRfEQhKN78lfMfNEE7
         iHNUx63VTLwuY84Zdl5rWyG2P3t643tA1U4N/gajVNykX2+iSjIAr29vVB1Syh1v6/gN
         cHY4e6lY+Mnz9vZz0zPZnGBZtEek3OTUzXq3LvhCx0jdnYV6wdkwtc8SK3Rr57bMCezL
         yaNw==
X-Gm-Message-State: ANoB5plKMyy2Qbe/WukpUMg0IeHUcHDhNpjhAX0yW5L4TvWESapRZFRy
        ZPz4NyYf+Okf0io68B0qRaw5bceD4S9Omg==
X-Google-Smtp-Source: AA0mqf7ZPIVNk9RGAuPoUFe1AqGdB/C52nEfQzac7bRu/nvnfgecxkVLS6zGu/0bDK0a7cZIP+9xPg==
X-Received: by 2002:a05:6214:514a:b0:4bb:9279:57cb with SMTP id kh10-20020a056214514a00b004bb927957cbmr7303721qvb.35.1669208710972;
        Wed, 23 Nov 2022 05:05:10 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:10 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 03/14] serial: liteuart: remove unused uart_ops stubs
Date:   Wed, 23 Nov 2022 08:04:49 -0500
Message-Id: <20221123130500.1030189-4-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123130500.1030189-1-gsomlo@gmail.com>
References: <20221123130500.1030189-1-gsomlo@gmail.com>
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
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
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

