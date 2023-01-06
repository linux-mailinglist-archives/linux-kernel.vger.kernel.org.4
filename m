Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAA966057F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjAFRRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjAFRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:17:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D4747D1CE;
        Fri,  6 Jan 2023 09:17:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1068D2F4;
        Fri,  6 Jan 2023 09:17:51 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FCFF3F71A;
        Fri,  6 Jan 2023 09:17:07 -0800 (PST)
Date:   Fri, 6 Jan 2023 17:17:04 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        =?UTF-8?B?QW5kcsOhcyBTemVtesO2?= <szemzo.andras@gmail.com>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ARM: dts: sunxi: Add MangoPi MQ-R board support
Message-ID: <20230106171704.12e81a81@donnerap.cambridge.arm.com>
In-Reply-To: <20230106010155.26868-1-andre.przywara@arm.com>
References: <20230106010155.26868-1-andre.przywara@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Jan 2023 01:01:51 +0000
Andre Przywara <andre.przywara@arm.com> wrote:

> The MangoPi MQ-R is a small SBC with the Allwinner T113-s3 SoC. That is
> a very close relative to the Allwinner D1/D1s SoCs, but with Arm
> Cortex-A7 cores, and 128 MB of SIP co-packaged DDR3 DRAM.
> 
> This series introduces the missing T113-s .dtsi, which builds on top of
> the D1/D1s .dtsi, but adds the ARM specific peripherals, like the CPU
> cores, the arch timer, the GIC and the PMU.
> This requires to add a symlink to the RISC-V DT directory in patch 1/4,
> to be able to easily reference the base .dtsi from other architecture
> directories.

First, forgot to mention that this builds on top of Samuel's D1/D1s DT
series:
https://lore.kernel.org/linux-arm-kernel/20221231233851.24923-1-samuel@sholland.org/
To actually boot, this also relies on the R528/T113s clock series:
https://lore.kernel.org/linux-arm-kernel/20221231231429.18357-1-samuel@sholland.org/

> After I had written most of the board .dts, I realised that the
> MangoPi MQ is almost the same, minus the RISC-V/ARM difference. I am a
> bit unsure if we should share more of the board .dts, though, as this
> would go cross architectures. I am open to any comments here.

So after getting some sleep and having a look at the MangoPi website
again, I realised that there is of course a D1s edition of the MQ-R as
well. So shall we split this up like this:
- a sunxi-mangopi-mq.dtsi, which contains all the board specific nodes
- a sun20i-d1-mangopi-mq.dts, which includes that and sun20i-d1s.dtsi
- a sun20i-d1-mangopi-mq-r.dts, which maybe includes
  sun20i-d1-mangopi-mq.dts, and just overwrites the model name?
- a sun8i-t113s-mangopi-mq-r.dts, which includes sunxi-mangopi-mq.dtsi
  and sun8i-t113s.dtsi

Let me know if this useful or more confusing.

Cheers,
Andre


> Andre Przywara (4):
>   dts: add riscv include prefix link
>   ARM: dts: sunxi: add Allwinner T113-s SoC .dtsi
>   dt-bindings: arm: sunxi: document MangoPi MQ-R board name
>   ARM: dts: sunxi: add MangoPi MQ-R board
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts | 160 ++++++++++++++++++
>  arch/arm/boot/dts/sun8i-t113s.dtsi            |  59 +++++++
>  scripts/dtc/include-prefixes/riscv            |   1 +
>  5 files changed, 226 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts
>  create mode 100644 arch/arm/boot/dts/sun8i-t113s.dtsi
>  create mode 120000 scripts/dtc/include-prefixes/riscv
> 

