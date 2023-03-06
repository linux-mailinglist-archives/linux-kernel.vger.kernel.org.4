Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0AD6ACF1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCFUZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCFUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:25:41 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B643457DC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:25:38 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c80so2498090ybf.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 12:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678134337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hF7wS3Hx/Pvpcugsib0JQfyCay4rq+Y4wSQiQgHE58Q=;
        b=mm4oC6jA+okjPImEMJZmmO6uLRhBRnDeHNzV1d8O1Qh5/hafaokl8mjkr8c79UlkBN
         k4drUKORz+wffyx+9YyisfP5mpJImJQsPDv41zOqZG7QkOgo9ri/A5/XDvukiwTsY1A2
         KtUQMjA/qFFeEpXLtJpt5gUH2u4dfLnbgQu/CtMDzJH1c3fz5MOdwhGAc24HiP++snNm
         r1Te6JP4fRv/ob/XR9eV/TIsK4dBpU+dkv3Z52FWkIPRC2czaKV51YKxz4dhn0C6znLk
         9MFCBlOUUHEl5/EKZvJ0XYjeKqLAQIDKZ8xVkWg4Cqj6qtXlNAIezz8HeYtOxpAaL4c1
         0yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678134337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hF7wS3Hx/Pvpcugsib0JQfyCay4rq+Y4wSQiQgHE58Q=;
        b=m6R7DEieC6hPuP4Vn7wJQpbU/Rr7Y4AATHN44K77HPSoXLkT1m5WxbOgYJMMQrYd0s
         d+6dZr78BvqL6nLis/9EJ/DfHwPu6LSmyCt+lxMm1iCO+PfF+FlobgxEIbRKSl0raQje
         Bif0zIknixk7s5WU0zfkk5yG6ytcUhC4W0MiZqnmftofQFfLHp9EmGy/tjlp8p1UVYyu
         ZlmS2hKSneSouDZHeLvlQCmvQ7oQuFu3XzHIqV5MUu9YnAm+Zr1boYScZr+G6s9Dcxc6
         BVvJYKZ6zQyyfyTYGCafg43H+6gHWg3Hfbu2bwhW2C6xITJ9rO3ymtwCFmkTz8NQ/yjn
         Lzkw==
X-Gm-Message-State: AO0yUKVn4PnkbwkVE+PcSBz6RnbEiQi851YGh+4H/wFFw9dvSlP71q5O
        OS9q9DgHW6cGBY9siqMi3lbwKvwmooqJxSkEf3qasA==
X-Google-Smtp-Source: AK7set8n4u10VCWBPTL7wngRuwzFB4EZKZN4IetFL6kNRt6cIBeVlYompKXHsIJ4rDipkAKfK7DTOCV1YSGWRZnP/FI=
X-Received: by 2002:a5b:e92:0:b0:ab8:1ed9:cfc9 with SMTP id
 z18-20020a5b0e92000000b00ab81ed9cfc9mr7085896ybr.6.1678134337360; Mon, 06 Mar
 2023 12:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com> <20230227173632.3292573-32-surenb@google.com>
In-Reply-To: <20230227173632.3292573-32-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 6 Mar 2023 12:25:26 -0800
Message-ID: <CAJuCfpECk6U_PEz7LkAEXyrkwJ+Uug_7i13mcg5fJnsDWZEg5A@mail.gmail.com>
Subject: Re: [PATCH v4 31/33] powerc/mm: try VMA lock-based page fault
 handling first
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 9:37 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> From: Laurent Dufour <ldufour@linux.ibm.com>
>
> Attempt VMA lock-based page fault handling first, and fall back to the
> existing mmap_lock-based handling if that fails.
> Copied from "x86/mm: try VMA lock-based page fault handling first"

Hi Andrew,
Laurent posted a fix for this patch at
https://lore.kernel.org/all/20230306154244.17560-1-ldufour@linux.ibm.com/.
Could you please squash the fix into this patch?
Thanks,
Suren.

>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/powerpc/mm/fault.c                | 41 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/Kconfig |  1 +
>  arch/powerpc/platforms/pseries/Kconfig |  1 +
>  3 files changed, 43 insertions(+)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 2bef19cc1b98..c7ae86b04b8a 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -469,6 +469,44 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>         if (is_exec)
>                 flags |= FAULT_FLAG_INSTRUCTION;
>
> +#ifdef CONFIG_PER_VMA_LOCK
> +       if (!(flags & FAULT_FLAG_USER))
> +               goto lock_mmap;
> +
> +       vma = lock_vma_under_rcu(mm, address);
> +       if (!vma)
> +               goto lock_mmap;
> +
> +       if (unlikely(access_pkey_error(is_write, is_exec,
> +                                      (error_code & DSISR_KEYFAULT), vma))) {
> +               int rc = bad_access_pkey(regs, address, vma);
> +
> +               vma_end_read(vma);
> +               return rc;
> +       }
> +
> +       if (unlikely(access_error(is_write, is_exec, vma))) {
> +               int rc = bad_access(regs, address);
> +
> +               vma_end_read(vma);
> +               return rc;
> +       }
> +
> +       fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
> +       vma_end_read(vma);
> +
> +       if (!(fault & VM_FAULT_RETRY)) {
> +               count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +               goto done;
> +       }
> +       count_vm_vma_lock_event(VMA_LOCK_RETRY);
> +
> +       if (fault_signal_pending(fault, regs))
> +               return user_mode(regs) ? 0 : SIGBUS;
> +
> +lock_mmap:
> +#endif /* CONFIG_PER_VMA_LOCK */
> +
>         /* When running in the kernel we expect faults to occur only to
>          * addresses in user space.  All other faults represent errors in the
>          * kernel and should generate an OOPS.  Unfortunately, in the case of an
> @@ -545,6 +583,9 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>
>         mmap_read_unlock(current->mm);
>
> +#ifdef CONFIG_PER_VMA_LOCK
> +done:
> +#endif
>         if (unlikely(fault & VM_FAULT_ERROR))
>                 return mm_fault_error(regs, address, fault);
>
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
> index ae248a161b43..70a46acc70d6 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -16,6 +16,7 @@ config PPC_POWERNV
>         select PPC_DOORBELL
>         select MMU_NOTIFIER
>         select FORCE_SMP
> +       select ARCH_SUPPORTS_PER_VMA_LOCK
>         default y
>
>  config OPAL_PRD
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index b481c5c8bae1..9c205fe0e619 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -21,6 +21,7 @@ config PPC_PSERIES
>         select HOTPLUG_CPU
>         select FORCE_SMP
>         select SWIOTLB
> +       select ARCH_SUPPORTS_PER_VMA_LOCK
>         default y
>
>  config PARAVIRT
> --
> 2.39.2.722.g9855ee24e9-goog
>
