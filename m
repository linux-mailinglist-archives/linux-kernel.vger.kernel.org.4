Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9931F6220D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKIAaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIAad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:30:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE01EC74
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 16:30:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C080B81CC8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC1EC43142
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667953829;
        bh=4U+Q54//+8Mboh9W6Q6zPTJ7xO2e6TEWWaIKq4egqf4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T6pifDpyDY9W/BL+dD3rbswhsVaUX1R6D4bPDtYnqoxioAPUe7Z2yIdJDv2C7CNR7
         gey6571QstRyfw90KQzYoYezE74GTPls3RGqcoywjIbI5f48IPuuQ1pTosN/MmAPMt
         30CTxEwePs9oFrGruIfhBKbfiNrkur/4Sx/6kzu6GQAUNRJNrlc1uI6LmwH0+EANLz
         pSF5R4hx23vPDyZi+SHAddMr/9tOPmkqbj32I+T6Tl/ZWZRqk1TPaQgVBvuc4WhDk/
         AbZPllCfx7wBtFoxk11XVrRx9Kd6mccHTtJIoTNjZSqhxWKKy+QavRPbBE/PvfNG8K
         7HPJGlGO+1YcA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso17325799fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 16:30:29 -0800 (PST)
X-Gm-Message-State: ACrzQf2cm83geYsCK8W2tQfq2LRzH1zSRjmYoIcd0QWFOlMJWJ5U5PPh
        /OiPq8sGPvdovQbsDxbKyA/4fEDz3GGxfdUJsFw=
X-Google-Smtp-Source: AMsMyM7btQd6y9sjJLT3OMXScXk6Ha1OX/HDrYukpNuUGedjdtK2GUIWsEZeVzi5C653Sx06j60ACuEbVm8AbMRyJNA=
X-Received: by 2002:a05:6870:64a1:b0:13c:d09d:79f9 with SMTP id
 cz33-20020a05687064a100b0013cd09d79f9mr32769397oab.112.1667953828298; Tue, 08
 Nov 2022 16:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20221108102044.3317793-1-guoren@kernel.org> <D91557B5-7E60-4A29-8669-34FF42454F8C@kernel.org>
In-Reply-To: <D91557B5-7E60-4A29-8669-34FF42454F8C@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Nov 2022 08:30:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRKtWPP18kmU+50npg4h33-Hr3aUUQKcyx416jTvMUWzw@mail.gmail.com>
Message-ID: <CAJF2gTRKtWPP18kmU+50npg4h33-Hr3aUUQKcyx416jTvMUWzw@mail.gmail.com>
Subject: Re: [PATCH RESEND] riscv: asid: Fixup stale TLB entry cause
 application crash
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, linux-kernel@vger.kernel.org,
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

On Tue, Nov 8, 2022 at 6:27 PM Conor Dooley <conor@kernel.org> wrote:
>
>
>
> On 8 November 2022 10:20:44 GMT, guoren@kernel.org wrote:
> >From: Guo Ren <guoren@linux.alibaba.com>
> >
> >After use_asid_allocator enabled, the userspace application will
> >crash for stale tlb entry. Because only using cpumask_clear_cpu without
> >local_flush_tlb_all couldn't guarantee CPU's tlb entries fresh. Then
> >set_mm_asid would cause user space application get a stale value by
> >the stale tlb entry, but set_mm_noasid is okay.
> >
> >Here is the symptom of the bug:
> >unhandled signal 11 code 0x1 (coredump)
> >   0x0000003fd6d22524 <+4>:     auipc   s0,0x70
> >   0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> >=> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> >(gdb) i r s0
> >s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> >(gdb) x/16 0x3fd6d92490
> >0x3fd6d92490:   0xd80ac8a8      0x0000003f
> >The core dump file shows that the value of register s0 is wrong, but the
> >value in memory is right. This is because 'ld s0, -148(s0)' use a stale
> >mapping entry in TLB and got a wrong value from a stale physical
> >address.
> >
> >When task run on CPU0, the task loaded/speculative-loaded the value of
> >address(0x3fd6d92490), and the first version of tlb mapping entry was
> >PTWed into CPU0's tlb.
> >When the task switched from CPU0 to CPU1 without local_tlb_flush_all
> >(because of asid), the task happened to write a value on address
> >(0x3fd6d92490). It caused do_page_fault -> wp_page_copy ->
> >ptep_clear_flush -> ptep_get_and_clear & flush_tlb_page.
> >The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need
> >tlb flush, but CPU0 had cleared the CPU0's mm_cpumask in previous switch_mm.
> >So we only flushed the CPU1 tlb, and setted second version mapping
> >of the pte. When the task switch from CPU1 to CPU0 again, CPU0 still used a
> >stale tlb mapping entry which contained a wrong target physical address.
> >When the task happened to read that value, the bug would be raised.
> >
> >Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> >Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >Signed-off-by: Guo Ren <guoren@kernel.org>
> >Cc: Anup Patel <apatel@ventanamicro.com>
> >Cc: Palmer Dabbelt <palmer@rivosinc.com>
> >---
> > arch/riscv/mm/context.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> >index 7acbfbd14557..8ad6c2493e93 100644
> >--- a/arch/riscv/mm/context.c
> >+++ b/arch/riscv/mm/context.c
> >@@ -317,7 +317,9 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >        */
> >       cpu = smp_processor_id();
> >
> >-      cpumask_clear_cpu(cpu, mm_cpumask(prev));
> >+      if (!static_branch_unlikely(&use_asid_allocator))
> >+              cpumask_clear_cpu(cpu, mm_cpumask(prev));
> >+
> >       cpumask_set_cpu(cpu, mm_cpumask(next));
> >
> >       set_mm(next, cpu);
>
> This is a completely different patch to what you already sent. Why have you marked it RESEND rather than v2?
Okay, I should send v2.



-- 
Best Regards
 Guo Ren
