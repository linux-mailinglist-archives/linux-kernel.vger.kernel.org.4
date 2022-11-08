Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894B0620C21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiKHJZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiKHJZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:25:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0CF27DD1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:25:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF6E3B819B9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69730C43470
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667899537;
        bh=hwz50AYBkBCjPYIHa+6/89SwfK+btdFhDyOrJaSPMks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cpsdMAw4FoYr2AbgkYaLVZKhe5kQPFZNj6K6FhZV/ozTFhYBSE1JHU9OnYrATW/7S
         D1dLSBW6GItXSsgxkJEZQ8JEAZ/HeW+pJVFoeFeNy7QqqoPJKxcUCc3rJf/M9URAfm
         d8kcLL/RANglsnILwIk9c1WYY+CAN6dHV2vJJ6YQFCnUne01Qae9Y4B7BQTsNXWvnv
         vSd8yS8PBb6e7buHSxg0v4cVEAZAT5IVKVUEIerT8Uk0naBnD+YyArGdw32wL4Atjs
         NjNjtUFJapYQzXB07r9FswS0pLZZ8rdTZaw/tbnMJ4X7sBaNg5A7pDaf1GKKvEKtnI
         pNFk1pD1MhA7g==
Received: by mail-oi1-f172.google.com with SMTP id n205so3844403oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 01:25:37 -0800 (PST)
X-Gm-Message-State: ACrzQf11lUH3HchaP/nyDaW+4JRc4uBq8XRO3urOxNQ7H/rN/0drgmla
        LOB2nQfpouADOTP2S5k289TJB7BnzHTt6usbbeo=
X-Google-Smtp-Source: AMsMyM5LOvXRipq+RzM0Ku0ZPbzZmM1dSyqTGf4kLWGahPuyMBWgEsiOsBq8I1x98is6irZ0nzPBAUA/gA+/4LSap+U=
X-Received: by 2002:a05:6808:f0f:b0:35a:7892:a7f3 with SMTP id
 m15-20020a0568080f0f00b0035a7892a7f3mr8124472oiw.112.1667899536512; Tue, 08
 Nov 2022 01:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20221108090219.3285030-1-guoren@kernel.org>
In-Reply-To: <20221108090219.3285030-1-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 8 Nov 2022 17:25:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQpA_PMKmRshuPa9PT_SuLXwS4nVJbZA07vOtOtztbhDQ@mail.gmail.com>
Message-ID: <CAJF2gTQpA_PMKmRshuPa9PT_SuLXwS4nVJbZA07vOtOtztbhDQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: asid: Fixup stale TLB entry cause application crash
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        alexandre.ghiti@canonical.com, conor.dooley@microchip.com,
        heiko@sntech.de, philipp.tomsich@vrull.eu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 5:02 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When use_asid_allocator is enabled, the userspace application would
> crash by stale tlb entry. Because only using cpumask_clear_cpu without
> local_flush_tlb_all couldn't guarantee CPU's tlb contains fresh mapping
> entry. Then set_mm_asid would cause user space application get a stale
> value by stale tlb entry, but set_mm_noasid is okay.
>
> Here is the symptom of the bug:
> unhandled signal 11 code 0x1 (coredump)
>    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
>    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> => 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> (gdb) i r s0
> s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> (gdb) x/16 0x3fd6d92490
> 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> The core dump file show us the value of register s0 is wrong, but the
> value in memory is right.
>
> When task run on CPU0, the task loaded/speculative-loaded the value of
> address-0x3fd6d92490, the first version tlb mapping enter in CPU0's tlb.
> When the task switched from CPU0 to CPU1 without local_tlb_flush_all
> (because of asid), the task happened to write a value on address:
> 0x3fd6d92490 that caused do_page_fault -> wp_page_copy ->
> ptep_clear_flush -> ptep_get_and_clear & flush_tlb_page.
> The flush_tlb_page would use mm_cpumask(mm) to determine which CPUs need
> tlb flush, but CPU0 cleared the CPU0's mm_cpumask in previous switch_mm.
> So we only flushed the CPU1's tlb entry, and setted second version mapping
> of the pte. When the task switch from CPU1 to CPU0 again, it still used a
> stale tlb entry on CPU0 which contained a wrong target physical address.
> When the task happened to read that value, the bug would be raised.
>
> Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/riscv/mm/context.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..843e86b63532 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -317,7 +317,6 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>          */
>         cpu = smp_processor_id();
>
> -       cpumask_clear_cpu(cpu, mm_cpumask(prev));
It should be:

-       cpumask_clear_cpu(cpu, mm_cpumask(prev));
+       if (static_branch_unlikely(&use_asid_allocator))
+               cpumask_clear_cpu(cpu, mm_cpumask(prev));
+

No bug on noasid part.

>         cpumask_set_cpu(cpu, mm_cpumask(next));
>
>         set_mm(next, cpu);
> --
> 2.36.1
>


-- 
Best Regards
 Guo Ren
