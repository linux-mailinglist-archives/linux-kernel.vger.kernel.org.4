Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1F6701849
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjEMQwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEMQwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:52:38 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 593D830C4;
        Sat, 13 May 2023 09:52:36 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,272,1677510000"; 
   d="scan'208";a="159221916"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 May 2023 01:52:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.8])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3291340062D0;
        Sun, 14 May 2023 01:52:30 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v3 0/5] Add Renesas PMIC RAA215300 and built-in RTC support
Date:   Sat, 13 May 2023 17:52:22 +0100
Message-Id: <20230513165227.13117-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
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

[2]
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230505091720.115675-1-biju.das.jz@bp.renesas.com/

[3]
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230505172530.357455-5-biju.das.jz@bp.renesas.com/

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

Biju Das (5):
  i2c: Enhance i2c_new_ancillary_device API
  rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300
  dt-bindings: mfd: Add Renesas RAA215300 PMIC bindings
  mfd: Add Renesas PMIC RAA215300 driver
  arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC

 .../bindings/mfd/renesas,raa215300.yaml       |  70 ++++++++++++
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  10 ++
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |   6 +-
 drivers/i2c/i2c-core-base.c                   |  38 +++++--
 drivers/media/i2c/adv748x/adv748x-core.c      |   2 +-
 drivers/media/i2c/adv7604.c                   |   3 +-
 drivers/mfd/Kconfig                           |   7 ++
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/raa215300.c                       | 102 ++++++++++++++++++
 drivers/rtc/rtc-isl1208.c                     |  21 ++++
 include/linux/i2c.h                           |   3 +-
 11 files changed, 251 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,raa215300.yaml
 create mode 100644 drivers/mfd/raa215300.c

-- 
2.25.1

