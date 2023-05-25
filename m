Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E147103CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbjEYEG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbjEYEEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:04:37 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB31A1B5;
        Wed, 24 May 2023 21:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oAW87YGFqDuCb1wMiNK8HhUC7h6jxZ7gmJadiuchbuo=; b=vzd6l2eDsrKJ2VXxs4taDBf9O4
        Oc6N48Z1YTxaN2yl0G5InFPkYbU2KEuvAVEzFu++jEqX4jQkU+JNyeovO+Xs2OtA/uUn5I86gLMo9
        2FguvfKwHawczsuTTkU5ddA7MzzVFzcfhbVrBWCIk9P430oYf6ei8yAT39I0RbcllF5I=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52970 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q22DE-0001dB-DC; Thu, 25 May 2023 00:04:28 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 25 May 2023 00:03:20 -0400
Message-Id: <20230525040324.3773741-7-hugo@hugovil.com>
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
Subject: [PATCH v3 06/11] serial: sc16is7xx: fix bug when first setting GPIO direction
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

When we want to configure a pin as an output pin with a value of logic
0, we end up as having a value of logic 1 on the output pin. Setting a
logic 0 a second time (or more) after that will correctly output a
logic 0 on the output pin.

By default, all GPIO pins are configured as inputs. When we enter
c16is7xx_gpio_direction_output() for the first time, we first set the
desired value in IOSTATE, and then we configure the pin as an output.
The datasheet states that writing to IOSTATE register will trigger a
transfer of the value to the I/O pin configured as output, so if the
pin is configured as an input, nothing will be transferred.

Therefore, set the direction first in IODIR, and then set the desired
value in IOSTATE.

This is what is done in NXP application note AN10587.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 8a2fc6f89d36..a5d8af0f6da0 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1343,9 +1343,18 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 		state |= BIT(offset);
 	else
 		state &= ~BIT(offset);
-	sc16is7xx_port_write(port, SC16IS7XX_IOSTATE_REG, state);
+
+	/*
+	 * If we write IOSTATE first, and then IODIR, the output value is not
+	 * transferred to the corresponding I/O pin.
+	 * The datasheet states that each register bit will be transferred to
+	 * the corresponding I/O pin programmed as output when writing to
+	 * IOSTATE. Therefore, configure direction first with IODIR, and then
+	 * set value after with IOSTATE.
+	 */
 	sc16is7xx_port_update(port, SC16IS7XX_IODIR_REG, BIT(offset),
 			      BIT(offset));
+	sc16is7xx_port_write(port, SC16IS7XX_IOSTATE_REG, state);
 
 	return 0;
 }
-- 
2.30.2

