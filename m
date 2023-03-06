Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52186AB50F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCFDaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFD37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:29:59 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237F7EF9C;
        Sun,  5 Mar 2023 19:29:58 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id ADF7324E194;
        Mon,  6 Mar 2023 11:29:50 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 11:29:50 +0800
Received: from [192.168.125.110] (183.27.97.46) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 6 Mar
 2023 11:29:49 +0800
Message-ID: <ae6ddeeb-81d3-81e5-c6ab-5d728007817d@starfivetech.com>
Date:   Mon, 6 Mar 2023 11:29:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 00/19] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Content-Language: en-US
To:     Tommaso Merciai <tomm.merciai@gmail.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <ZAJFpKlXPM+riuSa@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <ZAJFpKlXPM+riuSa@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 20:08:20 +0100, Tommaso Merciai wrote:
> Hello Hal,
> I start to play with jh7110-starfive-visionfive-2-v1.3b I have collect
> your series [3]. Now I'm trying to boot the image with the following
> cmds:
> 
> setenv bootfile vmlinuz;
> setenv fileaddr a0000000;
> setenv fdtcontroladdr 0xffffffffffffffff;
> setenv ipaddr 10.0.0.100;
> setenv serverip 10.0.0.1;
> setenv kernel_comp_addr_r 0xb0000000;
> setenv kernel_comp_size 0x10000000;
> tftpboot ${fdt_addr_r} jh7110-starfive-visionfive-2-v1.3b.dtb;
> tftpboot ${kernel_addr_r} Image.gz;
> run chipa_set_linux;
> booti ${kernel_addr_r} - ${fdt_addr_r}
> 
> 
> This the result:
> 
> Bytes transferred = 109443584 (685fa00 hex)
> StarFive # run chipa_set_linux;
> StarFive # printenv file
>   fileaddr filesize
> StarFive # printenv filesize
> filesize=685fa00
> StarFive # booti ${kernel_addr_r} - ${fdt_addr_r}
>    Uncompressing Kernel Image
> ## Flattened Device Tree blob at 46000000
>    Booting using the fdt blob at 0x46000000
>    Using Device Tree in place at 0000000046000000, end 0000000046005c14
> 
> Starting kernel ...
> 
> clk u5_dw_i2c_clk_core already disabled
> clk u5_dw_i2c_clk_apb already disabled
> 
> ---------------------------------------------
> 
> I'm missing something? Any hints?
> Many thanks in advance! :)

You can try the instructions at the link [1]. The branch [1] is
based on v2 of this series, so you need to change the dtb name
to "jh7110-starfive-visionfive-2-v1.3b.dtb" when using tftpboot.
I will send v5 and update it to [1] this week.

[1] https://github.com/starfive-tech/linux/tree/JH7110_VisionFive2_upstream

Best regards,
Hal
