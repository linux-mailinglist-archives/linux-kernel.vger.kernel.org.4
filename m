Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6881F6A184A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBXIw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjBXIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:52:29 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4013662A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:52:00 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PNNq472c7zRsSP;
        Fri, 24 Feb 2023 16:49:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Feb 2023 16:51:51 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>, <akpm@linux-foudation.org>,
        <wuchi.zero@gmail.com>, <ben-linux@fluff.org>,
        <rusty@rustcorp.com.au>
Subject: [PATCH] x86: profiling: Set prof_cpu_mask to NULL after free
Date:   Fri, 24 Feb 2023 16:49:45 +0800
Message-ID: <20230224084945.134038-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

There is no interface to disable profile_tick() even though profile_init()
has been already failed. So just set prof_cpu_mask to NULL when free it.
Then accessing to prof_cpu_mask can be rejected by prof_buffer or
cpumask_available().

Fixes: c309b917cab5 ("cpumask: convert kernel/profile.c")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/profile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index 8a77769bc4b4..d60f9634fb2a 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -133,6 +133,7 @@ int __ref profile_init(void)
 		return 0;
 
 	free_cpumask_var(prof_cpu_mask);
+	prof_cpu_mask = NULL;
 	return -ENOMEM;
 }
 
@@ -334,7 +335,7 @@ void profile_tick(int type)
 {
 	struct pt_regs *regs = get_irq_regs();
 
-	if (!user_mode(regs) && cpumask_available(prof_cpu_mask) &&
+	if (!user_mode(regs) && prof_buffer && cpumask_available(prof_cpu_mask) &&
 	    cpumask_test_cpu(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }
-- 
2.17.1

