Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24DF7403DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjF0TMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjF0TMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:12:05 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0C11B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:12:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so4960665e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687893122; x=1690485122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXfyigdyr/yTiNeA7Ut2nmo3O2NFg7CaK74SkteVs98=;
        b=klkTd4lzgPBHgF4Ykw7vdE7k2RMQnymPdeHpX4KJaOjkBAsuxSBMkV/7DI+/PLxV01
         U+umDXKxaxTC93+a3m/1y+hfSpWWc8K/ukvBjy5VkMiQlVNnRSdSdtb8TTx6VBbLYKPN
         4XpL7TkCP5HZT2fLSB7u7E8GesPtMIXmBVq0qDpky1NFotNxjFndljFgAKERpOlhG0zx
         eEviWRon/++YkPFQDA8BVmFi/71jo0liX5gm6VDiw+xSlFK/j6XHHhgiSN8NmkF/fQNb
         Y/MV6siClP5Z7tqFJmwNQu65mRCbjkjHYZKDpIhFozvqey0AsJARb0cjPkiDhG5betic
         qKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687893122; x=1690485122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXfyigdyr/yTiNeA7Ut2nmo3O2NFg7CaK74SkteVs98=;
        b=PbbGN1n8Ui+eNz22yhBB2LTlZ05IuugDZVu5yUpbyT65wsXMxIVEa5z7BeaDUIMWIk
         +qTBtxd/Ten3X54HaQnMUQhrrEJA64ZSihmOqs8p6yhHI1ZIKQiXBK7wF/hVRD95m5v4
         Dnn7qrzmuXARyHVmTl7XWa+e6EdB6nB4LA0iT9vSPfiLIk/j8N01kK+FQAqnqXX6G4u3
         mrzrIL1BnkX41h8UG3afERr6Pltp7635r6KK5dFWZLseOoARd8dKEZ8Wt0AkFGMgUVHh
         o/55aVE9dDwGFDwfv5OqjHVLQEpgOYJEz+wH8W6fzwk6dsWW64gxBL6upsrtc/JsjLft
         Ve4w==
X-Gm-Message-State: AC+VfDzyPcCglUrRpXLDpnsXPK/G+0QCAlL4CvWRVJhJnCFw1tmE1Of0
        Kafp6rMWeQgbENVwvDgYHIpG3XsTjvXNTl5eXqScIg==
X-Google-Smtp-Source: ACHHUZ59Dg93NW5zeQxecwBWd3kpcQGCzUZ65wo3jktofgxII3wg33JhE13tN+dhrqbI6k1cNbbAVAWoxGrpTWFjziw=
X-Received: by 2002:ac2:5de6:0:b0:4f7:6976:2070 with SMTP id
 z6-20020ac25de6000000b004f769762070mr18672154lfq.40.1687893121687; Tue, 27
 Jun 2023 12:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230623222016.3742145-1-evan@rivosinc.com> <20230623222016.3742145-2-evan@rivosinc.com>
 <20230626-veneering-superglue-751719bd967c@wendy>
In-Reply-To: <20230626-veneering-superglue-751719bd967c@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 27 Jun 2023 12:11:25 -0700
Message-ID: <CALs-HsskE1-OkZxFzH9bM6bR9NBW5R4mh5AJScVtnvHbv+Pi6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Probe for unaligned access speed
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Yangyu Chen <cyy@cyyself.name>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 7:15=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey Evan,
>
> Some minor nitpickery comments & one actual one.
>
> On Fri, Jun 23, 2023 at 03:20:15PM -0700, Evan Green wrote:
> > Rather than deferring misaligned access speed determinations to a vendo=
r
>
> Could you pick a consistent word to use? You've got "unaligned",
> "misaligned" and "noalign" sprinkled through out the series.
>
> > function, let's probe them and find out how fast they are. If we
> > determine that a misaligned word access is faster than N byte accesses,
> > mark the hardware's misaligned access as "fast".
> >
> > Fix the documentation as well to reflect this bar. Previously the only
> > SoC that returned "fast" was the THead C906. The change to the
> > documentation is more a clarification, since the C906 is fast in the
> > sense of the corrected documentation.
> >
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > ---
> >
> >  Documentation/riscv/hwprobe.rst     |  8 +--
> >  arch/riscv/include/asm/cpufeature.h |  2 +
> >  arch/riscv/kernel/Makefile          |  1 +
> >  arch/riscv/kernel/copy-noalign.S    | 71 ++++++++++++++++++++++++++
> >  arch/riscv/kernel/copy-noalign.h    | 13 +++++
> >  arch/riscv/kernel/cpufeature.c      | 78 +++++++++++++++++++++++++++++
> >  arch/riscv/kernel/smpboot.c         |  2 +
> >  7 files changed, 171 insertions(+), 4 deletions(-)
> >  create mode 100644 arch/riscv/kernel/copy-noalign.S
> >  create mode 100644 arch/riscv/kernel/copy-noalign.h
> >
> > diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwpr=
obe.rst
> > index 19165ebd82ba..710325751766 100644
> > --- a/Documentation/riscv/hwprobe.rst
> > +++ b/Documentation/riscv/hwprobe.rst
> > @@ -88,12 +88,12 @@ The following keys are defined:
> >      always extremely slow.
> >
> >    * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are =
supported
> > -    in hardware, but are slower than the cooresponding aligned accesse=
s
> > -    sequences.
>
> Nice, fixed the typo by removing the offender ;)
>
> > +    in hardware, but are slower than N byte accesses, where N is the n=
ative
> > +    word size.
> >
> >    * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are =
supported
> > -    in hardware and are faster than the cooresponding aligned accesses
> > -    sequences.
> > +    in hardware and are faster than N byte accesses, where N is the na=
tive
> > +    word size.
> >
> >    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned access=
es are
> >      not supported at all and will generate a misaligned address fault.
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/a=
sm/cpufeature.h
> > index 23fed53b8815..b8e917176616 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -30,4 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
> >  /* Per-cpu ISA extensions. */
> >  extern struct riscv_isainfo hart_isa[NR_CPUS];
> >
> > +void check_misaligned_access(int cpu);
> > +
> >  #endif
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index a42951911067..f934d7ab7840 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -34,6 +34,7 @@ extra-y +=3D vmlinux.lds
> >  obj-y        +=3D head.o
> >  obj-y        +=3D soc.o
> >  obj-$(CONFIG_RISCV_ALTERNATIVE) +=3D alternative.o
> > +obj-y        +=3D copy-noalign.o
> >  obj-y        +=3D cpu.o
> >  obj-y        +=3D cpufeature.o
> >  obj-y        +=3D entry.o
> > diff --git a/arch/riscv/kernel/copy-noalign.S b/arch/riscv/kernel/copy-=
noalign.S
> > new file mode 100644
> > index 000000000000..3807fc2324b2
> > --- /dev/null
> > +++ b/arch/riscv/kernel/copy-noalign.S
> > @@ -0,0 +1,71 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (C) 2023 Rivos Inc. */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/asm.h>
> > +
> > +     .text
> > +
> > +/* void __copy_words_unaligned(void *, const void *, size_t) */
> > +/* Performs a memcpy without aligning buffers, using word loads and st=
ores. */
> > +/* Note: The size is truncated to a multiple of 8 * SZREG */
> > +ENTRY(__copy_words_unaligned)
> > +     andi a4, a2, ~((8*SZREG)-1)
> > +     beqz a4, 2f
> > +     add a3, a1, a4
> > +1:
> > +     REG_L a4,       0(a1)
> > +     REG_L a5,   SZREG(a1)
> > +     REG_L a6, 2*SZREG(a1)
> > +     REG_L a7, 3*SZREG(a1)
> > +     REG_L t0, 4*SZREG(a1)
> > +     REG_L t1, 5*SZREG(a1)
> > +     REG_L t2, 6*SZREG(a1)
> > +     REG_L t3, 7*SZREG(a1)
> > +     REG_S a4,       0(a0)
> > +     REG_S a5,   SZREG(a0)
> > +     REG_S a6, 2*SZREG(a0)
> > +     REG_S a7, 3*SZREG(a0)
> > +     REG_S t0, 4*SZREG(a0)
> > +     REG_S t1, 5*SZREG(a0)
> > +     REG_S t2, 6*SZREG(a0)
> > +     REG_S t3, 7*SZREG(a0)
> > +     addi a0, a0, 8*SZREG
> > +     addi a1, a1, 8*SZREG
> > +     bltu a1, a3, 1b
> > +
> > +2:
> > +     ret
> > +END(__copy_words_unaligned)
> > +
> > +/* void __copy_bytes_unaligned(void *, const void *, size_t) */
> > +/* Performs a memcpy without aligning buffers, using only byte accesse=
s. */
> > +/* Note: The size is truncated to a multiple of 8 */
> > +ENTRY(__copy_bytes_unaligned)
> > +     andi a4, a2, ~(8-1)
> > +     beqz a4, 2f
> > +     add a3, a1, a4
>
> Could you align operands for ASM please, to make this a little easier to
> read?
>
> > +1:
> > +     lb a4, 0(a1)
> > +     lb a5, 1(a1)
> > +     lb a6, 2(a1)
> > +     lb a7, 3(a1)
> > +     lb t0, 4(a1)
> > +     lb t1, 5(a1)
> > +     lb t2, 6(a1)
> > +     lb t3, 7(a1)
> > +     sb a4, 0(a0)
> > +     sb a5, 1(a0)
> > +     sb a6, 2(a0)
> > +     sb a7, 3(a0)
> > +     sb t0, 4(a0)
> > +     sb t1, 5(a0)
> > +     sb t2, 6(a0)
> > +     sb t3, 7(a0)
> > +     addi a0, a0, 8
> > +     addi a1, a1, 8
> > +     bltu a1, a3, 1b
> > +
> > +2:
> > +     ret
> > +END(__copy_bytes_unaligned)
> > diff --git a/arch/riscv/kernel/copy-noalign.h b/arch/riscv/kernel/copy-=
noalign.h
> > new file mode 100644
> > index 000000000000..99fbb9c763e0
> > --- /dev/null
> > +++ b/arch/riscv/kernel/copy-noalign.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023 Rivos, Inc.
> > + */
> > +#ifndef __RISCV_KERNEL_COPY_NOALIGN_H
> > +#define __RISCV_KERNEL_COPY_NOALIGN_H
> > +
> > +#include <linux/types.h>
> > +
> > +void __copy_words_unaligned(void *dst, const void *src, size_t size);
> > +void __copy_bytes_unaligned(void *dst, const void *src, size_t size);
> > +
> > +#endif /* __RISCV_KERNEL_COPY_NOALIGN_H */
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index bdcf460ea53d..3f7200dcc00c 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -19,11 +19,21 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/hwcap.h>
> > +#include <asm/hwprobe.h>
> >  #include <asm/patch.h>
> >  #include <asm/processor.h>
> >  #include <asm/vector.h>
> >
> > +#include "copy-noalign.h"
> > +
> >  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
> > +#define MISALIGNED_ACCESS_JIFFIES_LG2 1
> > +#define MISALIGNED_BUFFER_SIZE 0x4000
> > +#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> > +
>
> I think this blank line is misplaced, it should go after NUM_ALPHA_EXTS
> instead of (or as well as) here.
>
> > +#define MISALIGNED_COPY_MBS(_count) \
> > +     ((HZ * (_count) * MISALIGNED_COPY_SIZE) >> \
> > +      (20 + MISALIGNED_ACCESS_JIFFIES_LG2))
> >
> >  unsigned long elf_hwcap __read_mostly;
> >
> > @@ -396,6 +406,74 @@ unsigned long riscv_get_elf_hwcap(void)
> >       return hwcap;
> >  }
> >
> > +void check_misaligned_access(int cpu)
> > +{
> > +     unsigned long j0, j1;
> > +     struct page *page;
> > +     void *dst;
> > +     void *src;
> > +     long word_copies =3D 0;
> > +     long byte_copies =3D 0;
> > +     long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
>
> Is this not a change from current behaviour, that may actually lead to
> incorrect reporting. Presently, only T-Head stuff sets a speed, so
> hwprobe falls back to UNKNOWN for everything else. With this, we will
> get slow set, for anything failing the test.
> Slow is defined as "Misaligned accesses are supported in hardware, but
> are slower than the cooresponding aligned accesses sequences (sic)", but
> you have no way of knowing, based on the test you are performing, whether
> the hardware supports it or if it is emulated by firmware.
> Perhaps that is not relevant to userspace, but wanted to know your
> thoughts.
>

Hm, that's true. EMULATED was an easy one when we were planning to get
this info from the DT. It also might be an easy one in the future, if
we get an SBI call that allows the kernel to take over misaligned trap
handling. We'd then be able to do a misaligned access and see if our
trap handler got called.

One option is to leave the value alone if we fail the FAST test
(rather than changing it from UNKNOWN to SLOW). This isn't great
though, as it effectively makes UNKNOWN synonymous with SLOW, but in a
way where usermode can't tell the difference between "I truly don't
know" and "I tried the fast test and it failed".

The alternative, as it is now, may mislabel some emulated systems as
slow until the new SBI call shows up. I'm not sure how bad this is in
practice. We could add a subsequent performance bar below which we
guess "emulated". This probably matches what usermode will use that
value for anyway (a synonym for "very slow"), but it's basically the
same problem with reversed polarity (we mislabel some slow systems as
emulated). I'm open to suggestions!

-Evan

> > +
> > +     page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE=
));
> > +     if (!page) {
> > +             pr_warn("Can't alloc pages to measure memcpy performance"=
);
> > +             return;
> > +     }
> > +
> > +     /* Make a misaligned destination buffer. */
> > +     dst =3D (void *)((unsigned long)page_address(page) | 0x1);
> > +     /* Misalign src as well, but differently (off by 1 + 2 =3D 3). */
> > +     src =3D dst + (MISALIGNED_BUFFER_SIZE / 2);
> > +     src +=3D 2;
> > +     /* Do a warmup. */
> > +     __copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +     preempt_disable();
> > +     j0 =3D jiffies;
> > +     while ((j1 =3D jiffies) =3D=3D j0)
> > +             cpu_relax();
> > +
> > +     while (time_before(jiffies,
> > +                        j1 + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
>
> Does this not fit in 100 chars?
>
> > +
> > +             __copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +             word_copies +=3D 1;
> > +     }
> > +
> > +     __copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> > +     j0 =3D jiffies;
> > +     while ((j1 =3D jiffies) =3D=3D j0)
> > +             cpu_relax();
> > +
> > +     while (time_before(jiffies,
> > +                        j1 + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
>
> Ditto here, no?
>
> Cheers,
> Conor.
