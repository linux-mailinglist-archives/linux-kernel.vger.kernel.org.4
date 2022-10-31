Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4898613213
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJaI7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJaI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECDDD124
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667206680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z91eHH8pl3kslsZiDOnRRDgLPUm79K5+l5tngN5wAPg=;
        b=D2+7WSEaIrbRqk/WsDTiGgbK7q4h0+77zRhZgolfhmcMCQFAGKyIQwQgNZ7YDS44QoO5tp
        yIzkrm3/Dx74eXP1i4vH1QrU5jTTXwjhw8b1q+/J5Y+C3XB6rA4czXURWIs2/TPkNQc90U
        ItCS4/w/FdszsUauy9VaqMt+vONE8hk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-5cSb-gPSOlGPn2x72M2L9Q-1; Mon, 31 Oct 2022 04:57:53 -0400
X-MC-Unique: 5cSb-gPSOlGPn2x72M2L9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D38751012466;
        Mon, 31 Oct 2022 08:57:52 +0000 (UTC)
Received: from localhost (ovpn-12-152.pek2.redhat.com [10.72.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85CCB40C2066;
        Mon, 31 Oct 2022 08:57:50 +0000 (UTC)
Date:   Mon, 31 Oct 2022 16:57:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, bagasdotme@gmail.com,
        k-hagio-ab@nec.com, lijiang@redhat.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, hschauhan@nulltrace.org,
        yixun.lan@gmail.com
Subject: Re: [PATCH V4 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Message-ID: <Y1+OC/BLBw0mVEV6@MiWiFi-R3L-srv>
References: <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
 <Y1CtreAKT/SEh4vN@MiWiFi-R3L-srv>
 <30621b3b-47ba-d612-cfb0-583d779691a3@linux.alibaba.com>
 <Y1C681H2mlxX+zqf@MiWiFi-R3L-srv>
 <6af05838-fa58-8197-f3ce-ca95457077a7@linux.alibaba.com>
 <5df30e57-88ae-0a3b-2c1a-b962363d8670@linux.alibaba.com>
 <Y1j9AAhJXpoCx48N@wendy>
 <3c8beab1-3ca7-c3d7-6f31-c28a0ae008a3@linux.alibaba.com>
 <Y1kilaWGEHChimZw@MiWiFi-R3L-srv>
 <Y1k6i1mNYNroWckn@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1k6i1mNYNroWckn@spud>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 at 02:47pm, Conor Dooley wrote:
> On Wed, Oct 26, 2022 at 08:05:41PM +0800, Baoquan He wrote:
> > Hi Xianting, 
> > 
> > On 10/26/22 at 05:44pm, Xianting Tian wrote:
> > > 
> > > 在 2022/10/26 下午5:25, Conor Dooley 写道:
> > > > On Wed, Oct 26, 2022 at 05:08:11PM +0800, Xianting Tian wrote:
> > > > > Hi Palmer, Conor
> > > > > 
> > > > > Is this version OK for you?
> > > > The weird ifdef/IS_ENABLED thing was the only comment I had. It's a bit
> > > > odd & I notice Baoquan brought it up too. I didn't (and won't) give you
> > > > a reviewed by on these patches because I don't understand the area well
> > > > enough. The general nitpickery seems to be sorted though.
> > > 
> > > I checked the KERNEL_LINK_ADDR definition of riscv,  it is valid for
> > > CONFIG_64BIT and !CONFIG_64BIT.
> > 
> > This series looks good to me. My only minor concern is if we can make
> > the arch_crash_save_vmcoreinfo() as below. I don't understand why we
> > have to have the CONFIG_64BIT ifdeffery and the IS_ENABLED(CONFIG_64BIT)
> > between two adjacent code blocks. Not sure if we are saying the same
> > thing.
> 
> I think we can just go and drop the IS_ENABLED(). From looking at it
> last time, one bit is compileable (but not usable) for !64BIT and the
> other isn't hence the IS_ENABLED(). I think it would make sense to drop
> the IS_ENABLED() - I don't think we're too likely to hit some compile
> testing edge cases that IS_ENABLED() would help with & only having one
> makes the code look a lot less odd and a lot more intentional.

I check risc-v code again, and agree we can drop the IS_ENABLED checking
to export KERNEL_LINK_ADDR anyway. We can surely deduce
KERNEL_LINK_ADDR in userspace e.g makedumpfile/Crash, while it seems no
harm to get it from the vmcoreinfo directly.

As for the difference between "#ifdef CONFIG_64BIT" and
"if (IS_ENABLED(CONFIG_64BIT))", I haven't got what's the Xianting's
point. Below is the IS_ENABLED definition in include/linux/kconfig.h,
it's truly different than #ifdef, while the change we are discussing
here is not related.

/*
 * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
 * 0 otherwise.  Note that CONFIG_FOO=y results in "#define CONFIG_FOO 1" in
 * autoconf.h, while CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1".
 */
#define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))

> 
> > 
> > +void arch_crash_save_vmcoreinfo(void)
> > +{
> > +       VMCOREINFO_NUMBER(VA_BITS);
> > +       VMCOREINFO_NUMBER(phys_ram_base);
> > +
> > +       vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
> > +       vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> > +       vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
> > +       vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
> > +       vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
> > +#ifdef CONFIG_64BIT
> > +	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
> > +       vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
> > +       vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
> > +#endif
> > +}
> > 
> > > 
> > > Maybe we can remove IS_ENABLED(CONFIG_64BIT)
> > > 
> > > arch/riscv/include/asm/pgtable.h
> > > #define ADDRESS_SPACE_END       (UL(-1))
> > > #ifdef CONFIG_64BIT
> > > /* Leave 2GB for kernel and BPF at the end of the address space */
> > > #define KERNEL_LINK_ADDR        (ADDRESS_SPACE_END - SZ_2G + 1)
> > > #else
> > > #define KERNEL_LINK_ADDR        PAGE_OFFSET
> > > #endif
> > > 
> > > arch/riscv/include/asm/page.h
> > > #ifdef CONFIG_64BIT
> > > #ifdef CONFIG_MMU
> > > #define PAGE_OFFSET             kernel_map.page_offset
> > > #else
> > > #define PAGE_OFFSET             _AC(CONFIG_PAGE_OFFSET, UL)
> > > #endif
> > > /*
> > >  * By default, CONFIG_PAGE_OFFSET value corresponds to SV48 address space so
> > >  * define the PAGE_OFFSET value for SV39.
> > >  */
> > > #define PAGE_OFFSET_L4          _AC(0xffffaf8000000000, UL)
> > > #define PAGE_OFFSET_L3          _AC(0xffffffd800000000, UL)
> > > #else
> > > #define PAGE_OFFSET             _AC(CONFIG_PAGE_OFFSET, UL)
> > > #endif /* CONFIG_64BIT */
> > > 
> > > > 
> > > > Thanks,
> > > > Conor.
> > > > 
> > > > > 在 2022/10/20 下午12:40, Xianting Tian 写道:
> > > > > > 在 2022/10/20 上午11:05, Baoquan He 写道:
> > > > > > > On 10/20/22 at 10:17am, Xianting Tian wrote:
> > > > > > > > 在 2022/10/20 上午10:08, Baoquan He 写道:
> > > > > > > > > On 10/19/22 at 06:36pm, Xianting Tian wrote:
> > > > > > > > > > Add arch_crash_save_vmcoreinfo(), which exports VM
> > > > > > > > > > layout(MODULES, VMALLOC,
> > > > > > > > > > VMEMMAP ranges and KERNEL_LINK_ADDR), va bits and ram
> > > > > > > > > > base for vmcore.
> > > > > > > > > > 
> > > > > > > > > > Default pagetable levels and PAGE_OFFSET aren't same for
> > > > > > > > > > different kernel
> > > > > > > > > > version as below. For pagetable levels, it sets sv57 by
> > > > > > > > > > default and falls
> > > > > > > > > > back to setting sv48 at boot time if sv57 is not
> > > > > > > > > > supported by the hardware.
> > > > > > > > > > 
> > > > > > > > > > For ram base, the default value is 0x80200000 for qemu
> > > > > > > > > > riscv64 env and,
> > > > > > > > > > for example, is 0x200000 on the XuanTie 910 CPU.
> > > > > > > > > > 
> > > > > > > > > >     * Linux Kernel 5.18 ~
> > > > > > > > > >     *      PGTABLE_LEVELS = 5
> > > > > > > > > >     *      PAGE_OFFSET = 0xff60000000000000
> > > > > > > > > >     * Linux Kernel 5.17 ~
> > > > > > > > > >     *      PGTABLE_LEVELS = 4
> > > > > > > > > >     *      PAGE_OFFSET = 0xffffaf8000000000
> > > > > > > > > >     * Linux Kernel 4.19 ~
> > > > > > > > > >     *      PGTABLE_LEVELS = 3
> > > > > > > > > >     *      PAGE_OFFSET = 0xffffffe000000000
> > > > > > > > > > 
> > > > > > > > > > Since these configurations change from time to time and
> > > > > > > > > > version to version,
> > > > > > > > > > it is preferable to export them via vmcoreinfo than to
> > > > > > > > > > change the crash's
> > > > > > > > > > code frequently, it can simplify the development of crash tool.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> > > > > > > > > > ---
> > > > > > > > > >     arch/riscv/kernel/Makefile     |  1 +
> > > > > > > > > >     arch/riscv/kernel/crash_core.c | 23 +++++++++++++++++++++++
> > > > > > > > > >     2 files changed, 24 insertions(+)
> > > > > > > > > >     create mode 100644 arch/riscv/kernel/crash_core.c
> > > > > > > > > > 
> > > > > > > > > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > > > > > > > > index db6e4b1294ba..4cf303a779ab 100644
> > > > > > > > > > --- a/arch/riscv/kernel/Makefile
> > > > > > > > > > +++ b/arch/riscv/kernel/Makefile
> > > > > > > > > > @@ -81,6 +81,7 @@ obj-$(CONFIG_KGDB)        += kgdb.o
> > > > > > > > > >     obj-$(CONFIG_KEXEC_CORE)    += kexec_relocate.o
> > > > > > > > > > crash_save_regs.o machine_kexec.o
> > > > > > > > > >     obj-$(CONFIG_KEXEC_FILE)    += elf_kexec.o machine_kexec_file.o
> > > > > > > > > >     obj-$(CONFIG_CRASH_DUMP)    += crash_dump.o
> > > > > > > > > > +obj-$(CONFIG_CRASH_CORE)    += crash_core.o
> > > > > > > > > >     obj-$(CONFIG_JUMP_LABEL)    += jump_label.o
> > > > > > > > > > diff --git a/arch/riscv/kernel/crash_core.c
> > > > > > > > > > b/arch/riscv/kernel/crash_core.c
> > > > > > > > > > new file mode 100644
> > > > > > > > > > index 000000000000..3e889d0ed7bd
> > > > > > > > > > --- /dev/null
> > > > > > > > > > +++ b/arch/riscv/kernel/crash_core.c
> > > > > > > > > > @@ -0,0 +1,23 @@
> > > > > > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > > > > > +
> > > > > > > > > > +#include <linux/crash_core.h>
> > > > > > > > > > +#include <linux/pagemap.h>
> > > > > > > > > > +
> > > > > > > > > > +void arch_crash_save_vmcoreinfo(void)
> > > > > > > > > > +{
> > > > > > > > > > +    VMCOREINFO_NUMBER(VA_BITS);
> > > > > > > > > > +    VMCOREINFO_NUMBER(phys_ram_base);
> > > > > > > > > > +
> > > > > > > > > > +
> > > > > > > > > > vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n",
> > > > > > > > > > PAGE_OFFSET);
> > > > > > > > > > + vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n",
> > > > > > > > > > VMALLOC_START);
> > > > > > > > > > +
> > > > > > > > > > vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n",
> > > > > > > > > > VMALLOC_END);
> > > > > > > > > > + vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n",
> > > > > > > > > > VMEMMAP_START);
> > > > > > > > > > +
> > > > > > > > > > vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n",
> > > > > > > > > > VMEMMAP_END);
> > > > > > > > > > +#ifdef CONFIG_64BIT
> > > > > > > > > > + vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n",
> > > > > > > > > > MODULES_VADDR);
> > > > > > > > > > +
> > > > > > > > > > vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n",
> > > > > > > > > > MODULES_END);
> > > > > > > > > > +#endif
> > > > > > > > > > +
> > > > > > > > > > +    if (IS_ENABLED(CONFIG_64BIT))
> > > > > > > > > > +
> > > > > > > > > > vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n",
> > > > > > > > > > KERNEL_LINK_ADDR);
> > > > > > > > > Wondering why you don't put KERNEL_LINK_ADDR exporting into the above
> > > > > > > > > ifdeffery scope, with that you can save one line of
> > > > > > > > > "IS_ENABLED(CONFIG_64BIT)".
> > > > > > > > I followed the rule in print_vm_layout() of
> > > > > > > > arch/riscv/mm/init.c, which used
> > > > > > > > IS_ENABLED when print the value of KERNEL_LINK_ADDR.
> > > > > > > > 
> > > > > > > I see. There's PAGE_OFFSET in the middle. Thanks.
> > > > > > > 
> > > > > > >           print_ml("lowmem", (unsigned long)PAGE_OFFSET,
> > > > > > >                   (unsigned long)high_memory)
> > > > > > > 
> > > > > > > So now, do you think if it's necessary to have another
> > > > > > > IS_ENABLED(CONFIG_64BIT) in the current arch_crash_save_vmcoreinfo()?
> > > > > > For which MACRO?  I think current code for PAGE_OFFSET is OK.
> > > > > > 
> > > 
> > 
> 

