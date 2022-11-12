Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3867A626BE2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiKLVVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiKLVVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:37 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FD116E;
        Sat, 12 Nov 2022 13:21:35 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id x13so5679211qvn.6;
        Sat, 12 Nov 2022 13:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/8DPEq9jxGYQguFphHAE7bQWgOJIibend0gpSldrS0=;
        b=pRD6w1gRCDzRGm1uW8MIeuaDnD+7DSCddkxcWGyWGiaYUOOhRBAtNKCByPwmkfUFAX
         NgNUEsXck9OsSIWfmsiEu1NTRvglPNJwt0gOpuYU+XeO4GZBpaYgfY+rywUTciUeQ3DL
         zV2jMtncMGRtIf//3oiSiGervTkqCQAGFbt0nFDPjaP9G12y0bwf66U37d3C2RlkBQSL
         HJqZ35yZIKFoMSKCxlwq0k/zjnYuGXEzrBX09mU39/46ANYs38+nPc6pWGfIE2NFuz+P
         J+R4SHQrucUoY19+IylRagorvNoWm4ZSpMtqyXt4YQwp3EYu68EkNXCbI+azdCiXcB8W
         GWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/8DPEq9jxGYQguFphHAE7bQWgOJIibend0gpSldrS0=;
        b=SQowBztMEdKLfaNgVIZ/u91IxnyzGLSFpbuwct2UegZ38g/ym0JWqTHMDzo5+wxb/R
         s3rKfbdiI21usHyrCVHd7t759tDhjuRx4v7Ret9KhJMeRXTjN1j18JIChmkVMhTceIvc
         CaJMr8yvgb3J04Gaq8/L4+Gf3RM8Uuzc5MqwdX3YU83LU4WeggO+oYjQtaiBl5ROW30D
         qIJ+RBF0rgSy78ViI2E9KsiZDCsVZQvGAGHF0OqAwyclt7m5Dn+5ybeF2UlgGFe4vxln
         KPAB2ShKoBzCmWOfBadjnjfCIMKvwkrzti2UeszGYQcE4QKqBet5HjUbTHsLjHvZB6ij
         e4mA==
X-Gm-Message-State: ANoB5pndsNBWYxmmzh+43p9kQAN+pi65VTuUfxvo6EEjZ/srYLCEENxG
        nWzhrIUpfdRLbOqOuazXPH0+kqNFdTyBRg==
X-Google-Smtp-Source: AA0mqf48SrqNEHPc/iMt+ke4qYur4Vq4FuEW6ojat5AjEpCoJcUd4DmynIMXMhdItAswccLTn2mYyg==
X-Received: by 2002:a05:6214:5911:b0:4b9:e098:e334 with SMTP id lp17-20020a056214591100b004b9e098e334mr7136818qvb.38.1668288094516;
        Sat, 12 Nov 2022 13:21:34 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:33 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 03/14] serial: liteuart: remove unused uart_ops stubs
Date:   Sat, 12 Nov 2022 16:21:14 -0500
Message-Id: <20221112212125.448824-4-gsomlo@gmail.com>
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

