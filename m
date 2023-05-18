Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5CB707FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjERLi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjERLh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:37:57 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C94D62D55;
        Thu, 18 May 2023 04:36:51 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,285,1677510000"; 
   d="scan'208";a="163369194"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 May 2023 20:36:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.79])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 75DD74005B2A;
        Thu, 18 May 2023 20:36:46 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v4 00/11] Add Renesas PMIC RAA215300 and built-in RTC support
Date:   Thu, 18 May 2023 12:36:32 +0100
Message-Id: <20230518113643.420806-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to add support for Renesas PMIC RAA215300 and
built-in RTC found on this PMIC device.

The details of PMIC can be found here[1].

Renesas PMIC RAA215300 exposes two separate i2c devices, one for the main
device and another for rtc device.

Enhance i2c_new_ancillary_device() to instantiate a real device.
(eg: Instantiate rtc device from PMIC driver)

The built-in RTC found on PMIC RAA215300 is the same as ISL1208.
However, the external oscillator bit is inverted on PMIC version
0x11. The PMIC driver detects PMIC version and instantiate appropriate
RTC device.

[1]
https://www.renesas.com/in/en/products/power-power-management/multi-channel-power-management-ics-pmics/ssdsoc-power-management-ics-pmic-and-pmus/raa215300-high-performance-9-channel-pmic-supporting-ddr-memory-built-charger-and-rtc

Ref:
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230505091720.115675-1-biju.das.jz@bp.renesas.com/
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230505172530.357455-5-biju.das.jz@bp.renesas.com/

v3->v4:
 * Dropped Rb tag from Geert for patch#1 as there are new changes.
 * Introduced __i2c_new_dummy_device() to share the code between
   i2c_new_dummy_device and i2c_new_ancillary_device().
 * Introduced __i2c_new_client_device() to pass parent dev
   parameter, so that the ancillary device can assign its parent during
   creation.
 * Added minItems to interrupt-names in binding patch.
 * Added interrupt-names in conditional schema check.
 * Documented clock and clock-names properties.
 * Dropped unused name variable from struct isl1208_config.
 * Make similar I2C and DT-based matching.
 * Drop enum isl1208_id and split the array isl1208_configs[].
 * Introduced isl1208_set_xtoscb() to set XTOSCB bit.
 * Added support for internal oscillator enable/disable.
 * Moved PMIC bindings from mfd->regulator.
 * Dropped minItems from reg.
 * Dropped renesas,rtc-enabled property and instead used clock-names property
   to find RTC is enabled or not.
 * Added reg-names in required property.
 * Updated the example.
 * Moved from mfd->regulator as it doesn't use MFD APIs
 * Dropped handling "renesas,rtc-enabled" property and instead used
   clock-names to determine RTC is enabled or not and then instantiating
   RTC device.
 * Added clock nodes.
v2->v3:
 * Enhanced i2c_new_ancillary_device() to instantiate a real ancillary_device().
 * RTC device is instantiated by PMIC driver and dropped isl1208_probe_helper().
 * Added "TYPE_RAA215300_RTC_A0" to handle inverted oscillator bit case.
 * Added more detailed description for renesas,rtc-enabled property.
 * Added support for handling "renesas,rtc-enabled" property.
 * Based on PMIC version, it instantiates rtc device by calling i2c_new_
   ancillary_device().
 * Updated the logs.
RFC->v2:
 * Dropped the cross-links from bindings and used a single compatible
   with separate i2c addresses for pmic main and rtc device.
 * Dropped patch#4 and split patch#3 from this series and send as
   separate patch to ML [2].
 * Added RTC platform driver and mfd cell entry to the PMIC driver.RTC
   platform driver creates rtc device by using i2c_new_ancillary_device()
   and register the rtc device by calling the helper function provided
   by rtc-isl2108 driver.
 * Updated reg property in bindings.
 * Added optional reg-names, interrupts and renesas,rtc-enabled
   properties.
 * Fixed the node name in the binding example
 * Dropped the cross link property renesas,raa215300-rtc.
 * Updated the binding example
 * Dropped MODULE_SOFTDEP from the driver as it is added in RTC platform
   driver.
 * Dropped compatible "renesas,raa215300-isl1208" and "renesas,raa215300-pmic" property.
 * Updated the comment polarity->bit for External Oscillator.
 * Added raa215300_rtc_probe_helper() for registering raa215300_rtc device and
   added the helper function isl1208_probe_helper() to share the code.
 * Updated pmic device node on the SoM dtsi based on the bindings.

Logs:
[   15.447305] rtc-isl1208 3-006f: registered as rtc0
[   15.479493] rtc-isl1208 3-006f: setting system clock to 2023-04-27T19:31:02 UTC (1682623862)

root@smarc-rzv2l:~# hwclock -r
2023-04-27 19:33:05.499001+00:00
root@smarc-rzv2l:~# hwclock -r
2023-04-27 19:33:06.936688+00:00
root@smarc-rzv2l:~#

Biju Das (11):
  i2c: Enhance i2c_new_ancillary_device API
  dt-bindings: rtc: isl1208: Convert to json-schema
  dt-bindings: rtc: isil,isl1208: Document clock and clock-names
    properties
  rtc: isl1208: Drop name variable
  rtc: isl1208: Make similar I2C and DT-based matching table
  rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
  rtc: isl1208: Add isl1208_set_xtoscb()
  rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300
  regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
  regulator: Add Renesas PMIC RAA215300 driver
  arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC

 .../bindings/regulator/renesas,raa215300.yaml |  84 ++++++++++++
 .../devicetree/bindings/rtc/isil,isl1208.txt  |  38 ------
 .../devicetree/bindings/rtc/isil,isl1208.yaml | 102 ++++++++++++++
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  18 +++
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |   6 +-
 drivers/i2c/i2c-core-base.c                   |  90 ++++++++-----
 drivers/media/i2c/adv748x/adv748x-core.c      |   2 +-
 drivers/media/i2c/adv7604.c                   |   3 +-
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/raa215300.c                 | 118 +++++++++++++++++
 drivers/rtc/rtc-isl1208.c                     | 125 +++++++++++++-----
 include/linux/i2c.h                           |   3 +-
 13 files changed, 491 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
 create mode 100644 drivers/regulator/raa215300.c

-- 
2.25.1

