Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FF16EF190
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjDZJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbjDZJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:58:19 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4144170E;
        Wed, 26 Apr 2023 02:58:15 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 878E65FD76;
        Wed, 26 Apr 2023 12:58:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682503093;
        bh=6G86vv0ZldsF0tx3obmD9tnm4TnBh9yFNnhE+Kn7PNY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Pok9v816oQJwV/KKO9Xt638ZeQZOS4JCQDV9ER/DtJY4Mk9bboasX7F0bC42BFUJE
         KweaN3uLmVqGRTrH7UDwhO8OyJePs9wTV1Blw2RSgI2jE8maj++qc7YG2sRti6F38i
         mpqEDIg3NNxruFZj43B9QyGDomy2m8y/yva5TmD4YCYETt83q6/Jn7/UO9ivasFxtY
         ahkCiG+a7CTok5zgTe2aGU6lEhaZPFXtfhr3YnGRPYhoZJAW7yHLj4fUp9ODybM/ss
         djQ4ygoWR+V6uKasKesaOJ57HVS+2tH8WkrcCijOauQ4iKTlM97faU4SIoXFPgwA84
         biwadFW8zdFaA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 26 Apr 2023 12:58:12 +0300 (MSK)
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
Subject: [PATCH v14 0/6] add Amlogic A1 clock controller drivers
Date:   Wed, 26 Apr 2023 12:57:59 +0300
Message-ID: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/26 04:45:00 #21166225
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
https://lore.kernel.org/all/20230418111612.19479-1-ddrokosov@sberdevices.ru/

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

Validation:
* to double check all clk flags run below helper script:
    pushd /sys/kernel/debug/clk
    for f in *; do
        if [[ -f "$f/clk_flags" ]]; then
            flags="$(cat $f/clk_flags | awk '{$1=$1};1' | sed ':a;N;$!ba;s/\n/ | /g')"
            echo -e "$f: $flags"
        fi
    done
    popd

* to trace current clks state use '/sys/kernel/debug/clk/clk_dump' node
  with jq post-processing:
    $ cat /sys/kernel/debug/clk/clk_dump | jq '.' > clk_dump.json

* to debug clk rate propagation, compile kernel with the following
  definition:
    $ sed -i "s/undef CLOCK_ALLOW_WRITE_DEBUGFS/define CLOCK_ALLOW_WRITE_DEBUGFS/g" drivers/clk/clk.c
  after that, clk_rate debug node for each clock will be available for
  write operation

Changes v14 since v13 at [14]:
    - remove the term "Meson" from all patchsets or replace it with
      "Amlogic"
    - purge extra commas as per Martin's suggestion
    - drop the unneeded use of of_match_ptr(), since all Meson clock
      drivers depend on the ARM64 config which selects CONFIG_OF by default

Changes v13 since v12 at [13]:
    - make the clock object registration order from the roots to the leaves
    - rearrange the clkids following above rule

Changes v12 since v11 at [12]:
    - split the DT bindings patchset into two patches: one for the PLL clock
      controller driver, and one for the peripherals clock controller driver
    - to satisfy the DT binding checker, use fake references to the
      peripherals clock controller in the PLL DT bindings schema, and then
      replace them with real references when the peripherals bindings
      become available.
    - remove the public/private clocks concept from both controllers,
      and instead use a linear clkid list with both exposed and internal
      objects, all of which are registered in the clock provider
    - combine all comments about RTC children with the flag
      'CLK_SET_RATE_NO_REPARENT' into a single item with multiple
      references to it

Changes v11 since v10 at [11]:
    - change include/dt-bindings license to proper value required for
      bindings files: 'GPL-2.0-only OR BSD-2-Clause'
    - pll and peripherals clocks are split into public and private parts;
      public clocks are available for external consumers through the DT layer,
      private clocks include internal muxes and dividers of composite clocks,
      they are placed inside clock controller driver without external access
    - make public clks CLKID bindings continuous
    - mark the following clock muxes as NO_REPARENT and add them to
      public clocks list: GEN_SEL, DSPA_A_SEL, DSPA_B_SEL, DSPB_A_SEL,
      DSP_B_B_SEL, PWM_A_SEL, PWM_B_SEL, PWM_C_SEL, PWM_D_SEL,
      PWM_E_SEL, PWM_F_SEL, CECA_32K_SEL, CECB_32K_SEL; each of them can
      be inherited from more accurate RTC clock and sometimes it's
      required to forbid reparenting in such situation; also GEN_SEL can
      be connected to external PAD and should not change parent
      automatically due to rate propagation. For such clocks user must
      setup parents on the DT side

Changes v10 since v9 at [10]:
    - split general clk-pll changes into two different patchsets:
      optional rst usage and new power sequence
    - squash dt bindings patchsets to avoid chicken-or-the-egg problem
      during run dt binding check routines
    - add vendor prefix to PLL and Peripherals clkcs bindings filenames
    - clear managed hifi_pll fields from initial poke table
    - move DSPA_SEL, DSPB_SEL and SARADC_SEL to private clkid table,
      because it should not be opened for direct usage
    - pwm_a clk used for voltage regulation is not critical anymore, it
      must be included to the proper cpu voltage regulation setup (will
      be available in the next patch series)
    - as discussed with Jerome, dspX clks are simple clocks and it
      should be enabled/disabled/ignored/anything else from appropriate
      DSP driver, so remove CLK_IGNORE_UNUSED tags
    - provide more understandable comments and remove irrelevant (I hope so)
    - remove CONFIG_OF usage, because it's redundant
    - fix license issue, it's GPL-2.0+ only in the current version
    - some commit msgs rewording

Changes v9 since v8 at [9]:
    - remove common a1-clkc driver for the first version of a1 clock
      controllers as Jerome suggested (it will be discussed after s4 and
      a1 clks landed, hope so)
    - replace inherited a1-pll clk_pll_ops with common ops and
      introduce custom A1 PLL logic under MESON_PARM_APPLICABLE()
      conditions
    - rename xtal depended clocks in PLL and Peripherals domains
    - remove 'a1_' prefix for all clocks, because they are already
      inside A1 driver, it's redundant
    - change udelay() to usleep_range() as preferred for small msec
      amount
    - purge all double quotes from the yaml schemas
    - use proper dt node names following kernel guidelines
      https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
    - use devm_platform_ioremap_resource() instead of simple
      devm_ioremap_resource()
    - mark all dspX clocks as CLK_IGNORE_UNUSED, because we do not want
      to touch these clocks during CCF initialization due to possible
      workload execution on it started from bootloader; in this case
      bootloader already made all initialization stuff for dspX
    - also mark all dspX with NO_REPARENT tag, because from dspX clocks
      we want to select proper clk source from device tree

Changes v8 since v7 at [8]:
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
    - The previous v7 version [8] had several logic and style problems,
      all of them are resolved in this version. Original Jian Hu v7 patches
      are not touched, and all additional fixes are implemented in separate
      patches. Patch "clk: meson: add support for A1 PLL clock ops" is
      removed, because a1-pll clk driver inherits all stuff from clk-pll
      base driver, just implements custom init/enable/disable/is_enabled
      callbacks.

Changes v7 since v6 at [7]:
    - fix 'dt_binding_check' compiling error
    - add acked-by

Changes v6 since v5 at [6]:
    - fix yaml file
    - add rst/current_en/l_detect parm detection
    - remove 'meson_eeclkc_data' in a1.c and a1-pll.c

Changes v5 since v4 at [5]:
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

Changes v4 since v3 at [3]:
    - fix reparenting orphan failed, it depends on jerome's patch [4]
    - fix changelist in v3 about reparenting orphan
    - remove the dts patch 

Changes v3 since v2 at [2]:
    - add probe function for A1
    - separate the clock driver into two patch
    - change some clock flags and ops
    - add support for a1 PLL ops
    - add A1 clock node
    - fix reparenting orphan clock failed, registering xtal_fixpll
      and xtal_hifipll after the provider registration, it is not
      a best way.

Changes v2 since v1 at [1]:
    - place A1 config alphabetically
    - add actual reason for RO ops, CLK_IS_CRITICAL, CLK_IGNORE_UNUSED
    - separate the driver into two driver: peripheral and pll driver
    - delete CLK_IGNORE_UNUSED flag for pwm b/c/d/e/f clock, dsp clock
    - delete the change in Kconfig.platforms, address to Kevin alone
    - remove the useless comments
    - modify the meson pll driver to support A1 PLLs

Links:
    [1] https://lkml.kernel.org/r/1569411888-98116-1-git-send-email-jian.hu@amlogic.com
    [2] https://lkml.kernel.org/r/1571382865-41978-1-git-send-email-jian.hu@amlogic.com
    [3] https://lkml.kernel.org/r/20191129144605.182774-1-jian.hu@amlogic.com
    [4] https://lkml.kernel.org/r/20191203080805.104628-1-jbrunet@baylibre.com
    [5] https://lkml.kernel.org/r/20191206074052.15557-1-jian.hu@amlogic.com
    [6] https://lkml.kernel.org/r/20191227094606.143637-1-jian.hu@amlogic.com
    [7] https://lkml.kernel.org/r/20200116080440.118679-1-jian.hu@amlogic.com
    [8] https://lore.kernel.org/linux-amlogic/20200120034937.128600-1-jian.hu@amlogic.com/
    [9] https://lore.kernel.org/linux-amlogic/20221201225703.6507-1-ddrokosov@sberdevices.ru/
    [10] https://lore.kernel.org/all/20230301183759.16163-1-ddrokosov@sberdevices.ru/
    [11] https://lore.kernel.org/all/20230313201259.19998-1-ddrokosov@sberdevices.ru/
    [12] https://lore.kernel.org/all/20230321193014.26349-1-ddrokosov@sberdevices.ru/
    [13] https://lore.kernel.org/all/20230404155332.9571-1-ddrokosov@sberdevices.ru/
    [14] https://lore.kernel.org/linux-amlogic/20230405195927.13487-1-ddrokosov@sberdevices.ru/

Dmitry Rokosov (6):
  clk: meson: make pll rst bit as optional
  clk: meson: introduce new pll power-on sequence for A1 SoC family
  dt-bindings: clock: meson: add A1 PLL clock controller bindings
  clk: meson: a1: add Amlogic A1 PLL clock controller driver
  dt-bindings: clock: meson: add A1 Peripherals clock controller
    bindings
  clk: meson: a1: add Amlogic A1 Peripherals clock controller driver

 .../bindings/clock/amlogic,a1-clkc.yaml       |   73 +
 .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   59 +
 MAINTAINERS                                   |    1 +
 drivers/clk/meson/Kconfig                     |   20 +
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/a1-pll.c                    |  356 +++
 drivers/clk/meson/a1-pll.h                    |   47 +
 drivers/clk/meson/a1.c                        | 2273 +++++++++++++++++
 drivers/clk/meson/a1.h                        |  114 +
 drivers/clk/meson/clk-pll.c                   |   47 +-
 drivers/clk/meson/clk-pll.h                   |    2 +
 include/dt-bindings/clock/amlogic,a1-clkc.h   |  114 +
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |   20 +
 13 files changed, 3121 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
 create mode 100644 drivers/clk/meson/a1-pll.c
 create mode 100644 drivers/clk/meson/a1-pll.h
 create mode 100644 drivers/clk/meson/a1.c
 create mode 100644 drivers/clk/meson/a1.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h

-- 
2.36.0

