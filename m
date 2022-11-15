Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543EF629251
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiKOHRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKOHRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:17:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8391DF05;
        Mon, 14 Nov 2022 23:17:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61D36B816D4;
        Tue, 15 Nov 2022 07:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B151BC433D6;
        Tue, 15 Nov 2022 07:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668496648;
        bh=4+/EQQYq7onpYQWLzcvcEdnGKo/7iYZ/uL0MrdW6F24=;
        h=From:To:Cc:Subject:Date:From;
        b=U2fZHfaNEO1BH3jEhS2mhHKTOSJgcQ5Icu5Qu1JDBg9q4iyq4KiQcyVszU7pARyZm
         0tD8X4lqMzghdB8FOYY49ZZDYpElPIk5RxW0JeDQbFgXOz/GSG8EfQSxsxNR0xCRIE
         eKuIrF3F/YV+nb9W9gjAuWze/9Ko/uIyCzCwQEVVvm5n5dwtI6mPi83j1/uII2PNAS
         1i65qXsclBHab/uLWk1tA08agPVljXyBht/wHtw4zSk71Boqu+Fgwz4K3WNIzTBhS1
         38c0ULOo5HZu1v+qpJs8eLG6ih5mRahawUFqcDN3/Vb+KNhBV8ZYG8lZ3bJezyxe0O
         AOZ54uzpS2FEA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 1/4] tty: serial: altera_jtaguart: remove flag from altera_jtaguart_rx_chars()
Date:   Tue, 15 Nov 2022 08:17:21 +0100
Message-Id: <20221115071724.5185-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TTY_NORMAL is the only value it contains, so remove the variable and use
the constant instead.

Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/altera_jtaguart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index aa49553fac58..8d1729711584 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -126,18 +126,17 @@ static void altera_jtaguart_set_termios(struct uart_port *port,
 static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
 {
 	struct uart_port *port = &pp->port;
-	unsigned char ch, flag;
+	unsigned char ch;
 	unsigned long status;
 
 	while ((status = readl(port->membase + ALTERA_JTAGUART_DATA_REG)) &
 	       ALTERA_JTAGUART_DATA_RVALID_MSK) {
 		ch = status & ALTERA_JTAGUART_DATA_DATA_MSK;
-		flag = TTY_NORMAL;
 		port->icount.rx++;
 
 		if (uart_handle_sysrq_char(port, ch))
 			continue;
-		uart_insert_char(port, 0, 0, ch, flag);
+		uart_insert_char(port, 0, 0, ch, TTY_NORMAL);
 	}
 
 	tty_flip_buffer_push(&port->state->port);
-- 
2.38.1

