Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E70623854
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKJApR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKJApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:45:06 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFE511C1F;
        Wed,  9 Nov 2022 16:45:03 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id h10so431175qvq.7;
        Wed, 09 Nov 2022 16:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/8DPEq9jxGYQguFphHAE7bQWgOJIibend0gpSldrS0=;
        b=mT17lCFFkMNVGGG9W8O+qcZhEge+jj52nBLrIkSu/8YEl7pSo9u1dFJm2NY0KgoyF3
         Xwx+GohbKhlZvD1DK4DmKicl/dfBTwm9mYwpViU1hGOUEqO733N3KELsx1VG67DK2oJ9
         VoBbigjKfRKDH4ORW+s3msiecWxQASHB6CTLrEK5JoL7B8VTXsQfggP+JYmtUIJ2oTol
         ljhCRSRSycljXjrXyxO/SgTDCr8palizKAqiNw1hg2umh20j1pVRlmXIdAyClWOHvUZZ
         73XfuioBqqaP/fI4sm3WnBkKZJn6uQVEUn0ucSSx/AH1Y3SkUx97UjX/bk2mFgOR03gA
         ZSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/8DPEq9jxGYQguFphHAE7bQWgOJIibend0gpSldrS0=;
        b=3Q25K3+gsVSceVlwtGtdjSvWSMer8Dv+WmURgOQXXLd4Gg5s7JyHovrGttNhMQilXE
         zDe+EoTBje9+YQfbeklRCP88QYTXyl7NKQ0DEGvx/n6N3BG+uHZz4sReGWPHH3kYYr5B
         Np2+mpea2084cyXEOm0IEF/dQGLh3VnYv0ctLpQO/zhGUiZWHDZeDQPaHlvzhjgwlEAT
         grwaUZtsix0u12XBZnyiADOMS6EAgp/VqbpBHlygRAx3vBgJ6iSIF3frWoW8lj++3W47
         REOLdkOR9QDHjoLN+iTuOwAbt7llLgeW5YCzNUel5cOrhodSf6GZBEgwXhiVYhZsjKcA
         Sj4A==
X-Gm-Message-State: ACrzQf2UbbUzazIWiB4ob/tGqP9geBXrjU+/P2PiQ5kVYqv/GRYyv4YU
        NXgf2QKztKIazTAa9vtVtL3sqVxIxX7Phg==
X-Google-Smtp-Source: AMsMyM4vBJqcNxy9yO3mAyFuGfHFKCwWUdqvY0etajIds9PKtrEJzFoi3vcCuNB+uKdljV82Na3MRg==
X-Received: by 2002:ad4:5f4c:0:b0:4b8:ec94:68e with SMTP id p12-20020ad45f4c000000b004b8ec94068emr56638770qvg.38.1668041102417;
        Wed, 09 Nov 2022 16:45:02 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a12a100b006eeb3165565sm11678506qki.80.2022.11.09.16.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:45:02 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v2 3/7] serial: liteuart: remove unused uart_ops stubs
Date:   Wed,  9 Nov 2022 19:44:46 -0500
Message-Id: <20221110004450.772768-4-gsomlo@gmail.com>
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

Remove stub uart_ops methods that are not called unconditionally
from serial_core. Document stubs that are expected to be present.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 1497d4cdc221..90f6280c5452 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -122,6 +122,7 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
 
 static void liteuart_stop_tx(struct uart_port *port)
 {
+	/* not used in LiteUART, but called unconditionally from serial_core */
 }
 
 static void liteuart_start_tx(struct uart_port *port)
@@ -154,11 +155,6 @@ static void liteuart_stop_rx(struct uart_port *port)
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
@@ -197,15 +193,6 @@ static const char *liteuart_type(struct uart_port *port)
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
@@ -232,13 +219,10 @@ static const struct uart_ops liteuart_ops = {
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
2.37.3

