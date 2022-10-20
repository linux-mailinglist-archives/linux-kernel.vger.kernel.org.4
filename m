Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397746055C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJTDFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJTDFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCF159A2B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666235134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+xXE+hLfnStgrhavEiF+uB0bvcu9Rc/vs92lJ9VfFU=;
        b=dSBmk8rqwtXGL4/xAF9qyK7TqDGsJYJ4tKMPUc3+C5Fswd2EGh9EAGg31sXywriWxEjdg4
        h5KUD/jxAE3ZeC+n8He+IEfN4eUE3qoIydW3Drk77wPWAEwDzwC+R9faCZikHE4F6LoNyA
        lNKbvTZjThWDLtCSc66g3CA4GVDDLm4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-LPQxcEDxNeOKlFqcJKKYRA-1; Wed, 19 Oct 2022 23:05:29 -0400
X-MC-Unique: LPQxcEDxNeOKlFqcJKKYRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E664C811E75;
        Thu, 20 Oct 2022 03:05:27 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0A40140EBF3;
        Thu, 20 Oct 2022 03:05:26 +0000 (UTC)
Date:   Thu, 20 Oct 2022 11:05:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        bagasdotme@gmail.com, k-hagio-ab@nec.com, lijiang@redhat.com,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V4 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Message-ID: <Y1C681H2mlxX+zqf@MiWiFi-R3L-srv>
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
 <Y1CtreAKT/SEh4vN@MiWiFi-R3L-srv>
 <30621b3b-47ba-d612-cfb0-583d779691a3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30621b3b-47ba-d612-cfb0-583d779691a3@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 at 10:17am, Xianting Tian wrote:
> 
> 在 2022/10/20 上午10:08, Baoquan He 写道:
> > On 10/19/22 at 06:36pm, Xianting Tian wrote:
> > > Add arch_crash_save_vmcoreinfo(), which exports VM layout(MODULES, VMALLOC,
> > > VMEMMAP ranges and KERNEL_LINK_ADDR), va bits and ram base for vmcore.
> > > 
> > > Default pagetable levels and PAGE_OFFSET aren't same for different kernel
> > > version as below. For pagetable levels, it sets sv57 by default and falls
> > > back to setting sv48 at boot time if sv57 is not supported by the hardware.
> > > 
> > > For ram base, the default value is 0x80200000 for qemu riscv64 env and,
> > > for example, is 0x200000 on the XuanTie 910 CPU.
> > > 
> > >   * Linux Kernel 5.18 ~
> > >   *      PGTABLE_LEVELS = 5
> > >   *      PAGE_OFFSET = 0xff60000000000000
> > >   * Linux Kernel 5.17 ~
> > >   *      PGTABLE_LEVELS = 4
> > >   *      PAGE_OFFSET = 0xffffaf8000000000
> > >   * Linux Kernel 4.19 ~
> > >   *      PGTABLE_LEVELS = 3
> > >   *      PAGE_OFFSET = 0xffffffe000000000
> > > 
> > > Since these configurations change from time to time and version to version,
> > > it is preferable to export them via vmcoreinfo than to change the crash's
> > > code frequently, it can simplify the development of crash tool.
> > > 
> > > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> > > ---
> > >   arch/riscv/kernel/Makefile     |  1 +
> > >   arch/riscv/kernel/crash_core.c | 23 +++++++++++++++++++++++
> > >   2 files changed, 24 insertions(+)
> > >   create mode 100644 arch/riscv/kernel/crash_core.c
> > > 
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index db6e4b1294ba..4cf303a779ab 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -81,6 +81,7 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
> > >   obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
> > >   obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
> > >   obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
> > > +obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
> > >   obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
> > > diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
> > > new file mode 100644
> > > index 000000000000..3e889d0ed7bd
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/crash_core.c
> > > @@ -0,0 +1,23 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +#include <linux/crash_core.h>
> > > +#include <linux/pagemap.h>
> > > +
> > > +void arch_crash_save_vmcoreinfo(void)
> > > +{
> > > +	VMCOREINFO_NUMBER(VA_BITS);
> > > +	VMCOREINFO_NUMBER(phys_ram_base);
> > > +
> > > +	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
> > > +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> > > +	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
> > > +	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
> > > +	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
> > > +#ifdef CONFIG_64BIT
> > > +	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
> > > +	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
> > > +#endif
> > > +
> > > +	if (IS_ENABLED(CONFIG_64BIT))
> > > +		vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
> > Wondering why you don't put KERNEL_LINK_ADDR exporting into the above
> > ifdeffery scope, with that you can save one line of "IS_ENABLED(CONFIG_64BIT)".
> I followed the rule in print_vm_layout() of arch/riscv/mm/init.c, which used
> IS_ENABLED when print the value of KERNEL_LINK_ADDR.
> 

I see. There's PAGE_OFFSET in the middle. Thanks.

        print_ml("lowmem", (unsigned long)PAGE_OFFSET,
                (unsigned long)high_memory)

So now, do you think if it's necessary to have another
IS_ENABLED(CONFIG_64BIT) in the current arch_crash_save_vmcoreinfo()?

