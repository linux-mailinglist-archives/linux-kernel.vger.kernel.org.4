Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1C65CFED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjADJtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjADJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:49:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DD71A21B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:49:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC621614E2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EACC433EF;
        Wed,  4 Jan 2023 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672825790;
        bh=8sm8xtJf3KAd4pR7kZe5UGTuodwcSnwrEzeARWqg0UA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=kWFz+rAaeiSFVSHcu1blPH+GGTSZjyRM4pSdFMYPZiPITxaqpNdOjkAtCi2eybLIZ
         phox/4xY8FW/Ui/Zw7ZP/x+Of3c77z3yN4NVP6fmdyxOSRsuTvarjGZEPFNmnyJbRX
         51NjMfCB+y7eh2aVytdQuON/tpNrU0lsyQvMYUGptYrrOb90X/Vy8aLK4PH0P81La6
         jDaxX3Ln5aL7SooMQTQ9aN9UUQn60eubLSaRjFNg0O9Bxfp/zAkXFDS8tsWu8Tagga
         /ZJ1S3aSb7+Vupufw9PF28pcEi1oIcA/IU4pShrsEAFZN9hD9a8saED+/XWNMjV7/S
         ak4kC65TIcYSA==
Date:   Wed, 04 Jan 2023 09:49:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH=5D_riscv=3A_Move_call_to_init=5Fcpu?= =?US-ASCII?Q?=5Ftopology=28=29_to_later_initialization_stage?=
User-Agent: K-9 Mail for Android
In-Reply-To: <672440143ab04d3dbcc6de0a16bab3e1@EXMBX161.cuchost.com>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com> <20230103065411.2l7k6r57v4phrnos@orel> <efed8f35ae8c4901ba01702bcc07b511@EXMBX161.cuchost.com> <Y7Rg28suWh1RUbkU@spud> <672440143ab04d3dbcc6de0a16bab3e1@EXMBX161.cuchost.com>
Message-ID: <F86CD957-8B7C-46B9-A14B-AAE67E43CD71@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sudeep, see below - I got mixed up & what arm64 does now makes sense to me!
Your opinion on the patch, motivation aside, would be nice though=2E

Hey Leyfoon,


On 4 January 2023 05:35:41 GMT, Leyfoon Tan <leyfoon=2Etan@starfivetech=2E=
com> wrote:
>
>
>> -----Original Message-----
>> From: Conor Dooley <conor@kernel=2Eorg>
>> Sent: Wednesday, 4 January, 2023 1:08 AM

---8<---
>> To: Leyfoon Tan <leyfoon=2Etan@starfivetech=2Ecom>; Sudeep Holla
>> <sudeep=2Eholla@arm=2Ecom>
>> Cc: Andrew Jones <ajones@ventanamicro=2Ecom>; Palmer Dabbelt
>> <palmer@dabbelt=2Ecom>; Paul Walmsley <paul=2Ewalmsley@sifive=2Ecom>; A=
lbert
>> Ou <aou@eecs=2Eberkeley=2Eedu>; linux-riscv@lists=2Einfradead=2Eorg; li=
nux-
>> kernel@vger=2Ekernel=2Eorg; Ley Foon Tan <lftan=2Elinux@gmail=2Ecom>
>> Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to later
>> initialization stage
---8<---

btw, this above is pretty much useless can you can drop it from replies=2E

>>=20
>> Hello!
>>=20
>> Couple comments for you=2E
>>=20
>> +CC Sudeep: I've got a question for you below=2E
>>=20
>> On Tue, Jan 03, 2023 at 07:53:38AM +0000, Leyfoon Tan wrote:
>> > > From: Andrew Jones <ajones@ventanamicro=2Ecom>
>> > > Subject: Re: [PATCH] riscv: Move call to init_cpu_topology() to
>> > > later initialization stage On Tue, Jan 03, 2023 at 11:53:16AM +0800=
,
>> > > Ley Foon Tan wrote:
>> > > > topology_parse_cpu_capacity() is failed to allocate memory with
>> > > > kcalloc() after read "capacity-dmips-mhz" DT parameter in CPU DT
>>=20
>> Uhh, so where did this "capacity-dmips-mhz" property actually come from=
?
>> I had a quick check of qemu with grep & I don't see anything there that
>> would add this property=2E
>> This property should not be valid on anything other than arm AFAICT=2E
>
>This DT parameter is not in default Qemu=2E I've added it for testing (se=
e test steps in below)=2E=20
>This is preparation to support asymmetric CPU topology for RISC-V=2E

The property is only valid on arm, so how does arm64 deal with such asymme=
tric topologies without it?
Why should we "fix" something that may never be a valid dts?

>
>>=20
>> > > > nodes=2E This
>> > > > topology_parse_cpu_capacity() is called from init_cpu_topology(),
>> > > > move call to init_cpu_topology() to later initialization  stage
>> > > > (after memory allocation is available)=2E
>> > > >
>> > > > Note, this refers to ARM64 implementation, call
>> > > > init_cpu_topology() in smp_prepare_cpus()=2E
>> > > >
>> > > > Tested on Qemu platform=2E
>> > >
>> > > Hi Ley,
>> > >
>> > > Can you provide the topologies (command lines) tested?
>> > 2 clusters with 2 CPU cores each=2E
>>=20
>> What's the actual commandline for this? I'm not the best with QEMU, so =
it'd
>> really be appreciated, given the above=2E
>I used the Qemu to dump the DTS for 'virt' machine from Qemu, then add th=
e "capacity-dmips-mhz" DT parameter and modify the CPU topology for cluster=
s=2E
>
>1=2E Dump the dtb for 'virt' machine:
>qemu-system-riscv64 -cpu rv64 -smp 4 -m 2048M -M virt,dumpdtb=3Dqemu_virt=
=2Edtb
>
>2=2E Convert dtb to dts
>dtc -I dtb -O dts qemu_virt=2Edtb > qemu_virt=2Edts
>
>3=2E Modifying qemu_virt=2Edts
>
>4=2E Compile dts to dtb
>dtc -I dts -O dtb qemu_virt=2Edts > qemu_virt=2Edtb
>
>5=2E Pass in "-dtb qemu_virt=2Edtb" as one of Qemu's argument=2E
>
>>=20
>> > > > Signed-off-by: Ley Foon Tan <leyfoon=2Etan@starfivetech=2Ecom>
>> > >
>> > > Fixes tag?
>> > Okay, will send out next revision with Fixes tag=2E
>>=20
>> Please don't just send versions to add tags, Palmer can pick them up if=
/when
>> he applies the patch=2E
>Okay=2E Will let Palmer add tag below if he applies the patch=2E
>
>Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot=2E ")
>
>
>>=20
>> > > >  arch/riscv/kernel/smpboot=2Ec | 3 ++-
>> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/arch/riscv/kernel/smpboot=2Ec
>> > > > b/arch/riscv/kernel/smpboot=2Ec index 3373df413c88=2E=2Eddb2afba6=
d25
>> > > > 100644
>> > > > --- a/arch/riscv/kernel/smpboot=2Ec
>> > > > +++ b/arch/riscv/kernel/smpboot=2Ec
>> > > > @@ -39,7 +39,6 @@ static DECLARE_COMPLETION(cpu_running);
>> > > >
>> > > >  void __init smp_prepare_boot_cpu(void)  {
>> > > > -	init_cpu_topology();
>> > > >  }
>> > > >
>> > > >  void __init smp_prepare_cpus(unsigned int max_cpus) @@ -48,6
>> > > > +47,8
>> > > @@
>> > > > void __init smp_prepare_cpus(unsigned int max_cpus)
>> > > >  	int ret;
>> > > >  	unsigned int curr_cpuid;
>> > > >
>> > > > +	init_cpu_topology();
>>=20
>> I know arm64 does this, but there is any real reason for us to do so?
>> @Sudeep, do you know why arm64 calls that each time?

I got myself mixed up between places I fiddled with storing the topology, =
so you can ignore that question Sudeep=2E
Clearly it's the one in smp_callin() that gets called for each CPU=2E
Woops=2E

>> Or if it is worth "saving" that call on riscv, since arm64 is clearly h=
appily calling
>> it for many years & calling it later would likely head off a good few a=
llocation
>> issues (like the one we saw with the topology reworking a few months ag=
o)=2E

=2E=2E=2Ebut is it still worth moving the function call later to head off =
any allocation failures if core topology code changes?

>> > > > +
>> > > >  	curr_cpuid =3D smp_processor_id();
>> > > >  	store_cpu_topology(curr_cpuid);
>> > > >  	numa_store_cpu_info(curr_cpuid);
>> > > > --
>> > > > 2=2E25=2E1
>> > > >
>> > >
>> > > Otherwise,
>> > >
>> > > Reviewed-by: Andrew Jones <ajones@ventanamicro=2Ecom>
>
>Regards
>Ley Foon
>
