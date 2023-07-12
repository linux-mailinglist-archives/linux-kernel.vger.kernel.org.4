Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3D74FD94
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGLDQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjGLDQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:16:26 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 810FB10D4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:16:24 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8AxCPIHG65khscDAA--.10903S3;
        Wed, 12 Jul 2023 11:16:23 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWM0GG65kA7cpAA--.53483S4;
        Wed, 12 Jul 2023 11:16:22 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH 2/3] LoongArch: Code cleanup in function pcpu_populate_pte
Date:   Wed, 12 Jul 2023 11:16:21 +0800
Message-Id: <20230712031622.1888321-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230712031622.1888321-1-maobibo@loongson.cn>
References: <20230712031622.1888321-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxWM0GG65kA7cpAA--.53483S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF17Xr48Ar4xXrWDtw45CFX_yoW8Zr4xp3
        93GwnYvFs8Gwn7Jay3JryfWr43JwsYg3W5K3yUur1fAFyIqrnrGw4DG3s7uFyUtF4fZFWI
        gF4rtasIva1DX3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4eMKDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some code cleanups in function pcpu_populate_pte:
1. Replace memblock_alloc with memblock_alloc_raw for pud and pmd since
they will be reinitialized with pud_init and pmd_init.

2. Add memory allocation failure handling

3. Replace pgd_populate with p4d_populate, it will be useful if there
four-level page tables.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/numa.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 708665895b47..778e1c20bfb0 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -73,33 +73,40 @@ void __init pcpu_populate_pte(unsigned long addr)
 	pmd_t *pmd;
 
 	if (p4d_none(*p4d)) {
-		pud_t *new;
-
-		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-		pgd_populate(&init_mm, pgd, new);
+		pud = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
+		if (!pud)
+			goto err_alloc;
+		p4d_populate(&init_mm, p4d, pud);
 #ifndef __PAGETABLE_PUD_FOLDED
-		pud_init(new);
+		pud_init(pud);
 #endif
 	}
 
 	pud = pud_offset(p4d, addr);
 	if (pud_none(*pud)) {
-		pmd_t *new;
-
-		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-		pud_populate(&init_mm, pud, new);
+		pmd = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
+		if (!pmd)
+			goto err_alloc;
+		pud_populate(&init_mm, pud, pmd);
 #ifndef __PAGETABLE_PMD_FOLDED
-		pmd_init(new);
+		pmd_init(pmd);
 #endif
 	}
 
 	pmd = pmd_offset(pud, addr);
 	if (!pmd_present(*pmd)) {
-		pte_t *new;
+		pte_t *pte;
 
-		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
-		pmd_populate_kernel(&init_mm, pmd, new);
+		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		if (!pte)
+			goto err_alloc;
+		pmd_populate_kernel(&init_mm, pmd, pte);
 	}
+
+	return;
+
+err_alloc:
+	panic("%s: Failed to allocate memory\n", __func__);
 }
 
 void __init setup_per_cpu_areas(void)
-- 
2.27.0

