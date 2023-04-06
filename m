Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB46D8D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjDFB5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjDFB5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:57:05 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46283CE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:57:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PsPkf381dz4f3v5b
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:56:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyHoJi5kX936GA--.31319S6;
        Thu, 06 Apr 2023 09:56:59 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com, yebin@huaweicloud.com
Subject: [PATCH v2 2/2] lib/percpu_counter: fix dying cpu compare race
Date:   Thu,  6 Apr 2023 09:56:29 +0800
Message-Id: <20230406015629.1804722-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230406015629.1804722-1-yebin@huaweicloud.com>
References: <20230406015629.1804722-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyHoJi5kX936GA--.31319S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7ArWDXw1ktFy7KFyfZwb_yoW8WFy5pr
        4UKry5Jr18AF92k343Kw1vqF9I9r1kAF4rKwnrGF1fAFnxZa45urW0yrs8JF109rn7Wrya
        qryjgF4xCa4Yv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
        =
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

In commit 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") a race
condition between a cpu dying and percpu_counter_sum() iterating online CPUs
was identified.
Acctually, there's the same race condition between a cpu dying and
__percpu_counter_compare(). Here, use 'num_online_cpus()' for quick judgment.
But 'num_online_cpus()' will be decreased before call 'percpu_counter_cpu_dead()',
then maybe return incorrect result.
To solve above issue, also need to add dying CPUs count when do quick judgment
in __percpu_counter_compare().

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 lib/percpu_counter.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 5004463c4f9f..399840cb0012 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -227,6 +227,15 @@ static int percpu_counter_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
+static __always_inline unsigned int num_count_cpus(void)
+{
+#ifdef CONFIG_HOTPLUG_CPU
+	return (num_online_cpus() + num_dying_cpus());
+#else
+	return num_online_cpus();
+#endif
+}
+
 /*
  * Compare counter against given value.
  * Return 1 if greater, 0 if equal and -1 if less
@@ -237,7 +246,7 @@ int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
 
 	count = percpu_counter_read(fbc);
 	/* Check to see if rough count will be sufficient for comparison */
-	if (abs(count - rhs) > (batch * num_online_cpus())) {
+	if (abs(count - rhs) > (batch * num_count_cpus())) {
 		if (count > rhs)
 			return 1;
 		else
-- 
2.31.1

