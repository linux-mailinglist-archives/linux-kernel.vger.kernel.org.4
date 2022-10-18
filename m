Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DAE6028F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiJRKDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJRKD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566DAB1B8B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666087405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dbUnzvIvlrGRDX1mE6CPBS4n0v7KTHoQYr0wJY597WU=;
        b=eRSXz6ECA0TywF0lRDv+nsWrD4Smyia67uyF01mQ3RIyNoktnMjO/R41H/QcVfurH+moP4
        OC4ADFeu8mvQ+gT7LB8N6pblTb6ImDuPq91sI/ocVwh7MHZSZn8vvfvrEj2Xi2dzcHZ/JV
        HsGyeh+Ul4e6wOu/ll50Uklldh4lpxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-nmYZgiEOO2iUX8PsY6IIIA-1; Tue, 18 Oct 2022 06:03:20 -0400
X-MC-Unique: nmYZgiEOO2iUX8PsY6IIIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A535982DFDD;
        Tue, 18 Oct 2022 10:03:19 +0000 (UTC)
Received: from localhost (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64908146820D;
        Tue, 18 Oct 2022 10:03:18 +0000 (UTC)
Date:   Tue, 18 Oct 2022 18:03:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Kazuhito Hagio <k-hagio-ab@nec.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        bagasdotme@gmail.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, hschauhan@nulltrace.org,
        yixun.lan@gmail.com
Subject: Re: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Message-ID: <Y05540td7lLz+0BY@MiWiFi-R3L-srv>
References: <20221018081755.6214-1-xianting.tian@linux.alibaba.com>
 <20221018081755.6214-2-xianting.tian@linux.alibaba.com>
 <Y05tfxRenMs5d+bt@MiWiFi-R3L-srv>
 <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
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

On 10/18/22 at 05:25pm, Xianting Tian wrote:
> 
> 在 2022/10/18 下午5:10, Baoquan He 写道:
> > On 10/18/22 at 04:17pm, Xianting Tian wrote:
> > > Add arch_crash_save_vmcoreinfo(), which exports VM layout(MODULES, VMALLOC,
> > > VMEMMAP and KERNEL_LINK_ADDR ranges), va bits and ram base for vmcore.
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
> > >   arch/riscv/kernel/crash_core.c | 29 +++++++++++++++++++++++++++++
> > >   2 files changed, 30 insertions(+)
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
> > > index 000000000000..8d7f5ff108da
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/crash_core.c
> > > @@ -0,0 +1,29 @@
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
> > > +	if (IS_ENABLED(CONFIG_64BIT)) {
> > > +#ifdef CONFIG_KASAN
> > > +		vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_START)=0x%lx\n", KASAN_SHADOW_START);
> > > +		vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_END)=0x%lx\n", KASAN_SHADOW_END);
> > > +#endif
> > > +		vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
> > > +		vmcoreinfo_append_str("NUMBER(ADDRESS_SPACE_END)=0x%lx\n", ADDRESS_SPACE_END);
> > Seems this is the firsr ARCH where kasan and kernel link/bpf space are
> > added to dump and analyze. Just curious, have you got code change to
> > make use of them to do dumping and analyze?
> 
> KASAN_SHADOW_START is not used, KERNEL_LINK_ADDR is used in the crash patch set:
> https://patchwork.kernel.org/project/linux-riscv/cover/20220813031753.3097720-1-xianting.tian@linux.alibaba.com/

Oh, I would say please no. Sometime we got tons of objection when adding an
necessary one, we definitely should not add one for possible future
use.

For this kind of newly added one, we need get ack from
makedumpfile/crash utility maintainer so that we know they are necessary
to have. At least they don't oppose.

> 
> I add it in case of using in furture.
> 
> > 
> > Thanks
> > Baoquan
> 

