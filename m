Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1FA620BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiKHJCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiKHJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:02:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF4013D2B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:02:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF49AB819BA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E7C433C1;
        Tue,  8 Nov 2022 09:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667898147;
        bh=40as9zy58r8i/rJfR7Z6TRRJsKNmmDmW8cmLv1ORktE=;
        h=From:To:Cc:Subject:Date:From;
        b=pkfJDph7m26p588lRvKtcu20kjCZlELls26LoNAh2HMA5oPn4okhu+02A9B5HV3wA
         B6jM2Tx5CPm9N/P5lhalCJiQt42kptl2J5hRuWT6HjMUqjW08sO3Em22n0jZyCU3gJ
         3y9HFKaL+e090LM91K1PI1j8enY9F0ucXaXMlQ25o6WheVnYeHLtcWhY9C7SyVvLV3
         T5jrQqwTCPLZXTF3Ul4a7NHJKrq3Wu5wN/ILrFsxine91hKQh6vZkmLS5IKP41nWYk
         0BcrifcoSpgRNaQ4cHm2cr3ey405LJ8I60X1f5QlJcKSat60uEUcgeT/9qfz17kjmd
         95rwf8jqrAZfA==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        alexandre.ghiti@canonical.com, conor.dooley@microchip.com,
        heiko@sntech.de, philipp.tomsich@vrull.eu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH] riscv: asid: Fixup stale TLB entry cause application crash
Date:   Tue,  8 Nov 2022 04:02:19 -0500
Message-Id: <20221108090219.3285030-1-guoren@kernel.org>
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

When use_asid_allocator is enabled, the userspace application would
crash by stale tlb entry. Because only using cpumask_clear_cpu without
local_flush_tlb_all couldn't guarantee CPU's tlb contains fresh mapping
entry. Then set_mm_asid would cause user space application get a stale
value by stale tlb entry, but set_mm_noasid is okay.

Here is the symptom of the bug:
unhandled signal 11 code 0x1 (coredump)
   0x0000003fd6d22524 <+4>:     auipc   s0,0x70
   0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
=> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
(gdb) i r s0
s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
(gdb) x/16 0x3fd6d92490
0x3fd6d92490:   0xd80ac8a8      0x0000003f
The core dump file show us the value of register s0 is wrong, but the
value in memory is right.

When task run on CPU0, the task loaded/speculative-loaded the value of
address-0x3fd6d92490, the first version tlb mapping enter in CPU0's tlb.
When the task switched from CPU0 to CPU1 without local_tlb_flush_all
(because of asid), the task happened to write a value on address:
0x3fd6d92490 that caused do_page_fault -> wp_page_copy ->
ptep_clear_flush -> ptep_get_and_clear & flush_tlb_page.
The flush_tlb_page would use mm_cpumask(mm) to determine which CPUs need
tlb flush, but CPU0 cleared the CPU0's mm_cpumask in previous switch_mm.
So we only flushed the CPU1's tlb entry, and setted second version mapping
of the pte. When the task switch from CPU1 to CPU0 again, it still used a
stale tlb entry on CPU0 which contained a wrong target physical address.
When the task happened to read that value, the bug would be raised.

Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 7acbfbd14557..843e86b63532 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -317,7 +317,6 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 */
 	cpu = smp_processor_id();
 
-	cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	cpumask_set_cpu(cpu, mm_cpumask(next));
 
 	set_mm(next, cpu);
-- 
2.36.1

