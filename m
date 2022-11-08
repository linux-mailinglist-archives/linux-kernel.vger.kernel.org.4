Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371BA62163A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiKHOYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiKHOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:24:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FE85C778
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667917394; x=1699453394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SDqeLciWvzE6LO/FhpYnUJs3+XSv10TJPui7BgZgG80=;
  b=h92xIZcEKjAmD+6YxfD9ry62Z8KA5aXnZ6WoSW/B9jV7cPCoaaSW2XbV
   MAOqraJA6OH2Rag33jEzl90yxCJypobU5yWo0u8Hbft2x6j/vT2leNmg8
   9pZj3f4LgTlrXZO5BRhvHx9DW1oW0UUz9xoKCAo6l0RsNdHzpO/zEBfGo
   yqm0cE7tBGfdhiO3M7AGPLVLGvInDMEfPdZmmcOZmYfJBYDGUuVY6buEs
   LGB+s1oqvxhhDK4zlqoN30YnUj6x4HzL+3kZjZfYt41cRGwPi5VYQr60h
   hNLef16qkvoXF7n+OnHzrAh2MnZtb8JIjmBxQmiRl1DXJZcDJ1EDBaEB1
   A==;
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="185920740"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Nov 2022 07:23:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 8 Nov 2022 07:23:03 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 8 Nov 2022 07:23:01 -0700
Date:   Tue, 8 Nov 2022 14:22:45 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <guoren@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <guoren@kernel.org>,
        <anup@brainfault.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH RESEND] riscv: asid: Fixup stale TLB entry cause
 application crash
Message-ID: <Y2pmNUBocENfS4uK@wendy>
References: <20221108102044.3317793-1-guoren@kernel.org>
 <D91557B5-7E60-4A29-8669-34FF42454F8C@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <D91557B5-7E60-4A29-8669-34FF42454F8C@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 10:27:51AM +0000, Conor Dooley wrote:
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
> > 	 */
> > 	cpu = smp_processor_id();
> > 
> >-	cpumask_clear_cpu(cpu, mm_cpumask(prev));
> >+	if (!static_branch_unlikely(&use_asid_allocator))
> >+		cpumask_clear_cpu(cpu, mm_cpumask(prev));
> >+
> > 	cpumask_set_cpu(cpu, mm_cpumask(next));
> > 
> > 	set_mm(next, cpu);
> 
> This is a completely different patch to what you already sent.
> Why have you marked it RESEND rather than v2?

In addition, it seems to break the build for the nommu defconfigs.
