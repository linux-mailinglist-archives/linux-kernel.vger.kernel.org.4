Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC870720600
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbjFBP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbjFBP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:26:42 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F4D1BB;
        Fri,  2 Jun 2023 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vlvSfJ7BB6pGJBxrOhJ5IMJLf95UIyksZ/69U1YnCu4=; b=bKChWXh4jkp3ScQwcUn5nZ+CEx
        OVkmEl5LRViMYgTLztidHjR/jn72t/IgFwBltYly5wbMs5ruLeb5Fk8lNHwzqFBCnbZPTrfHEfL7J
        J8ilXzfm69XjobFU+SWs/xoI3luVcwY2LZKai7CQjpKaTF59Byv5pfIDKczayLuqIucg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:50948 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q56ff-0008Hq-Bd; Fri, 02 Jun 2023 11:26:31 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Date:   Fri,  2 Jun 2023 11:26:17 -0400
Message-Id: <20230602152626.284324-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602152626.284324-1-hugo@hugovil.com>
References: <20230602152626.284324-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v7 1/9] serial: sc16is7xx: fix broken port 0 uart init
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The sc16is7xx_config_rs485() function is called only for the second
port (index 1, channel B), causing initialization problems for the
first port.

For the sc16is7xx driver, port->membase and port->mapbase are not set,
and their default values are 0. And we set port->iobase to the device
index. This means that when the first device is registered using the
uart_add_one_port() function, the following values will be in the port
structure:
    port->membase = 0
    port->mapbase = 0
    port->iobase  = 0

Therefore, the function uart_configure_port() in serial_core.c will
exit early because of the following check:
	/*
	 * If there isn't a port here, don't do anything further.
	 */
	if (!port->iobase && !port->mapbase && !port->membase)
		return;

Typically, I2C and SPI drivers do not set port->membase and
port->mapbase.

The max310x driver sets port->membase to ~0 (all ones). By
implementing the same change in this driver, uart_configure_port() is
now correctly executed for all ports.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index abad091baeea..faa51a58671f 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1436,6 +1436,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
 		s->p[i].port.iobase	= i;
+		s->p[i].port.membase	= (void __iomem *)~0;
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
-- 
2.30.2

