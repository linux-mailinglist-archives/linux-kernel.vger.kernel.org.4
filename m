Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AF765509B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiLWMxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:53:49 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0FDBE1D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:53:47 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 203so5175830yby.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ddwl2eXurQm27aQuatUeFHpduWH+gP/YWJaFq+Y/k28=;
        b=kQltr/P0KxpXcfOlYI0CzgzhH/bAsWjzhykkDJJ+xgVS32fgPJfoMw2A0SCZtxc94o
         fF9RFLXeMNCQVOUUzcOtWgltNc9JswVzufQ/vV8llRhR5NrbtXnzgylmEY+mNv5OCKKX
         DwiEL4neDqZWWl2KvIyWuGxwPYzk31V/1RBHRud6OddWqqFYJvHR6tDwyNuBoLT6DQrC
         F0UKtbpNkwRtmTmWAnXmjQTpdacAyHsEJVssDI8KK2C8Z0MVgdKjEMAj3OPPoLNbiLKZ
         Hxk++a9sR+IhV+YUyQsnMzdij6Fjk/l8oX1HIoKbhjO3+56UxeJJXIszHv5cc7L/SjD8
         8RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ddwl2eXurQm27aQuatUeFHpduWH+gP/YWJaFq+Y/k28=;
        b=jfMGmb4LTM5YYby+8W+TsfH1AFuc+evfNaaHueteyejhOI5KL8ZtA4F/SnpqUqJjrw
         cV8vxKaHOCegQXavuOa0pYqeg0Ya8yhBICv5fK2s4jXOL3inwB4sNB5LSfHOFHZnwC0n
         lZY42Bq9e9HAN31Nn/jghCE16qxh2A+jcnwERvbKCt6QT+9DosqFgOzavU1tmthdEO4D
         PpTHPjwZY+5NrZcpOv0IpuJHsgKrZuH1hmG3T5z0qGbmarpDlMk7SEXi5V23312QdR3U
         BCa0R6bps6TNbix/+Q5SdsRQPih5wW082YblTV3jppji2t7+fzf4RrjHxVyEOCfS10qy
         KVzA==
X-Gm-Message-State: AFqh2kpPMVArEWApjVFmTbmGD/QDhmdp6X/P95t3PU7VugGlBVx2XPdy
        CZi0wegpJ+WpqXGCkLSHpugjT98lSUhDCGmhpwc=
X-Google-Smtp-Source: AMrXdXuPNjW1/ValhDj6KqDhCWENtVPP90a7xAg83ZTdS2f4qyMJUYCiBo3F4LGH8LvJ8b38FEf/kqGNuCzly1FcPfg=
X-Received: by 2002:a25:d311:0:b0:6fa:40a8:5952 with SMTP id
 e17-20020a25d311000000b006fa40a85952mr981148ybf.594.1671800026317; Fri, 23
 Dec 2022 04:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20221111075902.798571-1-guoren@kernel.org>
In-Reply-To: <20221111075902.798571-1-guoren@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 23 Dec 2022 12:53:19 +0000
Message-ID: <CA+V-a8tbFhefuYF0UrGNrKZn6CpHEUhOvsf4GNmdLza0gWvf=w@mail.gmail.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application crash
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

Thank you for the patch.

On Fri, Nov 11, 2022 at 8:00 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> After use_asid_allocator is enabled, the userspace application will
> crash by stale TLB entries. Because only using cpumask_clear_cpu without
> local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> Then set_mm_asid would cause the user space application to get a stale
> value by stale TLB entry, but set_mm_noasid is okay.
>
> Here is the symptom of the bug:
> unhandled signal 11 code 0x1 (coredump)
>    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
>    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> => 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> (gdb) i r s0
> s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> (gdb) x /2x 0x3fd6d92490
> 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> The core dump file shows that register s0 is wrong, but the value in
> memory is correct. Because 'ld s0, -148(s0)' used a stale mapping entry
> in TLB and got a wrong result from an incorrect physical address.
>
> When the task ran on CPU0, which loaded/speculative-loaded the value of
> address(0x3fd6d92490), then the first version of the mapping entry was
> PTWed into CPU0's TLB.
> When the task switched from CPU0 to CPU1 (No local_tlb_flush_all here by
> asid), it happened to write a value on the address (0x3fd6d92490). It
> caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
> ptep_get_and_clear & flush_tlb_page.
> The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need TLB
> flush, but CPU0 had cleared the CPU0's mm_cpumask in the previous
> switch_mm. So we only flushed the CPU1 TLB and set the second version
> mapping of the PTE. When the task switched from CPU1 to CPU0 again, CPU0
> still used a stale TLB mapping entry which contained a wrong target
> physical address. It raised a bug when the task happened to read that
> value.
>
>    CPU0                               CPU1
>    - switch 'task' in
>    - read addr (Fill stale mapping
>      entry into TLB)
>    - switch 'task' out (no tlb_flush)
>                                       - switch 'task' in (no tlb_flush)
>                                       - write addr cause pagefault
>                                         do_page_fault() (change to
>                                         new addr mapping)
>                                           wp_page_copy()
>                                             ptep_clear_flush()
>                                               ptep_get_and_clear()
>                                               & flush_tlb_page()
>                                         write new value into addr
>                                       - switch 'task' out (no tlb_flush)
>    - switch 'task' in (no tlb_flush)
>    - read addr again (Use stale
>      mapping entry in TLB)
>      get wrong value from old phyical
>      addr, BUG!
>
> The solution is to keep all CPUs' footmarks of cpumask(mm) in switch_mm,
> which could guarantee to invalidate all stale TLB entries during TLB
> flush.
>
> Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Changes in v3:
>  - Move set/clear cpumask(mm) into set_mm (Make code more pretty
>    with Andrew's advice)
>  - Optimize comment description
>
> Changes in v2:
>  - Fixup nommu compile problem (Thx Conor, Also Reported-by: kernel
>    test robot <lkp@intel.com>)
>  - Keep cpumask_clear_cpu for noasid
> ---
>  arch/riscv/mm/context.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
As reported on the patch [0] I was seeing consistent failures on the
RZ/Five SoC while running bonnie++ utility. After applying this patch
on top of Palmer's for-next branch (eb67d239f3aa) I am no longer
seeing this issue.

Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[0] https://patchwork.kernel.org/project/linux-riscv/patch/20220829205219.283543-1-geomatsi@gmail.com/

Cheers,
Prabhakar

> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..0f784e3d307b 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -205,12 +205,24 @@ static void set_mm_noasid(struct mm_struct *mm)
>         local_flush_tlb_all();
>  }
>
> -static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> +static inline void set_mm(struct mm_struct *prev,
> +                         struct mm_struct *next, unsigned int cpu)
>  {
> -       if (static_branch_unlikely(&use_asid_allocator))
> -               set_mm_asid(mm, cpu);
> -       else
> -               set_mm_noasid(mm);
> +       /*
> +        * The mm_cpumask indicates which harts' TLBs contain the virtual
> +        * address mapping of the mm. Compared to noasid, using asid
> +        * can't guarantee that stale TLB entries are invalidated because
> +        * the asid mechanism wouldn't flush TLB for every switch_mm for
> +        * performance. So when using asid, keep all CPUs footmarks in
> +        * cpumask() until mm reset.
> +        */
> +       cpumask_set_cpu(cpu, mm_cpumask(next));
> +       if (static_branch_unlikely(&use_asid_allocator)) {
> +               set_mm_asid(next, cpu);
> +       } else {
> +               cpumask_clear_cpu(cpu, mm_cpumask(prev));
> +               set_mm_noasid(next);
> +       }
>  }
>
>  static int __init asids_init(void)
> @@ -264,7 +276,8 @@ static int __init asids_init(void)
>  }
>  early_initcall(asids_init);
>  #else
> -static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> +static inline void set_mm(struct mm_struct *prev,
> +                         struct mm_struct *next, unsigned int cpu)
>  {
>         /* Nothing to do here when there is no MMU */
>  }
> @@ -317,10 +330,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>          */
>         cpu = smp_processor_id();
>
> -       cpumask_clear_cpu(cpu, mm_cpumask(prev));
> -       cpumask_set_cpu(cpu, mm_cpumask(next));
> -
> -       set_mm(next, cpu);
> +       set_mm(prev, next, cpu);
>
>         flush_icache_deferred(next, cpu);
>  }
> --
> 2.36.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
