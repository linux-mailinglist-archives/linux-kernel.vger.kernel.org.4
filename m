Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CE7459F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjGCKQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGCKQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:16:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF2DBC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:16:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31438512cafso690473f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688379378; x=1690971378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHna20O5nuwmYMQaQmDisbtnuP0SS9Nya9vSK5lPsIM=;
        b=D51JaqYyHlucBw7NXpCblfBlLZtkeRJxiAkudc6DBT/DtQEDrb1FYnMMibCzrI8sk1
         H/x/VwgSSbWnJwtbWC8lJqvxt9b7A3UmUuUfhOLCyQyJTWCN4Mv1v8xfMgW/xlbkWdZI
         yDj0Q+VahUAxGkQFoUlnGeuLBcP9mA0tUgVAXo8QHQjlnn3BPdTzbCWbgNRT5/UGS3Re
         /28ME7WC6JEVV7WtL2QEJOi/AvMqij1E+ak6798ICJ/Y8cY8AUKzQtt1+on7GKr3ZVHk
         ic7heDchy2bwzeczoMHnAV6OH95ba8TlEvMf1OjzowxZtvNvVfvBcoQyzY3Uhq0gBndb
         gxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688379378; x=1690971378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHna20O5nuwmYMQaQmDisbtnuP0SS9Nya9vSK5lPsIM=;
        b=CdQy9K2dfhMIceftgsl24AUel+kkHQlNhLmMqwthZViMXmlID+6dRQvs5cMLmhMMTh
         LF13xvqsFb4ufokA1y/fI9jM78EIYYlyMarsSXQKz9OxqG+bnb3RWWzyBR/X+Giong2B
         DiYjqm9Yb+W7B5JS/XIu7fUvGv7nj35UbfqyBnWMD2d72VvrmrxRxbDpaUIsprXchLwy
         SWMTbpm5dLqJpg95yHqe7JNrJj6Zt7tndn4lkslrlU0PU+Aiv5Nfkxq+PhhORUctWSWu
         +oKI+lFVy7ZUFVPTSe641Kaa9/90/uOaQBCng0tFg7OyFRrdd15M/Afp8yTEErTMgZL3
         cHIw==
X-Gm-Message-State: ABy/qLZ9FQPo2pyGMswRaKvF1cUBRipFGWgpeg3+mPBQGkWONhvGGQKS
        n9pifNg0XnpSv1I9MqrVs8baQMdDgfdE3343EqwHQw==
X-Google-Smtp-Source: APBJJlEyPHaw9RDOWtWuuNTrLxiqJdK1Y9rx8u7ncpQxqzZArAv5IjOfEjZY7gyHfQ9l2BG3z28vd3wfUHh72kONM4Y=
X-Received: by 2002:adf:fe8f:0:b0:314:ca7:f30b with SMTP id
 l15-20020adffe8f000000b003140ca7f30bmr8267188wrr.54.1688379378380; Mon, 03
 Jul 2023 03:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230702-headway-dreamlike-d7ba39ac4910@spud>
 <CAEEQ3wnzf=iDDHJATo2vdVz-SDNYRGBEEb7sXUyGojgP4ZAgaA@mail.gmail.com> <20230703-glorified-headless-16e998608eaa@wendy>
In-Reply-To: <20230703-glorified-headless-16e998608eaa@wendy>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 3 Jul 2023 18:16:07 +0800
Message-ID: <CAEEQ3wnjYK+Jj9Ce_yEHPL_z3eYn4OKP85YLXnVeaPd+SA3DJw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, ardb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, alexghiti@rivosinc.com,
        sunilvl@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Jul 3, 2023 at 4:13=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> Hey,
>
> On Mon, Jul 03, 2023 at 03:19:01PM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wro=
te:
> > On Sun, Jul 2, 2023 at 9:48=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> > >
> > > %subject: riscv: obtain ACPI RSDP from FFI.
> > >
> > > This subject is a bit unhelpful because FFI would commonly mean "fore=
ign
> > > function interface" & you have not yet introduced it. It seems like i=
t
> > > would be better to do s/FFI/devicetree/ or similar.
> >
> > FFI: FDT FIRMWARE INTERFACE.
> >
> > You are right, s/FFI/devicetree/ is of course possible=EF=BC=8C but I a=
ctually
> > want to use FFI as a general solution, put all relevant codes under
> > driver/firmware/, and use RISC-V arch to call general codes.
>
> Yes, I read the patchset. It's still unhelpful to someone reading
> $subject because nobody knows what your version of FFI is IMO.
>
> > In this case, only one Kconfig CONFIG_FDT_FW_INTERFACE is enough=EF=BC=
=8C and
> > The FFI code will be placed first in the patchset.
> >
> > But Ard's suggestion is to put the part of SMBIOS in the generic code,
> > and put the FFI for ACPI in the RISCV arch.
> >
> > Please see  the v1:
> > https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1=
-cuiyunhui@bytedance.com/
>
> I read this too, I was following along with the discussion on the v1.

Okay,  I will take your suggestion=EF=BC=8C to do s/FFI/devicetree/.
This needs to be confirmed with you:
Continue to follow the current code structure, patch 1/3 is placed in
arch/riscv/, and 2/3 is placed under driver/firmware?

>
> > Put the following to /driver/firmware/ffi.c , What do you think?
> > void __init ffi_acpi_root_pointer(void)
> > {
> >     ...
> > }
>
> Usually the NOP versions just go in the headers.
>
> > > Please also drop the full stop from the commit messages ;)
> > Okay, thanks.
> >
> > >
> > > Please use a cover letter for multi-patch series & include changelogs=
.
> > OK, On v3 I would use.
> >
> > >
> > > +CC Sunil, Alex:
> > >
> > > Can you guys please take a look at this & see if it is something that=
 we
> > > want to do (ACPI without EFI)?
> > >
> > > On Sun, Jul 02, 2023 at 05:57:32PM +0800, Yunhui Cui wrote:
> > > > 1. We need to enable the ACPI function on RISC-V.
> > >
> > > RISC-V already supports ACPI, the "we" in this commit message is
> > > confusing. Who is "we"? Bytedance?
>
> Who is the "we"?

"We" are people who need to use ACPI on RISC-V systems, including
ByteDance of course.

>
> > > > When booting with
> > > > Coreboot, we encounter two problems:
> > > > a. Coreboot does not support EFI
> > >
> > >
> > > > b. On RISC-V, only the DTS channel can be used.
> > >
> > > We support ACPI, so this seems inaccurate. Could you explain it bette=
r
> > > please?
> >
> > Yes, Sunil already supports ACPI, But it is based on EDK2 boot which
> > supports EFI.
> > In fact, We use Coreboot which has the features of a and b above.
>
> My point is that the commit message has gaps in it.
> This point b & point 1 make it seem like this patch adds ACPI support to
> an architecture that only supports devicetree. "DTS channel" needs to be
> explained further, to be frank I have no idea what that means. Does it
> mean that coreboot on RISC-V only supports DT, or that the RISC-V linux
> kernel requires a mini-DT when booting with EFI?

Yeah=EF=BC=8C Coreboot only supports DT, do not support EFI.
The first half sentence has already said "When booting with Coreboot,
we encounter two problems:"

How about changing the commit log to the following?

riscv: obtain ACPI RSDP from devicetree.

On RISC-V, when using Coreboot to start, since Coreboot only supports
DTS but not EFI, and
RISC-V does not have a reserved address segment.
When the system enables ACPI, ACPI RSDP needs to be passed through DTS

>
> > > > 2. Based on this, we have added an interface for obtaining firmware
> > > > information transfer through FDT, named FFI.
> > >
> > > Please use the long form of "FFI" before using the short form, since =
you
> > > are inventing this & noone knows what it means yet.
> > >
> > > > 3. We not only use FFI to pass ACPI RSDP, but also pass other
> > > > firmware information as an extension.
> > >
> > > This patch doesn't do that though?
> >
> > Similar problems may be encountered on other arches, which is also the
> > purpose of this sentence.
>
> Right, but that has nothing to do with this patch? This patch only
> implements the ACPI side of things for RISC-V, it doesn't do the SMBIOS
> stuff. Leave that for the patch that actually does that please.

Okay, Modify it to the above commit log and there will be no such problem.

> > > > +RISC-V FDT FIRMWARE INTERFACE (FFI) SUPPORT
> > > > +M:     Yunhui Cui cuiyunhui@bytedance.com
> > > > +S:     Maintained
> > > > +F:     arch/riscv/include/asm/ffi.h
> > > > +F:     arch/riscv/kernel/ffi.c
> > >
> > > Please add this in alphabetical order, these entries have recently be=
en
> > > resorted. That said, maintainers entry for a trivial file in arch cod=
e
> > > seems a wee bit odd, seems like it would be better suited rolled up i=
nto
> > > your other entry for the interface, like how Ard's one looks for EFI?
> > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index b49793cf34eb..2e1c40fb2300 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -785,6 +785,16 @@ config EFI
> > > >         allow the kernel to be booted as an EFI application. This
> > > >         is only useful on systems that have UEFI firmware.
> > > >
> > > > +config FFI
> > > > +     bool "Fdt firmware interface"
> > > > +     depends on OF
> > > > +     default y
> > > > +     help
> > > > +       Added an interface to obtain firmware information transfer
> > > > +       through FDT, named FFI. Some bootloaders do not support EFI=
,
> > > > +       such as coreboot.
> > > > +       We can pass firmware information through FFI, such as ACPI.
> > >
> > > I don't understand your Kconfig setup. Why don't you just have one
> > > option (the one from patch 2/3), instead of adding 2 different but
> > > similarly named options?
> > OK, let me try it=EF=BC=8C and use the Kconfig CONFIG_FDT_FW_INTERFACE.=
  EFI
> > seems to use two...
>
> It doesn't use two different options, AFAIR. There's an EFI option in
> the arch Kconfigs and then a menu in drivers/firmware/efi/Kconfig that
> allows enabling sub-components. You've got two entries that appear
> unrelated, despite parsing the same DT bits.

OKay, I'll update it on v3.

>
> >
> > > >  config CC_HAVE_STACKPROTECTOR_TLS
> > > >       def_bool $(cc-option,-mstack-protector-guard=3Dtls -mstack-pr=
otector-guard-reg=3Dtp -mstack-protector-guard-offset=3D0)
> > > >
> > > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm=
/acpi.h
> > > > index f71ce21ff684..f9d1625dd159 100644
> > > > --- a/arch/riscv/include/asm/acpi.h
> > > > +++ b/arch/riscv/include/asm/acpi.h
> > > > @@ -15,6 +15,8 @@
> > > >  /* Basic configuration for ACPI */
> > > >  #ifdef CONFIG_ACPI
> > > >
> > > > +#include <asm/ffi.h>
> > > > +
> > > >  typedef u64 phys_cpuid_t;
> > > >  #define PHYS_CPUID_INVALID INVALID_HARTID
> > > >
> > > > @@ -66,6 +68,13 @@ int acpi_get_riscv_isa(struct acpi_table_header =
*table,
> > > >                      unsigned int cpu, const char **isa);
> > > >
> > > >  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUM=
A_NO_NODE; }
> > > > +
> > > > +#define ACPI_HAVE_ARCH_GET_ROOT_POINTER
> > >
> > > How come this is not set in Kconfig like HAVE_FOO options usually are=
?
>
> > This is modeled after x86 historical code.
> > See arch/x86/include/asm/acpi.h
>
> Is that a good reason for propagating the pattern? Is there a benefit to
> this, other than "x86 did this"?

I smiled when I read this sentence=EF=BC=8CI haven't thought of a better wa=
y yet =EF=BC=9A-=EF=BC=89


>
> > > > +static inline u64 acpi_arch_get_root_pointer(void)
> > > > +{
> > > > +     return acpi_rsdp;
> > > > +}
> > > > +
> > > >  #else
> > > >  static inline void acpi_init_rintc_map(void) { }
> > > >  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int =
cpu)
> > > > diff --git a/arch/riscv/include/asm/ffi.h b/arch/riscv/include/asm/=
ffi.h
> > > > new file mode 100644
> > > > index 000000000000..847af02abd87
> > > > --- /dev/null
> > > > +++ b/arch/riscv/include/asm/ffi.h
> > > > @@ -0,0 +1,9 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +#ifndef _ASM_FFI_H
> > > > +#define _ASM_FFI_H
> > > > +
> > > > +extern u64 acpi_rsdp;
> > >
> > > /stuff/linux/drivers/acpi/osl.c:178:22: error: redefinition of 'acpi_=
rsdp' with a different type: 'unsigned long' vs 'u64' (aka 'unsigned long l=
ong')
> > >
> > > Fails to build when Kexec is enabled.
> >
> > Rename my acpi_rsdp to arch_acpi_rsdp? WDYT?
>
> You could do s/arch/riscv/ either, that'd match what we prefix a lot of
> stuff with.

 Sorry, I don't quite understand what you mean. Could you tell me in detail=
?

>
> > > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefil=
e
> > > > index 506cc4a9a45a..274e06f4da33 100644
> > > > --- a/arch/riscv/kernel/Makefile
> > > > +++ b/arch/riscv/kernel/Makefile
> > > > @@ -92,6 +92,7 @@ obj-$(CONFIG_CRASH_CORE)    +=3D crash_core.o
> > > >  obj-$(CONFIG_JUMP_LABEL)     +=3D jump_label.o
> > > >
> > > >  obj-$(CONFIG_EFI)            +=3D efi.o
> > > > +obj-$(CONFIG_FFI)              +=3D ffi.o
> > >
> > > This file uses tabs for alignment, not spaces.
> > Okay, got it.
> >
> > >
> > > >  obj-$(CONFIG_COMPAT)         +=3D compat_syscall_table.o
> > > >  obj-$(CONFIG_COMPAT)         +=3D compat_signal.o
> > > >  obj-$(CONFIG_COMPAT)         +=3D compat_vdso/
> > > > diff --git a/arch/riscv/kernel/ffi.c b/arch/riscv/kernel/ffi.c
> > > > new file mode 100644
> > > > index 000000000000..c5ac2b5d9148
> > > > --- /dev/null
> > > > +++ b/arch/riscv/kernel/ffi.c
>
> > > > +void __init ffi_init(void)
> > > > +{
> > > > +     ffi_acpi_root_pointer();
> > >
> > > What happens if, on a system with "normal" ACPI support, ffi_init() i=
s
> > > called & ffi_acpi_root_pointer() calls things like fdt_path_offset()?
> >
> > According to the current logic, get it from FFI is enabled, if can
> > not,  continue to use =E2=80=9Cnormal=E2=80=9D ACPI.
>
> I find it hard to understand what you mean here. Do you mean something
> like "The calls to fdt_path_offset() will use the mini EFI DT and are
> harmless. If the config table is not present, it will continue to use
> \"normal\" ACPI."?

acpi_os_get_root_pointer()
{
        pa =3D acpi_arch_get_root_pointer();
        if (pa)
                return pa;

        ...//efi logic
}

Even if acpi_arch_get_root_pointer returns 0, it does not affect the
next efi logic.

>
> > > > +}
> > > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > > index 971fe776e2f8..5a933d6b6acb 100644
> > > > --- a/arch/riscv/kernel/setup.c
> > > > +++ b/arch/riscv/kernel/setup.c
> > > > @@ -36,6 +36,7 @@
> > > >  #include <asm/thread_info.h>
> > > >  #include <asm/kasan.h>
> > > >  #include <asm/efi.h>
> > > > +#include <asm/ffi.h>
> > > >
> > > >  #include "head.h"
> > > >
> > > > @@ -279,6 +280,7 @@ void __init setup_arch(char **cmdline_p)
> > > >       parse_early_param();
> > > >
> > > >       efi_init();
> > > > +     ffi_init();
> > >
> > > What provides ffi_init() if CONFIG_FFI is disabled?
>
> > Ok=EF=BC=8C Modified on v3,  put it with the CONFIG_FFI
>
> Sorry, what does this mean?

I mean thanks for the idea, I'll update it in v3.
#ifdef CONFIG_FDT_FW_INTERFACE
    ffi_init();
#endif


>
> >
> > >
> > > >       paging_init();
> > > >
> > > >       /* Parse the ACPI tables for possible boot-time configuration=
 */
>
> Cheers,
> Conor.


Thanks,
Yunhui
