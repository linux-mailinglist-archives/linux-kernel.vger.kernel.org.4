Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF11E700ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbjELO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbjELO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA67AD15
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC0C0655F5
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EC6C433EF;
        Fri, 12 May 2023 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683903476;
        bh=lQUbfvw+rG1d/xBNHe707+zVxdkdQoFXQhp1/m5+D2o=;
        h=From:To:Cc:Subject:Date:From;
        b=Pj6FNyKzYS1+2WsFAf60GrrqPD8Bmex/fW3XVKGpchoXvDFVdCzq5pdBn4CLPLVXT
         HUhE+59XO8/Wzj4AbJ4CpzpWU8GhJax++sLAiqeoqCvrFb26fbJweVhVIu8+8/ShtW
         5xxS2gt3CMy+8uR+Uh/dbsXnUZQ/OW7fUfDsFOB9sjBoB4onucM2o++3XufmploeLt
         IToUIhUOICJmjt97dVVQn7bZqxLzfM2ZZQl1LSBWBymwWA1g9Ot3XItdXz4P1zf78H
         GHHMedHBLWkcPYUKroEaEtDo4RitN+wAPQcmwNItogJTgj79mJ1cXeuAh7lNssR//F
         kXU3t1IihxakQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        virtualization@lists.linux-foundation.org, linux@rivosinc.com,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/7] riscv: Memory Hot(Un)Plug support
Date:   Fri, 12 May 2023 16:57:30 +0200
Message-Id: <20230512145737.985671-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Memory Hot(Un)Plug support for the RISC-V port
==============================================

Introduction
------------

To quote "Documentation/admin-guide/mm/memory-hotplug.rst": "Memory
hot(un)plug allows for increasing and decreasing the size of physical
memory available to a machine at runtime."

This series attempts to add memory hot(un)plug support for the RISC-V
Linux port.

I'm sending the series as a v1, but it's borderline RFC. It definitely
needs more testing time, but it would be nice with some early input.

Implementation
--------------

From an arch perspective, a couple of callbacks needs to be
implemented to support hot plugging:

arch_add_memory()
This callback is responsible for updating the linear/direct map, and
call into the memory hot plugging generic code via __add_pages().

arch_remove_memory()
In this callback the linear/direct map is tore down.

vmemmap_free()
The function tears down the vmemmap mappings (if
CONFIG_SPARSEMEM_VMEMMAP is in-use), and also deallocates the backing
vmemmap pages. Note that for persistent memory, an alternative
allocator for the backing pages can be used -- the vmem_altmap. This
means that when the backing pages are cleared, extra care is needed so
that the correct deallocation method is used. Note that RISC-V
populates the vmemmap using vmemmap_populate_basepages(), so currently
no hugepages are used for the backing store.

The page table unmap/teardown functions are heavily based (copied!)
from the x86 tree. The same remove_pgd_mapping() is used in both
vmemmap_free() and arch_remove_memory(), but in the latter function
the backing pages are not removed.

On RISC-V, the PGD level kernel mappings needs to synchronized with
all page-tables (e.g. via sync_kernel_mappings()). Synchronization
involves special care, like locking. Instead, this patch series takes
a different approach (introduced by Jörg Rödel in the x86-tree);
Pre-allocate the PGD-leaves (P4D, PUD, or PMD depending on the paging
setup) at mem_init(), for vmemmap and the direct map.

Pre-allocating the PGD-leaves waste some memory, but is only enabled
for CONFIG_MEMORY_HOTPLUG. The number pages, potentially unused, are
~128 * 4K.

Patch 1: Preparation for hotplugging support, by pre-allocating the
         PGD leaves.

Patch 2: Changes the __init attribute to __meminit, to avoid that the
         functions are removed after init. __meminit keeps the
         functions after init, if memory hotplugging is enabled for
         the build.
         
Patch 3: Refactor the direct map setup, so it can be used for hot add.

Patch 4: The actual add/remove code. Mostly a page-table-walk
         exercise.

Patch 5: Turn on the arch support in Kconfig

Patch 6: Now that memory hotplugging is enabled, make virtio-mem
         usable for RISC-V
         
Patch 7: Pre-allocate vmalloc PGD-leaves as well, which removes the
         need for vmalloc faulting.
         
RFC
---

 * TLB flushes. The current series uses Big Hammer flush-it-all.
 * Pre-allocation vs explicit syncs

Testing
-------

ACPI support is still in the making for RISC-V, so tests that involve
CXL and similar fanciness is currently not possible. Virtio-mem,
however, works without proper ACPI support. In order to try this out
in Qemu, some additional patches for Qemu are needed:

 * Enable virtio-mem for RISC-V
 * Add proper hotplug support for virtio-mem
 
The patch for Qemu can be found is commit 5d90a7ef1bc0
("hw/riscv/virt: Support for virtio-mem-pci"), and can be found here

  https://github.com/bjoto/qemu/tree/riscv-virtio-mem

I will try to upstream that work in parallel with this.
  
Thanks to David Hildenbrand for valuable input for the Qemu side of
things.

The series is based on the RISC-V fixes tree
  https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=fixes


Thanks,
Björn


Björn Töpel (7):
  riscv: mm: Pre-allocate PGD leaves to avoid synchronization
  riscv: mm: Change attribute from __init to __meminit for page
    functions
  riscv: mm: Refactor create_linear_mapping_range() for hot add
  riscv: mm: Add memory hot add/remove support
  riscv: Enable memory hot add/remove arch kbuild support
  virtio-mem: Enable virtio-mem for RISC-V
  riscv: mm: Pre-allocate vmalloc PGD leaves

 arch/riscv/Kconfig               |   2 +
 arch/riscv/include/asm/kasan.h   |   4 +-
 arch/riscv/include/asm/mmu.h     |   2 +-
 arch/riscv/include/asm/pgtable.h |   2 +-
 arch/riscv/mm/fault.c            |   7 +-
 arch/riscv/mm/init.c             | 387 ++++++++++++++++++++++++++++---
 drivers/virtio/Kconfig           |   2 +-
 7 files changed, 364 insertions(+), 42 deletions(-)


base-commit: 3b90b09af5be42491a8a74a549318cfa265b3029
-- 
2.39.2

