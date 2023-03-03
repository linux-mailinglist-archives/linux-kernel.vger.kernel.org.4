Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C87D6A9FE5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCCTIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCTI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:08:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2E612BDE;
        Fri,  3 Mar 2023 11:08:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso4641690wmb.0;
        Fri, 03 Mar 2023 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PaganyYku+5M5Gn2fyqQMgAHoPD2vYX4XmmZIlQWHiQ=;
        b=o8g9HP7+HQktVY6qdY64cZXwQensElF+MhlTwft5jS8Jh4OXVjtvilcxCqvCWmPXyJ
         +Mtrv1xKKZ4xAfe7fC51FOaJxSR5AtBDB5XyPfxuzrCRANgNcYxVcgMAAJrJmO+k6oQm
         LW5VUc3AoVh9MI4ymhVUCDLI7EnjCce+Y1BG31MNvoBVYvkUt5irxVIUa0EdNV/H2h1P
         JptpRV2UkN9d5dRvcZUcObiltD9Zptb/sLRc4X98DqRBbmrkx1QmQOIpKPLV6JyDQTML
         UGnEaPppN7Kbe5CVhZwb8b0BAu5pbumiXtZdEM95WD0hjR7PqXX8Y1VaRdo4wXsubktQ
         JcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaganyYku+5M5Gn2fyqQMgAHoPD2vYX4XmmZIlQWHiQ=;
        b=Py2oXVt+klNxRpiPRchPjEL9MpmZdmoZNB7ZYM4c4y8BauwUGL2yMyJlXUQ93lkUg8
         PJfjcRBftR7Ri06xikWtOCa9OIKGidrrBMI/Y/Q6400Eh3kPeg+rFWAVK1CqNB8BPsKN
         gtkhO0/u3Wcs8nhbScsWO7LCXWguc7GkJ4yW+UDhvM4T0d+YN7aIq/vW3am2I3KGwP+R
         yHTNuD1cIS8YFbhPIBnatf1VMDUFPQSNsGrpk/WGVlfGCp2Z/3JMJtBdTL7wW/8E6kJh
         SDxA/PKbGzDdDbW5Esgc0vzsxElhxeqoJv9ISpetc55PPPEt6v1Knfy03ZWAc1pmydVG
         dLpQ==
X-Gm-Message-State: AO0yUKV9a6HjmM/hBEvrdbY752a38aQQrxTXE2i2ShwGjz93YmuUrCsE
        YAdddd7VBPtBaxISrDfsFqs=
X-Google-Smtp-Source: AK7set8yOeX4V+K/tLN9Y4PH4ncRRlBHpv6GjtfYU0QGLl+6iRUHBlHh4qDKKs4b1jSmjjsD1C+DSQ==
X-Received: by 2002:a05:600c:1d2a:b0:3e1:374:8b66 with SMTP id l42-20020a05600c1d2a00b003e103748b66mr2500939wms.40.1677870503595;
        Fri, 03 Mar 2023 11:08:23 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-172.cust.vodafonedsl.it. [188.217.49.172])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bc04a000000b003e876122dc1sm6544017wmc.47.2023.03.03.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 11:08:23 -0800 (PST)
Date:   Fri, 3 Mar 2023 20:08:20 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/19] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <ZAJFpKlXPM+riuSa@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221024645.127922-1-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hal,
I start to play with jh7110-starfive-visionfive-2-v1.3b I have collect
your series [3]. Now I'm trying to boot the image with the following
cmds:

setenv bootfile vmlinuz;
setenv fileaddr a0000000;
setenv fdtcontroladdr 0xffffffffffffffff;
setenv ipaddr 10.0.0.100;
setenv serverip 10.0.0.1;
setenv kernel_comp_addr_r 0xb0000000;
setenv kernel_comp_size 0x10000000;
tftpboot ${fdt_addr_r} jh7110-starfive-visionfive-2-v1.3b.dtb;
tftpboot ${kernel_addr_r} Image.gz;
run chipa_set_linux;
booti ${kernel_addr_r} - ${fdt_addr_r}


This the result:

Bytes transferred = 109443584 (685fa00 hex)
StarFive # run chipa_set_linux;
StarFive # printenv file
  fileaddr filesize
StarFive # printenv filesize
filesize=685fa00
StarFive # booti ${kernel_addr_r} - ${fdt_addr_r}
   Uncompressing Kernel Image
## Flattened Device Tree blob at 46000000
   Booting using the fdt blob at 0x46000000
   Using Device Tree in place at 0000000046000000, end 0000000046005c14

Starting kernel ...

clk u5_dw_i2c_clk_core already disabled
clk u5_dw_i2c_clk_apb already disabled

---------------------------------------------

I'm missing something? Any hints?
Many thanks in advance! :)

Regards,
Tommaso

On Tue, Feb 21, 2023 at 10:46:26AM +0800, Hal Feng wrote:
> This patch series adds basic clock, reset & DT support for StarFive
> JH7110 SoC. Patch 17 depends on series [1] which provides pinctrl
> dt-bindings. Patch 19 depends on series [2] which provides dt-bindings
> of VisionFive 2 board and JH7110 SoC.
> 
> You can simply review or test the patches at the link [3].
> 
> [1]: https://lore.kernel.org/all/20230209143702.44408-1-hal.feng@starfivetech.com/
> [2]: https://lore.kernel.org/all/20230216131511.3327943-1-conor.dooley@microchip.com/
> [3]: https://github.com/hal-feng/linux/commits/visionfive2-minimal
> 
> Changes since v3:
> - Suggested by Conor, Merged clock & reset series and DT series together
>   so that they could go via the same tree as the dt-binding headers are
>   required by both driver & devicetree.
> - Rebased on tag v6.2.
> 
> [Clock & reset]
> Patch 2:
> - Split patch 2 into two. One for renaming file and one for renaming
>   variables. (by Conor)
> Patch 4:
> - Split patch 4 into two. One for code movement and one for
>   extraction. (by Conor)
> Patch 5 & 9 & 10 & 11:
> - Fixed the issues reported by kernel test robot.
> Patch 9:
> - Set (&priv->base) as driver data instead of (priv->base).
> - Set the frequency of clock PLL0 as 1000MHz for Synchronizing with the
>   lastest u-boot setting from StarFive. (by Emil)
> - Used devm_kzalloc() instead of kzalloc() when registering aux device.
> Patch 10:
> - Set (&priv->base) as driver data instead of (priv->base).
> Patch 11:
> - Used (*base) to get the register base address instead of (base).
> 
> [Device tree]
> - Dropped patch 1, 4, 5 because they were accepted.
> - Added a new patch to add SiFive S7 compatible. (by Conor)
> - Added a new patch to add JH7110 pin function definitions.
> Patch 6:
> - Changed the label "S76_0" to "S7_0" and used compatible "sifive,s7"
>   for core 0.
> - Updated ISA of each cores. (by Conor)
> - Made the node names generic. (by Krzysztof)
> - Added clock-output-names for all external clocks.
> - Added i2c0~6 nodes.
> - Changed the node name "gpio" to "pinctrl". Changed the label "gpio"
>   and "gpioa" to "sysgpio" and "aongpio". (by Conor)
> Patch 7:
> - Separated the long lines into more lines in Makefile. (by Conor)
> - Renamed jh7110-starfive-visionfive-2-va.dts and
>   jh7110-starfive-visionfive-2-vb.dts to
>   jh7110-starfive-visionfive-2-v1.2a.dts and
>   jh7110-starfive-visionfive-2-v1.3b.dts.
>   Changed the model and compatible to match v1.2A and v1.3B which
>   are printed on the silkscreen of VisionFive 2 board. (by Emil)
> - Configured pins for i2c0/2/5/6 and enabled them.
> 
>   clock & reset v3: https://lore.kernel.org/all/20221220005054.34518-1-hal.feng@starfivetech.com/
>   DT v3: https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
> 
> Changes since v2:
> [Clock & reset]
> - Rebased on tag v6.1.
> - Added "JH71X0" to the StarFive driver headers in MAINTAINERS.
> - Removed Co-developed-by tag of Hal in patch 1 and patch 4.
> - Changed the commit author from Hal to Emil in patch 2 and patch 5.
>   Removed Co-developed-by tag of Emil in patch 2 and patch 5. (by Emil)
> - Improved the coding style of patch 11, 12 and 13.
> - Dropped patch 14. (by Emil)
> Patch 4:
> - Passed the "owner" member of reset_controller_dev structure
>   directly in reset_starfive_jh7100_register(). (by Emil)
> - Added MAINTAINERS changes.
> Patch 7:
> - Split patch 7 into sys part and aon part. Merged them into patch 9 and
>   patch 10 respectively. (by Krzysztof)
> - Renamed include/dt-bindings/clock/starfive-jh7110.h to
>   include/dt-bindings/clock/starfive,jh7110-crg.h. (by Krzysztof)
> - Synchronized the definitions with the latest changes from Emil.
> Patch 8:
> - Split patch 8 into sys part and aon part. Merged them into patch 9 and
>   patch 10 respectively. (by Krzysztof)
> - Renamed include/dt-bindings/reset/starfive-jh7110.h to
>   include/dt-bindings/reset/starfive,jh7110-crg.h. (by Krzysztof)
> - Fixed the date of Copyright. (by Emil)
> - Dropped weird indentations. (by Krzysztof)
> - Synchronized the definitions with the latest changes from Emil.
> Patch 9:
> - Improved the description of clocks. (by Emil and Krzysztof)
> - Added MAINTAINERS changes.
> Patch 10:
> - Improved the description of clocks. (by Emil and Krzysztof)
> - Changed the clock-name "clk_rtc" to "rtc_osc" and  "apb_bus_func" to
>   "apb_bus".
> Patch 11:
> - Removed the flags of trace/debug clocks and set the flags of core clocks
>   as CLK_IS_CRITICAL. (by Emil)
> - Deleted the extra 1-1 clocks and synchronized the clock tree with the
>   latest changes from Emil. (by Emil)
> - Selected RESET_STARFIVE_JH7110 in Kconfig option CLK_STARFIVE_JH7110_SYS.
> Patch 12:
> - Changed the macro JH7110_AONCLK_RTC to JH7110_AONCLK_RTC_OSC and
>   JH7110_AONCLK_APB_BUS_FUNC to JH7110_AONCLK_APB_BUS.
> - Synchronized the clock tree with the latest changes from Emil.
> - Set the MODULE_LICENSE as "GPL" according to commit bf7fbeeae6db.
> Patch 13:
> - Removed the "asserted" member in reset_info structure and always pass
>   NULL when calling reset_starfive_jh71x0_register(). (by Emil)
> 
> [Device tree]
> - Rebased on tag v6.1.
> - Dropped patch 8 because it was merged.
> Patch 1:
> - Made the links into "Link:" tags. (by Conor)
> - Corrected the board name to "VisionFive 2" instead of
>   "VisionFive V2" and added compatibles for version A and
>   version B of VisionFive 2. (by Emil)
> Patch 4:
> - Used "sifive,ccache0" compatible string to match. (by Conor)
> Patch 5:
> - Dropped "select SIFIVE_CCACHE" in config SOC_STARFIVE. (by Conor)
> - Dropped "starfive,jh7110-ccache" compatible in
>   drivers/soc/sifive/sifive_ccache.c.
> Patch 6:
> - Removed all "clock-frequency = <0>". (by Conor)
> - Sorted the nodes after their addresses. (by Emil)
> - Renamed "clk_rtc" to "rtc_osc".
> - Added "sifive,ccache0" compatible in the cache-controller node.
> - Renamed "JH7110_SYSCLK_APB_BUS_FUNC" to "JH7110_SYSCLK_APB_BUS" and
>   renamed "apb_bus_func" to "apb_bus".
>   Renamed "JH7110_SYSCLK_IOMUX" to "JH7110_SYSCLK_IOMUX_APB".
>   Renamed "JH7110_SYSRST_IOMUX" to "JH7110_SYSRST_IOMUX_APB".
>   Renamed "JH7110_AONRST_AON_IOMUX" to "JH7110_AONRST_IOMUX".
> - Removed "reg-names" in gpio nodes.
> Patch 7:
> - Corrected the board name to "VisionFive 2" instead of "VisionFive V2".
> - Renamed jh7110-starfive-visionfive-v2.dts to
>   jh7110-starfive-visionfive-2.dtsi.
> - Added dts for VisionFive 2 version A and version B boards.
> - In the chosen node, deleted "linux,initrd-start" and "linux,initrd-end"
>   and changed the value of "stdout-path" to "serial0:115200n8".
> - Changed the bias of uart0 "rx-pins" to
>   "bias-disable; /* external pull-up */".
> - Renamed "clk_rtc" to "rtc_osc".
> - Moved the gpio node behind the uart0 node.
> 
>   clock & reset v2: https://lore.kernel.org/all/20221118010627.70576-1-hal.feng@starfivetech.com/
>   DT v2: https://lore.kernel.org/all/20221118011714.70877-1-hal.feng@starfivetech.com/
> 
> Changes since v1:
> [Clock & reset]
> - Rebased on tag v6.1-rc5.
> - Rewrote the clock and reset drivers using auxiliary bus framework, so
>   patch 8, 9, 15 were dropped and all patches changed a lot. (by Stephen)
> - Split Patch 14 into two patches. One is for factoring out the common
>   JH71X0 code, the another one is for renaming. (by Stephen)
> - Created a subdirectory for StarFive reset drivers.
> - Factored out common JH71X0 reset code.
> - Renamed the common clock and reset code from "*starfive*" or
>   "*STARFIVE*" to "*jh71x0*" or "*JH71X0*".
> - Combined JH7110 system and always-on clock DT binding headers in one
>   file named "include/dt-bindings/clock/starfive-jh7110.h".
> - Renamed clock definitions "JH7110_SYSCLK_PCLK2_MUX_FUNC_PCLK" and
>   "JH7110_SYSCLK_U2_PCLK_MUX_PCLK" to "JH7110_SYSCLK_PCLK2_MUX_FUNC" and
>   "JH7110_SYSCLK_PCLK2_MUX".
> - Rewrote the DT bindings of clock and reset for using auxiliary bus.
> - Registered an auxiliary device for reset controller in clock drivers.
> - Changed clock names "CODAJ*" and "WAVE*" to "codaj*" and "wave*".
>   Changed clock names "u2_pclk_mux_func_pclk" and "u2_pclk_mux_pclk" to
>   "pclk2_mux_func" and "pclk2_mux".
> - Changed the flags of clock apb0 and noc_bus_isp_axi to CLK_IS_CRITICAL
>   as suggested by StarFive SDK group.
> - Registered clock gmac0_gtxc as a gate clock instead of a div clock
>   as suggested by StarFive SDK group.
> - Changed the frequency of clock pll2_out to 1188MHz as suggested by
>   StarFive SDK group.
> - Fixed the bug that the clock JH7110_AONCLK_GMAC0_GTXCLK was not handled
>   in JH7110 always-on clock driver.
> - Registered the reset driver as an auxiliary driver.
> - Reworded the commit messages.
> 
> [Device tree]
> - Rebased on tag v6.1-rc5.
> - Added blank line in patch 1. (by Krzysztof)
> - Rebased patch 4 and 6 on the newest code. (by Conor)
> - Dropped patch 5. (by Conor)
> - Removed the quirk of JH7100 in patch 6, considering this patch series
>   should only add support for JH7110.
> - For patch 27, added Co-developed-by tag for Jianlong and me. Renamed
>   cpu labels to "S76_0", "U74_*" instead of "cpu*" following the style
>   of jh7100.dtsi. Moved all "clock-frequency" properties to the board dts.
>   Rewrote clock-controller nodes and deleted reset-controller nodes for
>   using auxiliary bus. Rewrote gpio nodes following generic pinctrl
>   bindings. Removed the redundant second reset entry of uart nodes.
> - For patch 28, added Co-developed-by tag for Jianlong and me. Added a
>   chosen node. Removed reserved-memory node. Added fixed frequency clock
>   nodes for overriding the "clock-frequency" properties. Rewrote the gpio
>   nodes following generic pinctrl bindings.
> - Dropped patch 30. (by Conor)
> - Reworded the commit messages.
> 
>   v1: https://lore.kernel.org/all/20220929143225.17907-1-hal.feng@linux.starfivetech.com/
> 
> Emil Renner Berthing (16):
>   clk: starfive: Factor out common JH7100 and JH7110 code
>   clk: starfive: Rename clk-starfive-jh7100.h to clk-starfive-jh71x0.h
>   clk: starfive: Rename "jh7100" to "jh71x0" for the common code
>   reset: Create subdirectory for StarFive drivers
>   reset: starfive: Factor out common JH71X0 reset code
>   reset: starfive: Extract the common JH71X0 reset code
>   reset: starfive: Rename "jh7100" to "jh71x0" for the common code
>   reset: starfive: jh71x0: Use 32bit I/O on 32bit registers
>   dt-bindings: clock: Add StarFive JH7110 system clock and reset
>     generator
>   dt-bindings: clock: Add StarFive JH7110 always-on clock and reset
>     generator
>   clk: starfive: Add StarFive JH7110 system clock driver
>   clk: starfive: Add StarFive JH7110 always-on clock driver
>   dt-bindings: timer: Add StarFive JH7110 clint
>   dt-bindings: interrupt-controller: Add StarFive JH7110 plic
>   riscv: dts: starfive: Add initial StarFive JH7110 device tree
>   riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device
>     tree
> 
> Hal Feng (2):
>   reset: starfive: Add StarFive JH7110 reset driver
>   dt-bindings: riscv: Add SiFive S7 compatible
> 
> Jianlong Huang (1):
>   riscv: dts: starfive: Add StarFive JH7110 pin function definitions
> 
>  .../clock/starfive,jh7110-aoncrg.yaml         |  76 ++
>  .../clock/starfive,jh7110-syscrg.yaml         |  80 ++
>  .../sifive,plic-1.0.0.yaml                    |   1 +
>  .../devicetree/bindings/riscv/cpus.yaml       |   1 +
>  .../bindings/timer/sifive,clint.yaml          |   1 +
>  MAINTAINERS                                   |  16 +-
>  arch/riscv/boot/dts/starfive/Makefile         |   6 +-
>  arch/riscv/boot/dts/starfive/jh7110-pinfunc.h | 308 ++++++++
>  .../jh7110-starfive-visionfive-2-v1.2a.dts    |  13 +
>  .../jh7110-starfive-visionfive-2-v1.3b.dts    |  13 +
>  .../jh7110-starfive-visionfive-2.dtsi         | 215 ++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 507 +++++++++++++
>  drivers/clk/starfive/Kconfig                  |  27 +
>  drivers/clk/starfive/Makefile                 |   6 +-
>  .../clk/starfive/clk-starfive-jh7100-audio.c  |  74 +-
>  drivers/clk/starfive/clk-starfive-jh7100.c    | 713 +++++-------------
>  drivers/clk/starfive/clk-starfive-jh7100.h    | 112 ---
>  .../clk/starfive/clk-starfive-jh7110-aon.c    | 156 ++++
>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 448 +++++++++++
>  drivers/clk/starfive/clk-starfive-jh71x0.c    | 383 ++++++++++
>  drivers/clk/starfive/clk-starfive-jh71x0.h    | 122 +++
>  drivers/reset/Kconfig                         |   8 +-
>  drivers/reset/Makefile                        |   2 +-
>  drivers/reset/reset-starfive-jh7100.c         | 173 -----
>  drivers/reset/starfive/Kconfig                |  20 +
>  drivers/reset/starfive/Makefile               |   5 +
>  .../reset/starfive/reset-starfive-jh7100.c    |  74 ++
>  .../reset/starfive/reset-starfive-jh7110.c    |  64 ++
>  .../reset/starfive/reset-starfive-jh71x0.c    | 131 ++++
>  .../reset/starfive/reset-starfive-jh71x0.h    |  20 +
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 225 ++++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 154 ++++
>  32 files changed, 3296 insertions(+), 858 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi
>  delete mode 100644 drivers/clk/starfive/clk-starfive-jh7100.h
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-sys.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
>  create mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
>  delete mode 100644 drivers/reset/reset-starfive-jh7100.c
>  create mode 100644 drivers/reset/starfive/Kconfig
>  create mode 100644 drivers/reset/starfive/Makefile
>  create mode 100644 drivers/reset/starfive/reset-starfive-jh7100.c
>  create mode 100644 drivers/reset/starfive/reset-starfive-jh7110.c
>  create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.c
>  create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
>  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
> 
> 
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> -- 
> 2.38.1
> 
