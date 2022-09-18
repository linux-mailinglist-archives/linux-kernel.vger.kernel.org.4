Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0936A5BBC12
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 08:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIRGCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 02:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRGCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 02:02:34 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52B9B186E6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 23:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yLnzU
        bPovSEiJ0d7dyY6v5Z2f9GIAuRNne5cim6kAUs=; b=Z3DFAypKnXP66QPrWjFVb
        qSvgsAve4wW/hKJBxdoQqr1eljOTlbsoGb435X3KlXFMweumiD9GP6HQb7RL2Dvx
        Jj02g5MY/B9TI3tEWHLW625Rw2vEdhp2Fi5yL+ELGQNIK+noUgJ3zhlp8ERZqy/c
        YSSj7vjnFrENyecv935H1o=
Received: from whoami-VirtualBox.. (unknown [223.72.42.150])
        by smtp12 (Coremail) with SMTP id EMCowACH1IHNsyZjESXTCQ--.16398S2;
        Sun, 18 Sep 2022 13:59:42 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     paul.walmsley@sifive.com, ajones@ventanamicro.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, anup@brainfault.org,
        alexandre.ghiti@canonical.com, guoren@kernel.org,
        akpm@linux-foundation.org, heiko@sntech.de, tongtiangen@huawei.com,
        sunnanyong@huawei.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, tjytimi@163.com
Subject: [PATCH v2] riscv: support update_mmu_tlb() for riscv
Date:   Sun, 18 Sep 2022 13:59:40 +0800
Message-Id: <20220918055940.24726-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowACH1IHNsyZjESXTCQ--.16398S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF45JFyDCF48AFWfWFyrXrb_yoWDXrg_u3
        WxCw4vgrWvqF4xua4UWF1fJr45KwsYyFn8Xrn2qa15tFn8Ja1DA3ykta1UJr4UuanIvF4I
        9F95JryS9F9FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUD3kDUUUUU==
X-Originating-IP: [223.72.42.150]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiVhOAeFqzt7mStgABs-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro definition to support updata_mmu_tlb() for riscv,
this function is from commit:7df676974359 ("mm/memory.c:Update
local TLB if PTE entry exists").

Signed-off-by: Jinyu Tang <tjytimi@163.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
v1 -> v2: 

Change the format with the help from Andrew Jones and Conor Dooley.

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

