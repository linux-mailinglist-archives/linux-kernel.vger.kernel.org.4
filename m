Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CCC64E261
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLOUcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOUcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:32:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467D25C8;
        Thu, 15 Dec 2022 12:32:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B23AB81AFA;
        Thu, 15 Dec 2022 20:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E89BC433F1;
        Thu, 15 Dec 2022 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671136362;
        bh=y/3TLTR8alCyKtmxTcEVJqr0AUUfHrH/2E1FxBjfCdo=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=MidHzEP0HrIzPA5nOA5tEymalTfFPQ8rtCZBPbPsxQ0sXSNi0NeuFkVuAkElJLf+I
         QWvT4huoJd4/6DQKUzl8b8wyC5kreTGxbF+AQxUL+98CUJFkChfll27/CEbE04rYJA
         0tEn+neLFvJxZF3K8U+v9wwsAymXVVU9SgnlIyklnmuoxEUpv41Vq4vf5n2Ozo81Wy
         9i+KZx2cMs8wVC0hUOpHsMo8aYeJNim/VpAkuXQOR9TBUKO9yF3AeyA9I5ei0OQEU8
         UnkSzaIMu/PlYRb76qnZPbFyDfg57BArPoJ7O66lL4/07qCBENx+2LYJR1Z/szkYUg
         KrHV0h6AlHX3A==
Date:   Thu, 15 Dec 2022 12:32:06 -0800
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, palmer@dabbelt.com,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_6/6=5D_soc=3A_renesas=3A_Add?= =?US-ASCII?Q?_L2_cache_management_for_RZ/Five_SoC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMuHMdUO7iFvh73u+m=EXYyxyePXHahJ=OVwQHdt0ap4vWDG4A@mail.gmail.com>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221212115505.36770-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUCkCyLOXbQEJyc7S2F08=ftNtPcEztRN3JWJv_FPmAVw@mail.gmail.com> <CA+V-a8vD=SOb6gPOwdPUE=kHeqa+oo2L-rbaW8zGjvw7YyQsqg@mail.gmail.com> <CAMuHMdWX4Yd52=Jv8kABtn+1B1V=dC2iXVZ81gNZBWNu4hb_3w@mail.gmail.com> <CA+V-a8t3+zzQ4yPftsAa51rkMGHr45NhMO4_2WmZ9BGg0wuQvw@mail.gmail.com> <Y5t7a2oZ64McjSSn@dizzy> <CAMuHMdUO7iFvh73u+m=EXYyxyePXHahJ=OVwQHdt0ap4vWDG4A@mail.gmail.com>
Message-ID: <88D71672-7A1D-422C-97E8-5046FB1B48CD@kernel.org>
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



On 15 December 2022 12:17:38 GMT-08:00, Geert Uytterhoeven <geert@linux-m6=
8k=2Eorg> wrote:
>Hi Conor,
>
>On Thu, Dec 15, 2022 at 8:54 PM Conor Dooley <conor@kernel=2Eorg> wrote:
>> On Thu, Dec 15, 2022 at 05:46:42PM +0000, Lad, Prabhakar wrote:
>> > On Thu, Dec 15, 2022 at 11:10 AM Geert Uytterhoeven
>> > <geert@linux-m68k=2Eorg> wrote:
>> > > On Thu, Dec 15, 2022 at 12:06 PM Lad, Prabhakar
>> > > <prabhakar=2Ecsengg@gmail=2Ecom> wrote:
>> > > > On Thu, Dec 15, 2022 at 10:36 AM Geert Uytterhoeven
>> > > > <geert@linux-m68k=2Eorg> wrote:
>> > > > > On Mon, Dec 12, 2022 at 12:58 PM Prabhakar <prabhakar=2Ecsengg@=
gmail=2Ecom> wrote:
>> > > > > > From: Lad Prabhakar <prabhakar=2Emahadev-lad=2Erj@bp=2Erenesa=
s=2Ecom>
>> > > > > >
>> > > > > > I/O Coherence Port (IOCP) provides an AXI interface for conne=
cting
>> > > > > > external non-caching masters, such as DMA controllers=2E The =
accesses
>> > > > > > from IOCP are coherent with D-Caches and L2 Cache=2E
>> > > > > >
>> > > > > > IOCP is a specification option and is disabled on the Renesas=
 RZ/Five
>> > > > > > SoC due to this reason IP blocks using DMA will fail=2E
>> > > > > >
>> > > > > > The Andes AX45MP core has a Programmable Physical Memory Attr=
ibutes (PMA)
>> > > > > > block that allows dynamic adjustment of memory attributes in =
the runtime=2E
>> > > > > > It contains a configurable amount of PMA entries implemented =
as CSR
>> > > > > > registers to control the attributes of memory locations in in=
terest=2E
>> > > > > > Below are the memory attributes supported:
>> > > > > > * Device, Non-bufferable
>> > > > > > * Device, bufferable
>> > > > > > * Memory, Non-cacheable, Non-bufferable
>> > > > > > * Memory, Non-cacheable, Bufferable
>> > > > > > * Memory, Write-back, No-allocate
>> > > > > > * Memory, Write-back, Read-allocate
>> > > > > > * Memory, Write-back, Write-allocate
>> > > > > > * Memory, Write-back, Read and Write-allocate
>> > > > > >
>> > > > > > More info about PMA (section 10=2E3):
>> > > > > > Link: http://www=2Eandestech=2Ecom/wp-content/uploads/AX45MP-=
1C-Rev=2E-5=2E0=2E0-Datasheet=2Epdf
>> > > > > >
>> > > > > > As a workaround for SoCs with IOCP disabled CMO needs to be h=
andled by
>> > > > > > software=2E Firstly OpenSBI configures the memory region as
>> > > > > > "Memory, Non-cacheable, Bufferable" and passes this region as=
 a global
>> > > > > > shared dma pool as a DT node=2E With DMA_GLOBAL_POOL enabled =
all DMA
>> > > > > > allocations happen from this region and synchronization callb=
acks are
>> > > > > > implemented to synchronize when doing DMA transactions=2E
>> > > > > >
>> > > > > > Example PMA region passes as a DT node from OpenSBI:
>> > > > > >     reserved-memory {
>> > > > > >         #address-cells =3D <2>;
>> > > > > >         #size-cells =3D <2>;
>> > > > > >         ranges;
>> > > > > >
>> > > > > >         pma_resv0@58000000 {
>> > > > > >             compatible =3D "shared-dma-pool";
>> > > > > >             reg =3D <0x0 0x58000000 0x0 0x08000000>;
>> > > > > >             no-map;
>> > > > > >             linux,dma-default;
>> > > > > >         };
>> > > > > >     };
>> > > > > >
>> > > > > > Signed-off-by: Lad Prabhakar <prabhakar=2Emahadev-lad=2Erj@bp=
=2Erenesas=2Ecom>
>> > > > >
>> > > > > Thanks for your patch!
>> > > > >
>> > > > > >  arch/riscv/include/asm/cacheflush=2Eh       |   8 +
>> > > > > >  arch/riscv/include/asm/errata_list=2Eh      |  28 ++-
>> > > > > >  drivers/soc/renesas/Kconfig               |   6 +
>> > > > > >  drivers/soc/renesas/Makefile              |   2 +
>> > > > > >  drivers/soc/renesas/rzfive/Kconfig        |   6 +
>> > > > > >  drivers/soc/renesas/rzfive/Makefile       |   3 +
>> > > > > >  drivers/soc/renesas/rzfive/ax45mp_cache=2Ec | 256 ++++++++++=
++++++++++++
>> > > > >
>> > > > > Given this touches arch/riscv/include/asm/, I don't think the
>> > > > > code belongs under drivers/soc/renesas/=2E
>> > > > >
>> > > > Ok=2E Do you have any suggestions on where you want me to put thi=
s code?
>> > >
>> > > As it plugs into core riscv functionality, I think it should be und=
er
>> > > arch/riscv/=2E
>> > > if the RISC-V maintainers object to that, another option is
>> > > drivers/soc/andestech/ or (new) drivers/cache/
>> > >
>> > RISC-V maintainers had already made it clear to not to include vendor
>> > specific stuff in the arch/riscv folder, so I'll consider putting thi=
s
>> > into drivers/cache/ folder to sync with the bindings=2E
>> >
>> > Conor/Palmer - do you have any objections/suggestions?
>>
>> I'm not its maintainer so sorta moot what I say, but having drivers in
>> arch/riscv makes little sense to me=2E=2E
>> Putting stuff in drivers/cache does sound like a good idea since the
>> binding is going there too=2E
>>
>> The SiFive ccache driver is in drivers/soc and it was suggested to me
>> this week that there's likely going to be a second SiFive cache driver
>> at some point in the near future=2E Plus Microchip are going to have to
>> add cache management stuff to the existing SiFive ccache driver=2E
>> Having them be their own thing makes sense in my mind - especially sinc=
e
>> they're not tied to SoCs sold by Andes or SiFive=2E
>>
>> I had a quick, and I mean *quick* look through other soc drivers to see
>> if there were any other cache controller drivers but nothing stood out
>> to me=2E Maybe someone else has more of a clue there=2E Ditto for misc,=
 had
>> a look but nothing seemed obvious=2E
>
>Usually they're under arch/:
>$ git ls-files -- "arch/*cache*" | wc -l
>148
>$ git ls-files -- "drivers/*cache*" | wc -l
>63

That's for checking what I could not!
Don't think my roaming data would cover a kernel clone!

>E=2Eg=2E arch/arm/mm/cache-l2x0=2Ec=2E

If that's where they usually go, is there a real reason not to do the same=
 here?
Whatever about a limited set of riscv cache drivers, moving all the other =
ones around to a new directory doesnt seem like a great idea=2E

