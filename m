Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596BA620D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiKHKU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKHKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:20:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47834BC1E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:20:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF16C614E6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60360C433D6;
        Tue,  8 Nov 2022 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667902854;
        bh=F/nbJavY2ngyv2qilaghZTRYq7104XTI4SbSBrKfj6A=;
        h=From:To:Cc:Subject:Date:From;
        b=Vv2jY7ePU9EU+XlBjjUeNuBt5yQSJOzSP/YPK7SREsFQis+UviJOQbecC/xfk84/C
         SDNd3+tEafVEd3BNGlCAmLsS/URxu1YJPSeBz5qNio0yggJDeLt4enGuXQammItIy5
         p3cBEbPhi10OXvzBJJNeMvhTJHmNQ5dXaTGpQrlswdxaoGurbudiCiFO0f5g96x1Dp
         +susVOPCtC5aqyFbVA57huKXFTJ1YuwPZzcvbZQJpLJxzz8mgrZzkz5pMWQPrNngEN
         wL3RcyDHpMNCrK5WX8whHqCRVS1BE69i41nKqBWZlf9UNo1u9WR20SMUowOq9IR8P/
         366T4Qs0iYubw==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH RESEND] riscv: asid: Fixup stale TLB entry cause application crash
Date:   Tue,  8 Nov 2022 05:20:44 -0500
Message-Id: <20221108102044.3317793-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

After use_asid_allocator enabled, the userspace application will
crash for stale tlb entry. Because only using cpumask_clear_cpu without
local_flush_tlb_all couldn't guarantee CPU's tlb entries fresh. Then
set_mm_asid would cause user space application get a stale value by
the stale tlb entry, but set_mm_noasid is okay.

Here is the symptom of the bug:
unhandled signal 11 code 0x1 (coredump)
   0x0000003fd6d22524 <+4>:     auipc   s0,0x70
   0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
=> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
(gdb) i r s0
s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
(gdb) x/16 0x3fd6d92490
0x3fd6d92490:   0xd80ac8a8      0x0000003f
The core dump file shows that the value of register s0 is wrong, but the
value in memory is right. This is because 'ld s0, -148(s0)' use a stale
mapping entry in TLB and got a wrong value from a stale physical
address.

When task run on CPU0, the task loaded/speculative-loaded the value of
address(0x3fd6d92490), and the first version of tlb mapping entry was
PTWed into CPU0's tlb.
When the task switched from CPU0 to CPU1 without local_tlb_flush_all
(because of asid), the task happened to write a value on address
(0x3fd6d92490). It caused do_page_fault -> wp_page_copy ->
ptep_clear_flush -> ptep_get_and_clear & flush_tlb_page.
The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need
tlb flush, but CPU0 had cleared the CPU0's mm_cpumask in previous switch_mm.
So we only flushed the CPU1 tlb, and setted second version mapping
of the pte. When the task switch from CPU1 to CPU0 again, CPU0 still used a
stale tlb mapping entry which contained a wrong target physical address.
When the task happened to read that value, the bug would be raised.

Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/context.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 7acbfbd14557..8ad6c2493e93 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -317,7 +317,9 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 */
 	cpu = smp_processor_id();
 
-	cpumask_clear_cpu(cpu, mm_cpumask(prev));
+	if (!static_branch_unlikely(&use_asid_allocator))
+		cpumask_clear_cpu(cpu, mm_cpumask(prev));
+
 	cpumask_set_cpu(cpu, mm_cpumask(next));
 
 	set_mm(next, cpu);
-- 
2.36.1

