Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EB96220D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKIAbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIAbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:31:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA056175D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 16:31:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC7661800
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E69DC43142
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667953860;
        bh=xd/O2mH6veguQD1GJ01IVz86tNpLc2HbY3EB+jSy0TE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZfdxaE1XrHI6q95W/7EhwwKdhaVbhNo7LoAkdz6PGh7bGEoNbL6vxDvxUqjujlTUP
         El85H4I2gs7K4XPWc0r7fPaVIWcWQOfuLirIH61QZd1fbh4/aogsjdtVK7Z1JQO60c
         qQ8jTu/TcobCDLzKjjIT6A0zCSLEDaphgoZ9PAAJnI5YwgXdADmi2GSwq8+wet44e/
         kFUkQO3zRj1Xrmf7f8HvxdR/ExuGGnZuIlYTZREr24oFfZ75/0hqVX0TokpJ3wSwp3
         x9ROUr//N9lb9YBaddkXSxhNQBJ50RyNzTYEtkqHZUr8BFeBf9qcNhSkqHBuBcJ4AU
         0ToYOcpnh9eCg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-13b103a3e5dso18112276fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 16:31:00 -0800 (PST)
X-Gm-Message-State: ACrzQf1zNt4IPfTIZM+1xj0ErprEe4lUpi1AenhK+ZYQRv+0uJC7cut+
        iUaFKZgRWK/W2ncq1uVb/EBQSWMlYILR4/v0FD0=
X-Google-Smtp-Source: AMsMyM4oPoZj7R74b9VIzROExjmUtHt+v4aXcnQhUub4txSApKVJ2UpDlqQT2Y9voCeuBc7okpQfZmc8Mc6/4idA4mU=
X-Received: by 2002:a05:6870:64a1:b0:13c:d09d:79f9 with SMTP id
 cz33-20020a05687064a100b0013cd09d79f9mr32770652oab.112.1667953859771; Tue, 08
 Nov 2022 16:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20221108102044.3317793-1-guoren@kernel.org> <D91557B5-7E60-4A29-8669-34FF42454F8C@kernel.org>
 <Y2pmNUBocENfS4uK@wendy>
In-Reply-To: <Y2pmNUBocENfS4uK@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Nov 2022 08:30:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSFPRAKdsKKvE2yiKmQmFD+TN3_k1G3QjHKeRXwqwWa6w@mail.gmail.com>
Message-ID: <CAJF2gTSFPRAKdsKKvE2yiKmQmFD+TN3_k1G3QjHKeRXwqwWa6w@mail.gmail.com>
Subject: Re: [PATCH RESEND] riscv: asid: Fixup stale TLB entry cause
 application crash
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, heiko@sntech.de,
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

Yes, thx for pointing that out.

On Tue, Nov 8, 2022 at 10:23 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Tue, Nov 08, 2022 at 10:27:51AM +0000, Conor Dooley wrote:
> >
> >
> > On 8 November 2022 10:20:44 GMT, guoren@kernel.org wrote:
> > >From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > >After use_asid_allocator enabled, the userspace application will
> > >crash for stale tlb entry. Because only using cpumask_clear_cpu without
> > >local_flush_tlb_all couldn't guarantee CPU's tlb entries fresh. Then
> > >set_mm_asid would cause user space application get a stale value by
> > >the stale tlb entry, but set_mm_noasid is okay.
> > >
> > >Here is the symptom of the bug:
> > >unhandled signal 11 code 0x1 (coredump)
> > >   0x0000003fd6d22524 <+4>:     auipc   s0,0x70
> > >   0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> > >=> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> > >(gdb) i r s0
> > >s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> > >(gdb) x/16 0x3fd6d92490
> > >0x3fd6d92490:   0xd80ac8a8      0x0000003f
> > >The core dump file shows that the value of register s0 is wrong, but the
> > >value in memory is right. This is because 'ld s0, -148(s0)' use a stale
> > >mapping entry in TLB and got a wrong value from a stale physical
> > >address.
> > >
> > >When task run on CPU0, the task loaded/speculative-loaded the value of
> > >address(0x3fd6d92490), and the first version of tlb mapping entry was
> > >PTWed into CPU0's tlb.
> > >When the task switched from CPU0 to CPU1 without local_tlb_flush_all
> > >(because of asid), the task happened to write a value on address
> > >(0x3fd6d92490). It caused do_page_fault -> wp_page_copy ->
> > >ptep_clear_flush -> ptep_get_and_clear & flush_tlb_page.
> > >The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need
> > >tlb flush, but CPU0 had cleared the CPU0's mm_cpumask in previous switch_mm.
> > >So we only flushed the CPU1 tlb, and setted second version mapping
> > >of the pte. When the task switch from CPU1 to CPU0 again, CPU0 still used a
> > >stale tlb mapping entry which contained a wrong target physical address.
> > >When the task happened to read that value, the bug would be raised.
> > >
> > >Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> > >Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > >Signed-off-by: Guo Ren <guoren@kernel.org>
> > >Cc: Anup Patel <apatel@ventanamicro.com>
> > >Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > >---
> > > arch/riscv/mm/context.c | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > >diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > >index 7acbfbd14557..8ad6c2493e93 100644
> > >--- a/arch/riscv/mm/context.c
> > >+++ b/arch/riscv/mm/context.c
> > >@@ -317,7 +317,9 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> > >      */
> > >     cpu = smp_processor_id();
> > >
> > >-    cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > >+    if (!static_branch_unlikely(&use_asid_allocator))
> > >+            cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > >+
> > >     cpumask_set_cpu(cpu, mm_cpumask(next));
> > >
> > >     set_mm(next, cpu);
> >
> > This is a completely different patch to what you already sent.
> > Why have you marked it RESEND rather than v2?
>
> In addition, it seems to break the build for the nommu defconfigs.



-- 
Best Regards
 Guo Ren
