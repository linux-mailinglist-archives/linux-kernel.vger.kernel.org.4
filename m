Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADADA73ED01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjFZVmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFZVme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:42:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA211708
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:42:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b69ed7d050so27827141fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1687815747; x=1690407747;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sQqAguOyU1Mcy0xM9zMI72dPux4dkpAbUkeX6HQFTw=;
        b=IE3XG0Hx1tFOZKU/eNAg+/YYZi4AXd9YGnYT6YFxYZoXdmy+mbo5d7XE3fZZVj5tov
         4jd7wyl0zg3H59/ZGIbNieLb22QbnMHUhVyj/kpaXHcN3SUFGJusk9BR8mFEsGu/d9so
         84NpTNqfn+GW8ZCPjyfVBHmW210aOFYbGOEJdSacDt+aTyx+VmzIQvPxZJVU/hruAYtR
         MdmPzOTib3WtDJTXWgMk8fYMQu5FWKWmvf2zX8z1LTQ/7LrfW03ZMxCsOmqsskHrn4VC
         c44qq4u0WTGLj49YJ7hW7WAB6CgGQ9nmUNGn8NGUnbx26hv5YrY4c53JSwnL+89pHe6l
         8H3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687815747; x=1690407747;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sQqAguOyU1Mcy0xM9zMI72dPux4dkpAbUkeX6HQFTw=;
        b=Pv6umruVRB8JtLk4dhS7NSBIXEtrWBhPEaVWR5HjM8sTIssJDYwdEmWY9T1V2XkEim
         Ymhk482J7QgSyCR/b0oBMB7q5gEvc+V1OGcnQ1MjQfo4hE8GC2t8WBeMb3pEdbU+SbMo
         +kw1Kqley8w305Am9n2gXjVrS4fjWfpdHwZ35mWoL60t0cC4g2ohzwlGBgRD2Wv4pRme
         PFlCt/fE8L8bDqOzlgnGjxFX33d6Onm2QYXzzn8HBHt1D0q/dBm4im4Q0y3uFN/fxZDo
         7Em57ckq5XMcPY/KZJ4Lf+mzO3fqixQcz4UYZmtQDmphs/eE/dW7oBghq5vYg3AO0uza
         vhbQ==
X-Gm-Message-State: AC+VfDzITxFXoAgcc49S7Bo9rRsWfDeHa/HgPjq9wUmXJ8LM9LTQVOaT
        2+F8+g+lDRa7tLXuw71LJdz7GA==
X-Google-Smtp-Source: ACHHUZ7zzcX+u1CBsWuphZXbQjhtHeJtaRuxaW6CVkrBjHoHpkSC/3Q2yNsdK4skxqfZ9WLw2d8p0g==
X-Received: by 2002:a19:4f07:0:b0:4f8:68a3:38e2 with SMTP id d7-20020a194f07000000b004f868a338e2mr14366103lfb.0.1687815747496;
        Mon, 26 Jun 2023 14:42:27 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f90067880esm11723250wmk.47.2023.06.26.14.42.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2023 14:42:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 1/2] RISC-V: Probe for unaligned access speed
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230623222016.3742145-2-evan@rivosinc.com>
Date:   Mon, 26 Jun 2023 22:42:16 +0100
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, linux-doc@vger.kernel.org,
        Yangyu Chen <cyy@cyyself.name>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Chiu <andy.chiu@sifive.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <64F2D853-61E5-49CF-BAB5-AAFB8697683E@jrtc27.com>
References: <20230623222016.3742145-1-evan@rivosinc.com>
 <20230623222016.3742145-2-evan@rivosinc.com>
To:     Evan Green <evan@rivosinc.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 2023, at 23:20, Evan Green <evan@rivosinc.com> wrote:
>=20
> Rather than deferring misaligned access speed determinations to a =
vendor
> function, let's probe them and find out how fast they are. If we
> determine that a misaligned word access is faster than N byte =
accesses,
> mark the hardware's misaligned access as "fast".

How sure are you that your measurements can be extrapolated and aren=E2=80=
=99t
an artefact of the testing process? For example, off the top of my head:

* The first run will potentially be penalised by data cache misses,
  untrained prefetchers, TLB misses, branch predictors, etc. compared
  with later runs. You have one warmup, but who knows how many
  iterations it will take to converge?

* The code being benchmarked isn=E2=80=99t the code being run, so =
differences
  in access patterns, loop unrolling, loop alignment, etc. may cause the
  real code to behave differently (and perhaps change which is better).

The non-determinism that could in theory result from this also seems
like a not great idea to have.

Jess

> Fix the documentation as well to reflect this bar. Previously the only
> SoC that returned "fast" was the THead C906. The change to the
> documentation is more a clarification, since the C906 is fast in the
> sense of the corrected documentation.
>=20
> Signed-off-by: Evan Green <evan@rivosinc.com>
> ---
>=20
> Documentation/riscv/hwprobe.rst     |  8 +--
> arch/riscv/include/asm/cpufeature.h |  2 +
> arch/riscv/kernel/Makefile          |  1 +
> arch/riscv/kernel/copy-noalign.S    | 71 ++++++++++++++++++++++++++
> arch/riscv/kernel/copy-noalign.h    | 13 +++++
> arch/riscv/kernel/cpufeature.c      | 78 +++++++++++++++++++++++++++++
> arch/riscv/kernel/smpboot.c         |  2 +
> 7 files changed, 171 insertions(+), 4 deletions(-)
> create mode 100644 arch/riscv/kernel/copy-noalign.S
> create mode 100644 arch/riscv/kernel/copy-noalign.h
>=20
> diff --git a/Documentation/riscv/hwprobe.rst =
b/Documentation/riscv/hwprobe.rst
> index 19165ebd82ba..710325751766 100644
> --- a/Documentation/riscv/hwprobe.rst
> +++ b/Documentation/riscv/hwprobe.rst
> @@ -88,12 +88,12 @@ The following keys are defined:
>     always extremely slow.
>=20
>   * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are =
supported
> -    in hardware, but are slower than the cooresponding aligned =
accesses
> -    sequences.
> +    in hardware, but are slower than N byte accesses, where N is the =
native
> +    word size.
>=20
>   * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are =
supported
> -    in hardware and are faster than the cooresponding aligned =
accesses
> -    sequences.
> +    in hardware and are faster than N byte accesses, where N is the =
native
> +    word size.
>=20
>   * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned =
accesses are
>     not supported at all and will generate a misaligned address fault.
> diff --git a/arch/riscv/include/asm/cpufeature.h =
b/arch/riscv/include/asm/cpufeature.h
> index 23fed53b8815..b8e917176616 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -30,4 +30,6 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
> /* Per-cpu ISA extensions. */
> extern struct riscv_isainfo hart_isa[NR_CPUS];
>=20
> +void check_misaligned_access(int cpu);
> +
> #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index a42951911067..f934d7ab7840 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -34,6 +34,7 @@ extra-y +=3D vmlinux.lds
> obj-y +=3D head.o
> obj-y +=3D soc.o
> obj-$(CONFIG_RISCV_ALTERNATIVE) +=3D alternative.o
> +obj-y +=3D copy-noalign.o
> obj-y +=3D cpu.o
> obj-y +=3D cpufeature.o
> obj-y +=3D entry.o
> diff --git a/arch/riscv/kernel/copy-noalign.S =
b/arch/riscv/kernel/copy-noalign.S
> new file mode 100644
> index 000000000000..3807fc2324b2
> --- /dev/null
> +++ b/arch/riscv/kernel/copy-noalign.S
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2023 Rivos Inc. */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +
> + .text
> +
> +/* void __copy_words_unaligned(void *, const void *, size_t) */
> +/* Performs a memcpy without aligning buffers, using word loads and =
stores. */
> +/* Note: The size is truncated to a multiple of 8 * SZREG */
> +ENTRY(__copy_words_unaligned)
> + andi a4, a2, ~((8*SZREG)-1)
> + beqz a4, 2f
> + add a3, a1, a4
> +1:
> + REG_L a4,       0(a1)
> + REG_L a5,   SZREG(a1)
> + REG_L a6, 2*SZREG(a1)
> + REG_L a7, 3*SZREG(a1)
> + REG_L t0, 4*SZREG(a1)
> + REG_L t1, 5*SZREG(a1)
> + REG_L t2, 6*SZREG(a1)
> + REG_L t3, 7*SZREG(a1)
> + REG_S a4,       0(a0)
> + REG_S a5,   SZREG(a0)
> + REG_S a6, 2*SZREG(a0)
> + REG_S a7, 3*SZREG(a0)
> + REG_S t0, 4*SZREG(a0)
> + REG_S t1, 5*SZREG(a0)
> + REG_S t2, 6*SZREG(a0)
> + REG_S t3, 7*SZREG(a0)
> + addi a0, a0, 8*SZREG
> + addi a1, a1, 8*SZREG
> + bltu a1, a3, 1b
> +
> +2:
> + ret
> +END(__copy_words_unaligned)
> +
> +/* void __copy_bytes_unaligned(void *, const void *, size_t) */
> +/* Performs a memcpy without aligning buffers, using only byte =
accesses. */
> +/* Note: The size is truncated to a multiple of 8 */
> +ENTRY(__copy_bytes_unaligned)
> + andi a4, a2, ~(8-1)
> + beqz a4, 2f
> + add a3, a1, a4
> +1:
> + lb a4, 0(a1)
> + lb a5, 1(a1)
> + lb a6, 2(a1)
> + lb a7, 3(a1)
> + lb t0, 4(a1)
> + lb t1, 5(a1)
> + lb t2, 6(a1)
> + lb t3, 7(a1)
> + sb a4, 0(a0)
> + sb a5, 1(a0)
> + sb a6, 2(a0)
> + sb a7, 3(a0)
> + sb t0, 4(a0)
> + sb t1, 5(a0)
> + sb t2, 6(a0)
> + sb t3, 7(a0)
> + addi a0, a0, 8
> + addi a1, a1, 8
> + bltu a1, a3, 1b
> +
> +2:
> + ret
> +END(__copy_bytes_unaligned)
> diff --git a/arch/riscv/kernel/copy-noalign.h =
b/arch/riscv/kernel/copy-noalign.h
> new file mode 100644
> index 000000000000..99fbb9c763e0
> --- /dev/null
> +++ b/arch/riscv/kernel/copy-noalign.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Rivos, Inc.
> + */
> +#ifndef __RISCV_KERNEL_COPY_NOALIGN_H
> +#define __RISCV_KERNEL_COPY_NOALIGN_H
> +
> +#include <linux/types.h>
> +
> +void __copy_words_unaligned(void *dst, const void *src, size_t size);
> +void __copy_bytes_unaligned(void *dst, const void *src, size_t size);
> +
> +#endif /* __RISCV_KERNEL_COPY_NOALIGN_H */
> diff --git a/arch/riscv/kernel/cpufeature.c =
b/arch/riscv/kernel/cpufeature.c
> index bdcf460ea53d..3f7200dcc00c 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -19,11 +19,21 @@
> #include <asm/cacheflush.h>
> #include <asm/cpufeature.h>
> #include <asm/hwcap.h>
> +#include <asm/hwprobe.h>
> #include <asm/patch.h>
> #include <asm/processor.h>
> #include <asm/vector.h>
>=20
> +#include "copy-noalign.h"
> +
> #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
> +#define MISALIGNED_ACCESS_JIFFIES_LG2 1
> +#define MISALIGNED_BUFFER_SIZE 0x4000
> +#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> +
> +#define MISALIGNED_COPY_MBS(_count) \
> + ((HZ * (_count) * MISALIGNED_COPY_SIZE) >> \
> + (20 + MISALIGNED_ACCESS_JIFFIES_LG2))
>=20
> unsigned long elf_hwcap __read_mostly;
>=20
> @@ -396,6 +406,74 @@ unsigned long riscv_get_elf_hwcap(void)
> return hwcap;
> }
>=20
> +void check_misaligned_access(int cpu)
> +{
> + unsigned long j0, j1;
> + struct page *page;
> + void *dst;
> + void *src;
> + long word_copies =3D 0;
> + long byte_copies =3D 0;
> + long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
> +
> + page =3D alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
> + if (!page) {
> + pr_warn("Can't alloc pages to measure memcpy performance");
> + return;
> + }
> +
> + /* Make a misaligned destination buffer. */
> + dst =3D (void *)((unsigned long)page_address(page) | 0x1);
> + /* Misalign src as well, but differently (off by 1 + 2 =3D 3). */
> + src =3D dst + (MISALIGNED_BUFFER_SIZE / 2);
> + src +=3D 2;
> + /* Do a warmup. */
> + __copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> + preempt_disable();
> + j0 =3D jiffies;
> + while ((j1 =3D jiffies) =3D=3D j0)
> + cpu_relax();
> +
> + while (time_before(jiffies,
> +   j1 + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> +
> + __copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> + word_copies +=3D 1;
> + }
> +
> + __copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> + j0 =3D jiffies;
> + while ((j1 =3D jiffies) =3D=3D j0)
> + cpu_relax();
> +
> + while (time_before(jiffies,
> +   j1 + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
> + __copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> + byte_copies +=3D 1;
> + }
> +
> + preempt_enable();
> + if (word_copies >=3D byte_copies)
> + speed =3D RISCV_HWPROBE_MISALIGNED_FAST;
> +
> + pr_info("cpu%d: Unaligned word copy %ld MB/s, byte copy %ld MB/s, =
misaligned accesses are %s\n",
> + cpu,
> + MISALIGNED_COPY_MBS(word_copies),
> + MISALIGNED_COPY_MBS(byte_copies),
> + (speed =3D=3D RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
> +
> + per_cpu(misaligned_access_speed, cpu) =3D speed;
> + __free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> +}
> +
> +static int check_misaligned_access0(void)
> +{
> + check_misaligned_access(0);
> + return 0;
> +}
> +
> +arch_initcall(check_misaligned_access0);
> +
> #ifdef CONFIG_RISCV_ALTERNATIVE
> /*
>  * Alternative patch sites consider 48 bits when determining when to =
patch
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index bb0b76e1a6d4..e34a71b4786b 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -26,6 +26,7 @@
> #include <linux/sched/task_stack.h>
> #include <linux/sched/mm.h>
> #include <asm/cpu_ops.h>
> +#include <asm/cpufeature.h>
> #include <asm/irq.h>
> #include <asm/mmu_context.h>
> #include <asm/numa.h>
> @@ -244,6 +245,7 @@ asmlinkage __visible void smp_callin(void)
> notify_cpu_starting(curr_cpuid);
> numa_add_cpu(curr_cpuid);
> set_cpu_online(curr_cpuid, 1);
> + check_misaligned_access(curr_cpuid);
> probe_vendor_features(curr_cpuid);
>=20
> if (has_vector()) {
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

