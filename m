Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79F862F85E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbiKROzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiKROzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:55:25 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E9D11C20;
        Fri, 18 Nov 2022 06:55:24 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id e15so3481807qvo.4;
        Fri, 18 Nov 2022 06:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBWlKsdKtevcy3cCWMNuX45X8cNraoMHYPlpt2EEsVk=;
        b=GCr97RO+onYFVnUovGH3O4JpLweqijtv9xIGpaU/MpRKY1fIz4a7L6W31SQlqMpeId
         5I3sZgT72Pdycfliczk5CjtKPt9QmBeXEF9Hg0eH7eBfCCgDx7DohoHGWnCmexpzRz0G
         RCrzQFjSia6nN+SpipCjYpe5EI+0XRhalMR3WghYxVrwC/b/7HOJccT0YJeWEkQMM5Wz
         mDHjoO1WX5xGhyRaN0Zl1eXsxlvvRcQsZYhR/7So4vC91pnDAWeMQUHm4lHnp/yYKBwK
         GysULF8uC4aREYOWIUeaLXkVkZBHjEchUsf/0Ct3VPxgwCKK+M14jU2Tq/QEwYuZlaM1
         drwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBWlKsdKtevcy3cCWMNuX45X8cNraoMHYPlpt2EEsVk=;
        b=N/jILMoV3YrREfQ1h71UV9nUwx8Yl2gXFfIkrYF7wvQE0p6mkgKVbjCBoZGJ50hDOQ
         aDCuZHA98qQi1eBJFkKC/hDFqw1MZxzuCc7AvdlPTKNUh7p93r8Qy+MVQe6eEw4jk4F2
         zo0XSF1uX/CkBLGMeeBDWTXJTzLNWTUdpVFECKUI/PdV6xtQuo0arKPhzRtQ/LZUhZwk
         jcYJKD3Zag2wwyemoEz5m9hPLsSyhOJEcAN8Z0PA28tNK9Dkn2m0tpV0fiGjieJyNtQI
         A+iCALI2ikciozDaAbtjKaXc0Ltu1RJG9bBSJwfCJD0wlhZb4e7cEYTeL/UE2EAgAC9o
         2ogg==
X-Gm-Message-State: ANoB5plg1kA2vUsCTyhxkpPfxcxaj27tXYoDiTWJoOZjBTO2xFgry4Bs
        GgyadXz9DFmo/GxqofjKxfM/H0DyhWYyHw==
X-Google-Smtp-Source: AA0mqf5uZqCZkVF69K4K/HqB0L8WA23uDezz4oOSZ8DRUdynlCaMZSJ2LFt1cUxEU/K9ydHSEMEW+g==
X-Received: by 2002:ad4:4d53:0:b0:4bb:6692:a5a6 with SMTP id m19-20020ad44d53000000b004bb6692a5a6mr6903198qvm.108.1668783323386;
        Fri, 18 Nov 2022 06:55:23 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:22 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 03/14] serial: liteuart: remove unused uart_ops stubs
Date:   Fri, 18 Nov 2022 09:55:01 -0500
Message-Id: <20221118145512.509950-4-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118145512.509950-1-gsomlo@gmail.com>
References: <20221118145512.509950-1-gsomlo@gmail.com>
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

