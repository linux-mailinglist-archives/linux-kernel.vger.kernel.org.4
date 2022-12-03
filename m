Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8FF6413F1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 04:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiLCDIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 22:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLCDI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 22:08:29 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D677B1C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:08:27 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id jn7so6266949plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 19:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQ9Qp9+HUESamZgztegXLRYtfdkMT+u4+Qv2NAYZnOI=;
        b=1TnXWNaLs9L2SGmKWGvwVuLiAMISwdppdRsaXmjW8/Ifgbh65V+sFHT6jSK3efeV+H
         eAkycYUrU0kme/RNCuau7q9Ci5Us7JJ1AWI8s8MVztjY2o/tJeajIwTdSet+jtZwY9Vm
         27qH7wVQvSKSulitlpL2H/fsQXmsjro1Dgzgu06ngaBBTqQG+JfQGaOFooXmfEWvVB2z
         TTRrvCa//1z3sGNzyaJ/r9Q4bRbRawCaWaSOz1Fq7Z1VfTkNkHxoS4txIrJt78PG96Ja
         2UdKSMERnAzJPJzZrzUj1bN55ajKwGMRpb3VgoNu0+TLweom0fpPR7OY3HyrVzmjaTnH
         Y+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ9Qp9+HUESamZgztegXLRYtfdkMT+u4+Qv2NAYZnOI=;
        b=x4EU5AdbfjQXvMWsMgJNVqdzEWEMu/znXhGwNZcTnT/0zNS8ALNMG1Os7fWQMEB1rE
         2cvuXLeWyT25e63r6ZFEPemiuXTEWd/4HvBOVcBC840X0LdIqbkg6S4/Fmb90Tmfygrm
         WfZxUxyxFcZTIQ9+7VDdq+Ku2omcP0hq2PlmU9yHk/utBfRXQKb4WTZeyd0rMcWWPkTT
         TZEgJIIDdAXP+xCDzKF6NgPYpghX1VZJJlxYT6GlewFBbVHYqxOWD7w7SbiCFxwgfK4y
         +AbhPZRqMgPAZyPhg0b4D2mkWBQ+Y1nfKBHvreVyXeP0eTENv5GoGQdP3TKk7mjsJmjP
         s5Kw==
X-Gm-Message-State: ANoB5pmmevYgAQfNJWRtvMJdUp3NZzbbrW62FVNm9u+OQvrc0Q9067+0
        vureckoSJ17pWOezFOV+zXvxyw==
X-Google-Smtp-Source: AA0mqf7hfOIxl4dhjVVh92XpSOTYxffO3W5Xrb5h+3teV6aZE157757zhWFRQm/ssukejgOBV+eQhA==
X-Received: by 2002:a17:902:e949:b0:189:7a15:1336 with SMTP id b9-20020a170902e94900b001897a151336mr33837903pll.122.1670036906752;
        Fri, 02 Dec 2022 19:08:26 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id c194-20020a621ccb000000b0056d3b8f530csm5773033pfc.34.2022.12.02.19.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:08:26 -0800 (PST)
Date:   Fri, 02 Dec 2022 19:08:26 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 19:08:14 PST (-0800)
Subject:     Re: [PATCH -next v2] riscv/mm/fault: simplify code for do_page_fault()
In-Reply-To: <20221029084715.3669204-1-tongtiangen@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        tongtiangen@huawei.com, wangkefeng.wang@huawei.com,
        guohanjun@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tongtiangen@huawei.com
Message-ID: <mhng-8618b532-dfe2-48bf-a5ab-4247cf36d07e@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2022 01:47:15 PDT (-0700), tongtiangen@huawei.com wrote:
> To make the code more hierarchical and readable, we fold vma related
> judgments into __do_page_fault(). And to simplify the code, move the
> tsk->thread.bad_cause's setting into bad_area(). No functional change
> intended.
>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
> v1 -> v2:
>   Fixed incorrect use of macro VM_FAULT_BADMAP.
>
>  arch/riscv/mm/fault.c | 77 +++++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 36 deletions(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index d86f7cebd4a7..3fdc2eebdd36 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -85,6 +85,8 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
>
>  static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code, unsigned long addr)
>  {
> +	current->thread.bad_cause = regs->cause;
> +
>  	/*
>  	 * Something tried to access memory that isn't in our memory map.
>  	 * Fix it, but check if it's kernel or user first.
> @@ -200,6 +202,38 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
>  	return false;
>  }
>
> +#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
> +#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)

These alias with VM_FAULT_HINDEX_MASK.  I just sent along 
<https://lore.kernel.org/all/20221203030356.3917-1-palmer@rivosinc.com/T/#t> 
to clean that up for the other ports that also do so, I'm going to hold 
off on this patch until I see what the comments on that one look like.

Otherwise this looks fine, it might not make 6.2 pending the discussion 
over there.

Thanks!

> +
> +static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
> +				unsigned int mm_flags, struct pt_regs *regs)
> +{
> +	struct vm_area_struct *vma = find_vma(mm, addr);
> +
> +	if (unlikely(!vma))
> +		return VM_FAULT_BADMAP;
> +
> +	if (unlikely(vma->vm_start > addr)) {
> +		if (unlikely(!(vma->vm_flags & VM_GROWSDOWN) ||
> +				expand_stack(vma, addr)))
> +			return VM_FAULT_BADMAP;
> +	}
> +
> +	/*
> +	 * Ok, we have a good vm_area for this memory access, so
> +	 * we can handle it.
> +	 */
> +	if (unlikely(access_error(regs->cause, vma)))
> +		return VM_FAULT_BADACCESS;
> +
> +	/*
> +	 * If for any reason at all we could not handle the fault,
> +	 * make sure we exit gracefully rather than endlessly redo
> +	 * the fault.
> +	 */
> +	return handle_mm_fault(vma, addr, mm_flags, regs);
> +}
> +
>  /*
>   * This routine handles page faults.  It determines the address and the
>   * problem, and then passes it off to one of the appropriate routines.
> @@ -207,7 +241,6 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
>  asmlinkage void do_page_fault(struct pt_regs *regs)
>  {
>  	struct task_struct *tsk;
> -	struct vm_area_struct *vma;
>  	struct mm_struct *mm;
>  	unsigned long addr, cause;
>  	unsigned int flags = FAULT_FLAG_DEFAULT;
> @@ -280,44 +313,16 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  		flags |= FAULT_FLAG_INSTRUCTION;
>  retry:
>  	mmap_read_lock(mm);
> -	vma = find_vma(mm, addr);
> -	if (unlikely(!vma)) {
> -		tsk->thread.bad_cause = cause;
> -		bad_area(regs, mm, code, addr);
> -		return;
> -	}
> -	if (likely(vma->vm_start <= addr))
> -		goto good_area;
> -	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
> -		tsk->thread.bad_cause = cause;
> -		bad_area(regs, mm, code, addr);
> -		return;
> -	}
> -	if (unlikely(expand_stack(vma, addr))) {
> -		tsk->thread.bad_cause = cause;
> -		bad_area(regs, mm, code, addr);
> -		return;
> -	}
>
> -	/*
> -	 * Ok, we have a good vm_area for this memory access, so
> -	 * we can handle it.
> -	 */
> -good_area:
> -	code = SEGV_ACCERR;
> +	fault = __do_page_fault(mm, addr, flags, regs);
>
> -	if (unlikely(access_error(cause, vma))) {
> -		tsk->thread.bad_cause = cause;
> -		bad_area(regs, mm, code, addr);
> -		return;
> -	}
> +	if (unlikely(fault & VM_FAULT_BADMAP))
> +		return bad_area(regs, mm, code, addr);
>
> -	/*
> -	 * If for any reason at all we could not handle the fault,
> -	 * make sure we exit gracefully rather than endlessly redo
> -	 * the fault.
> -	 */
> -	fault = handle_mm_fault(vma, addr, flags, regs);
> +	if (unlikely(fault & VM_FAULT_BADACCESS)) {
> +		code = SEGV_ACCERR;
> +		return bad_area(regs, mm, code, addr);
> +	}
>
>  	/*
>  	 * If we need to retry but a fatal signal is pending, handle the
