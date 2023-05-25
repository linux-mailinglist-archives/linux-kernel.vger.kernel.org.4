Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04C07103D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbjEYEG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbjEYEE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:04:59 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE62E65;
        Wed, 24 May 2023 21:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wtCZaz+ygLc5odu0jyJWVuukps/nAVPXx7PU+/vrFgM=; b=Qbt1LRs+4mv0pRnwxJYbf2ZAB6
        2UDi3v8PyYf2TGyY8fXk0bcNmATMeSPqqpDWOeKnKRrd+gunR7FhgZ3OSqpe259puDiO1CUxPvgqJ
        N6+lJEE6ZXipwALuWFPgoMyCXTVOarP2sSNIay4QSLpWLlQzzciypsfiUEOAl8BOyoUE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52970 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q22DM-0001dB-39; Thu, 25 May 2023 00:04:36 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 25 May 2023 00:03:25 -0400
Message-Id: <20230525040324.3773741-12-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525040324.3773741-1-hugo@hugovil.com>
References: <20230525040324.3773741-1-hugo@hugovil.com>
MIME-Version: 1.0
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
Subject: [PATCH v3 11/11] serial: sc16is7xx: add dump registers function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

With this driver, it is very hard to debug the registers using
the /sys/kernel/debug/regmap interface.

The main reason is that bits 0 and 1 of the register address
correspond to the channels bits, so the register address itself starts
at bit 2, so we must 'mentally' shift each register address by 2 bits
to get its offset.

Also, only channels 0 and 1 are supported, so combinations of bits
0 and 1 being 10b and 11b are invalid, and the display of these
registers is useless.

For example:

cat /sys/kernel/debug/regmap/spi0.0/registers
04: 10 -> Port 0, register offset 1
05: 10 -> Port 1, register offset 1
06: 00 -> Port 2, register offset 1 -> invalid
07: 00 -> port 3, register offset 1 -> invalid
...

Add a debug module parameter to call a custom dump function for each
port registers after the probe phase to help debug.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 03d00b144304..693b6cc371f8 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -347,6 +347,10 @@ struct sc16is7xx_port {
 	struct sc16is7xx_one		p[];
 };
 
+static bool debug;
+module_param(debug, bool, 0644);
+MODULE_PARM_DESC(debug, "enable/disable debug messages");
+
 static unsigned long sc16is7xx_lines;
 
 static struct uart_driver sc16is7xx_uart = {
@@ -387,6 +391,28 @@ static void sc16is7xx_port_write(struct uart_port *port, u8 reg, u8 val)
 	regmap_write(s->regmap, (reg << SC16IS7XX_REG_SHIFT) | line, val);
 }
 
+static int sc16is7xx_port_dump(struct uart_port *port)
+{
+	int i;
+	unsigned char *buf;
+	char name[64];
+	const int regs_count_per_port = 16;
+
+	buf = devm_kzalloc(port->dev, regs_count_per_port, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	for (i = 0; i < regs_count_per_port; i++)
+		buf[i] = sc16is7xx_port_read(port, i);
+
+	snprintf(name, sizeof(name), "sc16is7xx %s%i: dump ",
+		 sc16is7xx_uart.dev_name, port->line);
+	print_hex_dump(KERN_ERR, name, DUMP_PREFIX_OFFSET, 16, 1,
+		       &((u8 *)buf)[0], regs_count_per_port, 1);
+
+	return 0;
+}
+
 static void sc16is7xx_fifo_read(struct uart_port *port, unsigned int rxlen)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
@@ -1614,6 +1640,10 @@ static int sc16is7xx_probe(struct device *dev,
 	}
 #endif
 
+	if (debug)
+		for (i = 0; i < devtype->nr_uart; ++i)
+			sc16is7xx_port_dump(&s->p[i].port);
+
 	/*
 	 * Setup interrupt. We first try to acquire the IRQ line as level IRQ.
 	 * If that succeeds, we can allow sharing the interrupt as well.
-- 
2.30.2

