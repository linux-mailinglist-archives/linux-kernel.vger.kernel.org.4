Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365E165D0D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjADKl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjADKlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:41:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE459112F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:41:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C11A1063;
        Wed,  4 Jan 2023 02:42:02 -0800 (PST)
Received: from bogus (unknown [10.163.75.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0AC33F71A;
        Wed,  4 Jan 2023 02:41:16 -0800 (PST)
Date:   Wed, 4 Jan 2023 10:41:16 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Message-ID: <20230104104116.ob666fm6agkoildy@bogus>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
 <20230103065411.2l7k6r57v4phrnos@orel>
 <efed8f35ae8c4901ba01702bcc07b511@EXMBX161.cuchost.com>
 <Y7Rg28suWh1RUbkU@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Rg28suWh1RUbkU@spud>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 05:07:39PM +0000, Conor Dooley wrote:
> Hello!
> 
> Couple comments for you.
> 
> +CC Sudeep: I've got a question for you below.
> 
> On Tue, Jan 03, 2023 at 07:53:38AM +0000, Leyfoon Tan wrote:
> > > From: Andrew Jones <ajones@ventanamicro.com>
> > > Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
> > > initialization stage
> > > On Tue, Jan 03, 2023 at 11:53:16AM +0800, Ley Foon Tan wrote:
> > > > topology_parse_cpu_capacity() is failed to allocate memory with
> > > > kcalloc() after read "capacity-dmips-mhz" DT parameter in CPU DT
> 
> Uhh, so where did this "capacity-dmips-mhz" property actually come from?
> I had a quick check of qemu with grep & I don't see anything there that
> would add this property.

From the DT properties.

> This property should not be valid on anything other than arm AFAICT.
>

Not sure if we restrict that on arm/arm64 only, but yes it is mostly used
on asymmetric CPU systems.


[...]

> > > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > > > index 3373df413c88..ddb2afba6d25 100644
> > > > --- a/arch/riscv/kernel/smpboot.c
> > > > +++ b/arch/riscv/kernel/smpboot.c
> > > > @@ -39,7 +39,6 @@ static DECLARE_COMPLETION(cpu_running);
> > > >
> > > >  void __init smp_prepare_boot_cpu(void)  {
> > > > -	init_cpu_topology();
> > > >  }
> > > >
> > > >  void __init smp_prepare_cpus(unsigned int max_cpus) @@ -48,6 +47,8
> > > @@
> > > > void __init smp_prepare_cpus(unsigned int max_cpus)
> > > >  	int ret;
> > > >  	unsigned int curr_cpuid;
> > > >
> > > > +	init_cpu_topology();
> 
> I know arm64 does this, but there is any real reason for us to do so?
> @Sudeep, do you know why arm64 calls that each time?

Not sure what you are referring as called each time. IIUC smp_prepare_cpus()
must be called only once on the primary during the boot to prepare for
the secondary boot. The difference is by this stage we know the max possible
CPU and supply the same to the call.

> Or if it is worth "saving" that call on riscv, since arm64 is clearly
> happily calling it for many years & calling it later would likely head
> off a good few allocation issues (like the one we saw with the topology
> reworking a few months ago).
>

Yes the failure seems like similar issue we saw with cacheinfo and early
allocation on RISC-V. However I can't recall why we have done this way
on arm64 and not in smp_prepare_boot_cpu() like in RISC-V.

Not sure if that was any helpful.

-- 
Regards,
Sudeep
