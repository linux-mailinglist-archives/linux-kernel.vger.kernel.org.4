Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF65EEF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiI2Hgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiI2Hg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:36:27 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 921D8138F20
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:36:25 -0700 (PDT)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.32])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+D4SjVjDKwjAA--.3144S2;
        Thu, 29 Sep 2022 15:36:24 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH] LoongArch: Fix cpu name after s3/s4
Date:   Thu, 29 Sep 2022 15:36:23 +0800
Message-Id: <20220929073623.7604-1-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxT+D4SjVjDKwjAA--.3144S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1ktryDurWxKr1fGw17ZFb_yoW8tFykpF
        s2kr4DAFZrWrn8K3s8try5WrWUZrnrGw12q3ZYkFWrZF4UXF1kXr48tr4DXF1UZa1kWrW0
        qFZ3Wa9rtF47JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
        0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY
        6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On coming back from s3/s4, the cpu name will be overwritten
in cpu_probe path of seconary cpu, so we adjust the postion
of using cpu name existed in cpu hardware register, and only
use it while failing to get cpu name from SMBIOS.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>

diff --git a/arch/loongarch/include/asm/cpu-info.h b/arch/loongarch/include/asm/cpu-info.h
index b6c4f96079df..937dce2a930a 100644
--- a/arch/loongarch/include/asm/cpu-info.h
+++ b/arch/loongarch/include/asm/cpu-info.h
@@ -64,6 +64,7 @@ extern void cpu_probe(void);
 
 extern const char *__cpu_family[];
 extern const char *__cpu_full_name[];
+extern char cpu_full_name[];
 #define cpu_family_string()	__cpu_family[raw_smp_processor_id()]
 #define cpu_full_name_string()	__cpu_full_name[raw_smp_processor_id()]
 
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 529ab8f44ec6..a548b2197224 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -180,14 +180,13 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 #define VENDOR_OFFSET	0
 #define CPUNAME_OFFSET	9
 
-static char cpu_full_name[MAX_NAME_LEN] = "        -        ";
+char cpu_full_name[MAX_NAME_LEN] = "        -        ";
 
 static inline void cpu_probe_loongson(struct cpuinfo_loongarch *c, unsigned int cpu)
 {
 	uint64_t *vendor = (void *)(&cpu_full_name[VENDOR_OFFSET]);
 	uint64_t *cpuname = (void *)(&cpu_full_name[CPUNAME_OFFSET]);
 
-	__cpu_full_name[cpu] = cpu_full_name;
 	*vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
 	*cpuname = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
 
diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index 82b478a5c665..955d82aa298e 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -44,6 +44,9 @@ static int __init init_cpu_fullname(void)
 	if (loongson_sysconf.cpuname && !strncmp(loongson_sysconf.cpuname, "Loongson", 8)) {
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
 			__cpu_full_name[cpu] = loongson_sysconf.cpuname;
+	} else {
+		for (cpu = 0; cpu < NR_CPUS; cpu++)
+			__cpu_full_name[cpu] = cpu_full_name;
 	}
 	return 0;
 }
-- 
2.31.1

