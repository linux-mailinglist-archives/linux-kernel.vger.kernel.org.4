Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650B47103D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbjEYEGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjEYEEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:04:51 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD57E62;
        Wed, 24 May 2023 21:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9uFf80nuPq7IpOBCTtsrmsGYtNovsW/4uJuo42PakOo=; b=hZS8RhBGHMEWLID3br+gSAdS39
        WNwEED5LXP+qFQrO0SMH4y60c3mBJasKvbCKoLvBfl7dcE1drHXktQSModQe0c9gXeMrMzRV8IVgR
        XTy5IQ0QncyR5VRTIM4p2KUUwtvNMtP35sRxeB6GinMfzzB5l+wz4CcO7mFLpQV2zIwY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52970 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q22DJ-0001dB-5g; Thu, 25 May 2023 00:04:34 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 25 May 2023 00:03:23 -0400
Message-Id: <20230525040324.3773741-10-hugo@hugovil.com>
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
Subject: [PATCH v3 09/11] serial: sc16is7xx: add I/O register translation offset
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If the shared GPIO pins on a dual port/channel variant like the
SC16IS752 are configured as GPIOs for port A, and modem control lines
on port A, we need to translate the Linux GPIO offset to an offset
that is compatible with the I/O registers of the SC16IS7XX (IOState,
IODir and IOIntEna).

Add a new variable to store that offset and set it when we detect that
special case.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 54 +++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 97ec532a0a19..c2cfd057ed9a 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -338,6 +338,7 @@ struct sc16is7xx_port {
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip		gpio;
 	int				gpio_configured;
+	int				gpio_offset;
 #endif
 	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
 	struct kthread_worker		kworker;
@@ -1298,12 +1299,50 @@ static const struct uart_ops sc16is7xx_ops = {
 };
 
 #ifdef CONFIG_GPIOLIB
+
+/*
+ * We may need to translate the Linux GPIO offset to a SC16IS7XX offset.
+ * This is needed only for the case where a dual port variant is configured to
+ * have only port B as modem status lines.
+ *
+ * Example for SC16IS752/762 with upper bank (port A) set as GPIOs, and
+ * lower bank (port B) set as modem status lines (special case described above):
+ *
+ * Pin         GPIO pin     Linux GPIO     SC16IS7XX
+ * name        function     offset         offset
+ * --------------------------------------------------
+ * GPIO7/RIA    GPIO7          3              7
+ * GPIO6/CDA    GPIO6          2              6
+ * GPIO5/DTRA   GPIO5          1              5
+ * GPIO4/DSRA   GPIO4          0              4
+ * GPIO3/RIB    RIB           N/A            N/A
+ * GPIO2/CDB    CDB           N/A            N/A
+ * GPIO1/DTRB   DTRB          N/A            N/A
+ * GPIO0/DSRB   DSRB          N/A            N/A
+ *
+ * Example  for SC16IS750/760 with upper bank (7..4) set as modem status lines,
+ * and lower bank (3..0) as GPIOs:
+ *
+ * Pin         GPIO pin     Linux GPIO     SC16IS7XX
+ * name        function     offset         offset
+ * --------------------------------------------------
+ * GPIO7/RI     RI            N/A            N/A
+ * GPIO6/CD     CD            N/A            N/A
+ * GPIO5/DTR    DTR           N/A            N/A
+ * GPIO4/DSR    DSR           N/A            N/A
+ * GPIO3        GPIO3          3              3
+ * GPIO2        GPIO2          2              2
+ * GPIO1        GPIO1          1              1
+ * GPIO0        GPIO0          0              0
+ */
+
 static int sc16is7xx_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	unsigned int val;
 	struct sc16is7xx_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[0].port;
 
+	offset += s->gpio_offset;
 	val = sc16is7xx_port_read(port, SC16IS7XX_IOSTATE_REG);
 
 	return !!(val & BIT(offset));
@@ -1314,6 +1353,7 @@ static void sc16is7xx_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
 	struct sc16is7xx_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[0].port;
 
+	offset += s->gpio_offset;
 	sc16is7xx_port_update(port, SC16IS7XX_IOSTATE_REG, BIT(offset),
 			      val ? BIT(offset) : 0);
 }
@@ -1324,6 +1364,7 @@ static int sc16is7xx_gpio_direction_input(struct gpio_chip *chip,
 	struct sc16is7xx_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[0].port;
 
+	offset += s->gpio_offset;
 	sc16is7xx_port_update(port, SC16IS7XX_IODIR_REG, BIT(offset), 0);
 
 	return 0;
@@ -1336,6 +1377,8 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 	struct uart_port *port = &s->p[0].port;
 	u8 state = sc16is7xx_port_read(port, SC16IS7XX_IOSTATE_REG);
 
+	offset += s->gpio_offset;
+
 	if (val)
 		state |= BIT(offset);
 	else
@@ -1395,6 +1438,7 @@ static int sc16is7xx_probe(struct device *dev,
 
 #ifdef CONFIG_GPIOLIB
 	s->gpio_configured = devtype->nr_gpio;
+	s->gpio_offset = 0;
 #endif /* CONFIG_GPIOLIB */
 
 	/* Always ask for fixed clock rate from a property. */
@@ -1529,16 +1573,24 @@ static int sc16is7xx_probe(struct device *dev,
 #endif /* CONFIG_GPIOLIB */
 			}
 
-		if (val)
+		if (val) {
+#ifdef CONFIG_GPIOLIB
+			/* Additional I/O regs offset. */
+			if (val == SC16IS7XX_IOCONTROL_MODEM_B_BIT)
+				s->gpio_offset = SC16IS7XX_GPIOS_PER_BANK;
+#endif /* CONFIG_GPIOLIB */
+
 			regmap_update_bits(
 				s->regmap,
 				SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
 				SC16IS7XX_IOCONTROL_MODEM_A_BIT |
 				SC16IS7XX_IOCONTROL_MODEM_B_BIT, val);
+		}
 	}
 
 #ifdef CONFIG_GPIOLIB
 	dev_dbg(dev, "GPIOs to configure: %d\n", s->gpio_configured);
+	dev_dbg(dev, "GPIOs offset: %d\n", s->gpio_offset);
 
 	if (s->gpio_configured) {
 		/* Setup GPIO controller */
-- 
2.30.2

