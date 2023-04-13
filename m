Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE846E0934
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDMIp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDMIpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:45:23 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A76903B;
        Thu, 13 Apr 2023 01:45:10 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1842df7cb53so17030338fac.10;
        Thu, 13 Apr 2023 01:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375509; x=1683967509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjFhaqNUgwhEITdByljXNEwDvl5KZHYACc5+H+WRmxg=;
        b=RlXc2tiQGuYcvcV3TUZmKD2co3vwcHH7lF+ItJcaWdyzRLHBbabXEgkkkHvxwWCPu6
         XmMVJDS/43XD+ZImf7wkAnRgw7A/4YV/k6W1BI2Lil0Ou5IzyAlYKhAjMDGRObfNUhI0
         yaGI1QvuXOyazM09faU0XZgGh2C/jX/PrYH6p2oqaYkBkwchhTeqmiwknAg6eKLOKu92
         Gu5+4+ybt75X9kDVReGDJKBfLevNg78cNqmyTQB2gdU2E1nz+Nla3Fce1l6teisHaU04
         M/N0nDzeJUggvB5c2+WUmM/lKBlJR9EqozqqLZOv12VVeZPvIppDhfvJL8EY7FkO3K9s
         kveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375509; x=1683967509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjFhaqNUgwhEITdByljXNEwDvl5KZHYACc5+H+WRmxg=;
        b=YZMtHr5CsKxIIHqyUXiFGVW2BAkh32kpHqPrC0lQuofpLLQEylYkh3hfyp11gvZY1O
         lOzVSughrtpVGFqM67JQQoVU7puhI4Gct1qNeIhlb+8HHCijdmHoo/FO2tVylCSMJfeE
         lnsEUOUZG254JsfsapFmmUvmjPowXi7cjwX4C6mKLJmEItKBt4RbRhFelFR/L4+adCK1
         WQ0RlNOI8pHmwJTOo+3ivg1Wmkl3lKdYfdQecbfYaLI9B14n0nr0XOuihDGWiTtlglsW
         EnQdtuhteci4/EbIFXpwdYBKfwkYnQ1CSRjhTN3euxHXzIJ3bnOyJB63/HwfR8b4EEwB
         SATg==
X-Gm-Message-State: AAQBX9eF2FfiCEu1pbO3xJojHQuhX+TIqQoC2V3A/9tfI4EkAMp7sibQ
        9gVHd6/L6Gh3QK+zCCnqbyRlLV/p1bzUqWy9UUvznsG6
X-Google-Smtp-Source: AKy350bh7BnK5X9IUb7Y1kALwgmrl26skQfM/gwRVHBGFmjQwajze1N5NFt5SbkPK3+9kR/gHV+Cu1adh6B+6WFYrsI=
X-Received: by 2002:a05:6870:b24f:b0:177:abbb:f20c with SMTP id
 b15-20020a056870b24f00b00177abbbf20cmr959114oam.0.1681375509039; Thu, 13 Apr
 2023 01:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 13 Apr 2023 10:44:56 +0200
Message-ID: <CAMhs-H-0Upz--k0tkm7BFCTd0b0Gso-c_uPyzeAjOigZowbK1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] mips: ralink: add complete clock and reset driver
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 6:00=E2=80=AFAM Sergio Paracuellos
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

Gentle ping on this series :-)

Thanks,
     Sergio Paracuellos

>
> Previous series:
> v1: https://lore.kernel.org/linux-clk/20230320161823.1424278-1-sergio.par=
acuellos@gmail.com/T/#t
>
> [0]: https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b06=
185@arinc9.com/T/#t
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
>  .../bindings/clock/mediatek,mtmips-sysc.yaml  |  65 ++
>  MAINTAINERS                                   |   6 +
>  arch/mips/include/asm/mach-ralink/mt7620.h    |  35 -
>  arch/mips/include/asm/mach-ralink/rt288x.h    |  10 -
>  arch/mips/include/asm/mach-ralink/rt305x.h    |  21 -
>  arch/mips/include/asm/mach-ralink/rt3883.h    |   8 -
>  arch/mips/ralink/clk.c                        |  26 +-
>  arch/mips/ralink/common.h                     |   5 -
>  arch/mips/ralink/mt7620.c                     | 226 ----
>  arch/mips/ralink/of.c                         |   4 -
>  arch/mips/ralink/reset.c                      |  61 --
>  arch/mips/ralink/rt288x.c                     |  31 -
>  arch/mips/ralink/rt305x.c                     |  78 --
>  arch/mips/ralink/rt3883.c                     |  44 -
>  drivers/clk/ralink/Kconfig                    |   7 +
>  drivers/clk/ralink/Makefile                   |   1 +
>  drivers/clk/ralink/clk-mtmips.c               | 985 ++++++++++++++++++
>  17 files changed, 1083 insertions(+), 530 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmi=
ps-sysc.yaml
>  create mode 100644 drivers/clk/ralink/clk-mtmips.c
>
> --
> 2.25.1
>
