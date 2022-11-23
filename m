Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE57635F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiKWN0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbiKWNYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:55 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C35FBA694;
        Wed, 23 Nov 2022 05:05:24 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id a27so11109061qtw.10;
        Wed, 23 Nov 2022 05:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uv4LkMStxbJeRiqSaeHzPlYy/gMVyjTWm665eb9apXw=;
        b=ft6BQtCT+XEtii9ajj64/wqVo1iR91TOXtD/jeajiJJHi6GzAhIUUEbOAddeYe57xr
         bBJStbSMjxVYpLgz9snXoztA2uwAJj9Skvgera5pGs1VrCpklGMr6i0bHlNtza5WR91N
         bF7RcTnrcxJT3YmLRBL6F7LgITnq9m7D4SjlnqkY4Ozk8jNXpzv2+MXwVCZVmN1D2DCW
         tfSg3g+RHyPQt3D6DVYN57QkM2PsfJg6t1onoGhBjM3QEpGNXETxPoQHhxIwCt6/b8cb
         Uls/A3e+zHtMhNl/0Lw+QKMYFi9jW2yCji7jf3fb1iRzOjSvd6yLROry3OvNg1KLIqsD
         883g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv4LkMStxbJeRiqSaeHzPlYy/gMVyjTWm665eb9apXw=;
        b=W9dHcPfsPHQeiBPLWskBWGLrqA3y1pRYZaXYJoZB/G9FZ8RRByd0rB1s21i7I0qSA2
         EvfmWuthR2V0/2X55ocGiE/SA1mtMGyy7JDJxthontVDPUQAv3rGRflc/N14tohiezrS
         p7bS+hr56Au17uZAKWAOYH09T9wZ2Y2dX0exXfGlCGmadkzRja+DSuHORyR/+nUgAJM/
         lqnkATxv0rucIAFNCT3b+4b6bRWMyVt6qxCCg/eG4JGt3J3+BBrIKhaE1xQ0e2BR8f3c
         vyCGQ/Tl9Dc11whHC3ct2x8Eh7VCm+IfNn76vNldWnp1BRzdD055N9lVW9YBGn6HXIIQ
         mmxA==
X-Gm-Message-State: ANoB5pnjKVR8t8yXBP/uUsq5RPUP1k8XFrA7RkHr3w3z7W5rz9ENAc59
        q7vWB45bCAaF28CMR3QB1a8iVnkeRS47JQ==
X-Google-Smtp-Source: AA0mqf6/kEW4ykinuJ/KxsZ0HJs6DQq1Dj3B4mYQDn9IaVajINYKBHPG192vVFM3BW+d108NUVDrUg==
X-Received: by 2002:a05:622a:509d:b0:3a5:b69:5015 with SMTP id fp29-20020a05622a509d00b003a50b695015mr26223730qtb.211.1669208722999;
        Wed, 23 Nov 2022 05:05:22 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:22 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 14/14] serial: liteuart: move polling putchar() function
Date:   Wed, 23 Nov 2022 08:05:00 -0500
Message-Id: <20221123130500.1030189-15-gsomlo@gmail.com>
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

The polling liteuart_putchar() function is only called from methods
conditionally enabled by CONFIG_SERIAL_LITEUART_CONSOLE. Move its
definition closer to the console code where it is dependent on the
same config option.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 6e9f58d3957c..ef557d59e4c8 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -70,14 +70,6 @@ static struct uart_driver liteuart_driver = {
 #endif
 };
 
-static void liteuart_putchar(struct uart_port *port, unsigned char ch)
-{
-	while (litex_read8(port->membase + OFF_TXFULL))
-		cpu_relax();
-
-	litex_write8(port->membase + OFF_RXTX, ch);
-}
-
 static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
@@ -377,6 +369,14 @@ static struct platform_driver liteuart_platform_driver = {
 
 #ifdef CONFIG_SERIAL_LITEUART_CONSOLE
 
+static void liteuart_putchar(struct uart_port *port, unsigned char ch)
+{
+	while (litex_read8(port->membase + OFF_TXFULL))
+		cpu_relax();
+
+	litex_write8(port->membase + OFF_RXTX, ch);
+}
+
 static void liteuart_console_write(struct console *co, const char *s,
 	unsigned int count)
 {
-- 
2.38.1

