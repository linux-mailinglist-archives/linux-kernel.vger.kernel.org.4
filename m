Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B95D6E94C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjDTMlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjDTMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:41:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7D5BA3;
        Thu, 20 Apr 2023 05:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87B016492A;
        Thu, 20 Apr 2023 12:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76537C433D2;
        Thu, 20 Apr 2023 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681994455;
        bh=jYk7Zd9ctQtmoQ9oVpNoBw40AOamcXM7JQPw3Wg6BqA=;
        h=From:To:Cc:Subject:Date:From;
        b=kyTv2Hp4EPxCfJmhEgrX3y9dPJoiFV38Ms7OHMzP8zShPevpZAgjUEZLvWlEZBrz3
         70QIWTOuWjfiH/bZZuqDvnff7eDIoh7kwk5Ty5a/Hz08qZJiz0TlkOGjmNCMYacToh
         DaA2Qx1vuFmHzHJFf/iPYcZSY49e5GqRUwP30WQI21frEy016+78eJS3f2dhdkyNc+
         S2DPCcLA6wKQHLslYGqgNg0aKf7qsyS+pzCZMC+LuONzrh8be0lzVNuRoM90HzyDSD
         /K8AlqcoQr+on4PNNwhq/GvUK8iqTtcoSQtC/vbelOFcGGNmQAoQRhtJJCporWVjpK
         nfePBVcjY1Ijw==
From:   broonie@kernel.org
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the risc-v tree with the risc-v-fixes tree
Date:   Thu, 20 Apr 2023 13:40:48 +0100
Message-Id: <20230420124048.65232-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/mm/init.c

between commit:

  ef69d2559fe91 ("riscv: Move early dtb mapping into the fixmap region")

from the risc-v-fixes tree and commits:

  8589e346bbb67 ("riscv: Move the linear mapping creation in its own function")
  3335068f87217 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/riscv/mm/init.c
index 0f14f4a8d179a,7bd66795165da..0000000000000
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@@ -1070,26 -1112,36 +1092,47 @@@ asmlinkage void __init setup_vm(uintptr
  	pt_ops_set_fixmap();
  }
  
- static void __init setup_vm_final(void)
+ static void __init create_linear_mapping_range(phys_addr_t start,
+ 					       phys_addr_t end)
  {
+ 	phys_addr_t pa;
  	uintptr_t va, map_size;
- 	phys_addr_t pa, start, end;
- 	u64 i;
  
- 	/* Setup swapper PGD for fixmap */
 +#if !defined(CONFIG_64BIT)
 +	/*
 +	 * In 32-bit, the device tree lies in a pgd entry, so it must be copied
 +	 * directly in swapper_pg_dir in addition to the pgd entry that points
 +	 * to fixmap_pte.
 +	 */
 +	unsigned long idx = pgd_index(__fix_to_virt(FIX_FDT));
 +
 +	set_pgd(&swapper_pg_dir[idx], early_pg_dir[idx]);
 +#endif
- 	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
- 			   __pa_symbol(fixmap_pgd_next),
- 			   PGDIR_SIZE, PAGE_TABLE);
++
+ 	for (pa = start; pa < end; pa += map_size) {
+ 		va = (uintptr_t)__va(pa);
+ 		map_size = best_map_size(pa, end - pa);
+ 
+ 		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
+ 				   pgprot_from_va(va));
+ 	}
+ }
+ 
+ static void __init create_linear_mapping_page_table(void)
+ {
+ 	phys_addr_t start, end;
+ 	u64 i;
+ 
+ #ifdef CONFIG_STRICT_KERNEL_RWX
+ 	phys_addr_t ktext_start = __pa_symbol(_start);
+ 	phys_addr_t ktext_size = __init_data_begin - _start;
+ 	phys_addr_t krodata_start = __pa_symbol(__start_rodata);
+ 	phys_addr_t krodata_size = _data - __start_rodata;
+ 
+ 	/* Isolate kernel text and rodata so they don't get mapped with a PUD */
+ 	memblock_mark_nomap(ktext_start,  ktext_size);
+ 	memblock_mark_nomap(krodata_start, krodata_size);
+ #endif
  
  	/* Map all memory banks in the linear mapping */
  	for_each_mem_range(i, &start, &end) {
