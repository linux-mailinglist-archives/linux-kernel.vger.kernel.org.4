Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7E720618
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbjFBP1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbjFBP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:26:48 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D47DE51;
        Fri,  2 Jun 2023 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=etX1eReG3B/ARZ7SD1XT7kh2ByzRv1fad++pPUx0hY4=; b=JKL29oOdYC2HW/+7FoZA0EUav8
        4WzsQ3YrXmeLiyxhvFKxuW/zsOMZAIkrF+iiJsiqVFxk4208WxqIX4V9K18DvCstc7EY5JHGQv6/d
        pgc/LTkZ+FdpOpPWJqnKMht0WX7i5k8HAk1Svc4GChZyolDwbMm0eluMMBwAN1/paT/0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:50948 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q56fl-0008Hq-2s; Fri, 02 Jun 2023 11:26:38 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri,  2 Jun 2023 11:26:21 -0400
Message-Id: <20230602152626.284324-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602152626.284324-1-hugo@hugovil.com>
References: <20230602152626.284324-1-hugo@hugovil.com>
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
Subject: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
changed the function of the GPIOs pins to act as modem control
lines without any possibility of selecting GPIO function.

As a consequence, applications that depends on GPIO lines configured
by default as GPIO pins no longer work as expected.

Also, the change to select modem control lines function was done only
for channel A of dual UART variants (752/762). This was not documented
in the log message.

Allow to specify GPIO or modem control line function in the device
tree, and for each of the ports (A or B).

Do so by using the new device-tree property named
"modem-control-line-ports" (property added in separate patch).

When registering GPIO chip controller, mask-out GPIO pins declared as
modem control lines according to this new "modem-control-line-ports"
DT property.

Boards that need to have GPIOS configured as modem control lines
should add that property to their device tree. Here is a list of
boards using the sc16is7xx driver in their device tree and that may
need to be modified:
    arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
    mips/boot/dts/ingenic/cu1830-neo.dts
    mips/boot/dts/ingenic/cu1000-neo.dts

Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
Cc: <stable@vger.kernel.org> # 6.1.x: 35210b22 dt-bindings: sc16is7xx: Add property to change GPIO function
Cc: <stable@vger.kernel.org> # 6.1.x: 7d61ca47 serial: sc16is7xx: refactor GPIO controller registration
Cc: <stable@vger.kernel.org> # 6.1.x: 322470ed serial: sc16is7xx: mark IOCONTROL register as volatile
Cc: <stable@vger.kernel.org> # 6.1.x: a0077362 serial: sc16is7xx: fix broken port 0 uart init
Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 103 ++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7d50674d2d0e..edc83f5f6340 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -236,7 +236,8 @@
 
 /* IOControl register bits (Only 750/760) */
 #define SC16IS7XX_IOCONTROL_LATCH_BIT	(1 << 0) /* Enable input latching */
-#define SC16IS7XX_IOCONTROL_MODEM_BIT	(1 << 1) /* Enable GPIO[7:4] as modem pins */
+#define SC16IS7XX_IOCONTROL_MODEM_A_BIT	(1 << 1) /* Enable GPIO[7:4] as modem A pins */
+#define SC16IS7XX_IOCONTROL_MODEM_B_BIT	(1 << 2) /* Enable GPIO[3:0] as modem B pins */
 #define SC16IS7XX_IOCONTROL_SRESET_BIT	(1 << 3) /* Software Reset */
 
 /* EFCR register bits */
@@ -301,12 +302,12 @@
 /* Misc definitions */
 #define SC16IS7XX_FIFO_SIZE		(64)
 #define SC16IS7XX_REG_SHIFT		2
+#define SC16IS7XX_GPIOS_PER_BANK	4
 
 struct sc16is7xx_devtype {
 	char	name[10];
 	int	nr_gpio;
 	int	nr_uart;
-	int	has_mctrl;
 };
 
 #define SC16IS7XX_RECONF_MD		(1 << 0)
@@ -336,6 +337,7 @@ struct sc16is7xx_port {
 	struct clk			*clk;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip		gpio;
+	unsigned long			gpio_valid_mask;
 #endif
 	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
 	struct kthread_worker		kworker;
@@ -447,35 +449,30 @@ static const struct sc16is7xx_devtype sc16is74x_devtype = {
 	.name		= "SC16IS74X",
 	.nr_gpio	= 0,
 	.nr_uart	= 1,
-	.has_mctrl	= 0,
 };
 
 static const struct sc16is7xx_devtype sc16is750_devtype = {
 	.name		= "SC16IS750",
-	.nr_gpio	= 4,
+	.nr_gpio	= 8,
 	.nr_uart	= 1,
-	.has_mctrl	= 1,
 };
 
 static const struct sc16is7xx_devtype sc16is752_devtype = {
 	.name		= "SC16IS752",
-	.nr_gpio	= 0,
+	.nr_gpio	= 8,
 	.nr_uart	= 2,
-	.has_mctrl	= 1,
 };
 
 static const struct sc16is7xx_devtype sc16is760_devtype = {
 	.name		= "SC16IS760",
-	.nr_gpio	= 4,
+	.nr_gpio	= 8,
 	.nr_uart	= 1,
-	.has_mctrl	= 1,
 };
 
 static const struct sc16is7xx_devtype sc16is762_devtype = {
 	.name		= "SC16IS762",
-	.nr_gpio	= 0,
+	.nr_gpio	= 8,
 	.nr_uart	= 2,
-	.has_mctrl	= 1,
 };
 
 static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
@@ -1350,16 +1347,45 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static int sc16is7xx_setup_gpio_chip(struct device *dev)
+static int sc16is7xx_gpio_init_valid_mask(struct gpio_chip *chip,
+					  unsigned long *valid_mask,
+					  unsigned int ngpios)
+{
+	struct sc16is7xx_port *s = gpiochip_get_data(chip);
+
+	*valid_mask = s->gpio_valid_mask;
+
+	return 0;
+}
+
+static int sc16is7xx_setup_gpio_chip(struct device *dev, u8 mctrl_mask)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(dev);
 
 	if (!s->devtype->nr_gpio)
 		return 0;
 
+	switch (mctrl_mask) {
+	case 0:
+		s->gpio_valid_mask = GENMASK(7, 0);
+		break;
+	case SC16IS7XX_IOCONTROL_MODEM_A_BIT:
+		s->gpio_valid_mask = GENMASK(3, 0);
+		break;
+	case SC16IS7XX_IOCONTROL_MODEM_B_BIT:
+		s->gpio_valid_mask = GENMASK(7, 4);
+		break;
+	default:
+		break;
+	}
+
+	if (s->gpio_valid_mask == 0)
+		return 0;
+
 	s->gpio.owner		 = THIS_MODULE;
 	s->gpio.parent		 = dev;
 	s->gpio.label		 = dev_name(dev);
+	s->gpio.init_valid_mask	 = sc16is7xx_gpio_init_valid_mask;
 	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
 	s->gpio.get		 = sc16is7xx_gpio_get;
 	s->gpio.direction_output = sc16is7xx_gpio_direction_output;
@@ -1371,6 +1397,44 @@ static int sc16is7xx_setup_gpio_chip(struct device *dev)
 }
 #endif
 
+static u8 sc16is7xx_setup_mctrl_ports(struct device *dev)
+{
+	struct sc16is7xx_port *s = dev_get_drvdata(dev);
+	int i;
+	int ret;
+	int count;
+	u32 mctrl_port[2];
+	u8 mctrl_mask;
+
+	count = device_property_count_u32(dev, "nxp,modem-control-line-ports");
+	if (count < 0 || count > ARRAY_SIZE(mctrl_port))
+		return 0;
+
+	ret = device_property_read_u32_array(dev, "nxp,modem-control-line-ports",
+					     mctrl_port, count);
+	if (ret)
+		return 0;
+
+	mctrl_mask = 0;
+
+	for (i = 0; i < count; i++) {
+		/* Use GPIO lines as modem control lines */
+		if (mctrl_port[i] == 0)
+			mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
+		else if (mctrl_port[i] == 1)
+			mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
+	}
+
+	if (mctrl_mask)
+		regmap_update_bits(
+			s->regmap,
+			SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
+			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
+			SC16IS7XX_IOCONTROL_MODEM_B_BIT, mctrl_mask);
+
+	return mctrl_mask;
+}
+
 static const struct serial_rs485 sc16is7xx_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
@@ -1383,6 +1447,7 @@ static int sc16is7xx_probe(struct device *dev,
 {
 	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
 	unsigned int val;
+	u8 mctrl_mask;
 	u32 uartclk = 0;
 	int i, ret;
 	struct sc16is7xx_port *s;
@@ -1478,12 +1543,6 @@ static int sc16is7xx_probe(struct device *dev,
 				     SC16IS7XX_EFCR_RXDISABLE_BIT |
 				     SC16IS7XX_EFCR_TXDISABLE_BIT);
 
-		/* Use GPIO lines as modem status registers */
-		if (devtype->has_mctrl)
-			sc16is7xx_port_write(&s->p[i].port,
-					     SC16IS7XX_IOCONTROL_REG,
-					     SC16IS7XX_IOCONTROL_MODEM_BIT);
-
 		/* Initialize kthread work structs */
 		kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
 		kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
@@ -1521,8 +1580,10 @@ static int sc16is7xx_probe(struct device *dev,
 				s->p[u].irda_mode = true;
 	}
 
+	mctrl_mask = sc16is7xx_setup_mctrl_ports(dev);
+
 #ifdef CONFIG_GPIOLIB
-	ret = sc16is7xx_setup_gpio_chip(dev);
+	ret = sc16is7xx_setup_gpio_chip(dev, mctrl_mask);
 	if (ret)
 		goto out_thread;
 #endif
@@ -1547,7 +1608,7 @@ static int sc16is7xx_probe(struct device *dev,
 		return 0;
 
 #ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio)
+	if (s->gpio_valid_mask)
 		gpiochip_remove(&s->gpio);
 
 out_thread:
@@ -1573,7 +1634,7 @@ static void sc16is7xx_remove(struct device *dev)
 	int i;
 
 #ifdef CONFIG_GPIOLIB
-	if (s->devtype->nr_gpio)
+	if (s->gpio_valid_mask)
 		gpiochip_remove(&s->gpio);
 #endif
 
-- 
2.30.2

