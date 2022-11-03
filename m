Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF50C61770E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKCHBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCHBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:01:09 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E653DB3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:01:08 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id n186so1086696oih.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 00:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kR6ignjGg3LmqCbSdIp9lkLVihLfP058l6KWrmtMNQM=;
        b=drK8F1zQPCBkx+X55Ab6f3areRAfKRxAskSrcFxRfa7+5ZmA/EfZEeatQ3PQmrxmjX
         iMf0Z/RP2j3EXOQK+I8Yaxy//iOeJu0e8jXbO9Ms08I9thA12xqTj2T/MzWVyrvQGanR
         bbPf/j8H1QH+FzMRX/krQKI8Hn2jaTgaubgHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kR6ignjGg3LmqCbSdIp9lkLVihLfP058l6KWrmtMNQM=;
        b=HkT+ywdUJ0wrTxHmgR8w7BJ4oqeRFJOU/7aIZ8wW/2SPF6ncLcWw+spI9FVp9KfPaV
         F+nqeJpWOnscASjhTLJ/OLellPjyEPrNsO41ZSrUtI5MhDqR2r/tudvltHBSI5TfC+v/
         WPYc9Hyz8w8iudlwO4Dc/E5BbMy2vpBnDxNEojUpQdfaz+CX+eelQFjlO6qsR9vkKNgw
         XoMpoFDDZXx6MVVgGPFScTBGV7TuCz5ETXTk2ylrwIuNLL3xRcmgllKAlHIaXwPXBgrs
         tpPLvf5twu9wjkk7csfUhWwUxhX8XKB75Y+xTHCliGzMbCI+OxwI1279OGb8aTi5VOYO
         /2VA==
X-Gm-Message-State: ACrzQf07NRZHrZ4FetZl3/cd55MDyUjgi+RVtJ9wPCjC2tg9T5XBkHmf
        ZmywGNsS3YNutPyuMOue9v6OPiyGor+fNUw8PwiOQoqFxw==
X-Google-Smtp-Source: AMsMyM6osueZMYemZ+UJ24+YmwA5XrUiqfs3YC3eZINQ3dKgjWzkh8OOYCR2sytCG/vcg869cuVp58yP73PAL+zoLeQ=
X-Received: by 2002:a05:6808:485:b0:359:d1b1:2587 with SMTP id
 z5-20020a056808048500b00359d1b12587mr18843466oid.274.1667458867973; Thu, 03
 Nov 2022 00:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221101143400.690000-1-apatel@ventanamicro.com> <20221101143400.690000-7-apatel@ventanamicro.com>
In-Reply-To: <20221101143400.690000-7-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 3 Nov 2022 00:00:56 -0700
Message-ID: <CAOnJCULmsJtd8+vLGjUdLtdyK+6HG40c7jQBbUqckWT75uGFog@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] RISC-V: Use IPIs for remote TLB flush when possible
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 7:34 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> If we have specialized interrupt controller (such as AIA IMSIC) which
> allows supervisor mode to directly inject IPIs without any assistance
> from M-mode or HS-mode then using such specialized interrupt controller,
> we can do remote TLB flushes directly from supervisor mode instead of
> using the SBI RFENCE calls.
>
> This patch extends remote TLB flush functions to use supervisor mode
> IPIs whenever direct supervisor mode IPIs.are supported by interrupt
> controller.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/mm/tlbflush.c | 93 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 78 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 37ed760d007c..27a7db8eb2c4 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -23,14 +23,62 @@ static inline void local_flush_tlb_page_asid(unsigned long addr,
>                         : "memory");
>  }
>
> +static inline void local_flush_tlb_range(unsigned long start,
> +               unsigned long size, unsigned long stride)
> +{
> +       if (size <= stride)
> +               local_flush_tlb_page(start);
> +       else
> +               local_flush_tlb_all();
> +}
> +
> +static inline void local_flush_tlb_range_asid(unsigned long start,
> +               unsigned long size, unsigned long stride, unsigned long asid)
> +{
> +       if (size <= stride)
> +               local_flush_tlb_page_asid(start, asid);
> +       else
> +               local_flush_tlb_all_asid(asid);
> +}
> +
> +static void __ipi_flush_tlb_all(void *info)
> +{
> +       local_flush_tlb_all();
> +}
> +
>  void flush_tlb_all(void)
>  {
> -       sbi_remote_sfence_vma(NULL, 0, -1);
> +       if (riscv_use_ipi_for_rfence())
> +               on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> +       else
> +               sbi_remote_sfence_vma(NULL, 0, -1);
> +}
> +
> +struct flush_tlb_range_data {
> +       unsigned long asid;
> +       unsigned long start;
> +       unsigned long size;
> +       unsigned long stride;
> +};
> +
> +static void __ipi_flush_tlb_range_asid(void *info)
> +{
> +       struct flush_tlb_range_data *d = info;
> +
> +       local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
> +}
> +
> +static void __ipi_flush_tlb_range(void *info)
> +{
> +       struct flush_tlb_range_data *d = info;
> +
> +       local_flush_tlb_range(d->start, d->size, d->stride);
>  }
>
> -static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
> -                                 unsigned long size, unsigned long stride)
> +static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
> +                             unsigned long size, unsigned long stride)
>  {
> +       struct flush_tlb_range_data ftd;
>         struct cpumask *cmask = mm_cpumask(mm);
>         unsigned int cpuid;
>         bool broadcast;
> @@ -45,19 +93,34 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>                 unsigned long asid = atomic_long_read(&mm->context.id);
>
>                 if (broadcast) {
> -                       sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> -               } else if (size <= stride) {
> -                       local_flush_tlb_page_asid(start, asid);
> +                       if (riscv_use_ipi_for_rfence()) {
> +                               ftd.asid = asid;
> +                               ftd.start = start;
> +                               ftd.size = size;
> +                               ftd.stride = stride;
> +                               on_each_cpu_mask(cmask,
> +                                                __ipi_flush_tlb_range_asid,
> +                                                &ftd, 1);
> +                       } else
> +                               sbi_remote_sfence_vma_asid(cmask,
> +                                                          start, size, asid);
>                 } else {
> -                       local_flush_tlb_all_asid(asid);
> +                       local_flush_tlb_range_asid(start, size, stride, asid);
>                 }
>         } else {
>                 if (broadcast) {
> -                       sbi_remote_sfence_vma(cmask, start, size);
> -               } else if (size <= stride) {
> -                       local_flush_tlb_page(start);
> +                       if (riscv_use_ipi_for_rfence()) {
> +                               ftd.asid = 0;
> +                               ftd.start = start;
> +                               ftd.size = size;
> +                               ftd.stride = stride;
> +                               on_each_cpu_mask(cmask,
> +                                                __ipi_flush_tlb_range,
> +                                                &ftd, 1);
> +                       } else
> +                               sbi_remote_sfence_vma(cmask, start, size);
>                 } else {
> -                       local_flush_tlb_all();
> +                       local_flush_tlb_range(start, size, stride);
>                 }
>         }
>
> @@ -66,23 +129,23 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
> -       __sbi_tlb_flush_range(mm, 0, -1, PAGE_SIZE);
> +       __flush_tlb_range(mm, 0, -1, PAGE_SIZE);
>  }
>
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
> -       __sbi_tlb_flush_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
> +       __flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
>  }
>
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                      unsigned long end)
>  {
> -       __sbi_tlb_flush_range(vma->vm_mm, start, end - start, PAGE_SIZE);
> +       __flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
>  }
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                         unsigned long end)
>  {
> -       __sbi_tlb_flush_range(vma->vm_mm, start, end - start, PMD_SIZE);
> +       __flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
>  }
>  #endif
> --
> 2.34.1
>

LGTM.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
