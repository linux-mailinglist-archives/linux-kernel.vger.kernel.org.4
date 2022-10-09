Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FF5F88B5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 03:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJIBXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 21:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJIBXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 21:23:07 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9558B1572E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 18:23:05 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx5OF3IkJjsvkoAA--.18413S2;
        Sun, 09 Oct 2022 09:23:04 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: Do not create sysfs control file for io master CPUs
Date:   Sun,  9 Oct 2022 09:23:02 +0800
Message-Id: <1665278582-16038-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Bx5OF3IkJjsvkoAA--.18413S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4kGFy5Kr15JF4Dtry3XFb_yoW8KF4rpF
        97Cr1kKrZ5WFn5Gayqq34q9rWUA3sxGw12ga12kay8CFW7Xrn8XF1ktF1kZF15JayrKFWF
        qryrK39a9F15J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVWkMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUg9mRDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now io master CPUs are not hotpluggable on LoongArch, in the current code,
only /sys/devices/system/cpu/cpu0/online is not created, let us set the
hotpluggable field of all the io master CPUs as 0, then prevent to create
sysfs control file for the other io master CPUs which confuses some user
space tools. This is similar with commit 9cce844abf07 ("MIPS: CPU#0 is not
hotpluggable").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/bootinfo.h | 5 +++++
 arch/loongarch/kernel/smp.c           | 5 -----
 arch/loongarch/kernel/topology.c      | 3 ++-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
index 8e5881b..ed0910e 100644
--- a/arch/loongarch/include/asm/bootinfo.h
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -40,4 +40,9 @@ extern unsigned long fw_arg0, fw_arg1, fw_arg2;
 extern struct loongson_board_info b_info;
 extern struct loongson_system_configuration loongson_sysconf;
 
+static inline bool io_master(int cpu)
+{
+	return test_bit(cpu, &loongson_sysconf.cores_io_master);
+}
+
 #endif /* _ASM_BOOTINFO_H */
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index b5fab30..781a4d4 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -240,11 +240,6 @@ void loongson3_smp_finish(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-static bool io_master(int cpu)
-{
-	return test_bit(cpu, &loongson_sysconf.cores_io_master);
-}
-
 int loongson3_cpu_disable(void)
 {
 	unsigned long flags;
diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
index ab1a75c..caa7cd8 100644
--- a/arch/loongarch/kernel/topology.c
+++ b/arch/loongarch/kernel/topology.c
@@ -5,6 +5,7 @@
 #include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
+#include <asm/bootinfo.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
@@ -40,7 +41,7 @@ static int __init topology_init(void)
 	for_each_present_cpu(i) {
 		struct cpu *c = &per_cpu(cpu_devices, i);
 
-		c->hotpluggable = !!i;
+		c->hotpluggable = !io_master(i);
 		ret = register_cpu(c, i);
 		if (ret < 0)
 			pr_warn("topology_init: register_cpu %d failed (%d)\n", i, ret);
-- 
2.1.0

