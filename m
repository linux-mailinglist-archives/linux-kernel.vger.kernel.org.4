Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE94972FEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244590AbjFNMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbjFNMdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:33:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8411FF9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:32:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1q9Pg7-00017A-9F; Wed, 14 Jun 2023 14:32:47 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1q9Pg5-007LpF-5K; Wed, 14 Jun 2023 14:32:45 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1q9Pg4-00HUIx-Fm; Wed, 14 Jun 2023 14:32:44 +0200
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Subject: [PATCH v2 0/8] ARM: dts: stm32: lxa-tac: add Linux Automation GmbH TAC
Date:   Wed, 14 Jun 2023 14:32:14 +0200
Message-Id: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Automation Test Automation Controller (LXA TAC)[1] is an embedded
software development tool built around the Octavo Systems OSD32MP15x SiP.

The device contains an eMMC for storage, a DSA-capable on board ethernet
switch with two external ports, dual CAN busses, a power switch to turn
a device under test on or off and some other I/O.

As of now there are two STM32MP157 based hardware generations (Gen 1 and
Gen 2) that have most of their hardware config in common.
In the future there will also be a STM32MP153 based hardware generation.

[1]: https://www.linux-automation.com/en/products/lxa-tac.html

V1: https://lore.kernel.org/lkml/20230607115508.2964574-1-l.goehrs@pengutronix.de/

Changes since V1:

  - Rebase on top of stm32-next as requested by Alexandre Torgue.
  - Split addition of shineworld lh133k compatible into separate
    vendor-prefix patch and panel-mipi-dbi-spi.yaml patch as suggested
    by Conor Dooley.
    Did not carry over the Reviewed-by: Rob Herring <robh@kernel.org>
    from the original patch due to the split.
  - Drop "dt-bindings: gpio: pca9570: add gpio-line-names property"
    as it is already in gpio/for-next.
  - Replace "dt-bindings: can: m_can: add termination-{gpios,ohms}
    properties" with a patch that replaces additionalProperties with
    unevaluatedProperties in bosch,m_can.yaml, as suggested by
    Rob Herring.
  - Drop "dt-bindings: net: dsa: microchip: add missing spi-{cpha,cpol}
    properties" as setting the correct SPI mode is the responsibility of the
    driver (suggested by Rob Herring).
  - Rename ethernet0_rgmii_pins_d pinctrl group to ethernet0_rgmii_pins_e
    as the former is already taken in stm32-next, as suggested by
    Alexandre Torgue.

Leonard Göhrs (8):
  dt-bindings: vendor-prefixes: Add prefix for ShineWorld Innovations
  dt-bindings: display: panel: mipi-dbi-spi: add shineworld lh133k
    compatible
  dt-bindings: display: panel: mipi-dbi-spi: add spi-3wire property
  dt-bindings: can: m_can: change from additional- to
    unevaluatedProperties
  dt-bindings: net: dsa: microchip: add interrupts property for ksz
    switches
  ARM: dts: stm32: Add pinmux groups for Linux Automation GmbH TAC
  dt-bindings: arm: stm32: Add compatible string for Linux Automation
    LXA TAC
  ARM: dts: stm32: lxa-tac: add Linux Automation GmbH TAC

 .../devicetree/bindings/arm/stm32/stm32.yaml  |   4 +-
 .../display/panel/panel-mipi-dbi-spi.yaml     |   3 +
 .../bindings/net/can/bosch,m_can.yaml         |   2 +-
 .../bindings/net/dsa/microchip,ksz.yaml       |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      | 129 ++++
 .../arm/boot/dts/stm32mp157c-lxa-tac-gen1.dts |  93 +++
 .../arm/boot/dts/stm32mp157c-lxa-tac-gen2.dts | 172 +++++
 arch/arm/boot/dts/stm32mp15xc-lxa-tac.dtsi    | 610 ++++++++++++++++++
 10 files changed, 1018 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32mp157c-lxa-tac-gen1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-lxa-tac-gen2.dts
 create mode 100644 arch/arm/boot/dts/stm32mp15xc-lxa-tac.dtsi


base-commit: c9cb7e72e293141d0d6c1d74c26788d3a0605172
-- 
2.39.2

