Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CCA70ED11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbjEXF2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbjEXF2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:28:42 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D613E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:28:41 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5621a279cbbso10713097b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684906120; x=1687498120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aS3Nhb3VAWEGlLu+XBwgpmCXcyJvTR79ms1GmCOYiuc=;
        b=yHK9rzEq2VzEMfw2DClczT1cZ0xt1Sc1yfEDGlQ/piJkXnt8SYE6F8347x9r4Bnc4X
         5iu3V89eWxuFne6sR9CxkQ6TxK6EN/6k7xBX1U24kVBLCxj0/5whUbyYRpkJBxC9+85Q
         qqvV1OC49D6WylWj5VRJukBH6nVXLiiZnWrGw7MJOfNnudiIuo1Wu8eRwGaol4pdIkqT
         mJXhFmDRVi/PyVkDerk/ALdFKhRrvkAuKqS0sctgyaFABXSacfned5FhxHdfNtu1TwO+
         i4pfgPYu6LKg+XSwBDJi7TyvTqRGiO2lfSZsYPaVWA+nZ4XwxxojQ5ChtP3PdIDKRzqK
         7OCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684906120; x=1687498120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aS3Nhb3VAWEGlLu+XBwgpmCXcyJvTR79ms1GmCOYiuc=;
        b=HFHHJpA3fDXKmnOYmWzpJ1G6maK/3vEyiz1K5DMy9s5AkHlzy9Lztf+JNIIiv0r8Y4
         3j8bMl40H3HeFsDilLfYwtpkeZyi+eGg5G+C98k/ftXMrxC2QKYO4QuEDKMFJ7X/THjb
         JHGqGCLAh20hIGLc4wtYvyPGFPXFmhxY0ssUSXu/vLE3o8Ko9Z02sh1YRyV48JetzweU
         Jn5KwZHUnV89q/pBzINOr2sPeZ5X72SSDeuKtopZ93XdR25nNsdtm44Rq4ViIAjd4iVq
         852pBuIYe4vY2QQXLRE7hn9ctH60vDRApJ5Sykr8yDxZ7hVYF/lJyA28/vJOjQDuf710
         kZEQ==
X-Gm-Message-State: AC+VfDzM7oORahZ48Y5zFG8IttTMG/GuEpKkKK6awsyEKbQtAG+756FY
        mw27tdqkNFhvc4QXQ9Oa245WLSBCfWGQZjq+4p6m2TxGqAym2zbX3IAqpw==
X-Google-Smtp-Source: ACHHUZ4Try6TclbYIBRhUv6Q1d1POhNmJXlpCYm6I1CpyXdd8PNyciLfqJujJFDOKp0b7AKP6kzrS4aavRcC3gJgu4g=
X-Received: by 2002:a05:690c:810:b0:565:62e7:223a with SMTP id
 bx16-20020a05690c081000b0056562e7223amr925533ywb.3.1684906120498; Tue, 23 May
 2023 22:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230523165942.2630-1-jszhang@kernel.org> <20230524050259.104358-1-guoren@kernel.org>
In-Reply-To: <20230524050259.104358-1-guoren@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 23 May 2023 22:28:29 -0700
Message-ID: <CAJuCfpGAV1dhxS3FDyxJNtg25ZznYOv4tHzSezhoWZdG_WRizQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: try VMA lock-based page fault handling first
To:     guoren@kernel.org
Cc:     jszhang@kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, chenhuacai@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:03=E2=80=AFPM <guoren@kernel.org> wrote:
>
> > Attempt VMA lock-based page fault handling first, and fall back to the
> > existing mmap_lock-based handling if that fails.
> >
> > A simple running the ebizzy benchmark on Lichee Pi 4A shows that
> > PER_VMA_LOCK can improve the ebizzy benchmark by about 32.68%. In
> Good improvement, I think VMA lock is worth to support in riscv.
>
> Please give more details about ebizzy, Is it
> https://github.com/linux-test-project/ltp/blob/master/utils/benchmark/ebi=
zzy-0.3/ebizzy.c
> ?
>
> > theory, the more CPUs, the bigger improvement, but I don't have any
> > HW platform which has more than 4 CPUs.
> >
> > This is the riscv variant of "x86/mm: try VMA lock-based page fault
> > handling first".
> >
>
> How about add Link tag here:
> Link: https://lwn.net/Articles/906852/
>
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> > Any performance numbers are welcome! Especially the numbers on HW
> > platforms with 8 or more CPUs.
> >
> >  arch/riscv/Kconfig    |  1 +
> >  arch/riscv/mm/fault.c | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 62e84fee2cfd..b958f67f9a12 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -42,6 +42,7 @@ config RISCV
> >       select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
> >       select ARCH_SUPPORTS_HUGETLBFS if MMU
> >       select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
> > +     select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
> >       select ARCH_USE_MEMTEST
> >       select ARCH_USE_QUEUED_RWLOCKS
> >       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index 8685f85a7474..eccdddf26f4b 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -286,6 +286,36 @@ void handle_page_fault(struct pt_regs *regs)
> >               flags |=3D FAULT_FLAG_WRITE;
> >       else if (cause =3D=3D EXC_INST_PAGE_FAULT)
> >               flags |=3D FAULT_FLAG_INSTRUCTION;
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     if (!(flags & FAULT_FLAG_USER))
> > +             goto lock_mmap;
> > +
> > +     vma =3D lock_vma_under_rcu(mm, addr);
> > +     if (!vma)
> > +             goto lock_mmap;
> > +
> > +     if (unlikely(access_error(cause, vma))) {
> > +             vma_end_read(vma);
> > +             goto lock_mmap;
> > +     }
> > +
> > +     fault =3D handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK,=
 regs);
> > +     vma_end_read(vma);
> > +
> > +     if (!(fault & VM_FAULT_RETRY)) {
> > +             count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> > +             goto done;
> > +     }
> > +     count_vm_vma_lock_event(VMA_LOCK_RETRY);
> > +
> > +     if (fault_signal_pending(fault, regs)) {
> > +             if (!user_mode(regs))
> > +                     no_context(regs, addr);
> > +             return;
> > +     }
> > +lock_mmap:
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> >  retry:
> >       mmap_read_lock(mm);
> >       vma =3D find_vma(mm, addr);
> > @@ -355,6 +385,9 @@ void handle_page_fault(struct pt_regs *regs)
> >
> >       mmap_read_unlock(mm);
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +done:
> > +#endif
> It's very close to cd7f176aea5f ("arm64/mm: try VMA lock-based page fault
> handling first"), and I didn't find any problem. So:
>
> Reviewed-by: Guo Ren <guoren@kernel.org>

Looks correct to me.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> F.Y.I Huacai Chen, maybe he also would be interesting this new feature.
>
>
> >       if (unlikely(fault & VM_FAULT_ERROR)) {
> >               tsk->thread.bad_cause =3D cause;
> >               mm_fault_error(regs, addr, fault);
> > --
> > 2.40.1
