Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485B2738648
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjFUOJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjFUOIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:08:54 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A6CF1B4;
        Wed, 21 Jun 2023 07:08:52 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qByVq-0004Al-00; Wed, 21 Jun 2023 16:08:46 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id CE2C9C02FD; Wed, 21 Jun 2023 16:07:17 +0200 (CEST)
Date:   Wed, 21 Jun 2023 16:07:17 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com, yangshiji66@outlook.com
Subject: Re: [PATCH v5 0/9] mips: ralink: add complete clock and reset driver
 for mtmips SoCs
Message-ID: <20230621140717.GA7206@alpha.franken.de>
References: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 06:09:32AM +0200, Sergio Paracuellos wrote:
> Hi all!
> 
> This patchset is a big effort to properly implement a clock and reset
> driver for old ralink SoCs. This allow to properly define clocks in 
> device tree and avoid to use fixed-clocks directly from 'arch/mips/ralink'
> architecture directory code.
> 
> Device tree 'sysc' node will be both clock and reset provider using 
> 'clock-cells' and 'reset-cells' properties.
> 
> The ralink SoCs we are taking about are RT2880, RT3050, RT3052, RT3350,
> RT3352, RT3883, RT5350, MT7620, MT7628 and MT7688. Mostly the code in
> this new driver has been extracted from 'arch/mips/ralink' and cleanly
> put using kernel clock and reset driver APIs. The clock plans for this
> SoCs only talks about relation between CPU frequency and BUS frequency.
> This relation is different depending on the particular SoC. CPU clock is
> derived from XTAL frequencies.
> 
>  Depending on the SoC we have the following frequencies:
>  * RT2880 SoC:
>      - XTAL: 40 MHz.
>      - CPU: 250, 266, 280 or 300 MHz.
>      - BUS: CPU / 2 MHz.
>   * RT3050, RT3052, RT3350:
>      - XTAL: 40 MHz.
>      - CPU: 320 or 384 MHz.
>      - BUS: CPU / 3 MHz.
>   * RT3352:
>      - XTAL: 40 MHz.
>      - CPU: 384 or 400 MHz.
>      - BUS: CPU / 3 MHz.
>      - PERIPH: 40 MHz.
>   * RT3383:
>      - XTAL: 40 MHz.
>      - CPU: 250, 384, 480 or 500 MHz.
>      - BUS: Depends on RAM Type and CPU:
>        + RAM DDR2: 125. ELSE 83 MHz.
>        + RAM DDR2: 128. ELSE 96 MHz.
>        + RAM DDR2: 160. ELSE 120 MHz.
>        + RAM DDR2: 166. ELSE 125 MHz.
>   * RT5350:
>       - XTAL: 40 MHz.
>       - CPU: 300, 320 or 360 MHz.
>       - BUS: CPU / 3, CPU / 4, CPU / 3 MHz.
>       - PERIPH: 40 MHz.
>   * MT7628 and MT7688:
>      - XTAL: 20 MHz or 40 MHz.
>      - CPU: 575 or 580 MHz.
>      - BUS: CPU / 3.
>      - PCMI2S: 480 MHz.
>      - PERIPH: 40 MHz.
>   * MT7620:
>      - XTAL: 20 MHz or 40 MHz.
>      - PLL: XTAL, 480, 600 MHz.
>      - CPU: depends on PLL and some mult and dividers.
>      - BUS: depends on PLL and some mult and dividers.
>      - PERIPH: 40 or XTAL MHz.
> 
> MT7620 is a bit more complex deriving CPU clock from a PLL and an bunch of
> register reads and predividers. To derive CPU and BUS frequencies in the
> MT7620 SoC 'mt7620_calc_rate()' helper is used.
> In the case XTAL can have different frequencies and we need a different
> clock frequency for peripherals 'periph' clock in introduced.
> The rest of the peripherals present in the SoC just follow their parent
> frequencies.
> 
> I am using 'mtmips' inside for ralink clock driver. This is aligned with
> pinctrl series recently merged through pinctrl git tree [0].
> 
> I am maintaining ralink as prefix for compatible strings after discussions
> between Rob and Arinc in v2 of this series [1].
> 
> Changes have been compile tested for:
> - RT2880
> - RT3883
> 
> Changes have been properly tested in: 
> - RT5350 SoC based board (ALL5003 board)
> - MT7620A SoC based board (Haier HW-L1W)
> - MT7628AN SoC based board (Motorola MWR03)
> 
> All of them resulting in a working platform.
> 
> Dts files for these SoCs in-tree except MT7621 are incomplete. We are
> planning to align with openWRT files at some point and add extra needed
> changes. Hence I am not touching them at all in these series. If this is
> a problem, please let me know and I will update them.
> 
> Talking about merging this series I'd like all of the patches going through
> the MIPS tree if possible.
> 
> Thanks in advance for your time.
> 
> Best regards,
>     Sergio Paracuellos
> 
> Changes in v5:
> - Address comments of Shiji Yang in v4.
> - Make use 'of_find_compatible_node()' instead of 'of_find_node_by_name()' since
>   node names must not be an ABI (Thanks Krzysztof!!!)
> - Test this changes in mt7620a Soc based board and MT7628AN Soc based board (Thanks Shiji Yang!!!)
> 
> Changes in v4:
> - Collect Reviewed-by and Acked-by tags.
> - Pass proper data for 'ralink,rt3352-sysc' and 'ralink,rt3883-sysc' compatible string.
> 
> Changes in v3:
> - Address Stephen comments in v2:
>     + Drop unsused include '<linux/clk.h>'.
>     + Add fixed and factor clocks when it makes sense.
>     + Make 'mtmips_periph_clk_ops' named variable.
>     + WARN_ON -> WARN_ON_ONCE.
>     + Avoid CONFIG_USB dependent code. Introduce new 'mtmips_clk_regs_init'.
>     + Don't validate the bindings in the driver.
>     + Make const 'struct clk_init_data' used inside macros.
>     + do_div -> div_u64.
>     + Make use of dev_err_probe.
> 
> Changes in v2:
> - Address bindings documentation changes pointed out by Krzysztof:
>     + Rename the file into 'mediatek,mtmips-sysc.yaml'.
>     + Redo commit subject and log message.
>     + Order compatibles alphabetically.
>     + Redo bindings description taking into account this is a system
>       controller node which provides both clocks and resets to the world.
>     + Drop label from example.
>     + Use 'syscon' as node name in example.
>     + Drop no sense 'ralink,rt2880-reset' compatible string 
> - Squash patches 6 and 7 together as pointed out by Stephen Boyd.
> 
> Previoous series:
> v4: https://lore.kernel.org/linux-clk/20230617052435.359177-1-sergio.paracuellos@gmail.com/T/#t
> v3: https://lore.kernel.org/linux-mips/20230616064735.GA6380@alpha.franken.de/T/#mafbc1704938b94a367c4b6240d9880a67be1f92f
> v2: https://lore.kernel.org/linux-clk/CAMhs-H-BfZb3mD8E=LeJ4vT22uibQ1DnaZsfTrtRxSiv=8L5RA@mail.gmail.com/T/#t
> v1: https://lore.kernel.org/linux-clk/20230320161823.1424278-1-sergio.paracuellos@gmail.com/T/#t
> 
> [0]: https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b06185@arinc9.com/T/#t
> [1]: https://lore.kernel.org/linux-clk/CAMhs-H-BfZb3mD8E=LeJ4vT22uibQ1DnaZsfTrtRxSiv=8L5RA@mail.gmail.com/T/#mfe725b6e3382c6fb09736472a846cbbc84f264dc
> 
> Sergio Paracuellos (9):
>   dt-bindings: clock: add mtmips SoCs system controller
>   clk: ralink: add clock and reset driver for MTMIPS SoCs
>   mips: ralink: rt288x: remove clock related code
>   mips: ralink: rt305x: remove clock related code
>   mips: ralink: rt3883: remove clock related code
>   mips: ralink: mt7620: remove clock related code
>   mips: ralink: remove reset related code
>   mips: ralink: get cpu rate from new driver code
>   MAINTAINERS: add Mediatek MTMIPS Clock maintainer
> 
>  .../bindings/clock/mediatek,mtmips-sysc.yaml  |   64 +
>  MAINTAINERS                                   |    6 +
>  arch/mips/include/asm/mach-ralink/mt7620.h    |   35 -
>  arch/mips/include/asm/mach-ralink/rt288x.h    |   10 -
>  arch/mips/include/asm/mach-ralink/rt305x.h    |   21 -
>  arch/mips/include/asm/mach-ralink/rt3883.h    |    8 -
>  arch/mips/ralink/clk.c                        |   61 +-
>  arch/mips/ralink/common.h                     |    5 -
>  arch/mips/ralink/mt7620.c                     |  226 ----
>  arch/mips/ralink/of.c                         |    4 -
>  arch/mips/ralink/reset.c                      |   61 -
>  arch/mips/ralink/rt288x.c                     |   31 -
>  arch/mips/ralink/rt305x.c                     |   78 --
>  arch/mips/ralink/rt3883.c                     |   44 -
>  drivers/clk/ralink/Kconfig                    |    7 +
>  drivers/clk/ralink/Makefile                   |    1 +
>  drivers/clk/ralink/clk-mtmips.c               | 1115 +++++++++++++++++
>  17 files changed, 1245 insertions(+), 532 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
>  create mode 100644 drivers/clk/ralink/clk-mtmips.c

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
