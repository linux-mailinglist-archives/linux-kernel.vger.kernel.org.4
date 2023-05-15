Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C688702225
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjEODZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjEODYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:24:53 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B89170B;
        Sun, 14 May 2023 20:24:50 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DA10A80C1;
        Mon, 15 May 2023 11:24:37 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 11:24:38 +0800
Received: from [192.168.125.131] (113.72.146.187) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 11:24:36 +0800
Message-ID: <b461a88f-76a1-29a2-d4d4-6ec9992a78ae@starfivetech.com>
Date:   Mon, 15 May 2023 11:23:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 06/10] clk: starfive: Add StarFive JH7110 Video-Output
 clock driver
Content-Language: en-US
To:     Aurelien Jarno <aurelien@aurel32.net>
References: <20230424135409.6648-1-xingyu.wu@starfivetech.com>
 <20230424135409.6648-7-xingyu.wu@starfivetech.com>
 <ZGFWyPbeEOxxqwQK@aurel32.net>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <ZGFWyPbeEOxxqwQK@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/15 5:46, Aurelien Jarno wrote:
> On 2023-04-24 21:54, Xingyu Wu wrote:
>> Add driver for the StarFive JH7110 Video-Output clock controller.
>> And these clock controllers should power on and enable the clocks from
>> SYSCRG first before registering.
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> 
> There seems to be something wrong with this patch. Building the kernel
> with the whole series applied and with CONFIG_FORTIFY_SOURCE=y triggers
> the following kernel bug: 
> 
> [   75.705103] detected buffer overflow in __fortify_strlen
> [   75.710497] ------------[ cut here ]------------
> [   75.715117] kernel BUG at lib/string_helpers.c:1027!
> [   75.720083] Kernel BUG [#1]
> [   75.722879] Modules linked in: clk_starfive_jh7110_vout(+) nvme_fabrics binfmt_misc starfive_wdt jh7110_trng watchdog sfctemp rng_core drm loop fuse drm_panel_orientation_quirks configfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 dm_mod nvme nvme_core t10_pi crc64_rocksoft crc64 crc_t10dif crct10dif_generic crct10dif_common xhci_pci xhci_hcd mmc_block dwmac_starfive stmmac_platform stmmac usbcore pcs_xpcs of_mdio fixed_phy fwnode_mdio phylink libphy usb_common dw_mmc_starfive dw_mmc_pltfm clk_starfive_jh7110_isp dw_mmc clk_starfive_jh7110_aon ptp phy_starfive_dphy_rx mmc_core pps_core phy_jh7110_pcie i2c_designware_platform clk_starfive_jh7110_stg phy_jh7110_usb i2c_designware_core
> [   75.785411] CPU: 1 PID: 419 Comm: insmod Not tainted 6.3.1+ #1
> [   75.791241] Hardware name: StarFive VisionFive 2 v1.2A (DT)
> [   75.796809] epc : fortify_panic+0x1a/0x1c
> [   75.800828]  ra : fortify_panic+0x1a/0x1c
> [   75.804838] epc : ffffffff80874242 ra : ffffffff80874242 sp : ffffffc80454b6a0
> [   75.812054]  gp : ffffffff8157f008 tp : ffffffd8c1214f80 t0 : 6465746365746564
> [   75.819269]  t1 : 0000000000000064 t2 : 2064657463657465 s0 : ffffffc80454b6b0
> [   75.826483]  s1 : 0000000000000020 a0 : 000000000000002c a1 : ffffffd8fdd63688
> [   75.833697]  a2 : ffffffd8fdd6f8e8 a3 : 0000000000000000 a4 : 0000000000000000
> [   75.840912]  a5 : 0000000000000000 a6 : ffffffff81426a38 a7 : 0000000000000000
> [   75.848126]  s2 : ffffffff80ec4e00 s3 : ffffffd8d9e28008 s4 : 000000000000001f
> [   75.855340]  s5 : 0000000000000000 s6 : ffffffff81580798 s7 : 0000000000ffffff
> [   75.862555]  s8 : ffffffd8d9e29ab0 s9 : 0000000000000011 s10: ffffffff017312a0
> [   75.869770]  s11: ffffffff01731450 t3 : ffffffff81592df7 t4 : ffffffff81592df7
> [   75.876984]  t5 : ffffffff81592df8 t6 : ffffffc80454b4a8
> [   75.882290] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> [   75.890199] [<ffffffff80874242>] fortify_panic+0x1a/0x1c
> [   75.895513] [<ffffffff805c7e20>] auxiliary_match_id+0x70/0xcc
> [   75.901262] [<ffffffff805c7f22>] auxiliary_match+0x1e/0x2a
> [   75.906749] [<ffffffff805bd6b0>] __device_attach_driver+0x2c/0xe4
> [   75.912841] [<ffffffff805bb04e>] bus_for_each_drv+0x70/0xc4
> [   75.918418] [<ffffffff805bdb0a>] __device_attach+0x94/0x198
> [   75.923989] [<ffffffff805bde68>] device_initial_probe+0x1a/0x22
> [   75.929908] [<ffffffff805bc146>] bus_probe_device+0x96/0x98
> [   75.935482] [<ffffffff805b971e>] device_add+0x56a/0x722
> [   75.940710] [<ffffffff805c7fc4>] __auxiliary_device_add+0x40/0x92
> [   75.946803] [<ffffffff80556ff4>] jh7110_reset_controller_register+0x92/0xca
> [   75.953765] [<ffffffff0173034c>] jh7110_voutcrg_probe+0x236/0x2fa [clk_starfive_jh7110_vout]
> [   75.962228] [<ffffffff805bfb40>] platform_probe+0x5e/0xa6
> [   75.967629] [<ffffffff805bd1e6>] really_probe+0xa0/0x342
> [   75.972940] [<ffffffff805bd508>] __driver_probe_device+0x80/0x138
> [   75.979031] [<ffffffff805bd5f8>] driver_probe_device+0x38/0xc4
> [   75.984863] [<ffffffff805bd83a>] __driver_attach+0xd2/0x1a8
> [   75.990436] [<ffffffff805baf92>] bus_for_each_dev+0x6c/0xb8
> [   75.996011] [<ffffffff805bcab6>] driver_attach+0x26/0x2e
> [   76.001325] [<ffffffff805bc384>] bus_add_driver+0x10c/0x1ee
> [   76.006900] [<ffffffff805be5e2>] driver_register+0x52/0xf4
> [   76.012386] [<ffffffff805bf78e>] __platform_driver_register+0x28/0x30
> [   76.018827] [<ffffffff01b72028>] jh7110_voutcrg_driver_init+0x28/0x1000 [clk_starfive_jh7110_vout]
> [   76.027802] [<ffffffff8000281a>] do_one_initcall+0x5c/0x1c8
> [   76.033377] [<ffffffff800a7612>] do_init_module+0x4c/0x1f6
> [   76.038867] [<ffffffff800a9396>] load_module+0x1a6c/0x1ebe
> [   76.044356] [<ffffffff800a99ea>] __do_sys_finit_module+0x9c/0xf8
> [   76.050365] [<ffffffff800a9a82>] sys_finit_module+0x1c/0x24
> [   76.055936] [<ffffffff80003df8>] ret_from_syscall+0x0/0x2
> [   76.061343] Code: 0800 85aa 3517 007a 0513 7ee5 a097 ffff 80e7 fc20 (9002) 7179 
> [   76.068735] ---[ end trace 0000000000000000 ]---
> 

I got the recurrence of this with CONFIG_FORTIFY_SOURCE=y.
And I found the problem that the reset name of auxiliary_device_id in VOUTCRG
is exactly 32 characters. I rename the reset of auxiliary_device_id in VOUTCRG
to a shorter name and fix the problem. And I will fix it in next patch.

Best regards,
Xingyu Wu
