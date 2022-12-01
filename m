Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8505963FB22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiLAW5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiLAW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:57:38 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEFDC7268;
        Thu,  1 Dec 2022 14:57:28 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1051F5FD02;
        Fri,  2 Dec 2022 01:57:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669935446;
        bh=XMC4EcvZyorO6Qws5CtaGdsWODwr3F8L/hWNJ1vGvD4=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=eDOmsU2en5hSjf++kEeIZlGWmsCQHFX8XdDfbPO1b/DCQBDIlAP3QeO54sS5QQaYG
         rXNuIc3ydwseEk2qolffSAC88LtcDxPYthTUAWxDAnUE95DImB+MMS2c8O43A/1eMC
         nFt8+gJokEhhQGFu31erN92V7h41mtVb5OGT5oO27ov/DBJ6uDqmch43vs3ZvRqUdy
         Uq2Qi6kVvHrQIO08eCH4VVfksLvW2NwwoQPLABAhPYdiL9xM/izgUsbiLL193Q04FO
         roumgCgPelCh0P2HyVX0Po7Oyecc13PEJeemyZRilQF8RO5y6dSVxz70WG9+GGkNve
         IqFZtsWWXP2uw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 01:57:25 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v8 00/11] add Amlogic A1 clock controller drivers
Date:   Fri, 2 Dec 2022 01:56:52 +0300
Message-ID: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/01 20:49:00 #20634374
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A1 SoC has four clock controllers on the board: PLL, Peripherals, CPU,
and Audio. The audio clock controller is different from others, but the
rest are very similar from a functional and regmap point of view.
This patch series add support for Amlogic A1 PLL and Peripherals clock
drivers.
It blocks all A1 peripherals mainline support and a couple of patch series,
which were already reviewed and acked, but weren't merged due to pending
clock controller drivers series, e.g.
https://lore.kernel.org/linux-amlogic/7hd09cw9oh.fsf@baylibre.com/

The previous v7 version [8] had several logic and style problems, all of
them are resolved in this version. Original Jian Hu v7 patches are not
touched, and all additional fixes are implemented in separate patches.
Patch "clk: meson: add support for A1 PLL clock ops" is removed, because
a1-pll clk driver inherits all stuff from clk-pll base driver, just
implements custom init/enable/disable/is_enabled callbacks.

TODO: CPU and Audio clock controllers are not included in this patch
series, it will be sent later. The following clks from these controllers
are not supported for now:
* Audio clks - vad, mclk_vad, mclk_d, resample_a, locker_in, mclk_b,
   pdmdclk, pdmsysclk, eqdrc, spdifin, mclk_a, audio2_toaudiotop,
   audio2_tovad, audio2_toddr_vad, audio2_tdmin_vad, audio2_pdm,
   audio2_ddr_arb, audio_audiolocker, audio_eqdrc, audio_resamplea,
   audio_spdifin, audio_toddrb, audio_toddra, audio_frddrb, audio_frddra,
   audio_tdmoutb, audio_tdmouta, audio_loopbacka, audio_tdminlb,
   audio_tdminb, audio_tdmina, audio_ddr_arb, mclk_c

* CPU clks: cpu_fixed_source_sel0, cpu_fixed_source_div0,
            cpu_fixed_source_sel1, cpu_fixed_source_div1, cpu_clk

Changes v7->v8:
    - introduced a1-clkc common driver for all A1 clock controllers
    - exported meson_clk_pll_wait_lock symbol
    - supported meson-a1-clkc common driver in the a1-pll and a1 clkc
    - inherited a1-pll from the base clk-pll driver, implemented own
      version of init/enable/disable/enabled routines; rate calculating
      logic is fully the same
    - aligned CLKID-related definitions with CLKID list from order
      perspective to remove holes and permutations
    - corrected Kconfig dependencies and types
    - provided correct MODULE_AUTHORs()
    - optimized and fixed up some clock relationships
    - removed unused register offset definitions
    - fixed up A1 PLL and Peripherals clkc dtb_check errors
    - fixed clk_summary kernel panic due to missing a1_pad_ctrl
      clk_regmap definition
    - included PLL and Peripherals clk controllers to the base a1 dts

Changes since v6 at [7]:
    - fix 'dt_binding_check' compiling error
    - add acked-by

Changes since v5 at [6]:
    - fix yaml file
    - add rst/current_en/l_detect parm detection
    - remove 'meson_eeclkc_data' in a1.c and a1-pll.c

Changes since v4 at [5]:
    - change yaml GPL
    - drop meson-eeclk.c patch, add probe function in each driver
    - add CLK_IS_CRITICAL for sys_clk clock, drop the flag for sys_a
      and sys_b
    - add new parm for pll, add protection for rst parm
    - drop flag for a1_fixed_pll
    - remove the same comment for fclk_div, add "refer to"
    - add critical flag for a1_sys_clk
    - remove rtc table
    - rename a1_dspa_en_dspa and a1_dspb_en_dspb
    - remove useless comment

Changes since v3 at [3]:
    - fix reparenting orphan failed, it depends on jerome's patch [4]
    - fix changelist in v3 about reparenting orphan
    - remove the dts patch 

Changes since v2 at [2]:
    - add probe function for A1
    - separate the clock driver into two patch
    - change some clock flags and ops
    - add support for a1 PLL ops
    - add A1 clock node
    - fix reparenting orphan clock failed, registering xtal_fixpll
      and xtal_hifipll after the provider registration, it is not
      a best way.

Changes since v1 at [1]:
    - place A1 config alphabetically
    - add actual reason for RO ops, CLK_IS_CRITICAL, CLK_IGNORE_UNUSED
    - separate the driver into two driver: peripheral and pll driver
    - delete CLK_IGNORE_UNUSED flag for pwm b/c/d/e/f clock, dsp clock
    - delete the change in Kconfig.platforms, address to Kevin alone
    - remove the useless comments
    - modify the meson pll driver to support A1 PLLs

[1] https://lkml.kernel.org/r/1569411888-98116-1-git-send-email-jian.hu@amlogic.com
[2] https://lkml.kernel.org/r/1571382865-41978-1-git-send-email-jian.hu@amlogic.com
[3] https://lkml.kernel.org/r/20191129144605.182774-1-jian.hu@amlogic.com
[4] https://lkml.kernel.org/r/20191203080805.104628-1-jbrunet@baylibre.com
[5] https://lkml.kernel.org/r/20191206074052.15557-1-jian.hu@amlogic.com
[6] https://lkml.kernel.org/r/20191227094606.143637-1-jian.hu@amlogic.com
[7] https://lkml.kernel.org/r/20200116080440.118679-1-jian.hu@amlogic.com
[8] https://lore.kernel.org/linux-amlogic/20200120034937.128600-1-jian.hu@amlogic.com/

Dmitry Rokosov (7):
  clk: meson: pll: export meson_clk_pll_wait_lock symbol
  clk: meson: introduce a1-clkc common driver for all A1 clock
    controllers
  clk: meson: a1: redesign Amlogic A1 PLL clock controller
  dt-bindings: clock: meson: fixup A1 PLL clkc dtb_check errors
  clk: meson: redesign A1 Peripherals CLK controller
  dt-bindings: clock: meson: fixup A1 peripherals clkc dtb_check errors
  arm64: dts: meson: a1: introduce PLL and Peripherals clk controllers

Jian Hu (4):
  dt-bindings: clock: meson: add A1 PLL clock controller bindings
  clk: meson: a1: add support for Amlogic A1 PLL clock driver
  dt-bindings: clock: meson: add A1 peripheral clock controller bindings
  clk: meson: a1: add support for Amlogic A1 Peripheral clock driver

 .../bindings/clock/amlogic,a1-clkc.yaml       |   73 +
 .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   59 +
 MAINTAINERS                                   |    1 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   27 +-
 drivers/clk/meson/Kconfig                     |   24 +
 drivers/clk/meson/Makefile                    |    3 +
 drivers/clk/meson/a1-pll.c                    |  451 ++++
 drivers/clk/meson/a1-pll.h                    |   59 +
 drivers/clk/meson/a1.c                        | 2222 +++++++++++++++++
 drivers/clk/meson/a1.h                        |  116 +
 drivers/clk/meson/clk-pll.c                   |    3 +-
 drivers/clk/meson/clk-pll.h                   |    2 +
 drivers/clk/meson/meson-a1-clkc.c             |   63 +
 drivers/clk/meson/meson-a1-clkc.h             |   25 +
 include/dt-bindings/clock/a1-clkc.h           |   98 +
 include/dt-bindings/clock/a1-pll-clkc.h       |   16 +
 16 files changed, 3240 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
 create mode 100644 drivers/clk/meson/a1-pll.c
 create mode 100644 drivers/clk/meson/a1-pll.h
 create mode 100644 drivers/clk/meson/a1.c
 create mode 100644 drivers/clk/meson/a1.h
 create mode 100644 drivers/clk/meson/meson-a1-clkc.c
 create mode 100644 drivers/clk/meson/meson-a1-clkc.h
 create mode 100644 include/dt-bindings/clock/a1-clkc.h
 create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h

-- 
2.36.0

