Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F7B612960
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ3JXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJ3JWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:22:53 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48531B84B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:22:34 -0700 (PDT)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-03 (Coremail) with SMTP id rQCowABXCVmKPV5jkxYmBw--.33365S6;
        Sun, 30 Oct 2022 17:02:17 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com
Subject: [PATCH 2/8] riscv/kprobe: Allocate detour buffer from module area
Date:   Sun, 30 Oct 2022 17:01:35 +0800
Message-Id: <20221030090141.2550837-3-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
References: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXCVmKPV5jkxYmBw--.33365S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1kJFW5XrWDCF18XFyxKrg_yoW8Zr17pF
        4DCr45JrZ8Z3W3G3y3tw1ku34Fva4kJa17KrW7ZFy5Zw45Jr43Zw4vgw4Fqrn5trsI9FWY
        qrWj9r9I9FWUA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEnc
        xIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4
        AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
        0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnnI
        D5UUUUU==
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiBwcPE2NeH6kltAAAsG
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

To address the limitation of PC-relative branch instruction
on riscv architecture, detour buffer slot used for optprobes is
allocated from a region, the distance of which from kernel should be
less than 4GB.

For the time being, Modules region always lives before the kernel.
But Vmalloc region resides far from kernel, the distance is half of the
kernel address space (See Documentation/riscv/vm-layout.rst), hence it
needs to override the alloc_optinsn_page() to make sure detour buffer
is allocated from jump-safe region.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/riscv/kernel/probes/kprobes.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7cf32..034eb7b13b3c 100644
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
+#if defined(CONFIG_OPTPROBES) && defined(CONFIG_64BIT)
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
2.25.1

