Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B285B6591
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiIMC1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiIMC1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:27:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7450152DD7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:27:07 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MRS0l04YxzNm9d;
        Tue, 13 Sep 2022 10:22:30 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 13 Sep
 2022 10:27:05 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>,
        <mhiramat@kernel.org>, <liaochang1@huawei.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liaochang@huawei.com>, <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH V2] riscv/kprobes: allocate detour buffer from module area
Date:   Tue, 13 Sep 2022 10:23:34 +0800
Message-ID: <20220913022334.83997-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address the limitation of PC-relative branch instruction
on riscv architecture, detour buffer slot used for optprobes is
allocated from a region, the distance of which from kernel should be
less than 4GB.

For the time being, Modules region always live before the kernel.
But Vmalloc region reside far from kernel, the distance is half of the
kernel address space (See Documentation/riscv/vm-layout.rst), hence it
needs to override the alloc_optinsn_page() to make sure allocate detour
buffer from jump-safe region.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
v2:
1. Avoid to depend on CONFIG_MODUELS.
2. Override alloc_optinsn_page to allocate slot from jump-safe region.

---
 arch/riscv/kernel/probes/kprobes.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7cf32..fd62b0b086d2 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -12,6 +12,7 @@
 #include <asm/cacheflush.h>
 #include <asm/bug.h>
 #include <asm/patch.h>
+#include <asm/set_memory.h>
 
 #include "decode-insn.h"
 
@@ -84,6 +85,30 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 }
 
 #ifdef CONFIG_MMU
+#ifdef CONFIG_OPTPROBES
+void *alloc_optinsn_page(void)
+{
+	void *page;
+
+	page = __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR,
+				    MODULES_END, GFP_KERNEL,
+				    PAGE_KERNEL, 0, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+	if (!page)
+		return NULL;
+
+	set_vm_flush_reset_perms(page);
+	/*
+	 * First make the page read-only, and only then make it executable to
+	 * prevent it from being W+X in between.
+	 */
+	set_memory_ro((unsigned long)page, 1);
+	set_memory_x((unsigned long)page, 1);
+
+	return page;
+}
+#endif
+
 void *alloc_insn_page(void)
 {
 	return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
-- 
2.17.1

