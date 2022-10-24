Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113A960BC79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJXVsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiJXVrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:47:51 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C53DFD2E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:59:54 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z68so1302642iof.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hWSp/6UcndKaZ8NRQJXiNT1wjP9FmhU1KAH3NkWN5I4=;
        b=UzP0aPIkaGLmtOilY1VnI/pgy1ujFkv6mRlP6oURmh/OKv7pGfue41WG+pA0w9G2S1
         vzrLcH0eaCqnYLMUk48QwLCP+G/x8RtSePFd96m8uhamOFQSghYcbTghAbe9lUWwEZAq
         idYVWY/Uu9vy2ap9WK9wEaCnuIBlmchwho/1/PU0Gqf5Kcb4Yaggpm8pCvEceDUPivTj
         0V9HqvSCcTbX9F4BXlWiv4An24Nw32XxlxlpW3NxQf82usQ6jXe9PsS1BsxPcemb7gcw
         ThB/O4qzGUQfC5UkrNiKU7MusnMm5GD4rM+0/0sxz8lVqkkz1ZvUSQ3Xcr9c3G8cU9VQ
         YDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWSp/6UcndKaZ8NRQJXiNT1wjP9FmhU1KAH3NkWN5I4=;
        b=KDpBNHaoNKfEgXZ7sXUxpcQ2+gE0gWrCq3qD6evPhIgWm6B59098QZSWn8KYLux0xW
         hxyLVvBfZ8xf7rQs7oY2gevRYzLXnsWD5FZe1Zm9PVEhLbt628W3j7sUu69ZUE1I5nVc
         QWLo2emzqd5mPZUrDxMzcP/WfvHTJR2KdZDIuVycnnFzfkczOz2tnCzqH1qnWC9ZAYYn
         5Vdo7LhP3OwgNoB1tPN9H8VCpU5673p1eO5k+HIJVDbrPv06eJlxly92HqWNHdYS5vk+
         1q9l+Lv7YFTNidvJhbSwR6OxPGshVSqLPZmxSgSQA8mbisEcbwoWzcDEks7DAK0uPBBZ
         7riA==
X-Gm-Message-State: ACrzQf2bsrGYFuWEXhRmuyprETJPSB3GnMDVKaOfmu5hr+DyBg7bXbF5
        MLpUmS33Vzuv0Jq794opZ4MnmfeCjJO4gLJ+RyApPeq47V0=
X-Google-Smtp-Source: AMsMyM6AlYIzYIEv7dB8WzNL/xThVqRV40naQrbQOOYHQpXH7IRYVOsjebSlUxSlYOzR4jNfcdlXvdStJ+odCEbY0gY=
X-Received: by 2002:a6b:5d08:0:b0:6bb:f915:4a33 with SMTP id
 r8-20020a6b5d08000000b006bbf9154a33mr18924194iob.2.1666641524042; Mon, 24 Oct
 2022 12:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 24 Oct 2022 21:58:07 +0200
Message-ID: <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
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

On Mon, Oct 24, 2022 at 10:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Oct 23, 2022 at 10:42:49PM -0700, John Hubbard wrote:
> > On 10/22/22 04:14, Peter Zijlstra wrote:
> > > --- a/include/linux/pgtable.h
> > > +++ b/include/linux/pgtable.h
> > > @@ -260,15 +260,12 @@ static inline pte_t ptep_get(pte_t *ptep
> > >
> > >  #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
> > >  /*
> > > - * WARNING: only to be used in the get_user_pages_fast() implementation.
> > > - *
> > > - * With get_user_pages_fast(), we walk down the pagetables without taking any
> > > - * locks.  For this we would like to load the pointers atomically, but sometimes
> > > - * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
> > > - * we do have is the guarantee that a PTE will only either go from not present
> > > - * to present, or present to not present or both -- it will not switch to a
> > > - * completely different present page without a TLB flush in between; something
> > > - * that we are blocking by holding interrupts off.
> > > + * For walking the pagetables without holding any locks.  Some architectures
> > > + * (eg x86-32 PAE) cannot load the entries atomically without using expensive
> > > + * instructions.  We are guaranteed that a PTE will only either go from not
> > > + * present to present, or present to not present -- it will not switch to a
> > > + * completely different present page without a TLB flush inbetween; which we
> > > + * are blocking by holding interrupts off.
> >
> >
> > This is getting interesting. My latest understanding of this story is
> > that both the "before" and "after" versions of that comment are
> > incorrect! Because, as Jann Horn noticed recently [1], there might not
> > be any IPIs involved in a TLB flush, if x86 is running under a
> > hypervisor, and that breaks the chain of reasoning here.
>
> That mail doesn't really include enough detail. The way x86 HV TLB
> flushing is supposed to work is by making use of
> MMU_GATHER_RCU_TABLE_FREE. Specifically, something like:
>
>
>         vCPU0                           vCPU1
>
>                                         tlb_gather_mmut(&tlb, mm);
>
>                                         ....
>
>         local_irq_disable();
>         ... starts page-table walk ...
>
>         <schedules out; sets KVM_VCPU_PREEMPTED>
>
>                                         tlb_finish_mmu(&tlb)
>                                           ...
>                                           kvm_flush_tlb_multi()
>                                             if (state & KVM_VCPU_PREEMPTED)
>                                               if (try_cmpxchg(,&state, state | KVM_VCPU_FLUSH_TLB))
>                                                 __cpumask_clear_cpu(cpu, flushmask);
>
>
>                                           tlb_remove_table_sync_one() / call_rcu()
>
>
>         <schedules back in>
>
>         ... continues page-table walk ...
>         local_irq_enable();
>
> If mmu gather is forced into tlb_remove_talbe_sync_one() (by memory
> pressure), then you've got your IPI back, otherwise it does call_rcu()
> and RCU itself will need vCPU0 to enable IRQs in order to make progress.
>
> Either way around, the actual freeing of the pages is delayed until the
> page-table walk is finished.
>
> What am I missing?

Unless I'm completely misunderstanding what's going on here, the whole
"remove_table" thing only happens when you "remove a table", meaning
you free an entire *pagetable*. Just zapping PTEs doesn't trigger that
logic.
