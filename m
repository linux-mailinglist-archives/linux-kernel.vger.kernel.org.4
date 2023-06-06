Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0860F723931
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjFFHkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbjFFHkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:40:02 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE93B118
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:39:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.41.186])
        by gateway (Coremail) with SMTP id _____8CxLPDN4n5kcwkAAA--.298S3;
        Tue, 06 Jun 2023 15:39:57 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.41.186])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxC8rM4n5kv_YBAA--.108S2;
        Tue, 06 Jun 2023 15:39:56 +0800 (CST)
From:   Hongliang Wang <wanghongliang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        wanghongliang <wanghongliang@loongson.cn>
Subject: [PATCH v1] soc:loongson:add model and clock-frequency attribute parse.
Date:   Tue,  6 Jun 2023 15:39:38 +0800
Message-Id: <20230606073938.556-1-wanghongliang@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxC8rM4n5kv_YBAA--.108S2
X-CM-SenderInfo: pzdqwxxrqjzxhdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw45Ww1xAr1xuw45ZFy7Jwc_yoW8ArWfpF
        WkZFZ5Gr45GFn3u34rtry8ZryYyrn5Cr4Iga47KFW5CanrXrn8X3yjqFyq9ryxJayrXa4F
        gr95uw4vqa15JagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wanghongliang <wanghongliang@loongson.cn>

This patch add the parse of model and clock-frequency attribute,
which come from the cpus device_node in device tree and show as
Model Name and CPU MHz in /proc/cpuinfo.

device tree:

cpus {
	...
	model = "Loongson-LS2K1000";

	cpu0: cpu@0 {
		...
		clock-frequency = <1000000000>;
	};
};

/proc/cpuinfo:

Model Name              : Loongson-LS2K1000
CPU MHz                 : 1000.00

Signed-off-by: wanghongliang <wanghongliang@loongson.cn>
---
 arch/loongarch/kernel/smp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ed167e244cda..8644fb9119ec 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -30,6 +30,7 @@
 #include <asm/processor.h>
 #include <asm/setup.h>
 #include <asm/time.h>
+#include <asm/bootinfo.h>
 
 int __cpu_number_map[NR_CPUS];   /* Map physical to logical */
 EXPORT_SYMBOL(__cpu_number_map);
@@ -186,6 +187,14 @@ static void __init fdt_smp_setup(void)
 #ifdef CONFIG_OF
 	unsigned int cpu, cpuid;
 	struct device_node *node = NULL;
+	const void *prop = NULL;
+
+	node = of_find_node_by_path("/cpus");
+	if (node) {
+		prop = of_get_property(node, "model", NULL);
+		if (prop)
+			loongson_sysconf.cpuname = (const char *)prop;
+	}
 
 	for_each_of_cpu_node(node) {
 		if (!of_device_is_available(node))
@@ -202,6 +211,10 @@ static void __init fdt_smp_setup(void)
 			cpu = cpumask_next_zero(-1, cpu_present_mask);
 		}
 
+		prop = of_get_property(node, "clock-frequency", NULL);
+		if (prop)
+			cpu_clock_freq = be32_to_cpup(prop);
+
 		num_processors++;
 		set_cpu_possible(cpu, true);
 		set_cpu_present(cpu, true);
-- 
2.31.1

