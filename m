Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440BA5F8478
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJHI7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJHI7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:59:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1B2F7671
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 01:59:40 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPGv7O0FjQlooAA--.21044S2;
        Sat, 08 Oct 2022 16:59:39 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Do not create sysfs control file for io master CPUs
Date:   Sat,  8 Oct 2022 16:59:39 +0800
Message-Id: <1665219579-2501-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxPGv7O0FjQlooAA--.21044S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4kGFy5tw4DArWDurWxWFg_yoW8tr4fpr
        yIkFyUKrWrWF1kJay0q34q9ryYy3srW347Za12kayrCa9rJrn8ZF1ktFn3XF15Jay0gFWF
        vF95A3yS9F45Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8ZwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bw89_UUUUU=
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
 arch/loongarch/kernel/smp.c      |  8 --------
 arch/loongarch/kernel/topology.c | 12 +++++++++++-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index b5fab30..ef89292 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -240,19 +240,11 @@ void loongson3_smp_finish(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-static bool io_master(int cpu)
-{
-	return test_bit(cpu, &loongson_sysconf.cores_io_master);
-}
-
 int loongson3_cpu_disable(void)
 {
 	unsigned long flags;
 	unsigned int cpu = smp_processor_id();
 
-	if (io_master(cpu))
-		return -EBUSY;
-
 #ifdef CONFIG_NUMA
 	numa_remove_cpu(cpu);
 #endif
diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
index ab1a75c..7e7a77f 100644
--- a/arch/loongarch/kernel/topology.c
+++ b/arch/loongarch/kernel/topology.c
@@ -5,6 +5,7 @@
 #include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
+#include <asm/bootinfo.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
@@ -33,6 +34,11 @@ void arch_unregister_cpu(int cpu)
 EXPORT_SYMBOL(arch_unregister_cpu);
 #endif
 
+static bool io_master(int cpu)
+{
+	return test_bit(cpu, &loongson_sysconf.cores_io_master);
+}
+
 static int __init topology_init(void)
 {
 	int i, ret;
@@ -40,7 +46,11 @@ static int __init topology_init(void)
 	for_each_present_cpu(i) {
 		struct cpu *c = &per_cpu(cpu_devices, i);
 
-		c->hotpluggable = !!i;
+		if (io_master(i))
+			c->hotpluggable = 0;
+		else
+			c->hotpluggable = 1;
+
 		ret = register_cpu(c, i);
 		if (ret < 0)
 			pr_warn("topology_init: register_cpu %d failed (%d)\n", i, ret);
-- 
2.1.0

