Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ECA72FFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbjFNNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjFNNZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:25:54 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A971D1980
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686749146;
        bh=fXwHkUmx1HmK4V5IxIkkFQGLk2Gvfoe3n2Hd3Qi5cWg=;
        h=From:To:Cc:Subject:Date;
        b=XbUvvHyEBVG9Sq1y6cV1O6+244RPARrmVyaySgtzCzc+VpvdJhKMFzaRhPaPo7+v8
         eoe597VpV0TbB/ophqBpYvBMUnPlSID3z5Udh3ajbtmc8NuZ/l2p07t88i7NunsLRA
         AumRR14qo6CBnUCu/2jvFkCwv8ToRaSxLbl3O87k=
Received: from localhost ([101.224.149.128])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 4E78406A; Wed, 14 Jun 2023 21:19:39 +0800
X-QQ-mid: xmsmtpt1686748779t9wp6qxru
Message-ID: <tencent_FBB94CE615C5CCE7701CD39C15CCE0EE9706@qq.com>
X-QQ-XMAILINFO: MNQ2FIpgVwZb6RJ8t41sGPm9Tx/DnC468oSMXaRkV3kaHxeUZ48LYbUCe/uFhG
         0cKfVQ8/xSe8OhBkUTIhpCB7YxVmLjqgd3MeX3a0wVXSbO0Ka8JuRGQJlgBfVFhPSPLw9Zr58qYi
         MaI0C1rHyxyeb+HCmqy5H11TpcOhNarUGIthBettkRtNOyrxGcMlf8J5tIu2ds4YlPMFuqq7tFGN
         fhtMG8MnV7RxFONYA2+LGJjjnKLr6N/moVEBZltwOIBbDwkFe+c0PV7vrLJR2KFq+VFuwmz0zPHs
         bkPk9MU3XXCPXlekuTNJG9fFthqM4OlQNJyw5CfhkibtwQ1aTWXMC1PN+ouEu6kDM3PLOsZX7Fm7
         6YsTdwOtv3cvdi9lqZnUdcv05HKOkT9nzqkCSh+HLQDzP4poVlXSAjDJ4pvwzLYZslx+0R/XICWR
         os0GwFq6QU7hSaCWRvOqEXE0Qby2rQ1Pskd7stXPF1sJpB1aNbVWU4Jjd0/ZbAtAFAvrjkW8o9hK
         esrE1iOMqs5e+BpxyN24+HOhx6bWPS++qKhDUE/KCVfbb7lctP5WikvknNq7j85dwfVhFkwSS/oX
         oHi2cwN5ihbokLzSYBDSTRhueVywshKRpDrLIjmtEeq/k++6DmzWdf/QUlmj1kxEXOkJZbl2qfiW
         fuFyfukB/I5EwthD7uY/bqvueZ3dhUiLNmZLA648vifBKH5sXvBjj19kzh0TesIHBcJ1PQjMy+W1
         tj0SpmczdGh75477m2WWmwguXci1n7MYRFLJ2YlAVc4zOq8rtlO7IYCH7ewnikrb6nf3kmtwfSvP
         RfIvVyAHqi+6erpjxkhThCq9ZgyyQbNj1m3HDO+vT3rRfeLO7cCK34Jiu4jXCQBctvqjTlvm4LxZ
         aUXkBq5AnucCWbopgl9TZHeqenzymx0wRkPDzGp0q/C2g4UhPZf1dz8I1lsNgiM0bpJ1x+0ZMFVt
         4Z42Vt+58JGeDDMn+6r1JbXMVnONITyOKTaAtAcni0hjMScB7ZjQ==
X-QQ-XMAILREADINFO: NBwrrjlpHXpInKmvoY9CzUo=
From:   Woody Zhang <woodylab@foxmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Woody Zhang <woodylab@foxmail.com>
Subject: [PATCH v3] riscv: move memblock_allow_resize() after linear mapping is ready
Date:   Wed, 14 Jun 2023 21:19:07 +0800
X-OQ-MSGID: <20230614131906.2303856-1-woodylab@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial memblock metadata is accessed from kernel image mapping. The
regions arrays need to "reallocated" from memblock and accessed through
linear mapping to cover more memblock regions. So the resizing should
not be allowed until linear mapping is ready. Note that there are
memblock allocations when building linear mapping.

This patch is similar to 24cc61d8cb5a ("arm64: memblock: don't permit
memblock resizing until linear mapping is up").

In following log, many memblock regions are reserved before
create_linear_mapping_page_table(). And then it triggered reallocation
of memblock.reserved.regions and memcpy the old array in kernel image
mapping to the new array in linear mapping which caused a page fault.

[    0.000000] memblock_reserve: [0x00000000bf01f000-0x00000000bf01ffff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf021000-0x00000000bf021fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf023000-0x00000000bf023fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf025000-0x00000000bf025fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf027000-0x00000000bf027fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf029000-0x00000000bf029fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf02b000-0x00000000bf02bfff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf02d000-0x00000000bf02dfff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf02f000-0x00000000bf02ffff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] memblock_reserve: [0x00000000bf030000-0x00000000bf030fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
[    0.000000] OF: reserved mem: 0x0000000080000000..0x000000008007ffff (512 KiB) map non-reusable mmode_resv0@80000000
[    0.000000] memblock_reserve: [0x00000000bf000000-0x00000000bf001fed] paging_init+0x19a/0x5ae
[    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
[    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
[    0.000000] memblock: reserved is doubled to 256 at [0x000000017fffd000-0x000000017fffe7ff]
[    0.000000] Unable to handle kernel paging request at virtual address ff600000ffffd000
[    0.000000] Oops [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc1-00011-g99a670b2069c #66
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] epc : __memcpy+0x60/0xf8
[    0.000000]  ra : memblock_double_array+0x192/0x248
[    0.000000] epc : ffffffff8081d214 ra : ffffffff80a3dfc0 sp : ffffffff81403bd0
[    0.000000]  gp : ffffffff814fbb38 tp : ffffffff8140dac0 t0 : 0000000001600000
[    0.000000]  t1 : 0000000000000000 t2 : 000000008f001000 s0 : ffffffff81403c60
[    0.000000]  s1 : ffffffff80c0bc98 a0 : ff600000ffffd000 a1 : ffffffff80c0bcd8
[    0.000000]  a2 : 0000000000000c00 a3 : ffffffff80c0c8d8 a4 : 0000000080000000
[    0.000000]  a5 : 0000000000080000 a6 : 0000000000000000 a7 : 0000000080200000
[    0.000000]  s2 : ff600000ffffd000 s3 : 0000000000002000 s4 : 0000000000000c00
[    0.000000]  s5 : ffffffff80c0bc60 s6 : ffffffff80c0bcc8 s7 : 0000000000000000
[    0.000000]  s8 : ffffffff814fd0a8 s9 : 000000017fffe7ff s10: 0000000000000000
[    0.000000]  s11: 0000000000001000 t3 : 0000000000001000 t4 : 0000000000000000
[    0.000000]  t5 : 000000008f003000 t6 : ff600000ffffd000
[    0.000000] status: 0000000200000100 badaddr: ff600000ffffd000 cause: 000000000000000f
[    0.000000] [<ffffffff8081d214>] __memcpy+0x60/0xf8
[    0.000000] [<ffffffff80a3e1a2>] memblock_add_range.isra.14+0x12c/0x162
[    0.000000] [<ffffffff80a3e36a>] memblock_reserve+0x6e/0x8c
[    0.000000] [<ffffffff80a123fc>] memblock_alloc_range_nid+0xb8/0x128
[    0.000000] [<ffffffff80a1256a>] memblock_phys_alloc_range+0x5e/0x6a
[    0.000000] [<ffffffff80a04732>] alloc_pmd_fixmap+0x14/0x1c
[    0.000000] [<ffffffff80a0475a>] alloc_p4d_fixmap+0xc/0x14
[    0.000000] [<ffffffff80a04a36>] create_pgd_mapping+0x98/0x17c
[    0.000000] [<ffffffff80a04e9e>] create_linear_mapping_range.constprop.10+0xe4/0x112
[    0.000000] [<ffffffff80a05bb8>] paging_init+0x3ec/0x5ae
[    0.000000] [<ffffffff80a03354>] setup_arch+0xb2/0x576
[    0.000000] [<ffffffff80a00726>] start_kernel+0x72/0x57e
[    0.000000] Code: b303 0285 b383 0305 be03 0385 be83 0405 bf03 0485 (b023) 00ef
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
Signed-off-by: Woody Zhang <woodylab@foxmail.com>
---
Changes in v3:
 - Add panic log for the bug case.
 - Move memblock_allow_resize to paging_init per suggestions from Alex and
   Song Shuai.

Changes in v2:
 - Refine commit log
---
 arch/riscv/mm/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4fa420faa780..1306149aad57 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -267,7 +267,6 @@ static void __init setup_bootmem(void)
 	dma_contiguous_reserve(dma32_phys_limit);
 	if (IS_ENABLED(CONFIG_64BIT))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-	memblock_allow_resize();
 }
 
 #ifdef CONFIG_MMU
@@ -1370,6 +1369,9 @@ void __init paging_init(void)
 {
 	setup_bootmem();
 	setup_vm_final();
+
+	/* Depend on that Linear Mapping is ready */
+	memblock_allow_resize();
 }
 
 void __init misc_mem_init(void)
-- 
2.39.2

