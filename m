Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A33622379
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 06:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiKIFlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 00:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKIFlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 00:41:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CAB1AD9C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 21:41:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60B656188F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFE4C433D6;
        Wed,  9 Nov 2022 05:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667972468;
        bh=NcYwem+RG7CdaZySwWGMcxlQ4IDXuYGi+05zOMk3sqU=;
        h=From:To:Cc:Subject:Date:From;
        b=A6Aw7vrV1Qw79HjJWSBXybgU6SvB/JtjMlUsZDpNHtY2LEdXNSvGuJLFtGYcHGhEc
         aC3iMHT0hGIFvCiuBfXC9IkSOz8qFt93aDlipKpAM7d66Ly9Tx+3YlbcgZgmSYVmXw
         bp0M4sKs68iWYMdt6nRy9Y+7ffGBggcwDA/eqKNzTX1n5u9htXGntKqR8BxnCZ7TFx
         /eXUZwdqqzEXY0uwdZd0g004hvGz34Z6sHwIUmbQUINoITLqWHZqfFxLvDnwOwe2z/
         /2RC24tKCtWD0jizM/3zT3YMU1oC1uE00dAqSEjtUkisUc3t1sw3Tg84vupN8VMloy
         h+uxN54KsUmhw==
From:   guoren@kernel.org
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Guo Ren <guoren@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH V2] riscv: asid: Fixup stale TLB entry cause application crash
Date:   Wed,  9 Nov 2022 00:40:56 -0500
Message-Id: <20221109054056.3618089-1-guoren@kernel.org>
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

After use_asid_allocator is enabled, the userspace application will
crash by stale TLB entries. Because only using cpumask_clear_cpu without
local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
Then set_mm_asid would cause the user space application to get a stale
value by stale TLB entry, but set_mm_noasid is okay.

Here is the symptom of the bug:
unhandled signal 11 code 0x1 (coredump)
   0x0000003fd6d22524 <+4>:     auipc   s0,0x70
   0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
=> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
(gdb) i r s0
s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
(gdb) x /2x 0x3fd6d92490
0x3fd6d92490:   0xd80ac8a8      0x0000003f
The core dump file shows that register s0 is wrong, but the value in
memory is correct. Because 'ld s0, -148(s0)' used a stale mapping entry
in TLB and got a wrong result from an incorrect physical address.

When the task ran on CPU0, which loaded/speculative-loaded the value of
address(0x3fd6d92490), then the first version of the mapping entry was
PTWed into CPU0's TLB.
When the task switched from CPU0 to CPU1 (No local_tlb_flush_all here by
asid), it happened to write a value on the address (0x3fd6d92490). It
caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
ptep_get_and_clear & flush_tlb_page.
The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need TLB
flush, but CPU0 had cleared the CPU0's mm_cpumask in the previous
switch_mm. So we only flushed the CPU1 TLB and set the second version
mapping of the PTE. When the task switched from CPU1 to CPU0 again, CPU0
still used a stale TLB mapping entry which contained a wrong target
physical address. It raised a bug when the task happened to read that
value.

The solution is to keep all CPUs' footmarks of cpumask(mm) in switch_mm,
which could prevent losing pieces of stuff during TLB flush.

Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
Changes in v2:
 - Fixup nommu compile problem (Thx Conor, Also Reported-by: kernel
   test robot <lkp@intel.com>)
 - Keep cpumask_clear_cpu for noasid
---
 arch/riscv/mm/context.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 7acbfbd14557..f58e4b211595 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -317,7 +317,11 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 */
 	cpu = smp_processor_id();
 
-	cpumask_clear_cpu(cpu, mm_cpumask(prev));
+#ifdef CONFIG_MMU
+	if (!static_branch_unlikely(&use_asid_allocator))
+#endif
+		cpumask_clear_cpu(cpu, mm_cpumask(prev));
+
 	cpumask_set_cpu(cpu, mm_cpumask(next));
 
 	set_mm(next, cpu);
-- 
2.36.1

