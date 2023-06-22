Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3304473A3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjFVO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjFVO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:13 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97245E42;
        Thu, 22 Jun 2023 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=OdPMqDWgVDt0x793WxRc09L+unPTlnGwL75MUH9aCYo=; b=W
        Np8UN7yYhJ+zqJkYdQB7NEibtid48PpIySKChx0CWnZsoKOMBdifWkF/F7NMyMH8p3ktKmUq3vDVB
        2H0Q4KfPDlf9457nIE7TFqHeYTDGFpW2ixrW7E2dzRlwcBFgVC/7fT4SptKGYkxT8XhW39QG/ZeqM
        nKvXhJX2ZbqOJ0wE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLl5-0002fr-Dz; Thu, 22 Jun 2023 10:58:04 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 22 Jun 2023 10:57:43 -0400
Message-Id: <20230622145800.2442116-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v4 00/17] rtc: pcf2127: add PCF2131 driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series adds the driver for the PCF2131 real-time clock.

This RTC is very similar in functionality to the PCF2127/29 with the
following differences:
  -supports two new control registers at offsets 4 and 5
  -supports a new reset register
  -supports 4 tamper detection functions instead of 1
  -has no nvmem (like the PCF2129)
  -has two output interrupt pins instead of one
  -has 1/100th seconds capabilities (not supported in this driver)
  -pcf2127 has watchdog clock sources: 1/60,   1, 64 and 4096Hz
   pcf2131 has watchdog clock sources: 1/64, 1/4,  4 and   64Hz
  -watchdog value register cannot be read after being set

Most of the register addresses are very different, although they still
follow the same layout. For example, the time/date and tamper registers
have a different base address, but the offsets are all the same.
Consequently, the source code of the PCF2127 driver can be easily adapted
to support this new device.

Patch 1 improves rtc_read_time() performance

Patch 2 improve timestamp reading performance

Patch 3 lowers error message severity

Patch 4 remove superfluous comments.

Patches 5 to 10 modify the existing pcf2127 driver to make it more generic
and able to support multiple variants, like the PCF2131. This is done
mostly by using offsets instead of absolute hardcoded register addresses.

Patch 11 add actual support for the PCF2131.

Patch 12 configures all interrupt sources to go through the INT A pin.

Patch 13 adapt the time/date registers write sequence for PCF2131 (STOP and
      CPR bits).

Patch 14 add support for generic watchdog timing configuration.

Patch 15 add a new flag to identify if device has read support for reading
      watchdog register value.
      Since the watchdog value register cannot be read on the PCF2131 after
      being set, it seems that we cannot detect if watchdog timer was
      started by bootloader. I am not sure what is the best way to handle
      this situation, suggestions are welcomed.

Patch 16 add UIE support for PCF2131

Patch 17 add the dt-bindings for the PCF2131.

I have tested the driver using a PCF2131-ARD evaluation board connected to
a Variscite imx8mn NANO SOM evaluation board:
  - Time get/set ok;
  - Alarms get/set ok
  - Timestamp 1 to 4 ok
  - IRQ alarm ok
  - Watchdog ok
  - Also tested successfully with "RTC Driver Test Example" from
    Documentation/rtc.txt

I have also tested the driver on a custom PCF2129 adapter board connected to
a Variscite imx8mn NANO SOM evaluation board.

Thank you.

Link: [v1] https://patchwork.ozlabs.org/project/rtc-linux/patch/20220125200009.900660-2-hugo@hugovil.com/
Link: [v2] https://patchwork.ozlabs.org/project/rtc-linux/list/?series=285734
Link: [v3] https://patchwork.ozlabs.org/project/rtc-linux/list/?series=332888

Changes for V2:
- In general, fix and improvements after I have tested on real hardware
- Fix alarm interrupt A/B mask setting for PCF2131:
  PCF2131_BIT_INT_AIE must be cleared, not set, to enable interrupt.
- Remove low_reg validation: only check if TS interrupt flag is
  defined, as low_reg is defined at address 0 for PCF2127/29.
- Change PWRMNG value for PCF2131: default is different than PCF2127/29.
- Adapt time/date registers write sequence for PCF2131 (STOP and CPR bits).
- Map all interrupt sources to INT A pin
- Read and validate PCF2131 device presence from RESET register
- Adapt watchdog configuration for PCF2131

Changes for V3:
- Rebase for kernel v6.1

Changes for V4:
- Rebase for kernel v6.4-rc7
- Add base-commit infos (git format-patch with --base= option)
- Rename regs_td_base -> reg_time_base
- Rename PCF2127_REG_TIME_DATE_BASE -> PCF2127_REG_TIME_BASE
- Remove/update comments
- Remove PCF2127_OFFSET_ALARM_* defines
- Remove PCF2127_OFFSET_TD_* defines
- Rename regs_base -> reg_base in struct pcf21xx_ts_config
- Remove identity string changes to not break userspace
- Explicitely set .inter_detect_bit to 0
- Replace hardcoded bit values with BIT() macros
- Remove reset register signature read
- Remove patch to set PWRMNG bits
- Rework to keep watchdog value store/computed inside the structure wdd
  (struct watchdog_device) to be in seconds.
- Rename confusing structure members
- Create separate patch for optimization of timestamp and time reading.
- Add UIE support for PCF2131

Hugo Villeneuve (17):
  rtc: pcf2127: improve rtc_read_time() performance
  rtc: pcf2127: improve timestamp reading performance
  rtc: pcf2127: lower message severity if setting time fails
  rtc: pcf2127: remove superfluous comments
  rtc: pcf2127: add variant-specific configuration structure
  rtc: pcf2127: adapt for time/date registers at any offset
  rtc: pcf2127: adapt for alarm registers at any offset
  rtc: pcf2127: adapt for WD registers at any offset
  rtc: pcf2127: adapt for CLKOUT register at any offset
  rtc: pcf2127: add support for multiple TS functions
  rtc: pcf2127: add support for PCF2131 RTC
  rtc: pcf2127: add support for PCF2131 interrupts on output INT_A
  rtc: pcf2127: adapt time/date registers write sequence for PCF2131
  rtc: pcf2127: support generic watchdog timing configuration
  rtc: pcf2127: add flag for watchdog register value read support
  rtc: pcf2127: add UIE support for PCF2131
  dt-bindings: rtc: pcf2127: add PCF2131

 .../devicetree/bindings/rtc/nxp,pcf2127.yaml  |   1 +
 drivers/rtc/Kconfig                           |   4 +-
 drivers/rtc/rtc-pcf2127.c                     | 874 ++++++++++++++----
 3 files changed, 691 insertions(+), 188 deletions(-)


base-commit: dad9774deaf1cf8e8f7483310dfb2690310193d2
-- 
2.30.2

