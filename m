Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD46B8875
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCNCXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCNCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:23:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F4A943B8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:22:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id g18so14603952ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678760575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmn/Tu9QQEldkcaMm6xr7JzrPZg/DPh7ApsKSJ8t7Qc=;
        b=G7XKJBWKNqGO2hwc+M0jlRTo8RuBBEZVbhOZ8ULGqDyMVGrUCGjPnMgQZYzi6wj1ds
         4rnbvyD24vh4pHTYlQjVGHQ6cHhYXPCoBLn+AtHVZf17e90lBjw/jiCax65M7ACKH+MJ
         YmnCXzUtaoaQVgbTils/S9KEndgnxKtziyHjDucXr4SOBM5JYu6sues2IGgxLSS7ITd+
         K8aaMflg1XQBmAZe7bLfTjoAER94IpHHJ64BqHqZDe2G42H34WL3RcrxV4yVwehnemAs
         XqDBtdZvhsJF20uxeUhpuHyQC8FOVisYMVgusSawUeKxKA4/zepDZ/MQME0qOFUJfVsk
         w1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678760575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmn/Tu9QQEldkcaMm6xr7JzrPZg/DPh7ApsKSJ8t7Qc=;
        b=bxfB8bzyH6Hw0ranVoxfE/SsNHfyHkqyh211q0d8yk4/ogfYW2xd2jxGmc4KyWZ5VU
         DrMTyVDiR8dpWAi6P1MSd08E82zFJW2hlgKNleguGof6p7SeHBFrdXuXLSHC2XhnapwH
         1WGo39iYrpL09JFTcXyYfbeSvtD6ucdqnvhnkiyl4uwzSQgnKk/By2VAKHI+nY0f1Ker
         UKKrqBHXhlMLdUecVA15ikuIGvntANHJJ/lhxwd9DGASAD6tX4+bvmzxjjMfVBAavLpF
         nciDkaBaaIECtehMdFHbxn0eoiJRn6pRcQY1EqKE/pXs6yQUhnd8UEDCDLycjkRw4m+L
         ZB4Q==
X-Gm-Message-State: AO0yUKWX0HV9SAtAqCraVKl/3YhjeWFWX9mKmPnklACNPrwhkU7Hvtlq
        SgVBUvfSQHNlx+vV0CrPydOrTOspRd0/pfxHL+A=
X-Google-Smtp-Source: AK7set8WsFCh8Mez4xozjfkSav06kp61NeO4s2czeZwHPbXa6/9XNImnQnan8FE3EIIw6B9FMGDCqPj8lcxVuZWIwaU=
X-Received: by 2002:a05:651c:336:b0:295:d632:ba25 with SMTP id
 b22-20020a05651c033600b00295d632ba25mr11181025ljp.5.1678760575431; Mon, 13
 Mar 2023 19:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230313034906.2401730-1-dylan@andestech.com>
In-Reply-To: <20230313034906.2401730-1-dylan@andestech.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 14 Mar 2023 10:22:43 +0800
Message-ID: <CA+ZOyahmpKXq2K-VqKkfN8t5aLDwU-OvL46oj9nNpdm6ZU3qNQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: mm: Fix incorrect ASID argument when flushing TLB
To:     Dylan Jhong <dylan@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@kernel.org, sergey.matyukevich@syntacore.com,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, x5710999x@gmail.com,
        tim609@andestech.com, peterlin@andestech.com, ycliang@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dylan Jhong <dylan@andestech.com> =E6=96=BC 2023=E5=B9=B43=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8812:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Currently, we pass the CONTEXTID instead of the ASID to the TLB flush
> function. We should only take the ASID field to prevent from touching
> the reserved bit field.
>
> Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> ---

Hi Dylan,
Thanks for your patch, if I remember correctly, there was a patch from
Alistair Francis did the similar fix. Perhaps we should track that
patch to see why it doesn't be merged. Thanks.

http://lists.infradead.org/pipermail/linux-riscv/2022-March/013558.html

> Changes from v2:
> - Remove unsued EXPORT_SYMBOL()
> ---
>  arch/riscv/include/asm/tlbflush.h | 2 ++
>  arch/riscv/mm/context.c           | 2 +-
>  arch/riscv/mm/tlbflush.c          | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index 907b9efd39a8..597d6d8aec28 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -12,6 +12,8 @@
>  #include <asm/errata_list.h>
>
>  #ifdef CONFIG_MMU
> +extern unsigned long asid_mask;
> +
>  static inline void local_flush_tlb_all(void)
>  {
>         __asm__ __volatile__ ("sfence.vma" : : : "memory");
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 80ce9caba8d2..6d1aeb063e81 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -22,7 +22,7 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>
>  static unsigned long asid_bits;
>  static unsigned long num_asids;
> -static unsigned long asid_mask;
> +unsigned long asid_mask;
>
>  static atomic_long_t current_version;
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index ce7dfc81bb3f..ba4c27187c95 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -27,7 +27,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm,=
 unsigned long start,
>         /* check if the tlbflush needs to be sent to other CPUs */
>         broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>         if (static_branch_unlikely(&use_asid_allocator)) {
> -               unsigned long asid =3D atomic_long_read(&mm->context.id);
> +               unsigned long asid =3D atomic_long_read(&mm->context.id) =
& asid_mask;
>
>                 /*
>                  * TLB will be immediately flushed on harts concurrently
> --
> 2.34.1
>
