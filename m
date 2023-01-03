Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E160365B8EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjACBcI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Jan 2023 20:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjACBb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:31:56 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222ABDA7;
        Mon,  2 Jan 2023 17:31:55 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A7F8824E137;
        Tue,  3 Jan 2023 09:31:52 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 09:31:52 +0800
Received: from ubuntu.localdomain (113.72.146.202) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 09:31:52 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/4] riscv: dts: starfive: visionfive-2: Add thermal-zones
Date:   Tue, 3 Jan 2023 09:31:45 +0800
Message-ID: <20230103013145.9570-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230103013145.9570-1-hal.feng@starfivetech.com>
References: <20230103013145.9570-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.202]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add thermal-zones for StarFive VisionFive 2 board.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index c60280b89c73..c7c7735f021d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -27,6 +27,34 @@ memory@40000000 {
 		reg = <0x0 0x40000000 0x1 0x0>;
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <15000>;
+
+			thermal-sensors = <&sfctemp>;
+
+			cooling-maps {
+			};
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					/* milliCelsius */
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu_crit {
+					/* milliCelsius */
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	gpio-restart {
 		compatible = "gpio-restart";
 		gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
-- 
2.38.1

