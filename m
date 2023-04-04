Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3916D6D5633
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjDDBmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjDDBmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:42:37 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908B6B8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:42:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pr9Vw49dmz4f3w0Y
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:42:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CGHgCtkmLh6GA--.26422S6;
        Tue, 04 Apr 2023 09:42:33 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com
Subject: [PATCH 2/2] lib/percpu_counter: fix dying cpu compare race
Date:   Tue,  4 Apr 2023 09:42:06 +0800
Message-Id: <20230404014206.3752945-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404014206.3752945-1-yebin@huaweicloud.com>
References: <20230404014206.3752945-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CGHgCtkmLh6GA--.26422S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7ArWDXw1ktFy7KFyfZwb_yoW8WFy5pr
        4UKry5Jr18AF92k343Kw1vqF9I9r1kAF4rKwnrGF1fAFnxZa45urW0yrs8JF109rn7Wrya
        qryjgF4xCa4Yv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2GYLDUUUU
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

