Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8DC732F32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbjFPK5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345469AbjFPK4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:56:43 -0400
Received: from mail-ed1-x561.google.com (mail-ed1-x561.google.com [IPv6:2a00:1450:4864:20::561])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7130A83C9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:48:41 -0700 (PDT)
Received: by mail-ed1-x561.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so3532584a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google; t=1686912520; x=1689504520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6sTC5pGl6XNZzwmeNOE7S97A8pGrSyNQTyHwRNfok4=;
        b=H7e4PJE/COEkCn7uTaLOPIHdqIsgSCthKaI8FdezrQFFKELM6pfMfr8Z1F7eOuAaq2
         j+CERzJ+3Dfjmjk8LJXwQWZxJZdhNekRWlMPyhuXq6SxKVj9kxnwtQAACMxogox2fwtl
         +zOwbQ69G9kgDuAmbLT799Zd2rEJkbUzA/OH47llA4lm2qMkO3OeBFVyQ+fVMnmdg0Q5
         1OFRxpPxdq0usTLnqSpFpmCaowj8HSi7qsWRcmpcP9RE3q8aCedi1ERnzBEgpFiNXFVG
         8dSCBxqjzWbyGY2pWEbkqmlUNgqaBDoU+4nb0IKgIgIHRUoHK+66fS6ByPeTSv98yN0G
         YXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686912520; x=1689504520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6sTC5pGl6XNZzwmeNOE7S97A8pGrSyNQTyHwRNfok4=;
        b=DycRg4wGJaDSFucAOm57KDG5UimTEoIqiADJvro6OIoqkyau/Cfx0EqNFXwKZu1XNP
         le89VDmLFfiPs0910NdvQbWopyzCUiHUrAGTnpiOMjr6cseGwCIxENOUnr9i+whVQWko
         A1JkJ2B/v5jPilykAgKTW8ADJVwxA9o5o5VjTjFQq/WEhKTwe+SxGR3RtxfgrQFhh2ii
         UFipgIfqLQM8mSTccczNqkYJ/IJ9/rubYZjFjA/eg4Jai2E7XW9QkaPe0zbTKzolMuJd
         su9t39hKDYVjZrWvAPQzpKZFByedfvDhxIwtVxYLz6YpzH07mNK8fmu9FZyawofRNVTk
         vohA==
X-Gm-Message-State: AC+VfDyWH5aZamDUJVzJKGrjmkz0iu+M0BjCnbOI1oHMBWrBnAwnFeVj
        IxKDTzB1HeP+4cUuJwacPWg3+HbIXzTSmAacTIEY7IMvxn1Q
X-Google-Smtp-Source: ACHHUZ60gXe4Q/+sJTSC6YdsfA/nL9NJtZAhb8u35HcJ9uttZCHSH+pIn9G6B+2RlR6ILarkqm4H1xKm/r3r
X-Received: by 2002:a17:907:d11:b0:96f:9cea:a34d with SMTP id gn17-20020a1709070d1100b0096f9ceaa34dmr7697675ejc.21.1686912519734;
        Fri, 16 Jun 2023 03:48:39 -0700 (PDT)
Received: from mta1.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id cs20-20020a170906dc9400b0098634569b96sm1092294ejc.288.2023.06.16.03.48.39
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2023 03:48:39 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.12.142] (port=33732 helo=FR-BES-DKT15120.home)
        by mta1.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1qA72r-0000gy-MC; Fri, 16 Jun 2023 12:51:09 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: imx: fix rs485 rx after tx
Date:   Fri, 16 Jun 2023 12:47:23 +0200
Message-Id: <20230616104838.2729694-1-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal
active high") RS485 reception no longer works after a transmission.

The following scenario shows the problem:
	1) Open a port in RS485 mode
	2) Receive data from remote (OK)
	3) Transmit data to remote (OK)
	4) Receive data from remote (Nothing received)

In RS485 mode, imx_uart_start_tx() calls imx_uart_stop_rx() and, when the
transmission is complete, imx_uart_stop_tx() calls imx_uart_start_rx().

Since the above commit imx_uart_stop_rx() now sets the loopback bit but
imx_uart_start_rx() does not clear it causing the hardware to remain in
loopback mode and not receive external data.

Fix this by moving the existing loopback disable code to a helper function
and calling it from imx_uart_start_rx() too.

Fixes: 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal active high")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---
 drivers/tty/serial/imx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c5e17569c3ad..3fe8ff241522 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -369,6 +369,16 @@ static void imx_uart_soft_reset(struct imx_port *sport)
 	sport->idle_counter = 0;
 }
 
+static void imx_uart_disable_loopback_rs485(struct imx_port *sport)
+{
+	unsigned int uts;
+
+	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
+	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
+	uts &= ~UTS_LOOP;
+	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
@@ -390,6 +400,7 @@ static void imx_uart_start_rx(struct uart_port *port)
 	/* Write UCR2 first as it includes RXEN */
 	imx_uart_writel(sport, ucr2, UCR2);
 	imx_uart_writel(sport, ucr1, UCR1);
+	imx_uart_disable_loopback_rs485(sport);
 }
 
 /* called with port.lock taken and irqs off */
@@ -1422,7 +1433,7 @@ static int imx_uart_startup(struct uart_port *port)
 	int retval;
 	unsigned long flags;
 	int dma_is_inited = 0;
-	u32 ucr1, ucr2, ucr3, ucr4, uts;
+	u32 ucr1, ucr2, ucr3, ucr4;
 
 	retval = clk_prepare_enable(sport->clk_per);
 	if (retval)
@@ -1521,10 +1532,7 @@ static int imx_uart_startup(struct uart_port *port)
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
-	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
-	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
-	uts &= ~UTS_LOOP;
-	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+	imx_uart_disable_loopback_rs485(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-- 
2.25.1

