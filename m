Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F096A0708
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjBWLGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjBWLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:06:37 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CA1754551
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 03:06:33 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Ax69m5SPdjGRsEAA--.2624S3;
        Thu, 23 Feb 2023 19:06:33 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxK763SPdjgJg5AA--.39214S4;
        Thu, 23 Feb 2023 19:06:33 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] LoongArch: kdump: Add crashkernel=YM handling
Date:   Thu, 23 Feb 2023 19:06:31 +0800
Message-Id: <1677150391-12838-3-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1677150391-12838-1-git-send-email-tangyouling@loongson.cn>
References: <1677150391-12838-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxK763SPdjgJg5AA--.39214S4
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WFy3tF1kXr4Uur1xXrW8WFg_yoW8ZFWrpr
        1UAF45tFW5GF93G3yrAr9rur1rA3Wxua4jgFZ0y34kAF9xXrn8tw4kW3ZrZFyUK3s3WF4j
        vrZYqF9Iga18taDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07jY38nUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel crashkernel parameter is specified with just a size,
we are supposed to allocate a region from RAM to store the crashkernel,
"crashkernel=512M" would be recommended for kdump.

Fix this by lifting similar code from x86, importing it to LoongArch
with the LoongArch specific parameters added. We allocate the crashkernel
region from the first 4G of physical memory (SWIOTLB needs to be allocated
on low 4G). Currently LoongArch does not implement crashkernel_low and
crashkernel_high like x86.

When X is not specified, crash_base defaults to 0 (crashkernel=YM@XM).

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/kernel/setup.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 4344502c0b31..ac2aad988fdb 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -234,11 +234,14 @@ static void __init arch_reserve_vmcore(void)
 #endif
 }
 
+/* 16M alignment for crash kernel regions */
+#define CRASH_ALIGN	SZ_16M
+#define CRASH_ADDR_MAX	SZ_4G
+
 static void __init arch_parse_crashkernel(void)
 {
 #ifdef CONFIG_KEXEC
 	int ret;
-	unsigned long long start;
 	unsigned long long total_mem;
 	unsigned long long crash_base, crash_size;
 
@@ -247,8 +250,14 @@ static void __init arch_parse_crashkernel(void)
 	if (ret < 0 || crash_size <= 0)
 		return;
 
-	start = memblock_phys_alloc_range(crash_size, 1, crash_base, crash_base + crash_size);
-	if (start != crash_base) {
+	if (crash_base <= 0) {
+		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, CRASH_ALIGN,
+				CRASH_ADDR_MAX);
+		if (!crash_base) {
+			pr_warn("crashkernel reservation failed - No suitable area found.\n");
+			return;
+		}
+	} else if (!memblock_phys_alloc_range(crash_size, 1, crash_base, crash_base + crash_size)) {
 		pr_warn("Invalid memory region reserved for crash kernel\n");
 		return;
 	}
-- 
2.37.3

