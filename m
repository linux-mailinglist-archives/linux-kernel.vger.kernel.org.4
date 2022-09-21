Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407F25BF9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIUIzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIUIyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:54:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E461D0CB;
        Wed, 21 Sep 2022 01:54:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so12082513ejc.1;
        Wed, 21 Sep 2022 01:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sc4HrH+dawwbyFY4jxaPYFax97q7PbwtRdCVIa2eWag=;
        b=nvXLTwTum0Zu+Nzwkb/Va5KR7MpZoNKJUWh0AvWe8HdVcr1Grhklhdo1BZW8sba5fw
         BGnTPKQw9TWdIn1AwbWmhqYPWj/FVYt+uu55rzvSXj7gyQEl6nisi0K/8PiKq+G1vate
         OwUz5f2/PwR248iBS39pCnt+cZvqAUi3xnXwI/CPS+xFuJqBAs2z3QcTEXopA/PS8206
         LsKWiJynHncuR2MFh2DVSwmUKzCR6RXBe0hFSksOj2krERKhpYbj6OOLJgFNJt7NSBQ6
         hVqA13u7w8pzq63oY/Yhzl8fszOLZBKNoD8poD5JuUBZFek7tviVQ4tIq4kb5M10FNKT
         s1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sc4HrH+dawwbyFY4jxaPYFax97q7PbwtRdCVIa2eWag=;
        b=fiYKw6vUuuu4YpfvCiVnOScNgbyE6WEVmuiqJL5IpbUGPlvIVtUKQZIVBRD1aEY1M3
         tJjNAGQbMeOJKyXdtr3TfAI4B/wMCEtOKHTm6Ajyr3XhgI93OTK/6+kKJRxFZumrOvb9
         sQ7zSWI0UOpoQb0h7EehaZGkS0i2dXguapPv1iSaVreSsXFDbVrOU2S9uLAQk41D3jE+
         JW7O2g4G5DzmCvDxFKGiyQeKHTshW9qaogFv1ZaqRrRL7ff8i3yLk3QatVvG03tpK5v1
         8bytmGliYixaxdFXmJAlPi6oXSKWDMum4pWteD7RE9iBVHSsFVBsuHnhpnYnrlMzLHmc
         RbyQ==
X-Gm-Message-State: ACrzQf0LQg0hp0qSphZSBVE4owymdiID4ghN7kIzH6Qghn8ow9QCWhEc
        LT2eFukVxmPo6hjrkMlO9EKS19nXY8o78IMu1pQ=
X-Google-Smtp-Source: AMsMyM5mpmqn+gfhEkasy6u301zqGqQeURhHcxEGpcBIv8VPgxV44BVkZMurDLR6PBxFMgmK/214xxyLA2GRvdonQRQ=
X-Received: by 2002:a17:907:c13:b0:781:d3c2:5015 with SMTP id
 ga19-20020a1709070c1300b00781d3c25015mr4799862ejc.457.1663750486484; Wed, 21
 Sep 2022 01:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220921084302.43631-1-yangyicong@huawei.com> <20220921084302.43631-2-yangyicong@huawei.com>
In-Reply-To: <20220921084302.43631-2-yangyicong@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 21 Sep 2022 20:54:35 +1200
Message-ID: <CAGsJ_4ydO=CegfrAF=jYmhOffXd7zKaFp_YxhdMgnoNGA8mBQQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm/tlbbatch: Introduce arch_tlbbatch_should_defer()
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, peterz@infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, anshuman.khandual@arm.com,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
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

On Wed, Sep 21, 2022 at 8:45 PM Yicong Yang <yangyicong@huawei.com> wrote:
>
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>
> The entire scheme of deferred TLB flush in reclaim path rests on the
> fact that the cost to refill TLB entries is less than flushing out
> individual entries by sending IPI to remote CPUs. But architecture
> can have different ways to evaluate that. Hence apart from checking
> TTU_BATCH_FLUSH in the TTU flags, rest of the decision should be
> architecture specific.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> [https://lore.kernel.org/linuxppc-dev/20171101101735.2318-2-khandual@linux.vnet.ibm.com/]
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> [Rebase and fix incorrect return value type]
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

>  arch/x86/include/asm/tlbflush.h | 12 ++++++++++++
>  mm/rmap.c                       |  9 +--------
>  2 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index cda3118f3b27..8a497d902c16 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -240,6 +240,18 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
>         flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
>  }
>
> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> +{
> +       bool should_defer = false;
> +
> +       /* If remote CPUs need to be flushed then defer batch the flush */
> +       if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
> +               should_defer = true;
> +       put_cpu();
> +
> +       return should_defer;
> +}
> +
>  static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
>  {
>         /*
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 93d5a6f793d2..cd8cf5cb0b01 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -690,17 +690,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>   */
>  static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>  {
> -       bool should_defer = false;
> -
>         if (!(flags & TTU_BATCH_FLUSH))
>                 return false;
>
> -       /* If remote CPUs need to be flushed then defer batch the flush */
> -       if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
> -               should_defer = true;
> -       put_cpu();
> -
> -       return should_defer;
> +       return arch_tlbbatch_should_defer(mm);
>  }
>
>  /*
> --
> 2.24.0
>
