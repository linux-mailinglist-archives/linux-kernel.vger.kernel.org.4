Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DD662AFED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKPAQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKPAQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:16:16 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A7B1BE;
        Tue, 15 Nov 2022 16:16:14 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id g10so10691794qkl.6;
        Tue, 15 Nov 2022 16:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QFox3T1RUAHoxY4Bqm6YyFiBNEx0ZrKnZC+XfWXVVyY=;
        b=ON2ecGuTwnPWNOGLvgebF/ZPPK4OgysjpIWEL/veiAgZQxGpQeVUdDPTe/KfQRy1ri
         C9ErNyZTJrLd9JcYEgqW6AUHF5xMRhhXxoAChgdf1JTDDMdrm4GUr86vDAOcZq2uCHeM
         LMB32DYhZTZEUzZNRbnLel2tLArnnSYxCFvfdxoU4xaQbd7qDePSFsZeMCzdpU94bL4J
         TzJsypLPb3uomGYO67xjM8rPMnggyacSMp6Jzk0qB786u3y3Kaj5HlL0FBLD5IH4bkxn
         Kg6pFY0LVNvhyMXb1jThoKpjZ9qTYf3YafouU744gDxPchB/b3jIWQCA7fClgpeIOGb+
         hKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFox3T1RUAHoxY4Bqm6YyFiBNEx0ZrKnZC+XfWXVVyY=;
        b=L05Aw0xUT6tQtPBxxqO06AhAaPgBw5yceapo5qsmW8cwFXyWqA+jGORkoB+Tvq3nnU
         xHAC/Gxi9ezFqlAxCUIFMwzWYBiC4s6Nknl+z3JK9mTMjZR2xYUXMIT8RjHhDjsZnzDF
         h3TgcPba3wVIrUMIHTH4+yus9r01eEZ5bvyOwF0M9k/2FIXxCsntec6h3pPfHki+ghhn
         8iCPtM6TSEizH3tF2G2/4Dz9xOC+JKSsy3w85agBH2RRKzYupSrZcBX4R4pUDlv7Mvwz
         PRObF5G5ZdrU/KyNFwTIqm5gJh3chK/M6lUaMg0eFTMjbkTL7n+1bmUe4JaB8FPAKmc2
         eXHQ==
X-Gm-Message-State: ANoB5pnIrKs4JnoLe/YDE2YFovfHWNkuiqERlfLd123AtOqajyavNwoM
        r6pzR3byCLXnWnS/qK1qlQo=
X-Google-Smtp-Source: AA0mqf78GT5xarMTInHXVeJEt5O5SckzmDzpKM27CY1oHpC9wz5XvbT0yM/UaJJNHjbOB8iqGCQevg==
X-Received: by 2002:a05:620a:209d:b0:6fa:2d5c:110a with SMTP id e29-20020a05620a209d00b006fa2d5c110amr17121354qka.628.1668557773894;
        Tue, 15 Nov 2022 16:16:13 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id e7-20020a05622a110700b0038b684a1642sm7926544qty.32.2022.11.15.16.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 16:16:13 -0800 (PST)
Date:   Tue, 15 Nov 2022 19:16:11 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org
Subject: Re: [PATCH v3 13/14] serial: liteuart: add IRQ support for the TX
 path
Message-ID: <Y3Qry3Hza6ydnibL@errol.ini.cmu.edu>
References: <20221112212125.448824-1-gsomlo@gmail.com>
 <20221112212125.448824-14-gsomlo@gmail.com>
 <957056a1-78a5-1141-18d7-b49f87fa85f0@linux.intel.com>
 <Y3PI0gP0vnmYTmZK@errol.ini.cmu.edu>
 <281fcd2-157e-c9ce-a0e5-b077ed43887a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <281fcd2-157e-c9ce-a0e5-b077ed43887a@linux.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 07:30:09PM +0200, Ilpo Järvinen wrote:
> On Tue, 15 Nov 2022, Gabriel L. Somlo wrote:
> 
> > On Tue, Nov 15, 2022 at 06:14:50PM +0200, Ilpo Järvinen wrote:
> > > On Sat, 12 Nov 2022, Gabriel Somlo wrote:
> > > 
> > > > Modify the TX path to operate in an IRQ-compatible way, while
> > > > maintaining support for polling mode via the poll timer.
> > > > 
> > > > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > > > ---
> > > >  drivers/tty/serial/liteuart.c | 67 ++++++++++++++++++++++++-----------
> > > >  1 file changed, 47 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> > > > index e30adb30277f..307c27398e30 100644
> > > > --- a/drivers/tty/serial/liteuart.c
> > > > +++ b/drivers/tty/serial/liteuart.c
> 
> > > > +	if (port->irq) {
> > > > +		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
> > > > +		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask & ~EV_TX);
> > > 
> > > If you put irq_mask into liteuart_port you wouldn't need to read it 
> > > back here?
> > 
> > So, instead of `bool poll_tx_started` I should just keep a copy of the
> > irq_mask there, and take `&port->lock` whenever I need to *both* update
> > the mask *and* write it out to the actual device register?
> 
> I was mostly thinking of storing EV_RX there but then it could be derived 
> from port->irq that is checked by all paths already.

So, just to clear up the best course of action here (before I rebase
everything on top of tty-next: How about the patch below (currently
applied separately at the end of the entire series, but I can respin
it as part of the rx path (12/14) and tx path (13/14) as appropriate.

Let me know what you think.

Thanks,
--Gabriel


diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index eb0ae8c8bd94..185db423c65f 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -47,7 +47,7 @@ struct liteuart_port {
 	struct uart_port port;
 	struct timer_list timer;
 	u32 id;
-	bool poll_tx_started;
+	u8 irq_reg;
 };
 
 #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
@@ -70,26 +70,27 @@ static struct uart_driver liteuart_driver = {
 #endif
 };
 
+static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 bits)
+{
+	struct liteuart_port *uart = to_liteuart_port(port);
+
+	if (set)
+		uart->irq_reg |= bits;
+	else
+		uart->irq_reg &= ~bits;
+
+	if (port->irq)
+		litex_write8(port->membase + OFF_EV_ENABLE, uart->irq_reg);
+}
+
 static void liteuart_stop_tx(struct uart_port *port)
 {
-	if (port->irq) {
-		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
-		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask & ~EV_TX);
-	} else {
-		struct liteuart_port *uart = to_liteuart_port(port);
-		uart->poll_tx_started = false;
-	}
+	liteuart_update_irq_reg(port, false, EV_TX);
 }
 
 static void liteuart_start_tx(struct uart_port *port)
 {
-	if (port->irq) {
-		u8 irq_mask = litex_read8(port->membase + OFF_EV_ENABLE);
-		litex_write8(port->membase + OFF_EV_ENABLE, irq_mask | EV_TX);
-	} else {
-		struct liteuart_port *uart = to_liteuart_port(port);
-		uart->poll_tx_started = true;
-	}
+	liteuart_update_irq_reg(port, true, EV_TX);
 }
 
 static void liteuart_stop_rx(struct uart_port *port)
@@ -149,12 +150,10 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
 {
 	struct liteuart_port *uart = data;
 	struct uart_port *port = &uart->port;
-	u8 isr = litex_read8(port->membase + OFF_EV_PENDING);
-
-	if (!(port->irq || uart->poll_tx_started))
-		isr &= ~EV_TX;	/* polling mode with tx stopped */
+	u8 isr;
 
 	spin_lock(&port->lock);
+	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
 	if (isr & EV_RX)
 		liteuart_rx_chars(port);
 	if (isr & EV_TX)
@@ -195,39 +194,40 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
 static int liteuart_startup(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
+	unsigned long flags;
 	int ret;
-	u8 irq_mask = 0;
 
 	if (port->irq) {
 		ret = request_irq(port->irq, liteuart_interrupt, 0,
 				  KBUILD_MODNAME, uart);
-		if (ret == 0) {
-			/* only enabling rx interrupts at startup */
-			irq_mask = EV_RX;
-		} else {
+		if (ret) {
 			pr_err(pr_fmt("line %d irq %d failed: using polling\n"),
 				port->line, port->irq);
 			port->irq = 0;
 		}
 	}
 
+	spin_lock_irqsave(&port->lock, flags);
+	/* only enabling rx irqs during startup */
+	liteuart_update_irq_reg(port, true, EV_RX);
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	if (!port->irq) {
-		uart->poll_tx_started = false;
 		timer_setup(&uart->timer, liteuart_timer, 0);
 		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 	}
 
-	litex_write8(port->membase + OFF_EV_ENABLE, irq_mask);
-
 	return 0;
 }
 
 static void liteuart_shutdown(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
+	unsigned long flags;
 
-	litex_write8(port->membase + OFF_EV_ENABLE, 0);
-	uart->poll_tx_started = false;
+	spin_lock_irqsave(&port->lock, flags);
+	liteuart_update_irq_reg(port, false, EV_RX | EV_TX);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	if (port->irq)
 		free_irq(port->irq, port);
-- 
2.37.3

