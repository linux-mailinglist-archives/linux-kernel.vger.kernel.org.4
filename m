Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18AF6D5632
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjDDBml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjDDBmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:42:37 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D554B4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:42:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pr9Vv6wcxz4f3mVj
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:42:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CGHgCtkmLh6GA--.26422S5;
        Tue, 04 Apr 2023 09:42:33 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com
Subject: [PATCH 1/2] cpu/hotplug: introduce 'num_dying_cpus' to get dying CPUs count
Date:   Tue,  4 Apr 2023 09:42:05 +0800
Message-Id: <20230404014206.3752945-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404014206.3752945-1-yebin@huaweicloud.com>
References: <20230404014206.3752945-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CGHgCtkmLh6GA--.26422S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy8ZFykGrW5KFWDCFy5CFg_yoW5JF4rpr
        4UGFW5trWUAFyIga9Yyws8Xr1F9wn5Crn5Gay29F13JFy3Ja4vq3WkuFy5Jr15WrZ3ur1a
        vrZ0qr409a15Xa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzl1vUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Introduce '__num_dying_cpus' variable to cache the number of dying CPUs
in the core and just return the cached variable.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 include/linux/cpumask.h | 20 ++++++++++++++++----
 kernel/cpu.c            |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 2a61ddcf8321..8127fd598f51 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -135,6 +135,8 @@ extern struct cpumask __cpu_dying_mask;
 
 extern atomic_t __num_online_cpus;
 
+extern atomic_t __num_dying_cpus;
+
 extern cpumask_t cpus_booted_once_mask;
 
 static __always_inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bits)
@@ -1018,10 +1020,14 @@ set_cpu_active(unsigned int cpu, bool active)
 static __always_inline void
 set_cpu_dying(unsigned int cpu, bool dying)
 {
-	if (dying)
-		cpumask_set_cpu(cpu, &__cpu_dying_mask);
-	else
-		cpumask_clear_cpu(cpu, &__cpu_dying_mask);
+	if (dying) {
+		if (!cpumask_test_and_set_cpu(cpu, &__cpu_dying_mask))
+			atomic_inc(&__num_dying_cpus);
+	}
+	else {
+		if (cpumask_test_and_clear_cpu(cpu, &__cpu_dying_mask))
+			atomic_dec(&__num_dying_cpus);
+	}
 }
 
 /**
@@ -1073,6 +1079,11 @@ static __always_inline unsigned int num_online_cpus(void)
 {
 	return arch_atomic_read(&__num_online_cpus);
 }
+
+static __always_inline unsigned int num_dying_cpus(void)
+{
+	return arch_atomic_read(&__num_dying_cpus);
+}
 #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
@@ -1108,6 +1119,7 @@ static __always_inline bool cpu_dying(unsigned int cpu)
 #define num_possible_cpus()	1U
 #define num_present_cpus()	1U
 #define num_active_cpus()	1U
+#define num_dying_cpus()	0U
 
 static __always_inline bool cpu_online(unsigned int cpu)
 {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f4a2c5845bcb..1c96c04cb259 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2662,6 +2662,8 @@ EXPORT_SYMBOL(__cpu_dying_mask);
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
 
+atomic_t __num_dying_cpus __read_mostly;
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
-- 
2.31.1

