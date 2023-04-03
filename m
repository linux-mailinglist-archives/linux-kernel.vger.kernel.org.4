Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31ABB6D3D35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjDCGTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjDCGTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:19:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF557A0
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 23:19:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c9so26156326lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 23:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680502750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FtfYUGGzvOVDt8VC72QnbE6YtkKoeRK0CEDvg4zStaw=;
        b=CqHxYRI10GUkHVGULUwc/sQqQ4jrT/AVO/sjSurrGVuqgV1zfTpcaxh2v7e201fGDn
         1ykRIVjEMLd8RflamoNXiEwA9xACGxAHjLhY4145h+fbXZOySvBjLeZbN2XlfmapErFn
         BaE4p4fAbVl/6kIDpksd8HE+KtCYuAN4IC10TP1gv6TW/VG0WtY0zomfGa0gL4AYwMug
         2UxCdApwx7MK4Z2gfb/sGzThlXEfAo6MvIDSpiQ67Mu4qNoXo1YtjBrZSJSccaIOB1hD
         ddl4Iyaal0/fVbCi4/XsNuGqdQ5WxLUBfvPGGZDd3ZDYFato8YxYQUJ/TBLtK9nuiPoO
         NIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680502750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtfYUGGzvOVDt8VC72QnbE6YtkKoeRK0CEDvg4zStaw=;
        b=3XcQ4wzF0sMbsNHuvQ4sjuXtc1WDB+bPD1oWNaUJibDdwMYMMsrR6j3GyVuCpTfAfq
         jCcaJ+7UKxG9EmITpxWaU1hP61cFE7aIepzd/7vCYycpmXwN6UYRfK8EuggB3r8/Qq13
         xBZdvcPI/vcyjDMiCYrgkLCEJdQTjHGBzEl/FXuZS3QDKZ/lzDjfRyFLfbpUKN6sjymQ
         bTo3yEX1bGuJ17PX608WnVe072lEh8uwpYrChj8Iv0QXHH+Hg3O7vJUWZ84QkjkM9k3T
         zNW8BDqlsLBLHjLCEzNvxMRxY88t0EmbeVPOOluSkrvjhrtvquEqn6eP561baylbyWqc
         kyHw==
X-Gm-Message-State: AAQBX9c41Nc/vuBCA5PW9g40rtZRyxdzQRSE+5+/nwz1ssgPv6eIHtqL
        jf8dN1qVIixjFor7U4TZ4n34PJVOFrdtGwywZXkTgw==
X-Google-Smtp-Source: AKy350YD/mmG5u8j8DaJxn3BqkvXFQ3SUbFqw8b35JcIR1GilpgWQtU1qnGQ+s8W6hEoX9eW1TRLSflsfK92lYJ/Ju0=
X-Received: by 2002:a05:6512:15b:b0:4ea:fa77:e436 with SMTP id
 m27-20020a056512015b00b004eafa77e436mr10145433lfo.6.1680502749951; Sun, 02
 Apr 2023 23:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com> <20230312112612.31869-12-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230312112612.31869-12-kirill.shutemov@linux.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Apr 2023 08:18:57 +0200
Message-ID: <CACT4Y+bnR=v0vUC_wTpd98Kpfd1KK--daPwjgnBL__r+wbHUkw@mail.gmail.com>
Subject: Re: [PATCHv16 11/17] x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023 at 12:27, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> IOMMU and SVA-capable devices know nothing about LAM and only expect
> canonical addresses. An attempt to pass down tagged pointer will lead
> to address translation failure.
>
> By default do not allow to enable both LAM and use SVA in the same
> process.
>
> The new ARCH_FORCE_TAGGED_SVA arch_prctl() overrides the limitation.
> By using the arch_prctl() userspace takes responsibility to never pass
> tagged address to the device.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/mmu.h         | 2 ++
>  arch/x86/include/asm/mmu_context.h | 6 ++++++
>  arch/x86/include/uapi/asm/prctl.h  | 1 +
>  arch/x86/kernel/process_64.c       | 7 +++++++
>  drivers/iommu/iommu-sva.c          | 4 ++++
>  include/linux/mmu_context.h        | 7 +++++++
>  6 files changed, 27 insertions(+)
>
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index e80762e998ce..0da5c227f490 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -14,6 +14,8 @@
>  #define MM_CONTEXT_HAS_VSYSCALL                1
>  /* Do not allow changing LAM mode */
>  #define MM_CONTEXT_LOCK_LAM            2
> +/* Allow LAM and SVA coexisting */
> +#define MM_CONTEXT_FORCE_TAGGED_SVA    3
>
>  /*
>   * x86 has arch-specific MMU state beyond what lives in mm_struct.
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> index 06eaaf75d572..4c396e9a384f 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -115,6 +115,12 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
>         mm->context.untag_mask = -1UL;
>  }
>
> +#define arch_pgtable_dma_compat arch_pgtable_dma_compat
> +static inline bool arch_pgtable_dma_compat(struct mm_struct *mm)
> +{
> +       return !mm_lam_cr3_mask(mm) ||
> +               test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags);
> +}
>  #else
>
>  static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index a31e27b95b19..eb290d89cb32 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -23,5 +23,6 @@
>  #define ARCH_GET_UNTAG_MASK            0x4001
>  #define ARCH_ENABLE_TAGGED_ADDR                0x4002
>  #define ARCH_GET_MAX_TAG_BITS          0x4003
> +#define ARCH_FORCE_TAGGED_SVA          0x4004
>
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 88aae519c8f8..eda826a956df 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -756,6 +756,10 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
>         if (current->mm != mm)
>                 return -EINVAL;
>
> +       if (mm_valid_pasid(mm) &&
> +           !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
> +               return -EINTR;
> +
>         if (mmap_write_lock_killable(mm))
>                 return -EINTR;
>
> @@ -878,6 +882,9 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
>                                 (unsigned long __user *)arg2);
>         case ARCH_ENABLE_TAGGED_ADDR:
>                 return prctl_enable_tagged_addr(task->mm, arg2);
> +       case ARCH_FORCE_TAGGED_SVA:
> +               set_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &task->mm->context.flags);

Hi Kirill,

ARCH_ENABLE_TAGGED_ADDR checks that task->mm == current->mm,
shouldn't ARCH_FORCE_TAGGED_SVA check that as well?

Also it looks like currently to enable both LAM and SVA.
LAM enabling checks for SVA, but SVA doesn't and both are not mutually
exclusive.


> +               return 0;
>         case ARCH_GET_MAX_TAG_BITS:
>                 if (!cpu_feature_enabled(X86_FEATURE_LAM))
>                         return put_user(0, (unsigned long __user *)arg2);
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 4ee2929f0d7a..dd76a1a09cf7 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -2,6 +2,7 @@
>  /*
>   * Helpers for IOMMU drivers implementing SVA
>   */
> +#include <linux/mmu_context.h>
>  #include <linux/mutex.h>
>  #include <linux/sched/mm.h>
>  #include <linux/iommu.h>
> @@ -32,6 +33,9 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>             min == 0 || max < min)
>                 return -EINVAL;
>
> +       if (!arch_pgtable_dma_compat(mm))
> +               return -EBUSY;
> +
>         mutex_lock(&iommu_sva_lock);
>         /* Is a PASID already associated with this mm? */
>         if (mm_valid_pasid(mm)) {
> diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
> index 14b9c1fa05c4..f2b7a3f04099 100644
> --- a/include/linux/mmu_context.h
> +++ b/include/linux/mmu_context.h
> @@ -35,4 +35,11 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
>  }
>  #endif
>
> +#ifndef arch_pgtable_dma_compat
> +static inline bool arch_pgtable_dma_compat(struct mm_struct *mm)
> +{
> +       return true;
> +}
> +#endif
> +
>  #endif
> --
> 2.39.2
>
