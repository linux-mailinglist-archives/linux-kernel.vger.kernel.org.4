Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8205A69A60E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBQH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBQH0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:26:37 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C90FE5D3F9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:26:32 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxldgnLO9jE64BAA--.3383S3;
        Fri, 17 Feb 2023 15:26:31 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+QmLO9jiSQ1AA--.63745S2;
        Fri, 17 Feb 2023 15:26:30 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] LoongArch: Add kernel relocation and KASLR support
Date:   Fri, 17 Feb 2023 15:26:24 +0800
Message-Id: <1676618789-20485-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Cxf+QmLO9jiSQ1AA--.63745S2
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZryUGrWUXF1fCFWfWFWktFb_yoW5WF4kpr
        yYkr95JF48Gr1fXwsrt3y3ur15t3Z7Gr43WFsIk34FkF1agr1UAry0vwsxXFyDtw4rXr4I
        gFn5KF12g3WUAa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5r7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series to support kernel relocation and KASLR (only 64bit).

Tested the kernel images built with new toolchain (Binutils-2.40 + patched
GCC-12.2) and old toolchain (kernel.org cross toolchain [1]) on a
3A5000-7A2000-EVB.

With CONFIG_RANDOMIZE_BASE=y, the results are:

1. first boot, new toolchain:

$ sudo cat /proc/iomem | grep Kernel
  01080000-0189ffff : Kernel code
  018a0000-01deb5ff : Kernel data
  01deb600-01ef6e9f : Kernel bss

2. second boot, new toolchain:

$ sudo cat /proc/iomem | grep Kernel
  012f0000-01b0ffff : Kernel code
  01b10000-0205b5ff : Kernel data
  0205b600-02166e9f : Kernel bss

3. first boot, old toolchain:
  010e0000-018fffff : Kernel code
  01900000-01e591ff : Kernel data
  01e59200-01f56dcf : Kernel bss

4. second boot, old toolchain:
  010b0000-018cffff : Kernel code
  018d0000-01e291ff : Kernel data
  01e29200-01f26dcf : Kernel bss

Changes from v4:
- Add la_abs macro implementation.
- Remove patch2 (LoongArch: Use la.pcrel instead of la.abs for exception
  handlers).
- Remove SYS_SUPPORTS_RELOCATABLE.
- Fix do_kaslr.
- Fix compiler warnings.
- Move some declarations and struct definitions to setup.h.

Changes from v3:

- JUMP_LINK_ADDR renamed to JUMP_VIRT_ADDR, and use the way of parameter
  passing.
- Reimplement kernel relocation, when the link address and load address
  are different, realize the effect of adaptive relocation (one of the
  usage scenarios is kdump operation).
- Reimplement KASLR.

Changes from v2:

- Correctly fixup pcaddi12i/ori/lu32i.d/lu52i.d sequence generated by
  GNU as <= 2.39 for la.pcrel.

Changes from v1 to v2:

- Relocate the handlers instead of using a trampoline, to avoid
  performance issue on NUMA systems.
- Fix compiler warnings.

Xi Ruoyao (1):
  LoongArch: Use la.pcrel instead of la.abs when it's trivially possible

Youling Tang (4):
  LoongArch: Add JUMP_VIRT_ADDR macro implementation to avoid using
    la.abs
  LoongArch: Add la_abs macro implementation
  LoongArch: Add support for kernel relocation
  LoongArch: Add support for kernel address space layout randomization
    (KASLR)

 arch/loongarch/Kconfig                  |  31 +++
 arch/loongarch/Makefile                 |   5 +
 arch/loongarch/include/asm/asmmacro.h   |  17 ++
 arch/loongarch/include/asm/setup.h      |  14 ++
 arch/loongarch/include/asm/stackframe.h |  13 +-
 arch/loongarch/include/asm/uaccess.h    |   1 -
 arch/loongarch/kernel/Makefile          |   2 +
 arch/loongarch/kernel/entry.S           |   2 +-
 arch/loongarch/kernel/genex.S           |   8 +-
 arch/loongarch/kernel/head.S            |  31 ++-
 arch/loongarch/kernel/relocate.c        | 240 ++++++++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S     |  20 +-
 arch/loongarch/mm/tlbex.S               |  17 +-
 arch/loongarch/power/suspend_asm.S      |   5 +-
 14 files changed, 375 insertions(+), 31 deletions(-)
 create mode 100644 arch/loongarch/kernel/relocate.c

-- 
2.37.3

