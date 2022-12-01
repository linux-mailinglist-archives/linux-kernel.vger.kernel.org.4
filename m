Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A863EB51
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiLAImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLAImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:42:15 -0500
X-Greylist: delayed 514 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 00:42:13 PST
Received: from mail-m12746.qiye.163.com (mail-m12746.qiye.163.com [115.236.127.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889EB865BB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:42:13 -0800 (PST)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:327b:59a0:748d:aafb:564e:dca6])
        by mail-m12746.qiye.163.com (Hmail) with ESMTPA id F1FD9BC04CD;
        Thu,  1 Dec 2022 16:33:35 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ding Hui <dinghui@sangfor.com.cn>
Subject: [RFC PATCH] arch/arm64: put crash_save_cpu() at last before die
Date:   Thu,  1 Dec 2022 16:33:13 +0800
Message-Id: <20221201083313.11734-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSh5NVklKTk1JSkxMT01LSlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTBlBTkIaS0FMT0MfQRoaHRlBTk1PHkEfGBpNWVdZFhoPEhUdFF
        lBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCI6LDo*ND0eSxYuDDAJCCkQ
        H04wFB9VSlVKTU1CQ0NITUpNTUlNVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUwZQU5CGktBTE9DH0EaGh0ZQU5NTx5BHxgaTVlXWQgBWUFJSkJDNwY+
X-HM-Tid: 0a84ccd1db81b219kuuuf1fd9bc04cd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we debug a vmcore by crash utility, sometimes we got
backtraces on non-panic core like this:

crash> bt -c 1
PID: 0      TASK: ffff80014107a000  CPU: 1   COMMAND: "swapper/1"
 #0 [1ffff0002f73c7dc] crash_save_cpu at ffff20002031cb68

The crash utility do backtrace by search LR from stack,
which pushed by callee of crash_save_cpu().

So the LR is easier to be destroyed by subsequent invoking other
functions, and lead to crash failed to backtrace on non-panic core

I tried to put crash_save_cpu() after sdei_mask_local_cpu(), and
it turns out bt is working to me.

But I'm not sure the order of crash_save_cpu() is whether strictly
required, so I send this RFC patch to get some suggestion.

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 arch/arm64/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ffc5d76cf695..5f1defe76f3d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -842,13 +842,13 @@ static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
 static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 {
 #ifdef CONFIG_KEXEC_CORE
-	crash_save_cpu(regs, cpu);
-
 	atomic_dec(&waiting_for_crash_ipi);
 
 	local_irq_disable();
 	sdei_mask_local_cpu();
 
+	crash_save_cpu(regs, cpu);
+
 	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		__cpu_try_die(cpu);
 
-- 
2.17.1

