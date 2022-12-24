Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F43655B0A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 20:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLXTCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 14:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 14:02:31 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD07310E1;
        Sat, 24 Dec 2022 11:02:30 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1p99mm-0007Ot-2t;
        Sat, 24 Dec 2022 20:02:21 +0100
Date:   Sat, 24 Dec 2022 19:02:14 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Steven Liu <steven.liu@mediatek.com>,
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spi: mediatek: Enable irq when pdata is ready
Message-ID: <Y6dL2ZWgd1BD6kew@makrotopia.org>
References: <20221128-spi-mt65xx-v1-0-509266830665@chromium.org>
 <166965653185.677424.5326738316899525692.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166965653185.677424.5326738316899525692.b4-ty@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,
Hi Mark,

On Mon, Nov 28, 2022 at 05:28:51PM +0000, Mark Brown wrote:
> On Mon, 28 Nov 2022 12:00:01 +0100, Ricardo Ribalda wrote:
> > If the device does not come straight from reset, we might receive an IRQ
> > before we are ready to handle it.
> > 
> > Fixes:
> > 
> > [    0.832328] Unable to handle kernel read from unreadable memory at virtual address 0000000000000010
> > [    1.040343] Call trace:
> > [    1.040347]  mtk_spi_can_dma+0xc/0x40
> > ...
> > [    1.262265]  start_kernel+0x338/0x42c
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: mediatek: Enable irq when pdata is ready
>       commit: c6f7874687f7027d7c4b2f53ff6e4d22850f915d
> 

Testing next-20221220 on the BananaPi BPi-R3 MT7986 board it turns
out that this commit is *causing* a kernel oops and strack trace output
actually quite similar to what is described in the commit message:
...
[    2.074496] mtk-spi 1100a000.spi: spi-mem transfer timeout
[    2.080064] spi-nor: probe of spi0.0 failed with error -110
[    2.085830] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
[    2.094624] Mem abort info:
[    2.097418]   ESR = 0x0000000096000005
[    2.101162]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.106466]   SET = 0, FnV = 0
[    2.109521]   EA = 0, S1PTW = 0
[    2.111511] mtk_soc_eth 15100000.ethernet eth0: mediatek frame engine at 0xffffffc00e280000, irq 121
[    2.112653]   FSC = 0x05: level 1 translation fault
[    2.112659] Data abort info:
[    2.121921] mtk_soc_eth 15100000.ethernet: generated random MAC address ba:0e:79:b6:0a:83
[    2.126628]   ISV = 0, ISS = 0x00000005
[    2.126631]   CM = 0, WnR = 0
[    2.126635] [0000000000000010] user address but active_mm is swapper
[    2.126724] Internal error: Oops: 0000000096000005 [#1] SMP
[    2.130647] mtk_soc_eth 15100000.ethernet eth1: mediatek frame engine at 0xffffffc00e280000, irq 121
[    2.137739] Modules linked in:
[    2.137748] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-next-20221220+ #0
[    2.137753] Hardware name: Bananapi BPI-R3 (DT)
[    2.137756] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.142036] i2c_dev: i2c /dev entries driver
[    2.144530] pc : mtk_spi_can_dma+0x0/0x2c
[    2.144541] lr : mtk_spi_interrupt+0x60/0x350
[    2.144545] sp : ffffffc008003ec0
[    2.144547] x29: ffffffc008003ec0 x28: ffffffc008eb67c8 x27: 0000000000012400
[    2.152967] NET: Registered PF_INET6 protocol family
[    2.156435] x26: 0000000000000400 x25: 0000000000000076 x24: ffffff80072dac00
[    2.156443] x23: 0000000000000000 x22: ffffffc008d33008 x21: 0000000000000000
[    2.156450] x20: ffffff8007b67000 x19: ffffff8007b67880 x18: 0000000000000002
[    2.156457] x17: ffffffc076e23000
[    2.166540] Segment Routing with IPv6
[    2.168599]  x16: ffffffc008004000 x15: 0000000000004000
[    2.168605] x14: 0000000000000000 x13: 00000000000001dd
[    2.175768] In-situ OAM (IOAM) with IPv6
[    2.180229]  x12: 00000000000001dd
[    2.187232] NET: Registered PF_PACKET protocol family
[    2.191417] x11: 0000000000000040 x10: 0000000000000000
[    2.195594] 8021q: 802.1Q VLAN Support v1.8
[    2.199745]  x9 : ffffffc076e23000
[    2.216379] pstore: Using crash dump compression: deflate
[    2.222225] x8 : 00000000f04bc9a3 x7 : 0000000000000000 x6 : 0000000000000002
[    2.222233] x5 : 0000000000000003 x4 : 0000000000000001
[    2.245403] mtk-pcie-gen3 11280000.pcie: host bridge /soc/pcie@11280000 ranges:
[    2.248702]  x3 : ffffffc008672704
[    2.248705] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff8007b67000
[    2.253927] mtk-pcie-gen3 11280000.pcie: Parsing ranges property...
[    2.257818] 
[    2.257820] Call trace:
[    2.257822]  mtk_spi_can_dma+0x0/0x2c
[    2.257828]  __handle_irq_event_percpu+0xa8/0x340
[    2.257835]  handle_irq_event+0x48/0xd0
[    2.257840]  handle_fasteoi_irq+0xa0/0x1dc
[    2.261241] mtk-pcie-gen3 11280000.pcie:      MEM 0x0020000000..0x002fffffff -> 0x0020000000
[    2.266255]  generic_handle_domain_irq+0x28/0x40
[    2.266260]  gic_handle_irq+0x4c/0x124
[    2.357698]  call_on_irq_stack+0x2c/0x40
[    2.361612]  do_interrupt_handler+0x78/0x84
[    2.365783]  el1_interrupt+0x30/0x4c
[    2.369351]  el1h_64_irq_handler+0x14/0x20
[    2.373434]  el1h_64_irq+0x64/0x68
[    2.376825]  arch_cpu_idle+0x14/0x20
[    2.380389]  default_idle_call+0x68/0xe0
[    2.384302]  do_idle+0xe8/0x140
[    2.387434]  cpu_startup_entry+0x24/0x30
[    2.391345]  rest_init+0x120/0x1a0
[    2.394735]  arch_post_acpi_subsys_init+0x0/0x8
[    2.399254]  start_kernel+0x68c/0x6ac
[    2.402905]  __primary_switched+0xb4/0xbc
[    2.406909] Code: 17ffffd3 12003c23 12103c24 17ffffe7 (b9401041) 
[    2.412987] ---[ end trace 0000000000000000 ]---
[    2.419401] pstore: backend (ramoops) writing error (-28)
[    2.420889] mtk-pcie-gen3 11280000.pcie: set MEM trans window[0]: cpu_addr = 0x20000000, pci_addr = 0x20000000, size = 0x10000000
[    2.424785] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[    2.424788] SMP: stopping secondary CPUs
[    2.424794] Kernel Offset: disabled
[    2.424796] CPU features: 0x00000,00000008,0000400b
[    2.424799] Memory Limit: none
[    2.460293] Rebooting in 1 seconds..

Reverting the above commit fixes the issue and results in normal boot:

[daniel@box linux.git]$ git revert c6f7874687f70
Auto-merging drivers/spi/spi-mt65xx.c
hint: Waiting for your editor to close the file... 
[mt7986-wip a1aafac27c46d] Revert "spi: mediatek: Enable irq when pdata is ready"
 1 file changed, 5 insertions(+), 7 deletions(-)
...
[    1.045904] spi-nor spi0.0: w25q256 (32768 Kbytes)
[    1.063603] 6 fixed-partitions partitions found on MTD device spi0.0
[    1.070099] OF: Bad cell count for /soc/spi@1100a000/flash@0/partitions
[    1.076799] OF: Bad cell count for /soc/spi@1100a000/flash@0/partitions
[    1.084180] Creating 6 MTD partitions on "spi0.0":
[    1.089011] 0x000000c00000-0x000002000000 : "fit"
[    1.096514] 0x000000180000-0x000000c00000 : "recovery"
[    1.103853] 0x000000100000-0x000000180000 : "fip"
[    1.110685] 0x000000080000-0x000000100000 : "reserved2"
[    1.118762] 0x000000040000-0x000000080000 : "u-boot-env"
[    1.126593] 0x000000000000-0x000000040000 : "bl2"
...


Best regards


Daniel
