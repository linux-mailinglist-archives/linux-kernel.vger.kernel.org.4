Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC06720611
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjFBP0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbjFBP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:26:44 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A2B18D;
        Fri,  2 Jun 2023 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SuJQI5JxUPzY+H5j7N6gL+Df0hCmvZbTgQvKUtpTEpg=; b=YrlbI3uPnMhTfUHWK0iSG06B3R
        UctC7P53n+VUxJa9vM3J9xTuVlRcB5E8sHvORNwd6SYhKaL5yqCQR331+uTlPW/GUVKX4WoJoWtff
        Jx7pfR/5G+RS2V85igMRgI/6mGZF71eU3sjTgOIKHueI/cPLUTx854kuvg8SHkm81lks=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:50948 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q56fj-0008Hq-7a; Fri, 02 Jun 2023 11:26:36 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Date:   Fri,  2 Jun 2023 11:26:20 -0400
Message-Id: <20230602152626.284324-5-hugo@hugovil.com>
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
Subject: [PATCH v7 4/9] dt-bindings: sc16is7xx: Add property to change GPIO function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Some variants in this series of UART controllers have GPIO pins that
are shared between GPIO and modem control lines.

The pin mux mode (GPIO or modem control lines) can be set for each
ports (channels) supported by the variant.

This adds a property to the device tree to set the GPIO pin mux to
modem control lines on selected ports if needed.

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 .../bindings/serial/nxp,sc16is7xx.txt         | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
index 0fa8e3e43bf8..1a7e4bff0456 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
@@ -23,6 +23,9 @@ Optional properties:
     1 = active low.
 - irda-mode-ports: An array that lists the indices of the port that
 		   should operate in IrDA mode.
+- nxp,modem-control-line-ports: An array that lists the indices of the port that
+				should have shared GPIO lines configured as
+				modem control lines.
 
 Example:
         sc16is750: sc16is750@51 {
@@ -35,6 +38,26 @@ Example:
                 #gpio-cells = <2>;
         };
 
+	sc16is752: sc16is752@53 {
+		compatible = "nxp,sc16is752";
+		reg = <0x53>;
+		clocks = <&clk20m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
+		gpio-controller; /* Port 0 as GPIOs */
+		#gpio-cells = <2>;
+	};
+
+	sc16is752: sc16is752@54 {
+		compatible = "nxp,sc16is752";
+		reg = <0x54>;
+		clocks = <&clk20m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
+	};
+
 * spi as bus
 
 Required properties:
@@ -59,6 +82,9 @@ Optional properties:
     1 = active low.
 - irda-mode-ports: An array that lists the indices of the port that
 		   should operate in IrDA mode.
+- nxp,modem-control-line-ports: An array that lists the indices of the port that
+				should have shared GPIO lines configured as
+				modem control lines.
 
 Example:
 	sc16is750: sc16is750@0 {
@@ -70,3 +96,23 @@ Example:
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	sc16is752: sc16is752@1 {
+		compatible = "nxp,sc16is752";
+		reg = <1>;
+		clocks = <&clk20m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
+		gpio-controller; /* Port 0 as GPIOs */
+		#gpio-cells = <2>;
+	};
+
+	sc16is752: sc16is752@2 {
+		compatible = "nxp,sc16is752";
+		reg = <2>;
+		clocks = <&clk20m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
+	};
-- 
2.30.2

