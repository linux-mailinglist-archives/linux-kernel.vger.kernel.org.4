Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11F86D3E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjDCHam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjDCHak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:30:40 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC497EE8;
        Mon,  3 Apr 2023 00:30:36 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id CA09124E22F;
        Mon,  3 Apr 2023 15:30:34 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Apr
 2023 15:30:34 +0800
Received: from [192.168.125.87] (183.27.97.179) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Apr
 2023 15:30:33 +0800
Message-ID: <ce4ee037-c53c-5bd4-8968-437ee21c9c51@starfivetech.com>
Date:   Mon, 3 Apr 2023 15:30:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v7 00/22] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
 <acb36897-8085-4f41-9b68-b243467ffc6f@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <acb36897-8085-4f41-9b68-b243467ffc6f@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.179]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2023 20:19:41 +0100, Conor Dooley wrote:
> Hey Hal,
> 
> On Sat, Apr 01, 2023 at 07:19:12PM +0800, Hal Feng wrote:
>> This patch series adds basic clock, reset & DT support for StarFive
>> JH7110 SoC.
>> 
>> @Stephen and @Conor, I have made this series start with the shared
>> dt-bindings, so it will be easier to merge.
> 
> Thanks. I probably should have asked for that, makes my life easier
> that's for sure!

My pleasure.

> 
>> @Conor, patch 1, 2, 16~21 were already in your branch. Patch 22 is the
>> same with the patch [1] I submitted before, which you had accepted but
>> not merge it into your branch.
> 
> I hadn't merged that into anywhere, so I just went and dropped the
> original incarnation of that branch and have re-created it.
> I don't recall there being a maintainers pattern error (from running
> scripts/get_maintainer.pl --self-test=patterns) with what I had done in
> my branch, but with your patch 1 applied I see one. To save myself a
> complaint from LKP, I stripped out the MAINTAINERS bits from patch 1
> into their own patch that can go with the clock/reset bits.
> 
> I squashed 22 into "riscv: dts: starfive: Add initial StarFive JH7110
> device tree" since there's no reason to add something knowingly
> incorrect IMO.
> 
> I've gone and pushed out the following as riscv-jh7110_initial_dts:
> riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device
> riscv: dts: starfive: Add StarFive JH7110 pin function definitions
> riscv: dts: starfive: Add initial StarFive JH7110 device tree
> dt-bindings: riscv: Add SiFive S7 compatible
> dt-bindings: interrupt-controller: Add StarFive JH7110 plic
> dt-bindings: timer: Add StarFive JH7110 clint
> dt-bindings: clock: Add StarFive JH7110 always-on clock and reset generator
> dt-bindings: clock: Add StarFive JH7110 system clock and reset generator
> 
> And the rest as riscv-jh7110_clk_reset:
> MAINTAINERS: generalise StarFive clk/reset entries

For this patch, I find something to improve.
1. Could you please help me sort the StarFive entries in MAINTAINERS?
"STARFIVE JH71X0 CLOCK DRIVERS" should be added after
"STARFIVE JH7110 MMC/SD/SDIO DRIVER".

2. A "S" should be added at the end of
"STARFIVE JH7100 RESET CONTROLLER DRIVER".

I have tested your branch and have no comments on the other patches.

> reset: starfive: Add StarFive JH7110 reset driver
> clk: starfive: Add StarFive JH7110 always-on clock driver
> clk: starfive: Add StarFive JH7110 system clock driver
> reset: starfive: jh71x0: Use 32bit I/O on 32bit registers
> reset: starfive: Rename "jh7100" to "jh71x0" for the common code
> reset: starfive: Extract the common JH71X0 reset code
> reset: starfive: Factor out common JH71X0 reset code
> reset: Create subdirectory for StarFive drivers
> reset: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
> clk: starfive: Rename "jh7100" to "jh71x0" for the common code
> clk: starfive: Rename clk-starfive-jh7100.h to clk-starfive-jh71x0.h
> clk: starfive: Factor out common JH7100 and JH7110 code
> clk: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
> dt-bindings: clock: Add StarFive JH7110 always-on clock and reset generator
> dt-bindings: clock: Add StarFive JH7110 system clock and reset generator
> 
> <https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/refs>
> 
> As it looks like everything has been resolved in terms of comments on
> v6, provided LKP doesn't complain or people don't spot something else,
> my plan is to send Stephen a PR around Wednesday for the driver bits.

Thanks for your work.

Best regards,
Hal

> 
> Please LMK if I screwed up anything,
> Conor.

