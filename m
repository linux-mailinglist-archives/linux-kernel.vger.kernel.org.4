Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC41073B96C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjFWOKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjFWOKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:10:00 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 954AD2693;
        Fri, 23 Jun 2023 07:09:57 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,152,1684767600"; 
   d="scan'208";a="165108779"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jun 2023 23:09:56 +0900
Received: from localhost.localdomain (unknown [10.226.93.107])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B53D34270489;
        Fri, 23 Jun 2023 23:09:51 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Trent Piepho <tpiepho@gmail.com>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v7 00/10] Add Renesas PMIC RAA215300 and built-in RTC support
Date:   Fri, 23 Jun 2023 15:09:38 +0100
Message-Id: <20230623140948.384762-1-biju.das.jz@bp.renesas.com>
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

PMIC driver enables RTC block and instantiate RTC device using
i2c_new_client_device().

The built-in RTC found on PMIC RAA215300 is the same as ISL1208.
However, the external oscillator bit is inverted on PMIC version
0x11. The PMIC driver detects PMIC version and instantiate appropriate
RTC device.

[1]
https://www.renesas.com/in/en/products/power-power-management/multi-channel-power-management-ics-pmics/ssdsoc-power-management-ics-pmic-and-pmus/raa215300-high-performance-9-channel-pmic-supporting-ddr-memory-built-charger-and-rtc

Ref:
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230505091720.115675-1-biju.das.jz@bp.renesas.com/
 https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230505172530.357455-5-biju.das.jz@bp.renesas.com/

v6->v7:
 * Updated the test logs by running rtc_test.
 * Dropped patch#1 and instead using i2c_new_client_device() to instantiate
   RTC driver.
 * Replaced i2c_new_ancillary_device->i2c_new_client_device for RTC client
   instantiation.
 * Introduced raa215300_clk_present() to find crystal or clock source is
   connected to the PMIC device.
 * Registered clk_dev, so that without any code change sibling device can 
   use the same clk API's for retrieving the clk details.
 * The optional irq is shared to sibling device by struct i2c_board_info.
 * Added code changes for clearing all blocks except RTC. Currently IRQ
   handling only supported in RTC driver. Enabling other blocks will lead
   to IRQ storm, if there is any fault.
 * In probe() latched registers are cleared and PMIC interrupts are masked
   to avoid IRQ storm.
 * Dropped Rb tag from Geert for patch#9 and patch#10 as new changes introduced.
 * In isl1208_set_xtoscb(), override the xtosc bit only if there is a
   mismatch.
 * Handling of xtosb_val inverted in probe() and the same change is adapted in
   isl1208_set_xtoscb().
 * Simplified isl1208_clk_present().
 * Removed unnecessary blank line before isl1208_rtc_set_time()
 * Dropped parsing the parent node for retrieving clk details as
   clk_dev is registered in sibling PMIC driver.
v5->v6:
 * Added Rb tag from Hans Verkuil and Geert.
 * Updated commit description and comment related to i2c_new_ancillary_device()
 * Fixed the issue related to assigning wrong parent device by adding check
   for aux_device_name.
 * Retained Rb tags for patch#1 as changes are trivial.
 * Added Rb tag from Geert for patch#2.
 * Updated the example with replacing node name "clock-xtal"->"x2-clock".
 * Updated the driver header comment block in C++ style
 * Dropped cache for registers.
 * Dropped check for I2C functionality.
 * Replaced "clock-xtal"->"x2-clock" for x2 node.
 * Sorted nodes in alphabetical order.
 * Added Rb tag from Geert for patch#6,#10 and #11
 * Replaced u8->int for xtosb_val parameter in isl1208_set_xtoscb().
 * Introduced isl1208_clk_present() for checking the presence of "xin" and
   "clkin" for determining internal oscillator is enabled or not.
 * Parsing of parent node is moved from probe->isl1208_clk_present()
 * Added comment for parsing parent node for getting clock resource.
 * Replaced XOR->NOT to make the operation more clear for the inverted case.
v4->v5:
 * Replaced parameter dev->parent in __i2c_new_client_device() and
   __i2c_new_dummy_device().
 * Improved error message in __i2c_new_dummy_device() by printing device name.
 * Updated comment for ancillary's device parent
 * Dropped aux_device_name check in i2c_new_ancillary_device().
 * Replaced oneOf->enum for clock-names as it is simpler.
 * Added Rb tag from Conor for binding patches#3 and #9.
 * Added Rb tag from Geert for patches#4, #5 and #6.
 * Replaced "unsigned long"->"kernel_ulong_t" in isl1208_id[].
 * Fixed the typo in commit description.
 * Replaced the variable int_osc_en->xtosb_val for isl1208_set_xtoscb() and
   changed the data type from bool->u8.
 * Replaced devm_clk_get->devm_clk_get_optional() in probe.
 * IS_ERR() related error is propagated and check for NULL to find out
   if a clock is present.
 * -ENOENT means clock not present, so any other errors are propagated.
 * Dropped bool inverted parameter from isl1208_set_xtoscb() instead
   using xor to compute the value of xtoscb.
 * Added description for clocks in PMIC bindings patch.
 * Dropped clk.h and started using of_property_present to check the
   clocks.
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

RTC test logs with, out of tree patch for enabling RTC IRQ with IRQ alarm
call back and HW modification done on RZ/G2L SMARC EVK to enable PMIC INT#
by wiring R83 on SoM module and PMOD0 PIN7:

root@smarc-rzg2l:~# /rtc_test.sh
Wed Jun 14 19:30:00 UTC 2023
TAP version 13
1..8
# Starting 8 tests from 1 test cases.
#  RUN           rtc.date_read ...
# rtctest.c:52:date_read:Current RTC date/time is 14/06/2023 19:30:01.
#            OK  rtc.date_read
ok 1 rtc.date_read
#  RUN           rtc.date_read_loop ...
# rtctest.c:95:date_read_loop:Continuously reading RTC time for 30s (with 11ms breaks after every read).
# rtctest.c:122:date_read_loop:Performed 2047 RTC time reads.
#            OK  rtc.date_read_loop
ok 2 rtc.date_read_loop
#  RUN           rtc.uie_read ...
#            OK  rtc.uie_read
ok 3 rtc.uie_read
#  RUN           rtc.uie_select ...
#            OK  rtc.uie_select
ok 4 rtc.uie_select
#  RUN           rtc.alarm_alm_set ...
# rtctest.c:221:alarm_alm_set:Alarm time now set to 19:30:41.
# rtctest.c:241:alarm_alm_set:data: 1a0
#            OK  rtc.alarm_alm_set
ok 5 rtc.alarm_alm_set
#  RUN           rtc.alarm_wkalm_set ...
# rtctest.c:281:alarm_wkalm_set:Alarm time now set to 14/06/2023 19:30:44.
#            OK  rtc.alarm_wkalm_set
ok 6 rtc.alarm_wkalm_set
#  RUN           rtc.alarm_alm_set_minute ...
# rtctest.c:331:alarm_alm_set_minute:Alarm time now set to 19:31:00.
# rtctest.c:351:alarm_alm_set_minute:data: 1a0
#            OK  rtc.alarm_alm_set_minute
ok 7 rtc.alarm_alm_set_minute
#  RUN           rtc.alarm_wkalm_set_minute ...
# rtctest.c:391:alarm_wkalm_set_minute:Alarm time now set to 14/06/2023 19:32:00.
#            OK  rtc.alarm_wkalm_set_minute
ok 8 rtc.alarm_wkalm_set_minute
# PASSED: 8 / 8 tests passed.
# Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0

cat/proc/interrupts | grep rtx
 78:         30          0  rzg2l-irqc   5 Level     rtc-isl1208


Biju Das (10):
  regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
  regulator: Add Renesas PMIC RAA215300 driver
  arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC
  dt-bindings: rtc: isl1208: Convert to json-schema
  dt-bindings: rtc: isil,isl1208: Document clock and clock-names
    properties
  rtc: isl1208: Drop name variable
  rtc: isl1208: Make similar I2C and DT-based matching table
  rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
  rtc: isl1208: Add isl1208_set_xtoscb()
  rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300

 .../bindings/regulator/renesas,raa215300.yaml |  85 ++++++++
 .../devicetree/bindings/rtc/isil,isl1208.txt  |  38 ----
 .../devicetree/bindings/rtc/isil,isl1208.yaml | 100 +++++++++
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  18 ++
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/raa215300.c                 | 190 ++++++++++++++++++
 drivers/rtc/rtc-isl1208.c                     | 130 +++++++++---
 8 files changed, 499 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
 create mode 100644 drivers/regulator/raa215300.c

-- 
2.25.1

