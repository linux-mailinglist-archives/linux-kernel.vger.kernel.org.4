Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387F95E616C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiIVLmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiIVLmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:42:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81389B843;
        Thu, 22 Sep 2022 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663846934; x=1695382934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h4RtjIzXLWK5epTWueE8Vm3jsayEzVLuddfdK7Akvws=;
  b=cCkd1B3oquXRKrsj+/aDEibpkdiB0flY7dnHH/hc8piTiVU7/w/DmsGe
   ExecArRAfbZwFOTGhs598LEGjUglqqW0YOBWqFYtOcOqbiwSFsx0iQT4y
   d6VCYkdxGzO1hJ4VSe48G2gxQFqBogq6r62xrD/T5Bg3EuTy0/PJFv2vP
   sbHmsLChVvyW0O2GgKaEEdxhuY1hu+bh3RCZWwCBYabUoPEQCZGmp17k3
   kZxKu5qDWSFJIaxuNZI3vd6R3R0JbR9GvrcYq0zD197EXBTkWeBUzgZZv
   poQNCy7hx8ix6Nk5B88BZq149bqKCVCU6Oi7sY1Ex1eUFLHghZeEXgO7w
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="114897412"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2022 04:42:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 22 Sep 2022 04:42:13 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 22 Sep 2022 04:42:07 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v5 0/9] Make atmel serial driver aware of GCLK
Date:   Thu, 22 Sep 2022 14:33:38 +0300
Message-ID: <20220922113347.144383-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches introduces the GCLK as a clock source for
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
SPI of FLEXCOM), do some small DT related fixups and do some small driver
cleanup.

The DT bindings related patches of this patch series depend on this patch
series converting atmel-flexcom bindings to json-schema:
https://lore.kernel.org/linux-arm-kernel/20220916075744.1879428-1-kavyasree.kotagiri@microchip.com/

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


v3 -> v4:
- Remove the first 4 patches as they have already been applied
https://lore.kernel.org/linux-arm-kernel/b537bbcf-cb0f-551d-6dd0-cf50864bafa3@microchip.com/
https://lore.kernel.org/linux-arm-kernel/53e72e5d-47fc-403d-c969-61b267a9ff15@microchip.com/
https://lore.kernel.org/linux-arm-kernel/1ae89854-74fa-6194-304f-db31d56d3674@microchip.com/
https://lore.kernel.org/linux-arm-kernel/3234cd79-65db-1210-50c1-e880ec6d87a0@microchip.com/
- Remove the addition of gclk's to sama5d2 clock driver as it has already been applied
https://lore.kernel.org/linux-arm-kernel/4b23db7d-d6b2-6c93-01f7-6a3b86f403d1@microchip.com/
- [PATCH 2] -> [PATCH 5]
  - add Acked-by/Reviewed-by tags to DT bindings
- [PATCH 8]
  - replace & with min_t



v4 -> v5:
- squash previous
`[PATCH v4 7/9] tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode Register`
into a newly added
`[PATCH v5 6/9] tty: serial: atmel: Separate mode clearing between UART and USART`
whose role is mainly of cleanup and to make a clear separation between the
clearing of the mode for UART vs USART and make BRSRCCK into a bitfield
instead of a bitmask as it is only a bit.
- squash previous
`[PATCH v4 6/9] tty: serial: atmel: Define GCLK as USART baudrate source clock`
into the current
`[PATCH v5 8/9] tty: serial: atmel: Make the driver aware of the existence of GCLK`
- new bitfield conversions to FIELD_PREP/FIELD_GET PATCH
`[PATCH v5 9/9] tty: serial: atmel: Use FIELD_PREP/FIELD_GET`


Sergiu Moga (9):
  dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref
    binding
  dt-bindings: serial: atmel,at91-usart: convert to json-schema
  dt-bindings: serial: atmel,at91-usart: Add SAM9260 compatibles to
    SAM9X60
  dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref
    binding
  dt-bindings: serial: atmel,at91-usart: Add gclk as a possible USART
    clock
  tty: serial: atmel: Separate mode clearing between UART and USART
  tty: serial: atmel: Only divide Clock Divisor if the IP is USART
  tty: serial: atmel: Make the driver aware of the existence of GCLK
  tty: serial: atmel: Use FIELD_PREP/FIELD_GET

 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   |  19 +-
 .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
 .../bindings/serial/atmel,at91-usart.yaml     | 190 ++++++++++++++++++
 drivers/tty/serial/atmel_serial.c             |  82 +++++++-
 drivers/tty/serial/atmel_serial.h             |  75 +++----
 5 files changed, 321 insertions(+), 143 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml

-- 
2.34.1

