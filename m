Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6CD65BB72
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbjACHxw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Jan 2023 02:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjACHxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:53:50 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C71DF14
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 23:53:42 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7023624E0FC;
        Tue,  3 Jan 2023 15:53:39 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 15:53:39 +0800
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 3 Jan
 2023 15:53:38 +0800
Received: from EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c]) by
 EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c%15]) with mapi id
 15.00.1497.044; Tue, 3 Jan 2023 15:53:38 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: RE: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Thread-Topic: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Thread-Index: AQHZH0BUA1ZpH2MfF0y2uzSNVn9yRK6MUX9Q
Date:   Tue, 3 Jan 2023 07:53:38 +0000
Message-ID: <efed8f35ae8c4901ba01702bcc07b511@EXMBX161.cuchost.com>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
 <20230103065411.2l7k6r57v4phrnos@orel>
In-Reply-To: <20230103065411.2l7k6r57v4phrnos@orel>
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
> From: Andrew Jones <ajones@ventanamicro.com>
> Sent: Tuesday, 3 January, 2023 2:54 PM
> To: Leyfoon Tan <leyfoon.tan@starfivetech.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>; Paul Walmsley
> <paul.walmsley@sifive.com>; Albert Ou <aou@eecs.berkeley.edu>; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Ley Foon Tan
> <lftan.linux@gmail.com>
> Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
> initialization stage
> 
> On Tue, Jan 03, 2023 at 11:53:16AM +0800, Ley Foon Tan wrote:
> > topology_parse_cpu_capacity() is failed to allocate memory with
> > kcalloc() after read "capacity-dmips-mhz" DT parameter in CPU DT
> > nodes. This
> > topology_parse_cpu_capacity() is called from init_cpu_topology(), move
> > call to init_cpu_topology() to later initialization  stage (after
> > memory allocation is available).
> >
> > Note, this refers to ARM64 implementation, call init_cpu_topology() in
> > smp_prepare_cpus().
> >
> > Tested on Qemu platform.
> 
> Hi Ley,
> 
> Can you provide the topologies (command lines) tested?
2 clusters with 2 CPU cores each.

> 
> >
> > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> 
> Fixes tag?
Okay, will send out next revision with Fixes tag.

Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot. ")


[...]

> >  arch/riscv/kernel/smpboot.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 3373df413c88..ddb2afba6d25 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -39,7 +39,6 @@ static DECLARE_COMPLETION(cpu_running);
> >
> >  void __init smp_prepare_boot_cpu(void)  {
> > -	init_cpu_topology();
> >  }
> >
> >  void __init smp_prepare_cpus(unsigned int max_cpus) @@ -48,6 +47,8
> @@
> > void __init smp_prepare_cpus(unsigned int max_cpus)
> >  	int ret;
> >  	unsigned int curr_cpuid;
> >
> > +	init_cpu_topology();
> > +
> >  	curr_cpuid = smp_processor_id();
> >  	store_cpu_topology(curr_cpuid);
> >  	numa_store_cpu_info(curr_cpuid);
> > --
> > 2.25.1
> >
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew

Thanks
Ley Foon
