Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9D6D8D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjDFB5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjDFB5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:57:03 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68ABA9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:57:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PsPkd3XFqz4f3nqJ
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:56:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyHoJi5kX936GA--.31319S5;
        Thu, 06 Apr 2023 09:56:59 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com, yebin@huaweicloud.com
Subject: [PATCH v2 1/2] cpu/hotplug: introduce 'num_dying_cpus' to get dying CPUs count
Date:   Thu,  6 Apr 2023 09:56:28 +0800
Message-Id: <20230406015629.1804722-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230406015629.1804722-1-yebin@huaweicloud.com>
References: <20230406015629.1804722-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyHoJi5kX936GA--.31319S5
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy8ZFykGrW5KFWDCFy5CFg_yoW5JF4rpr
        4UGFW5trWUAFyIga9Yyws8Xr1F9wn5Crn5Gay29F13JFy3Ja4vq3WkuFy5Jr15WrZ3ur1a
        vrZ0qr409a15Xa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU2_M3UUUUU
        =
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.1 required=5.0 tests=KHOP_HELO_FCRDNS,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
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

