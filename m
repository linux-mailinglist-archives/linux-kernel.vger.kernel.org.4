Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A12E6D5B0D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjDDImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:42:10 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74DC21FC0;
        Tue,  4 Apr 2023 01:42:03 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bxok7a4itkQV0WAA--.22927S3;
        Tue, 04 Apr 2023 16:42:02 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxwOTW4itkYRYVAA--.55009S3;
        Tue, 04 Apr 2023 16:42:00 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/6] LoongArch: Simplified randomization layout after jump new kernel processing
Date:   Tue,  4 Apr 2023 16:41:43 +0800
Message-Id: <20230404084148.744-2-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230404084148.744-1-zhangqing@loongson.cn>
References: <20230404084148.744-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxwOTW4itkYRYVAA--.55009S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFy5JFyUAw4rur18urW7Arb_yoW5AF45pr
        y7Zw1kJr45Grs7J34qqa4Dury5XwnrWw1aganrK34rZr12qFy5Xw1kurnrWFWjq3yFgr4S
        qFyrKF9Iva1UJ3DanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxUsw0eDUUUU
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modified relocate_kernel is not returned directly new kernel's entry point，
instead, we share start_kernel processing with the normal kernel, which avoids
calling 'jr a0' directly and we can do other operations(eg: kasan_early_init)
before start_kernel when CONFIG_RANDOMIZE_BASE is turned on.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/asm/setup.h |  2 +-
 arch/loongarch/kernel/head.S       | 10 +++++-----
 arch/loongarch/kernel/relocate.c   |  8 ++------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index be05c0e706a2..2dca0d1dd90a 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -33,7 +33,7 @@ extern long __la_abs_end;
 extern long __rela_dyn_begin;
 extern long __rela_dyn_end;
 
-extern void * __init relocate_kernel(void);
+extern unsigned long __init relocate_kernel(void);
 
 #endif
 
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index aa64b179744f..35c4a78614c3 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -95,12 +95,12 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	PTR_LI		sp, (_THREAD_SIZE - PT_SIZE)
 	PTR_ADD		sp, sp, tp
 	set_saved_sp	sp, t0, t1
-#endif
-
-	/* relocate_kernel() returns the new kernel entry point */
-	jr		a0
-	ASM_BUG()
 
+	/* Jump to new kernel: new_pc = current_pc + random_offset */
+	pcaddi		t0, 0
+	add.d		t0, t0, a0
+	jirl		zero, t0, 0xc
+#endif
 #endif
 
 	bl		start_kernel
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 01f94d1e3edf..6c3eff9af9fb 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -157,12 +157,11 @@ static inline void __init update_reloc_offset(unsigned long *addr, long random_o
 	*new_addr = (unsigned long)reloc_offset;
 }
 
-void * __init relocate_kernel(void)
+unsigned long __init relocate_kernel(void)
 {
 	unsigned long kernel_length;
 	unsigned long random_offset = 0;
 	void *location_new = _text; /* Default to original kernel start */
-	void *kernel_entry = start_kernel; /* Default to original kernel entry point */
 	char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
 
 	strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
@@ -190,9 +189,6 @@ void * __init relocate_kernel(void)
 
 		reloc_offset += random_offset;
 
-		/* Return the new kernel's entry point */
-		kernel_entry = RELOCATED_KASLR(start_kernel);
-
 		/* The current thread is now within the relocated kernel */
 		__current_thread_info = RELOCATED_KASLR(__current_thread_info);
 
@@ -204,7 +200,7 @@ void * __init relocate_kernel(void)
 
 	relocate_absolute(random_offset);
 
-	return kernel_entry;
+	return random_offset;
 }
 
 /*
-- 
2.20.1

