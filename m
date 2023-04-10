Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A26DC2AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDJCYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjDJCYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:24:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE324358A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:24:10 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pvt453hZ2z17RqC;
        Mon, 10 Apr 2023 10:20:37 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 10:24:08 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <chenzhongjin@huawei.com>, <akpm@linux-foudation.org>,
        <ben-linux@fluff.org>, <wuchi.zero@gmail.com>
Subject: [PATCH 2/2] profiling: Check prof_buffer in profile_tick()
Date:   Mon, 10 Apr 2023 10:22:26 +0800
Message-ID: <20230410022226.181812-3-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410022226.181812-1-chenzhongjin@huawei.com>
References: <20230410022226.181812-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reported a UAF problem in profile_tick():

  BUG: KASAN: use-after-free in profile_tick+0x5c/0x80
  Read of size 8 at addr ffff888100928aa0 by task bash/1108

  CPU: 2 PID: 1108 Comm: bash Not tainted 5.10.0+ #72
  Call Trace:
   <IRQ>
   dump_stack+0x93/0xc5
   print_address_description.constprop.0+0x1c/0x3c0
   kasan_report.cold+0x37/0x74
   check_memory_region+0x161/0x1c0
   profile_tick+0x5c/0x80
   tick_sched_timer+0xcd/0x100
   __hrtimer_run_queues+0x23e/0x480
   hrtimer_interrupt+0x1c2/0x440
   asm_call_irq_on_stack+0xf/0x20
   </IRQ>
  ...

It is beacause in profiling_store(), profile_init() is possible to fail
and free prof_cpu_mask. However prof_cpu_mask is not set to NULL and
cpumask_available(prof_cpu_mask) will return true in profile_tick().
Then cpumask_test_cpu() will dereference prof_cpu_mask and trigger the
KASAN warning.

There is no interface to disable profile_tick() even though profile_init
has been already failed. And when CONFIG_CPUMASK_OFFSTACK=n, cpumask_var_t
is an array pointer which can not be set to NULL. So prof_cpu_mask can be
a freed pointner or uncleaned array here, and cpumask_available() can't
promise it is safe to use it.

To fix this, add check for prof_buffer in profile_tick() before check
cpumask_available(prof_cpu_mask). Because prof_cpu_mask is available only
after prof_buffer is allocated successfully.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/profile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index 8a77769bc4b4..cca47dc2b1db 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -334,7 +334,7 @@ void profile_tick(int type)
 {
 	struct pt_regs *regs = get_irq_regs();
 
-	if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
+	if (!user_mode(regs) && prof_buffer && cpumask_available(prof_cpu_mask) &&
 	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }
-- 
2.17.1

