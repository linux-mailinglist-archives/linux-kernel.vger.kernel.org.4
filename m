Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573215B3F13
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIISwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIISwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:52:14 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769DC133A19
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:52:12 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k9so1260801ils.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nuX8RHdOBuwR18rb/hIKqVYoCioDbOlB9tjSaWc6TfE=;
        b=Q7u1GP81wzUd6Q5YRwMiSxpFY8c8++WLzn2hRT3zSDv46zq4SMTlWHT8g4Dx9ul15x
         cUIvGL6JEmEkw21Tv4+D3qQm91sdLj+xlMrWEIcr8Rer00eeSWnay2EoMNgpCkiWNvyU
         lM+OMZShB0ulM92Tr3YmHmirOHJIJYrrGod0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nuX8RHdOBuwR18rb/hIKqVYoCioDbOlB9tjSaWc6TfE=;
        b=UeaPHyLsK5g+MgHwKOzUmZSpy0Qt+2kHI+UtaFNOBh2cpZa5+fXsEsN0hisX3pSbRK
         PEXLNWl8e9y95OTZnalF/ryrinZFQK2Z3KfVzF+P4goGGVg+uoCP7pLPuIgP+jXB3l55
         DjpHEP+DAmkm511k6XIWLmJ9zCpcYkRIK1xypKEd29XG9qaLqedzAXxdCupYqCGO3G8d
         BBlVn4XPmlXKTmgDKZpiu1FK/Z1rB6lgootnq0m8fYyhu7DScSQptX2LHUGRBSbiGEJ0
         nglHLngMdcXIXu+4Y7G29nCS2E141fzRaB37dfxxBG7pd3k2GHoLbGoLWiB2w+Pq6ZXZ
         CmdA==
X-Gm-Message-State: ACgBeo28dGVNwI+NZVAVD45neAtNo5E+r8eCAK7xk0CGYC5C4Ch4lqgp
        3J5X0KmYoHQFr5d0NN41W9or14fRIXpK+irWZD2C
X-Google-Smtp-Source: AA6agR6pzEUW+mqZG3PaEOzTo4gvZqU1ZlYy278KgMLv1t2nzlQQ1rvsnPee+gs2iLrUggjzLXnEv01uqAxMVpnzfQg=
X-Received: by 2002:a05:6e02:20c2:b0:2f1:d171:8149 with SMTP id
 2-20020a056e0220c200b002f1d1718149mr4887812ilq.220.1662749531849; Fri, 09 Sep
 2022 11:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220908170133.1159747-1-abrestic@rivosinc.com> <20220908185006.1212126-1-abrestic@rivosinc.com>
In-Reply-To: <20220908185006.1212126-1-abrestic@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 9 Sep 2022 11:52:01 -0700
Message-ID: <CAOnJCULmjX9JScQOg4G16tYOeX=nMcvuJOpQM-eExERUb89uww@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Make mmap() with PROT_WRITE imply PROT_READ
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 11:50 AM Andrew Bresticker <abrestic@rivosinc.com> wrote:
>
> Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
> invalid") made mmap() return EINVAL if PROT_WRITE was set wihtout
> PROT_READ with the justification that a write-only PTE is considered a
> reserved PTE permission bit pattern in the privileged spec. This check
> is unnecessary since RISC-V defines its protection_map such that PROT_WRITE
> maps to the same PTE permissions as PROT_WRITE|PROT_READ, and it is
> inconsistent with other architectures that don't support write-only PTEs,
> creating a potential software portability issue. Just remove the check
> altogether and let PROT_WRITE imply PROT_READ as is the case on other
> architectures.
>
> Note that this also allows PROT_WRITE|PROT_EXEC mappings which were
> disallowed prior to the aforementioned commit; PROT_READ is implied in
> such mappings as well.
>
> Fixes: 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is invalid")
> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> ---
> v1 -> v2: Update access_error() to account for write-implies-read
> ---
>  arch/riscv/kernel/sys_riscv.c | 3 ---
>  arch/riscv/mm/fault.c         | 3 ++-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 571556bb9261..5d3f2fbeb33c 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -18,9 +18,6 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>         if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>                 return -EINVAL;
>
> -       if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> -               return -EINVAL;
> -
>         return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>                                offset >> (PAGE_SHIFT - page_shift_offset));
>  }
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index f2fbd1400b7c..d86f7cebd4a7 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -184,7 +184,8 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
>                 }
>                 break;
>         case EXC_LOAD_PAGE_FAULT:
> -               if (!(vma->vm_flags & VM_READ)) {
> +               /* Write implies read */
> +               if (!(vma->vm_flags & (VM_READ | VM_WRITE))) {
>                         return true;
>                 }
>                 break;

This should be a separate patch with commit text about VMA permissions.

> --
> 2.25.1
>

Otherwise, lgtm.

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
