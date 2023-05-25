Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F140710904
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjEYJeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjEYJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:34:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C71A2;
        Thu, 25 May 2023 02:34:31 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685007269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4e3/MmglhQzDhzxZKmrh29ltZzGLtHjU6m+4lcF3Ohc=;
        b=NTr1IkyQZ3OjcNlK4kp6xH1FWtIZitO+012FKXjtrrK1TncJzHvVRCKB2HJMfrJeLNwbdv
        JqTB4lbCkHpWdmGVU5IV0oSMOrnCgco1IrJYFalyMgIYhkmoF+ls8sWoIXWwGHBTvAv2VM
        AsESQbtcYDRinZpSMAv2lQTsnptfIbem7K8AtFoGqFwud1/rfvw7F05ZvxvRy0LATu+F8T
        D+EFAcJK7ms+VnYmR2p2r9Qpx1ZLFq6Z0RTlRc1a0UNByZ9v138z6/F1HL5D3TdYva9DEW
        wga+ysXcWpNnhcGd/bCi+WRLYUf/VVV3R00jadPPgDtnIqKZbThruZgML7Vlfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685007269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4e3/MmglhQzDhzxZKmrh29ltZzGLtHjU6m+4lcF3Ohc=;
        b=OQ/ky65DAwfr8I0FKrHj0L+b/kkpcdBW/cvTc4v+Gja6TPoPnsWTFi/SGx6YP134mMOLhZ
        Z42apekShbMWanBQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-serial@vger.kernel.org
Subject: [PATCH tty v1 4/8] serial: core: lock port for start_rx() in uart_resume_port()
Date:   Thu, 25 May 2023 11:37:55 +0206
Message-Id: <20230525093159.223817-5-john.ogness@linutronix.de>
In-Reply-To: <20230525093159.223817-1-john.ogness@linutronix.de>
References: <20230525093159.223817-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of the start_rx() callback (qcom_geni) directly calls
its own stop_rx() callback. Since stop_rx() requires that the
port->lock is taken and interrupts are disabled, the start_rx()
callback has the same requirement.

Fixes: cfab87c2c271 ("serial: core: Introduce callback for start_rx and do stop_rx in suspend only if this callback implementation is present.")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/serial_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 37ad53616372..f856c7fae2fd 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2430,8 +2430,11 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		if (console_suspend_enabled)
 			uart_change_pm(state, UART_PM_STATE_ON);
 		uport->ops->set_termios(uport, &termios, NULL);
-		if (!console_suspend_enabled && uport->ops->start_rx)
+		if (!console_suspend_enabled && uport->ops->start_rx) {
+			spin_lock_irq(&uport->lock);
 			uport->ops->start_rx(uport);
+			spin_unlock_irq(&uport->lock);
+		}
 		if (console_suspend_enabled)
 			console_start(uport->cons);
 	}
-- 
2.30.2

