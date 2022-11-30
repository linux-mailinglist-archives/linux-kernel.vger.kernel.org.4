Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED15D63D04C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiK3IUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiK3ITx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:19:53 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B1A555CA5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:19:51 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxRPAmEodjqU8CAA--.5487S3;
        Wed, 30 Nov 2022 16:19:50 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPuIjEodj6GEiAA--.20038S4;
        Wed, 30 Nov 2022 16:19:50 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/5] LoongArch: Use stop_machine_cpuslocked() to modify instruction
Date:   Wed, 30 Nov 2022 16:19:33 +0800
Message-Id: <1669796376-4608-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1669796376-4608-1-git-send-email-yangtiezhu@loongson.cn>
References: <1669796376-4608-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxPuIjEodj6GEiAA--.20038S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxJr1kZw17ZF45XF1DAF15twb_yoW8Zryfpr
        1DAFsxJr45CF1SgasxAw4DXr13Wws3CwnrXay7Jw4SkF1jqwn5Ja1vqr1qvF10qw4rCr4S
        vFs8CFWfWa1UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8rwIDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the current larch_insn_patch_text() to patch_text_nosync(),
then redefine larch_insn_patch_text() with stop_machine_cpuslocked()
to modify instruction to avoid CPU race, this is preparation for later
patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/inst.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index aaaf9de..d842405 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 #include <linux/sizes.h>
+#include <linux/stop_machine.h>
 #include <linux/uaccess.h>
 
 #include <asm/cacheflush.h>
@@ -10,6 +11,12 @@
 
 static DEFINE_RAW_SPINLOCK(patch_lock);
 
+struct patch_insn {
+	void *addr;
+	u32 insn;
+	atomic_t cpu_count;
+};
+
 int larch_insn_read(void *addr, u32 *insnp)
 {
 	int ret;
@@ -34,7 +41,7 @@ int larch_insn_write(void *addr, u32 insn)
 	return ret;
 }
 
-int larch_insn_patch_text(void *addr, u32 insn)
+static int patch_text_nosync(void *addr, u32 insn)
 {
 	int ret;
 	u32 *tp = addr;
@@ -50,6 +57,30 @@ int larch_insn_patch_text(void *addr, u32 insn)
 	return ret;
 }
 
+static int patch_text_cb(void *data)
+{
+	struct patch_insn *param = data;
+	int ret = 0;
+
+	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
+		ret = patch_text_nosync(param->addr, param->insn);
+		atomic_inc(&param->cpu_count);
+	} else {
+		while (atomic_read(&param->cpu_count) <= num_online_cpus())
+			cpu_relax();
+		smp_mb();
+	}
+
+	return ret;
+}
+
+int larch_insn_patch_text(void *addr, u32 insn)
+{
+	struct patch_insn param = { addr, insn, ATOMIC_INIT(0) };
+
+	return stop_machine_cpuslocked(patch_text_cb, &param, cpu_online_mask);
+}
+
 u32 larch_insn_gen_nop(void)
 {
 	return INSN_NOP;
-- 
2.1.0

