Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA95565CCA0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 06:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjADFft convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Jan 2023 00:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjADFfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 00:35:47 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B78165B2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 21:35:44 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id EFB6024E311;
        Wed,  4 Jan 2023 13:35:41 +0800 (CST)
Received: from EXMBX163.cuchost.com (172.16.7.73) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 4 Jan
 2023 13:35:42 +0800
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX163.cuchost.com
 (172.16.6.73) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 4 Jan
 2023 13:35:41 +0800
Received: from EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c]) by
 EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c%15]) with mapi id
 15.00.1497.044; Wed, 4 Jan 2023 13:35:41 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: RE: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Thread-Topic: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Thread-Index: AQHZH0BUA1ZpH2MfF0y2uzSNVn9yRK6MUX9QgAAVqICAATb70A==
Date:   Wed, 4 Jan 2023 05:35:41 +0000
Message-ID: <672440143ab04d3dbcc6de0a16bab3e1@EXMBX161.cuchost.com>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
 <20230103065411.2l7k6r57v4phrnos@orel>
 <efed8f35ae8c4901ba01702bcc07b511@EXMBX161.cuchost.com>
 <Y7Rg28suWh1RUbkU@spud>
In-Reply-To: <Y7Rg28suWh1RUbkU@spud>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Wednesday, 4 January, 2023 1:08 AM
> To: Leyfoon Tan <leyfoon.tan@starfivetech.com>; Sudeep Holla
> <sudeep.holla@arm.com>
> Cc: Andrew Jones <ajones@ventanamicro.com>; Palmer Dabbelt
> <palmer@dabbelt.com>; Paul Walmsley <paul.walmsley@sifive.com>; Albert
> Ou <aou@eecs.berkeley.edu>; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Ley Foon Tan <lftan.linux@gmail.com>
> Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
> initialization stage
> 
> Hello!
> 
> Couple comments for you.
> 
> +CC Sudeep: I've got a question for you below.
> 
> On Tue, Jan 03, 2023 at 07:53:38AM +0000, Leyfoon Tan wrote:
> > > From: Andrew Jones <ajones@ventanamicro.com>
> > > Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to
> > > later initialization stage On Tue, Jan 03, 2023 at 11:53:16AM +0800,
> > > Ley Foon Tan wrote:
> > > > topology_parse_cpu_capacity() is failed to allocate memory with
> > > > kcalloc() after read "capacity-dmips-mhz" DT parameter in CPU DT
> 
> Uhh, so where did this "capacity-dmips-mhz" property actually come from?
> I had a quick check of qemu with grep & I don't see anything there that
> would add this property.
> This property should not be valid on anything other than arm AFAICT.

This DT parameter is not in default Qemu. I've added it for testing (see test steps in below). 
This is preparation to support asymmetric CPU topology for RISC-V.

> 
> > > > nodes. This
> > > > topology_parse_cpu_capacity() is called from init_cpu_topology(),
> > > > move call to init_cpu_topology() to later initialization  stage
> > > > (after memory allocation is available).
> > > >
> > > > Note, this refers to ARM64 implementation, call
> > > > init_cpu_topology() in smp_prepare_cpus().
> > > >
> > > > Tested on Qemu platform.
> > >
> > > Hi Ley,
> > >
> > > Can you provide the topologies (command lines) tested?
> > 2 clusters with 2 CPU cores each.
> 
> What's the actual commandline for this? I'm not the best with QEMU, so it'd
> really be appreciated, given the above.
I used the Qemu to dump the DTS for 'virt' machine from Qemu, then add the "capacity-dmips-mhz" DT parameter and modify the CPU topology for clusters.

1. Dump the dtb for 'virt' machine:
qemu-system-riscv64 -cpu rv64 -smp 4 -m 2048M -M virt,dumpdtb=qemu_virt.dtb

2. Convert dtb to dts
dtc -I dtb -O dts qemu_virt.dtb > qemu_virt.dts

3. Modifying qemu_virt.dts

4. Compile dts to dtb
dtc -I dts -O dtb qemu_virt.dts > qemu_virt.dtb

5. Pass in "-dtb qemu_virt.dtb" as one of Qemu's argument.

> 
> > > > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > >
> > > Fixes tag?
> > Okay, will send out next revision with Fixes tag.
> 
> Please don't just send versions to add tags, Palmer can pick them up if/when
> he applies the patch.
Okay. Will let Palmer add tag below if he applies the patch.

Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot. ")


> 
> > > >  arch/riscv/kernel/smpboot.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/riscv/kernel/smpboot.c
> > > > b/arch/riscv/kernel/smpboot.c index 3373df413c88..ddb2afba6d25
> > > > 100644
> > > > --- a/arch/riscv/kernel/smpboot.c
> > > > +++ b/arch/riscv/kernel/smpboot.c
> > > > @@ -39,7 +39,6 @@ static DECLARE_COMPLETION(cpu_running);
> > > >
> > > >  void __init smp_prepare_boot_cpu(void)  {
> > > > -	init_cpu_topology();
> > > >  }
> > > >
> > > >  void __init smp_prepare_cpus(unsigned int max_cpus) @@ -48,6
> > > > +47,8
> > > @@
> > > > void __init smp_prepare_cpus(unsigned int max_cpus)
> > > >  	int ret;
> > > >  	unsigned int curr_cpuid;
> > > >
> > > > +	init_cpu_topology();
> 
> I know arm64 does this, but there is any real reason for us to do so?
> @Sudeep, do you know why arm64 calls that each time?
> Or if it is worth "saving" that call on riscv, since arm64 is clearly happily calling
> it for many years & calling it later would likely head off a good few allocation
> issues (like the one we saw with the topology reworking a few months ago).
> 
> Thanks,
> Conor.
> 
> > > > +
> > > >  	curr_cpuid = smp_processor_id();
> > > >  	store_cpu_topology(curr_cpuid);
> > > >  	numa_store_cpu_info(curr_cpuid);
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Otherwise,
> > >
> > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Regards
Ley Foon

