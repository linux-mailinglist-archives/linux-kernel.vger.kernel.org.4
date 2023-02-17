Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0568B69B3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBQUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBQUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:23:07 -0500
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6012A147
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:23:04 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id T7G2pKIElTHu0T7G2pfheb; Fri, 17 Feb 2023 21:23:03 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 17 Feb 2023 21:23:03 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: Reorder fields in 'struct plat_serial8250_port'
Date:   Fri, 17 Feb 2023 21:22:57 +0100
Message-Id: <f3cb1efe1454e0615840fd331ee335bc441589a9.1676665358.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct plat_serial8250_port'
from 144 to 128 bytes.

It saves a few bytes of memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct plat_serial8250_port {
	long unsigned int          iobase;               /*     0     8 */
	void *                     membase;              /*     8     8 */
	resource_size_t            mapbase;              /*    16     8 */
	unsigned int               irq;                  /*    24     4 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          irqflags;             /*    32     8 */
	unsigned int               uartclk;              /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	void *                     private_data;         /*    48     8 */
	unsigned char              regshift;             /*    56     1 */
	unsigned char              iotype;               /*    57     1 */
	unsigned char              hub6;                 /*    58     1 */
	unsigned char              has_sysrq;            /*    59     1 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 1 boundary (64 bytes) --- */
	upf_t                      flags;                /*    64     8 */
	unsigned int               type;                 /*    72     4 */

	/* XXX 4 bytes hole, try to pack */

	unsigned int               (*serial_in)(struct uart_port *, int); /*    80     8 */
	void                       (*serial_out)(struct uart_port *, int, int); /*    88     8 */
	void                       (*set_termios)(struct uart_port *, struct ktermios *, const struct ktermios  *); /*    96     8 */
	void                       (*set_ldisc)(struct uart_port *, struct ktermios *); /*   104     8 */
	unsigned int               (*get_mctrl)(struct uart_port *); /*   112     8 */
	int                        (*handle_irq)(struct uart_port *); /*   120     8 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	void                       (*pm)(struct uart_port *, unsigned int, unsigned int); /*   128     8 */
	void                       (*handle_break)(struct uart_port *); /*   136     8 */

	/* size: 144, cachelines: 3, members: 21 */
	/* sum members: 128, holes: 4, sum holes: 16 */
	/* last cacheline: 16 bytes */
};

After:
=====
struct plat_serial8250_port {
	long unsigned int          iobase;               /*     0     8 */
	void *                     membase;              /*     8     8 */
	resource_size_t            mapbase;              /*    16     8 */
	unsigned int               uartclk;              /*    24     4 */
	unsigned int               irq;                  /*    28     4 */
	long unsigned int          irqflags;             /*    32     8 */
	void *                     private_data;         /*    40     8 */
	unsigned char              regshift;             /*    48     1 */
	unsigned char              iotype;               /*    49     1 */
	unsigned char              hub6;                 /*    50     1 */
	unsigned char              has_sysrq;            /*    51     1 */
	unsigned int               type;                 /*    52     4 */
	upf_t                      flags;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned int               (*serial_in)(struct uart_port *, int); /*    64     8 */
	void                       (*serial_out)(struct uart_port *, int, int); /*    72     8 */
	void                       (*set_termios)(struct uart_port *, struct ktermios *, const struct ktermios  *); /*    80     8 */
	void                       (*set_ldisc)(struct uart_port *, struct ktermios *); /*    88     8 */
	unsigned int               (*get_mctrl)(struct uart_port *); /*    96     8 */
	int                        (*handle_irq)(struct uart_port *); /*   104     8 */
	void                       (*pm)(struct uart_port *, unsigned int, unsigned int); /*   112     8 */
	void                       (*handle_break)(struct uart_port *); /*   120     8 */

	/* size: 128, cachelines: 2, members: 21 */
};
---
 include/linux/serial_8250.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 19376bee9667..741ed4807a9c 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -18,16 +18,16 @@ struct plat_serial8250_port {
 	unsigned long	iobase;		/* io base address */
 	void __iomem	*membase;	/* ioremap cookie or NULL */
 	resource_size_t	mapbase;	/* resource base */
+	unsigned int	uartclk;	/* UART clock rate */
 	unsigned int	irq;		/* interrupt number */
 	unsigned long	irqflags;	/* request_irq flags */
-	unsigned int	uartclk;	/* UART clock rate */
 	void            *private_data;
 	unsigned char	regshift;	/* register shift */
 	unsigned char	iotype;		/* UPIO_* */
 	unsigned char	hub6;
 	unsigned char	has_sysrq;	/* supports magic SysRq */
-	upf_t		flags;		/* UPF_* flags */
 	unsigned int	type;		/* If UPF_FIXED_TYPE */
+	upf_t		flags;		/* UPF_* flags */
 	unsigned int	(*serial_in)(struct uart_port *, int);
 	void		(*serial_out)(struct uart_port *, int, int);
 	void		(*set_termios)(struct uart_port *,
-- 
2.34.1

