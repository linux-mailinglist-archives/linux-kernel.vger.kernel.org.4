Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FA16D7B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbjDELTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbjDELTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:19:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4234559C5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:19:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s20so16601855ljp.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1680693556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr/D5jNM2LuXAy18BJTEshOX4//SxsyRmKq3m/Ky3gI=;
        b=G9FWY+CpPfemuV18tJp6I5vV57uHa/pLP3g//2sgPcuUwKxV0b3TVvXhtqAoI2KL00
         /ckoEBXMtK1cJVVRR/+xWZomqZzUgF4N/R+PfWGIB1HJY0YyjnoaGRX/cMkD4RSRfDY6
         Lh5nIQJBvoZKXPSjLkTiA0PkTOON8WaBivU8VJl1xCMHKhoKrcljsLXZzkjwedPo4PnS
         CR3d1L1FPJHgzzrBkWxExiqrISe17twWvHrbf3hSLMA/SwxbYd/xEpFAaO23cMPFlUqr
         LcY6ua9Y0RVORVZeADqyFUOtjKi+jsU2I7OzMZUvBGRrmttfKj0t7Om7rIHwLcfr0iY9
         Gb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680693556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zr/D5jNM2LuXAy18BJTEshOX4//SxsyRmKq3m/Ky3gI=;
        b=WsFEIH6mju6tndVF91kFboE5+rG4Zg1EjCFdcQQqY0hGRkXLFwRPW/qhzrrHRL/0PB
         PCDlarQ3u/h+JcxaDiXbMVZbGuzOdO0MvathnyaiH9vzbvhnI1cXIoMukpjfkAfwutIv
         jy+3zGBM530ADJ+CFRVZY84gGothsU5Vu7CtcW2M70PRg8sFS3QEfUdwqj8/hmSaQ7Wa
         9GR+ViTXZ1TeVHJumPtZb+DQ9U5vBqPcES4BxJhaZuZO8pNUnLnMgDLexnVyYkvi+Vkl
         xBxSb2bvSv3d9IjMwkieRae1WicQbijaOydNAnt6Nqi6dBmXrk8mTDgpjnZ/wcoKmpoh
         ZqLg==
X-Gm-Message-State: AAQBX9fWPIdu+JZav9xO88Pio5n1b+fVvOkG1zi0BqojjfZqtC7xgHZ9
        T86tAe+Z7KZwi9LiKwbOu34h3LZnKaRsO1iyMuE=
X-Google-Smtp-Source: AKy350YQqgmQKs1sXMC5Gzd7+xiWL9laj+6oTJUkXJ/tKNBCCRr3fHGHNkMXn6grPljCzkj8S0/SQQ==
X-Received: by 2002:a2e:9784:0:b0:295:a930:d7a3 with SMTP id y4-20020a2e9784000000b00295a930d7a3mr1859021lji.15.1680693556605;
        Wed, 05 Apr 2023 04:19:16 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id i19-20020a2e8093000000b0029f3e2efbb9sm2817730ljg.90.2023.04.05.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:19:16 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, Lukasz Majczak <lma@semihalf.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/2] serial: core: enable FIFO after resume
Date:   Wed,  5 Apr 2023 13:15:59 +0200
Message-Id: <20230405111559.110220-3-lma@semihalf.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230405111559.110220-1-lma@semihalf.com>
References: <20230405111559.110220-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "serial/8250: Use fifo in 8250 console driver" commit
has revealed an issue of not re-enabling FIFO after resume.
The problematic path is inside uart_resume_port() function.
First, when the console device is re-enabled,
a call to uport->ops->set_termios() internally initializes FIFO
(in serial8250_do_set_termios()), although further code
disables it by issuing ops->startup() (pointer to serial8250_do_startup,
internally calling serial8250_clear_fifos()).
There is even a comment saying "Clear the FIFO buffers and disable them.
(they will be reenabled in set_termios())", but in this scenario,
set_termios() has been called already and FIFO remains disabled.

This patch address the issue by reversing the order - first checks
if tty port is suspended and performs actions accordingly
(e.g. call to ops->startup()), then tries to re-enable
the console device after suspend (and call to uport->ops->set_termios()).

Signed-off-by: Lukasz Majczak <lma@semihalf.com>
Cc: <stable@vger.kernel.org> # 6.1+
---
 drivers/tty/serial/serial_core.c | 54 ++++++++++++++++----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 394a05c09d87..57a153adba3a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2406,33 +2406,6 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 	put_device(tty_dev);
 	uport->suspended = 0;
 
-	/*
-	 * Re-enable the console device after suspending.
-	 */
-	if (uart_console(uport)) {
-		/*
-		 * First try to use the console cflag setting.
-		 */
-		memset(&termios, 0, sizeof(struct ktermios));
-		termios.c_cflag = uport->cons->cflag;
-		termios.c_ispeed = uport->cons->ispeed;
-		termios.c_ospeed = uport->cons->ospeed;
-
-		/*
-		 * If that's unset, use the tty termios setting.
-		 */
-		if (port->tty && termios.c_cflag == 0)
-			termios = port->tty->termios;
-
-		if (console_suspend_enabled)
-			uart_change_pm(state, UART_PM_STATE_ON);
-		uport->ops->set_termios(uport, &termios, NULL);
-		if (!console_suspend_enabled && uport->ops->start_rx)
-			uport->ops->start_rx(uport);
-		if (console_suspend_enabled)
-			console_start(uport->cons);
-	}
-
 	if (tty_port_suspended(port)) {
 		const struct uart_ops *ops = uport->ops;
 		int ret;
@@ -2471,6 +2444,33 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		tty_port_set_suspended(port, false);
 	}
 
+	/*
+	 * Re-enable the console device after suspending.
+	 */
+	if (uart_console(uport)) {
+		/*
+		 * First try to use the console cflag setting.
+		 */
+		memset(&termios, 0, sizeof(struct ktermios));
+		termios.c_cflag = uport->cons->cflag;
+		termios.c_ispeed = uport->cons->ispeed;
+		termios.c_ospeed = uport->cons->ospeed;
+
+		/*
+		 * If that's unset, use the tty termios setting.
+		 */
+		if (port->tty && termios.c_cflag == 0)
+			termios = port->tty->termios;
+
+		if (console_suspend_enabled)
+			uart_change_pm(state, UART_PM_STATE_ON);
+		uport->ops->set_termios(uport, &termios, NULL);
+		if (!console_suspend_enabled && uport->ops->start_rx)
+			uport->ops->start_rx(uport);
+		if (console_suspend_enabled)
+			console_start(uport->cons);
+	}
+
 	mutex_unlock(&port->mutex);
 
 	return 0;
-- 
2.40.0.577.gac1e443424-goog

