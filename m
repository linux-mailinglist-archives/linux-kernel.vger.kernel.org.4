Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061B760DE00
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiJZJ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJZJZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:25:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D9982638;
        Wed, 26 Oct 2022 02:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666776341; x=1698312341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J2x3u/A7C/R5Z7jun6x22iPwMoJoUKGDgdxT1e8scO8=;
  b=E29cMAiN/IMXs7B3SD26yk+265mrcOuV9IK1VsJgHbcsHbsoWxMC7f9M
   XZN1SS+iRWpmMv8aYsRrTNiN1R7vPUInK3WCP6XsmJr4XNIZlxjUP38oR
   KT1T3JY3wLe4R0l9HaHlmxMxCDw9emMCOB2U7dJW+ByzezPnaLc3BaUIW
   LuP1fRt9bM9b7/S8s2ug/1wcypA8lKPFuq6pnj2O8zcaU5w0P87wI8jM0
   87iI4bWQidQxOIYA69vfYL2/nL5x3IaRZqjqjVIlH8/3kJQmufwmHv3wh
   EE0wHRLo+of6l3vZifeYigSY+ZCQLStcHjXM9MoXUc1csA4ttqHSvAILi
   w==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="197083124"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 02:25:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 02:25:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 26 Oct 2022 02:25:35 -0700
Date:   Wed, 26 Oct 2022 10:25:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
CC:     Baoquan He <bhe@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <anup@brainfault.org>, <heiko@sntech.de>, <guoren@kernel.org>,
        <mick@ics.forth.gr>, <alexandre.ghiti@canonical.com>,
        <vgoyal@redhat.com>, <dyoung@redhat.com>, <corbet@lwn.net>,
        <bagasdotme@gmail.com>, <k-hagio-ab@nec.com>, <lijiang@redhat.com>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <crash-utility@redhat.com>, <heinrich.schuchardt@canonical.com>,
        <hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V4 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Message-ID: <Y1j9AAhJXpoCx48N@wendy>
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
 <Y1CtreAKT/SEh4vN@MiWiFi-R3L-srv>
 <30621b3b-47ba-d612-cfb0-583d779691a3@linux.alibaba.com>
 <Y1C681H2mlxX+zqf@MiWiFi-R3L-srv>
 <6af05838-fa58-8197-f3ce-ca95457077a7@linux.alibaba.com>
 <5df30e57-88ae-0a3b-2c1a-b962363d8670@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5df30e57-88ae-0a3b-2c1a-b962363d8670@linux.alibaba.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 05:08:11PM +0800, Xianting Tian wrote:
> Hi Palmer, Conor
> 
> Is this version OK for you?

The weird ifdef/IS_ENABLED thing was the only comment I had. It's a bit
odd & I notice Baoquan brought it up too. I didn't (and won't) give you
a reviewed by on these patches because I don't understand the area well
enough. The general nitpickery seems to be sorted though.

Thanks,
Conor.

> 
> 在 2022/10/20 下午12:40, Xianting Tian 写道:
> > 
> > 在 2022/10/20 上午11:05, Baoquan He 写道:
> > > On 10/20/22 at 10:17am, Xianting Tian wrote:
> > > > 在 2022/10/20 上午10:08, Baoquan He 写道:
> > > > > On 10/19/22 at 06:36pm, Xianting Tian wrote:
> > > > > > Add arch_crash_save_vmcoreinfo(), which exports VM
> > > > > > layout(MODULES, VMALLOC,
> > > > > > VMEMMAP ranges and KERNEL_LINK_ADDR), va bits and ram
> > > > > > base for vmcore.
> > > > > > 
> > > > > > Default pagetable levels and PAGE_OFFSET aren't same for
> > > > > > different kernel
> > > > > > version as below. For pagetable levels, it sets sv57 by
> > > > > > default and falls
> > > > > > back to setting sv48 at boot time if sv57 is not
> > > > > > supported by the hardware.
> > > > > > 
> > > > > > For ram base, the default value is 0x80200000 for qemu
> > > > > > riscv64 env and,
> > > > > > for example, is 0x200000 on the XuanTie 910 CPU.
> > > > > > 
> > > > > >    * Linux Kernel 5.18 ~
> > > > > >    *      PGTABLE_LEVELS = 5
> > > > > >    *      PAGE_OFFSET = 0xff60000000000000
> > > > > >    * Linux Kernel 5.17 ~
> > > > > >    *      PGTABLE_LEVELS = 4
> > > > > >    *      PAGE_OFFSET = 0xffffaf8000000000
> > > > > >    * Linux Kernel 4.19 ~
> > > > > >    *      PGTABLE_LEVELS = 3
> > > > > >    *      PAGE_OFFSET = 0xffffffe000000000
> > > > > > 
> > > > > > Since these configurations change from time to time and
> > > > > > version to version,
> > > > > > it is preferable to export them via vmcoreinfo than to
> > > > > > change the crash's
> > > > > > code frequently, it can simplify the development of crash tool.
> > > > > > 
> > > > > > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> > > > > > ---
> > > > > >    arch/riscv/kernel/Makefile     |  1 +
> > > > > >    arch/riscv/kernel/crash_core.c | 23 +++++++++++++++++++++++
> > > > > >    2 files changed, 24 insertions(+)
> > > > > >    create mode 100644 arch/riscv/kernel/crash_core.c
> > > > > > 
> > > > > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > > > > index db6e4b1294ba..4cf303a779ab 100644
> > > > > > --- a/arch/riscv/kernel/Makefile
> > > > > > +++ b/arch/riscv/kernel/Makefile
> > > > > > @@ -81,6 +81,7 @@ obj-$(CONFIG_KGDB)        += kgdb.o
> > > > > >    obj-$(CONFIG_KEXEC_CORE)    += kexec_relocate.o
> > > > > > crash_save_regs.o machine_kexec.o
> > > > > >    obj-$(CONFIG_KEXEC_FILE)    += elf_kexec.o machine_kexec_file.o
> > > > > >    obj-$(CONFIG_CRASH_DUMP)    += crash_dump.o
> > > > > > +obj-$(CONFIG_CRASH_CORE)    += crash_core.o
> > > > > >    obj-$(CONFIG_JUMP_LABEL)    += jump_label.o
> > > > > > diff --git a/arch/riscv/kernel/crash_core.c
> > > > > > b/arch/riscv/kernel/crash_core.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..3e889d0ed7bd
> > > > > > --- /dev/null
> > > > > > +++ b/arch/riscv/kernel/crash_core.c
> > > > > > @@ -0,0 +1,23 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +
> > > > > > +#include <linux/crash_core.h>
> > > > > > +#include <linux/pagemap.h>
> > > > > > +
> > > > > > +void arch_crash_save_vmcoreinfo(void)
> > > > > > +{
> > > > > > +    VMCOREINFO_NUMBER(VA_BITS);
> > > > > > +    VMCOREINFO_NUMBER(phys_ram_base);
> > > > > > +
> > > > > > +   
> > > > > > vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n",
> > > > > > PAGE_OFFSET);
> > > > > > + vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n",
> > > > > > VMALLOC_START);
> > > > > > +   
> > > > > > vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n",
> > > > > > VMALLOC_END);
> > > > > > + vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n",
> > > > > > VMEMMAP_START);
> > > > > > +   
> > > > > > vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n",
> > > > > > VMEMMAP_END);
> > > > > > +#ifdef CONFIG_64BIT
> > > > > > + vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n",
> > > > > > MODULES_VADDR);
> > > > > > +   
> > > > > > vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n",
> > > > > > MODULES_END);
> > > > > > +#endif
> > > > > > +
> > > > > > +    if (IS_ENABLED(CONFIG_64BIT))
> > > > > > +
> > > > > > vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n",
> > > > > > KERNEL_LINK_ADDR);
> > > > > Wondering why you don't put KERNEL_LINK_ADDR exporting into the above
> > > > > ifdeffery scope, with that you can save one line of
> > > > > "IS_ENABLED(CONFIG_64BIT)".
> > > > I followed the rule in print_vm_layout() of
> > > > arch/riscv/mm/init.c, which used
> > > > IS_ENABLED when print the value of KERNEL_LINK_ADDR.
> > > > 
> > > I see. There's PAGE_OFFSET in the middle. Thanks.
> > > 
> > >          print_ml("lowmem", (unsigned long)PAGE_OFFSET,
> > >                  (unsigned long)high_memory)
> > > 
> > > So now, do you think if it's necessary to have another
> > > IS_ENABLED(CONFIG_64BIT) in the current arch_crash_save_vmcoreinfo()?
> > 
> > For which MACRO?  I think current code for PAGE_OFFSET is OK.
> > 
