Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A373D151
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjFYOKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjFYOKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:10:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68861B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:10:50 -0700 (PDT)
X-QQ-mid: bizesmtp73t1687702201tfi94mxf
Received: from localhost.localdomain ( [112.2.230.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 25 Jun 2023 22:09:56 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: 7QbCsSX/jDajboDIHjqXf60bGtIy5uaeLeazsMLa+7tUdkr3UGx10netYGscB
        urao5noZ9e0frsU9G1KBZ9rFA+mY4cvgSB865YOu0EOCQ8l9rF2XEOdiTTkNnEFQbed40my
        8eFOG2ZNIilDyadp3uJXT0MYK7YxgbWYDN5wzN9QVebgwF3leCB/t4axu/g/O4NXHOBTnRd
        iriLXHVh1GlKHeBdaPzczRTETLTg0QYdVRfn/arFPO8w0OF2aJSUwKWfms3kSlC3tJB5LKz
        4BoRRKhVkbH4zwvEQUU6h4053IIjk9G1cFJ9kIWgHo2ndiphh4Towdx++by0wIwTFIyYuZl
        pCAysmh43140F197LcSw+J3ajAS3wD44tSP3Yg9VWU1+pV6Ggk=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8927406621294641602
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        mpe@ellerman.id.au, arnd@arndb.de, songshuaishuai@tinylab.org,
        rppt@kernel.org, samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        conor.dooley@microchip.com, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V1 0/3] Revert huge-paged linear mapping and its related fixups
Date:   Sun, 25 Jun 2023 22:09:28 +0800
Message-Id: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have encountered these two issues about huge-paged linear mapping since v6.4-rc1: 

1. Bug report: kernel paniced when system hibernates[1]
  
OpenSbi [v0.8,v1.3) set the PMP regions as !no-map, and the commit 3335068f8721 
("riscv: Use PUD/P4D/PGD pages for the linear mapping") mapped them in linear mapping.
The hibernation process attempted to save/restore these mapped regions resulting in access fault.

This issue was temporarily fixed by commit ed309ce52218 ("RISC-V: mark hibernation as nonportable").
But as Alex's RFC and Rob's response stats in another thread [2] , 
"Hibernation is only one case. Speculative accesses could also occur."
So this fixing commit seems not the perfect answer to this issue. 


2. Bug report: kernel paniced while booting (with UEFI )[3]

During the booting with UEFI, UEFI Memory Mapping overwrote the memblock.
The phys_ram_base was set as the end address of mmoderes0 (like 0x80040000 for 256 KiB mmoderes0@80000000),
which resulted the VA based on 2M-aligned PA was not 2M-aligned using va_pa_offset 
(PAGE_OFFSET - phys_ram_base) to translate.

The best_map_size() from commit 3335068f8721 didn't check the virtual alignment
before choosing a map size. and then a "VA hole" was created where page faults always occurred.

This issue was fixed by commit 49a0a3731596 ("riscv: Check the virtual alignment before choosing a map size"),
But this fixing commit has a side-effect ("the possible third one" as Alex said in this thread). 
There are numerous PTE allocations slowing down the boot time and consuming some system memory when UEFI booting
(Note that it's not involved when booting directly with OpenSbi, where phys_ram_base is the 2M-aligned base of DRAM).

In my test, compared with/out reverting both commit 49a0a3731596 and commit 3335068f8721,
I must wait ~20s for the linear mapping creation and mem_init_print_info() reported ~8M extra reserved memory.

To eliminate this side-effect, We should find a way to align VA and PA on a 2MB boundary. 
The simplest way is reverting the commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping").



Using PUD/P4D/PGD pages for the linear mapping to improve the performance is marginal from a recent talk [4]
from Mike Rapoport. OpenSbi had marked all the PMP-protected regions as "no-map" [5] to practice this talk.

For all those reasons, let's revert these related commits:

- commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
- commit 49a0a3731596 ("riscv: Check the virtual alignment before choosing a map size")
- commit ed309ce52218 ("RISC-V: mark hibernation as nonportable")
 
[1]: https://lore.kernel.org/linux-riscv/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
[2]: https://lore.kernel.org/linux-kernel/20230530080425.18612-1-alexghiti@rivosinc.com/
[3]: https://lore.kernel.org/linux-riscv/tencent_7C3B580B47C1B17C16488EC1@qq.com/
[4]: https://lwn.net/Articles/931406/
[5]: https://github.com/riscv-software-src/opensbi/commit/8153b2622b08802cc542f30a1fcba407a5667ab9

Song Shuai (3):
  Revert "RISC-V: mark hibernation as nonportable"
  Revert "riscv: Check the virtual alignment before choosing a map size"
  Revert "riscv: Use PUD/P4D/PGD pages for the linear mapping"

 arch/riscv/Kconfig            |  5 +---
 arch/riscv/include/asm/page.h | 16 -------------
 arch/riscv/mm/init.c          | 43 +++++++----------------------------
 arch/riscv/mm/physaddr.c      | 16 -------------
 drivers/of/fdt.c              | 11 ++++-----
 5 files changed, 14 insertions(+), 77 deletions(-)

-- 
2.20.1

