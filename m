Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026006F6DFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjEDOsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEDOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:48:20 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E0CD;
        Thu,  4 May 2023 07:48:19 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-38e5eeba43cso199749b6e.3;
        Thu, 04 May 2023 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683211698; x=1685803698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/elf53ReInwQkE2MA0feH0LEMQ6B/gIWB/x/DzsbjR8=;
        b=hInvwGa9X+53HLs//WPzgh4itSmpZzu4o+YjJu+vqENVTsUVRuyX/tQ1TOMDhzad28
         1dVJEHFRTuHAQu346Wv0c2w3kglaMsLtdGi7f+jiBc/cr8pddyPxL63imxc1SAkLo0PX
         MvCBVx5yKU4P451j4Vqn9NL5S7EvOv9h1dqFjA3PbC+Dft76gUBqqVW5ZerzC4ySXpiX
         UK/+7saLslglP4T9ylLUexeQGl0F7aQkQgYOERMtHq2NAHvbqAqLZ/zeitfvo/fBXn73
         RgPDrsFD6fFIUx2Uh6pz9U8eoi9tbPCkJfCdr3ivnS4VTxIYONJhEEjnrvPVYoEt6BZt
         3iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683211698; x=1685803698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/elf53ReInwQkE2MA0feH0LEMQ6B/gIWB/x/DzsbjR8=;
        b=MO++zvWvUVBua3s3VqIKqlXM/sIxdFHxoBDwFP57aZbgAyNyyedxTiGgg2Mi9y0Ugm
         8lNXIwehXe3SPP5nyPi5xWSNkW/aTnf4wNBRMbRl1yJDSbHcIBjpssOLEt8XDSnJqUhg
         iRTBjutDdKcSQ5z/aXZctyp8yf805ot81ZPucf5lWFb2tjpddIUW2Jnr20Tk0jzTn3fj
         OPL+F+pcxsDLbpHzRJd7pZ1JDVQHn+s9APiVrFuNoejA4d7WG52uIz29yF8zuihReVQR
         rO6Oz3PLzDIXB+F26f+umKIY9kctAsopAKLXvXC49IfwI5SbBIx568UDyfCQE3vEDMoR
         rYhQ==
X-Gm-Message-State: AC+VfDyXIwRszEi+sTY+HZ7ktDkoyCjo9Ru6dYUsLfLKafs20sJCsUVH
        gFP5y6EJvCQnY3EzNtXpphhYMRSfwtqP1X23ManTq4xhP/E=
X-Google-Smtp-Source: ACHHUZ6MwHuU84KzmOFkHJdZLMa2SNpJTDMCzVNdGE6/3Ylx9yAG6UCDbFstjPwKMPydDnS8O3/Igd9Ud3WI5jH3yZA=
X-Received: by 2002:a05:6808:190b:b0:38e:a4a6:41a with SMTP id
 bf11-20020a056808190b00b0038ea4a6041amr1947029oib.20.1683211697946; Thu, 04
 May 2023 07:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 4 May 2023 16:48:06 +0200
Message-ID: <CAMhs-H_yn_76RAFNk4ux_-rn9FdKna9Vsu0raFQXfr3ykkRWPw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] mips: ralink: add complete clock and reset driver
 for mtmips SoCs
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:03=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi all!
>
> This patchset is a big effort to properly implement a clock and reset
> driver for old ralink SoCs. This allow to properly define clocks in
> device tree and avoid to use fixed-clocks directly from 'arch/mips/ralink=
'
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
> MT7620 is a bit more complex deriving CPU clock from a PLL and an bunch o=
f
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
> I am maintaining ralink as prefix for compatible strings after discussion=
s
> between Rob and Arinc in v2 of this series [1].
>
> Changes have been compile tested for:
> - RT2880
> - RT3883
> - MT7620
>
> Changes have been properly tested in RT5350 SoC based board (ALL5003 boar=
d)
> resulting in a working platform.
>
> Dts files for these SoCs in-tree except MT7621 are incomplete. We are
> planning to align with openWRT files at some point and add extra needed
> changes. Hence I am not touching them at all in these series. If this is
> a problem, please let me know and I will update them.
>
> Talking about merging this series I'd like all of the patches going throu=
gh
> the MIPS tree if possible.
>
> Thanks in advance for your time.
>
> Best regards,
>     Sergio Paracuellos
>
> Changes in v3:
> - Address Stephen comments in v2:
>     + Drop unsused include '<linux/clk.h>'.
>     + Add fixed and factor clocks when it makes sense.
>     + Make 'mtmips_periph_clk_ops' named variable.
>     + WARN_ON -> WARN_ON_ONCE.
>     + Avoid CONFIG_USB dependent code. Introduce new 'mtmips_clk_regs_ini=
t'.
>     + Don't validate the bindings in the driver.
>     + Make const 'struct clk_init_data' used inside macros.
>     + do_div -> div_u64.
>     + Make use of dev_err_probe.

Hi Stephen,

Does anything else need to be addressed to have all of these added?

Philipp, can you please review the reset related code in PATCH 2/9 of
these series?

Thanks in advance for your time!

Best regards,
    Sergio Paracuellos

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
> v2: https://lore.kernel.org/linux-clk/CAMhs-H-BfZb3mD8E=3DLeJ4vT22uibQ1Dn=
aZsfTrtRxSiv=3D8L5RA@mail.gmail.com/T/#t
> v1: https://lore.kernel.org/linux-clk/20230320161823.1424278-1-sergio.par=
acuellos@gmail.com/T/#t
>
> [0]: https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b06=
185@arinc9.com/T/#t
> [1]: https://lore.kernel.org/linux-clk/CAMhs-H-BfZb3mD8E=3DLeJ4vT22uibQ1D=
naZsfTrtRxSiv=3D8L5RA@mail.gmail.com/T/#mfe725b6e3382c6fb09736472a846cbbc84=
f264dc
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
>  .../bindings/clock/mediatek,mtmips-sysc.yaml  |   65 +
>  MAINTAINERS                                   |    6 +
>  arch/mips/include/asm/mach-ralink/mt7620.h    |   35 -
>  arch/mips/include/asm/mach-ralink/rt288x.h    |   10 -
>  arch/mips/include/asm/mach-ralink/rt305x.h    |   21 -
>  arch/mips/include/asm/mach-ralink/rt3883.h    |    8 -
>  arch/mips/ralink/clk.c                        |   26 +-
>  arch/mips/ralink/common.h                     |    5 -
>  arch/mips/ralink/mt7620.c                     |  226 ----
>  arch/mips/ralink/of.c                         |    4 -
>  arch/mips/ralink/reset.c                      |   61 -
>  arch/mips/ralink/rt288x.c                     |   31 -
>  arch/mips/ralink/rt305x.c                     |   78 --
>  arch/mips/ralink/rt3883.c                     |   44 -
>  drivers/clk/ralink/Kconfig                    |    7 +
>  drivers/clk/ralink/Makefile                   |    1 +
>  drivers/clk/ralink/clk-mtmips.c               | 1134 +++++++++++++++++
>  17 files changed, 1232 insertions(+), 530 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmi=
ps-sysc.yaml
>  create mode 100644 drivers/clk/ralink/clk-mtmips.c
>
> --
> 2.25.1
>
