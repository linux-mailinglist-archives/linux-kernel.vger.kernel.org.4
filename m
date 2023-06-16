Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEED73286A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244696AbjFPHHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244352AbjFPHHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:07:04 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B1D12D6D;
        Fri, 16 Jun 2023 00:06:53 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qA3Xk-0006Nz-00; Fri, 16 Jun 2023 09:06:48 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2875FC02FD; Fri, 16 Jun 2023 08:47:35 +0200 (CEST)
Date:   Fri, 16 Jun 2023 08:47:35 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: Re: [PATCH v3 0/9] mips: ralink: add complete clock and reset driver
 for mtmips SoCs
Message-ID: <20230616064735.GA6380@alpha.franken.de>
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
 <CAMhs-H_yn_76RAFNk4ux_-rn9FdKna9Vsu0raFQXfr3ykkRWPw@mail.gmail.com>
 <CAMhs-H_NxauVCL7Sc7SWBk4dTQ8CyqLbPnTZO66VAqycPoOyTw@mail.gmail.com>
 <CAMhs-H8R4oz=Hs8y=3-R15hkySPEO4scookZ_shPzEbQoAyTKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhs-H8R4oz=Hs8y=3-R15hkySPEO4scookZ_shPzEbQoAyTKA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:12:00AM +0200, Sergio Paracuellos wrote:
> On Tue, May 23, 2023 at 11:47 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > On Thu, May 4, 2023 at 4:48 PM Sergio Paracuellos
> > <sergio.paracuellos@gmail.com> wrote:
> > >
> > > On Tue, Apr 18, 2023 at 11:03 AM Sergio Paracuellos
> > > <sergio.paracuellos@gmail.com> wrote:
> > > >
> > > > Hi all!
> > > >
> > > > This patchset is a big effort to properly implement a clock and reset
> > > > driver for old ralink SoCs. This allow to properly define clocks in
> > > > device tree and avoid to use fixed-clocks directly from 'arch/mips/ralink'
> > > > architecture directory code.
> > > >
> > > > Device tree 'sysc' node will be both clock and reset provider using
> > > > 'clock-cells' and 'reset-cells' properties.
> > > >
> > > > The ralink SoCs we are taking about are RT2880, RT3050, RT3052, RT3350,
> > > > RT3352, RT3883, RT5350, MT7620, MT7628 and MT7688. Mostly the code in
> > > > this new driver has been extracted from 'arch/mips/ralink' and cleanly
> > > > put using kernel clock and reset driver APIs. The clock plans for this
> > > > SoCs only talks about relation between CPU frequency and BUS frequency.
> > > > This relation is different depending on the particular SoC. CPU clock is
> > > > derived from XTAL frequencies.
> > > >
> > > >  Depending on the SoC we have the following frequencies:
> > > >  * RT2880 SoC:
> > > >      - XTAL: 40 MHz.
> > > >      - CPU: 250, 266, 280 or 300 MHz.
> > > >      - BUS: CPU / 2 MHz.
> > > >   * RT3050, RT3052, RT3350:
> > > >      - XTAL: 40 MHz.
> > > >      - CPU: 320 or 384 MHz.
> > > >      - BUS: CPU / 3 MHz.
> > > >   * RT3352:
> > > >      - XTAL: 40 MHz.
> > > >      - CPU: 384 or 400 MHz.
> > > >      - BUS: CPU / 3 MHz.
> > > >      - PERIPH: 40 MHz.
> > > >   * RT3383:
> > > >      - XTAL: 40 MHz.
> > > >      - CPU: 250, 384, 480 or 500 MHz.
> > > >      - BUS: Depends on RAM Type and CPU:
> > > >        + RAM DDR2: 125. ELSE 83 MHz.
> > > >        + RAM DDR2: 128. ELSE 96 MHz.
> > > >        + RAM DDR2: 160. ELSE 120 MHz.
> > > >        + RAM DDR2: 166. ELSE 125 MHz.
> > > >   * RT5350:
> > > >       - XTAL: 40 MHz.
> > > >       - CPU: 300, 320 or 360 MHz.
> > > >       - BUS: CPU / 3, CPU / 4, CPU / 3 MHz.
> > > >       - PERIPH: 40 MHz.
> > > >   * MT7628 and MT7688:
> > > >      - XTAL: 20 MHz or 40 MHz.
> > > >      - CPU: 575 or 580 MHz.
> > > >      - BUS: CPU / 3.
> > > >      - PCMI2S: 480 MHz.
> > > >      - PERIPH: 40 MHz.
> > > >   * MT7620:
> > > >      - XTAL: 20 MHz or 40 MHz.
> > > >      - PLL: XTAL, 480, 600 MHz.
> > > >      - CPU: depends on PLL and some mult and dividers.
> > > >      - BUS: depends on PLL and some mult and dividers.
> > > >      - PERIPH: 40 or XTAL MHz.
> > > >
> > > > MT7620 is a bit more complex deriving CPU clock from a PLL and an bunch of
> > > > register reads and predividers. To derive CPU and BUS frequencies in the
> > > > MT7620 SoC 'mt7620_calc_rate()' helper is used.
> > > > In the case XTAL can have different frequencies and we need a different
> > > > clock frequency for peripherals 'periph' clock in introduced.
> > > > The rest of the peripherals present in the SoC just follow their parent
> > > > frequencies.
> > > >
> > > > I am using 'mtmips' inside for ralink clock driver. This is aligned with
> > > > pinctrl series recently merged through pinctrl git tree [0].
> > > >
> > > > I am maintaining ralink as prefix for compatible strings after discussions
> > > > between Rob and Arinc in v2 of this series [1].
> > > >
> > > > Changes have been compile tested for:
> > > > - RT2880
> > > > - RT3883
> > > > - MT7620
> > > >
> > > > Changes have been properly tested in RT5350 SoC based board (ALL5003 board)
> > > > resulting in a working platform.
> > > >
> > > > Dts files for these SoCs in-tree except MT7621 are incomplete. We are
> > > > planning to align with openWRT files at some point and add extra needed
> > > > changes. Hence I am not touching them at all in these series. If this is
> > > > a problem, please let me know and I will update them.
> > > >
> > > > Talking about merging this series I'd like all of the patches going through
> > > > the MIPS tree if possible.
> > > >
> > > > Thanks in advance for your time.
> > > >
> > > > Best regards,
> > > >     Sergio Paracuellos
> > > >
> > > > Changes in v3:
> > > > - Address Stephen comments in v2:
> > > >     + Drop unsused include '<linux/clk.h>'.
> > > >     + Add fixed and factor clocks when it makes sense.
> > > >     + Make 'mtmips_periph_clk_ops' named variable.
> > > >     + WARN_ON -> WARN_ON_ONCE.
> > > >     + Avoid CONFIG_USB dependent code. Introduce new 'mtmips_clk_regs_init'.
> > > >     + Don't validate the bindings in the driver.
> > > >     + Make const 'struct clk_init_data' used inside macros.
> > > >     + do_div -> div_u64.
> > > >     + Make use of dev_err_probe.
> > >
> > > Hi Stephen,
> > >
> > > Does anything else need to be addressed to have all of these added?
> > >
> > > Philipp, can you please review the reset related code in PATCH 2/9 of
> > > these series?
> > >
> > > Thanks in advance for your time!
> > >
> > > Best regards,
> > >     Sergio Paracuellos
> >
> > Gentle ping for this series :-)
> 
> Another gentle ping for this series :-)

I'm reday to take it through the MIPS tree, if Stephen acks the
clk driver changes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
