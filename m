Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233976CB715
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjC1GZb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Mar 2023 02:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjC1GZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:25:12 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFD340DB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:24:22 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6E9D024E2F2;
        Tue, 28 Mar 2023 14:23:52 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Mar
 2023 14:23:52 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Mar
 2023 14:23:51 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 28 Mar 2023 14:23:51 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v7 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Topic: [PATCH v7 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Index: AQHZXUPUmSFyHAHJnEaKAA/P9UfMX68OGliAgAADeoCAAaM50A==
Date:   Tue, 28 Mar 2023 06:23:51 +0000
Message-ID: <c6e4a3cb42044c07b1ec37b76ea6596d@EXMBX066.cuchost.com>
References: <20230323045604.536099-1-jeeheng.sia@starfivetech.com>
 <20230323045604.536099-5-jeeheng.sia@starfivetech.com>
 <20230327131025.6bawvoti65sth4rk@orel> <20230327132251.dejgmcpxjdrqzmvk@orel>
In-Reply-To: <20230327132251.dejgmcpxjdrqzmvk@orel>
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
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Jones <ajones@ventanamicro.com>
> Sent: Monday, March 27, 2023 9:23 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>; Conor Dooley
> <conor.dooley@microchip.com>
> Subject: Re: [PATCH v7 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> 
> On Mon, Mar 27, 2023 at 03:10:25PM +0200, Andrew Jones wrote:
> > On Thu, Mar 23, 2023 at 12:56:04PM +0800, Sia Jee Heng wrote:
> > > Low level Arch functions were created to support hibernation.
> > > swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> > > cpu state onto the stack, then calling swsusp_save() to save the memory
> > > image.
> > >
> > > Arch specific hibernation header is implemented and is utilized by the
> > > arch_hibernation_header_restore() and arch_hibernation_header_save()
> > > functions. The arch specific hibernation header consists of satp, hartid,
> > > and the cpu_resume address. The kernel built version is also need to be
> > > saved into the hibernation image header to making sure only the same
> > > kernel is restore when resume.
> > >
> > > swsusp_arch_resume() creates a temporary page table that covering only
> > > the linear map. It copies the restore code to a 'safe' page, then start
> > > to restore the memory image. Once completed, it restores the original
> > > kernel's page table. It then calls into __hibernate_cpu_resume()
> > > to restore the CPU context. Finally, it follows the normal hibernation
> > > path back to the hibernation core.
> > >
> > > To enable hibernation/suspend to disk into RISCV, the below config
> > > need to be enabled:
> > > - CONFIG_ARCH_HIBERNATION_HEADER
> > > - CONFIG_ARCH_HIBERNATION_POSSIBLE
> > >
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  arch/riscv/Kconfig                 |   6 +
> > >  arch/riscv/include/asm/assembler.h |  20 ++
> > >  arch/riscv/include/asm/suspend.h   |  19 ++
> > >  arch/riscv/kernel/Makefile         |   1 +
> > >  arch/riscv/kernel/asm-offsets.c    |   5 +
> > >  arch/riscv/kernel/hibernate-asm.S  |  77 ++++++
> > >  arch/riscv/kernel/hibernate.c      | 427 +++++++++++++++++++++++++++++
> > >  7 files changed, 555 insertions(+)
> > >  create mode 100644 arch/riscv/kernel/hibernate-asm.S
> > >  create mode 100644 arch/riscv/kernel/hibernate.c
> > >
> >
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Actually, I forgot to point out something. As hibernation depends on
> suspend.c for save/restore_csrs, we need something like
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 73cca7f17f6f..f1d2289df660 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -54,7 +54,7 @@ config RISCV
>         select CLINT_TIMER if !MMU
>         select CLONE_BACKWARDS
>         select COMMON_CLK
> -       select CPU_PM if CPU_IDLE
> +       select CPU_PM if CPU_IDLE || HIBERNATION
Sure. Will add it
>         select EDAC_SUPPORT
>         select GENERIC_ARCH_TOPOLOGY
>         select GENERIC_ATOMIC64 if !64BIT
> 
> 
> Thanks,
> drew
