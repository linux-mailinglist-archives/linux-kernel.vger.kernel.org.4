Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DE95F8B9F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJINqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 09:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJINqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 09:46:14 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F5AF27CD8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=y0Va6
        t7IEzPneZZtRuTxgWXS6wlUeWN5JX4PCoeBRrs=; b=XXMM4mRU1nmydeADv4Tpq
        R8j78WlAfg3csIkBDlNUklZ+KXjVHjZJKdujhc2V9QI/82ab+Px4bdlrwV0GmiDi
        MYyg2C8LPCJVyzXAxcv+PUJ4qHKTHpIAchqkXz1ty9J9VngaJ2Vaf4H36INHo1c0
        TNK8HIMTeLQcvsmmVZd2ys=
Received: from whoami-VirtualBox.. (unknown [223.72.43.15])
        by smtp12 (Coremail) with SMTP id EMCowAD3G8Rh0EJjxxnCCw--.433S2;
        Sun, 09 Oct 2022 21:45:08 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     Conor.Dooley@microchip.com, ajones@ventanamicro.com,
        anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        guoren@kernel.org, akpm@linux-foundation.org,
        tongtiangen@huawei.com, panqinglin2020@iscas.ac.cn,
        maobibo@loongson.cn
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, Jinyu Tang <tjytimi@163.com>
Subject: [PATCH v3] riscv: support update_mmu_tlb()
Date:   Sun,  9 Oct 2022 21:45:03 +0800
Message-Id: <20221009134503.18783-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAD3G8Rh0EJjxxnCCw--.433S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW7Cw17AFWkAr4fCr1UGFg_yoW8KFWfpF
        ZrCF1kGrZrKw1IkFWxAw17ur48X3ykKa4Utryayr98CanFgr1vyFZ5Ka95Zr18CFZag3Wx
        uFWYgr15u398Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUwTm3UUUUU=
X-Originating-IP: [223.72.43.15]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiZQuVeF8ZU3hMLwABsM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro definition to support update_mmu_tlb() for riscv,
this function is from commit:7df676974359 ("mm/memory.c:Update
local TLB if PTE entry exists").

update_mmu_tlb() is used when a thread notice that other cpu thread
has handled the fault and changed the PTE. For MIPS, it's worth to
do that,this cpu thread will trap in tlb fault again otherwise.

For RISCV, it's also better to flush local tlb than do nothing in
update_mmu_tlb(). There are two kinds of page fault that have
update_mmu_tlb() inside:

1.page fault which PTE is NOT none, only protection check error,
like write protection fault. If updata_mmu_tlb() is empty, after
finsh page fault this time and re-execute, cpu will find address
but protection checked error in tlb again. So this will cause
another page fault. PTE in memory is good now,so update_mmu_cache()
in handle_pte_fault() will be executed. If updata_mmu_tlb() is not
empty flush local tlb, cpu won't find this address in tlb next time,
and get entry in physical memory, so it won't cause another page
fault.

2.page fault which PTE is none or swapped.
For this case, this cpu thread won't cause another page fault,cpu
will have tlb miss when re-execute, and get entry in memory
directly. But "set pte in phycial memory and flush local tlb" is
pratice in Linux, it's better to flush local tlb if it find entry
in phycial memory has changed.

Maybe it's same for other ARCH which can't detect PTE changed and
update it in local tlb automatically.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
v2 -> v3:
Explain why it should do this.Thanks for Conor Dooley's Advice.

v1 -> v2:
Change the format with the help from Andrew Jones and Conor Dooley
 
 arch/riscv/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7ec936910a96..c61ae83aadee 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -418,6 +418,9 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 	local_flush_tlb_page(address);
 }
 
+#define __HAVE_ARCH_UPDATE_MMU_TLB
+#define update_mmu_tlb update_mmu_cache
+
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp)
 {
-- 
2.30.2

