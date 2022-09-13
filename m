Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3C05B76D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiIMQyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiIMQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:53:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859B6BFEBA;
        Tue, 13 Sep 2022 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663084022; x=1694620022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7z+D4Ltf5HUEkrrqqSRW3ahpsjP+DtOUMGNcad4s4sc=;
  b=E5UafnUQPIIiUYK4A2/QQ4WX47fXb0fwVpmvsjTQaokIhs96dVcvZhXr
   9ck10cALskbKua5EPbB6VTK1EPAwCjn377bLfYHEgO6ZnqQgkaLGrdBjI
   tl5fLgH9ojZwaQOpyvgn/G6accT3oaiIkEuLgBJc/hh33MFNcvc0e/08W
   pt/XZqY4eM2/MZIBOsIvMJv3ecjp6UpyIMO8ZG9Rowktk9NuBA45SKsmK
   XlPZTT/wguchGMNt3T5HGGMwzDgObQAPy/xfQxxb9LetK4ZUAYfVpJuSr
   81pUKsGWnLDdD0kUKLWh+zcwFzHgmmktfxq1/pe5X6t9/kHpYpvBHIYds
   A==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="176926291"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 07:24:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 07:24:44 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 07:24:39 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <sergiu.moga@microchip.com>,
        <admin@hifiphile.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 00/14] Make atmel serial driver aware of GCLK
Date:   Tue, 13 Sep 2022 17:21:52 +0300
Message-ID: <20220913142205.162399-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches introduces the GCLK as a potential clock source for
the baudrate generator of UART on sama5d2 SoCs. Unlike the serial mode of
the USART offered by FLEXCOM, the UART does not provide a fractional part
that can be added to the clock divisor to obtain a more accurate result,
which greatly decreases the flexibility available for producing a higher
variety of baudrates. Now, with the last patch of the series, the driver
will check for a GCLK in the DT. If provided, whenever `atmel_set_termios`
is called, unless there is a fractional part, the driver will compare the
error rate between the desired baudrate and the actual baudrate obtained
through each of the available clock sources and will choose the clock source
with the lowest error rate. While at it, convert the DT binding
for UART/USART to json-schema, update the FLEXCOM binding to reference the
new UART/USART binding (while differentiating between the SPI of USART and the
SPI of FLEXCOM) and do some small DT related fixups.

The DT bindings related patches of this patch series depend on this patch
series converting atmel-flexcom bindings to json-schema:
https://lore.kernel.org/all/20220708115619.254073-1-kavyasree.kotagiri@microchip.com/

v1 -> v2:
- [PATCH 3] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref
    binding:
	- use full schema paths

- [PATCH 5] dt-bindings: serial: atmel,at91-usart: convert to json-schema
	- only do what the commit says, split the addition of other compatibles
	(PATCH 6) and properties (PATCH 13) in other patches
	- remove unnecessary "|"'s
	- mention header in `atmel,usart-mode`'s description
	- place `if:` under `allOf:`
	- respect order of spi0's DT properties: compatible, then reg then the
	reset of properties

- two new baudrate clock source related patches:
  [PATCH 9] tty: serial: atmel: Add definition for GCLK as baudrate source clock
			+
  [PATCH 10] tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode
    Register:
	- v1's bitfield definition of GCLK was wrong, so add two more patches:
		- one for the definition of GCLK of USART IP's
		- one for the definition of BRSRCCK bitmask and its bitfields
		for UART IP's

- a new cleanup related patch that introduces a new struct atmel_uart_port field:
  [PATCH 11] tty: serial: atmel: Only divide Clock Divisor if the IP is USART:
  	- this ensures a division by 8 which is unnecessary and unappliable to
	UART IP's is only done for USART IP's

- four new patches regarding DT fixes and a SPI binding update that I came
upon:
  [PATCH 1] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA related properties
  [PATCH 2] ARM: dts: at91: sama7g5: Swap rx and tx for spi11
  [PATCH 4] ARM: dts: at91: sam9x60ek: Add DBGU compatibles to uart1
  [PATCH 6] dt-bindings: serial: atmel,at91-usart: Highlight SAM9X60 incremental

- [PATCH 12] tty: serial: atmel: Make the driver aware of the existence of GCLK
	- take into account the different placement of the baudrate clock source
	into the IP's Mode Register (USART vs UART)
	- don't check for atmel_port->gclk != NULL
	- use clk_round_rate instead of clk_set_rate + clk_get_rate
	- remove clk_disable_unprepare from the end of the probe method

v2 -> v3:
- Re-order the patches as suggested by Krzysztof Kozlowski:
1. DTS changes needed for aligning to schema.
2. all bindings
3. rest

- New DT consistency related patch:
  [PATCH 3] ARM: dts: at91: Add `atmel,usart-mode` required property to serial
    nodes

- [PATCH 6] dt-bindings: serial: atmel,at91-usart: convert to json-schema:
  - Check value of `atmel,usart-mode` instead of the node regex
  - Define all properties top level and disallow them explicitly for other type,
  since additionalProperties:false conflicts with referencing other schemas
  - Remove useless else if: after else:

- [PATCH 7] dt-bindings: serial: atmel,at91-usart: add SAM9260 compatibles to
  SAM9X60:
  - Use the commit message suggested by Krzysztof Kozlowski

- [PATCH 8] dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref
  binding
  - Compare devices based on the compatible instead of the clock

- [PATCH 12] tty: serial: atmel: Only divide Clock Divisor if the IP is USART
  - Use ATMEL_US_CD instead of 65535

- [PATCH 14] tty: serial: atmel: Make the driver aware of the existence of GCLK
  - add `gclk_fail` goto
  - replace `goto err` with `goto err_clk_disable_unprepare;`


Sergiu Moga (14):
  ARM: dts: at91: sama7g5: Swap rx and tx for spi11
  ARM: dts: at91: sam9x60ek: Add DBGU compatibles to uart1
  ARM: dts: at91: Add `atmel,usart-mode` required property to serial
    nodes
  spi: dt-bindings: atmel,at91rm9200-spi: Add DMA related properties
  dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref
    binding
  dt-bindings: serial: atmel,at91-usart: convert to json-schema
  dt-bindings: serial: atmel,at91-usart: Add SAM9260 compatibles to
    SAM9X60
  dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref
    binding
  dt-bindings: serial: atmel,at91-usart: Add gclk as a possible USART
    clock
  tty: serial: atmel: Define GCLK as USART baudrate source clock
  tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode Register
  tty: serial: atmel: Only divide Clock Divisor if the IP is USART
  clk: at91: sama5d2: Add Generic Clocks for UART/USART
  tty: serial: atmel: Make the driver aware of the existence of GCLK

 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   |  19 +-
 .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
 .../bindings/serial/atmel,at91-usart.yaml     | 190 ++++++++++++++++++
 .../bindings/spi/atmel,at91rm9200-spi.yaml    |  10 +
 arch/arm/boot/dts/at91-sam9x60ek.dts          |   3 +-
 arch/arm/boot/dts/at91rm9200.dtsi             |   6 +
 arch/arm/boot/dts/at91sam9260.dtsi            |   8 +
 arch/arm/boot/dts/at91sam9261.dtsi            |   5 +
 arch/arm/boot/dts/at91sam9263.dtsi            |   5 +
 arch/arm/boot/dts/at91sam9g45.dtsi            |   6 +
 arch/arm/boot/dts/at91sam9n12.dtsi            |   6 +
 arch/arm/boot/dts/at91sam9rl.dtsi             |   6 +
 arch/arm/boot/dts/at91sam9x5.dtsi             |   7 +
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi      |   2 +
 arch/arm/boot/dts/sam9x60.dtsi                |   2 +
 arch/arm/boot/dts/sama5d2.dtsi                |  11 +
 arch/arm/boot/dts/sama5d3.dtsi                |   7 +
 arch/arm/boot/dts/sama5d3_uart.dtsi           |   3 +
 arch/arm/boot/dts/sama5d4.dtsi                |   9 +
 arch/arm/boot/dts/sama7g5.dtsi                |  11 +-
 drivers/clk/at91/sama5d2.c                    |  10 +
 drivers/tty/serial/atmel_serial.c             |  76 ++++++-
 drivers/tty/serial/atmel_serial.h             |   4 +
 23 files changed, 394 insertions(+), 110 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml

-- 
2.34.1

