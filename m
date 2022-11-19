Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A817630BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 05:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKSEAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 23:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKSEA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 23:00:29 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CADFE084;
        Fri, 18 Nov 2022 20:00:25 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NDg0F5NfVz15Mcv;
        Sat, 19 Nov 2022 11:59:57 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 12:00:22 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 12:00:22 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <paulmck@kernel.org>, <frederic@kernel.org>,
        <quic_neeraju@quicinc.com>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <zhengyejian1@huawei.com>
Subject: [PATCH] rcu: Fix kernel stack overflow caused by kprobe on rcu_irq_enter_check_tick()
Date:   Sat, 19 Nov 2022 12:00:49 +0800
Message-ID: <20221119040049.795065-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register kprobe on __rcu_irq_enter_check_tick() can cause kernel stack
overflow [1]. This issue is first found in v5.10 and can be reproduced
by enabling CONFIG_NO_HZ_FULL and doing like:
  # cd /sys/kernel/debug/tracing/
  # echo 'p:mp1 __rcu_irq_enter_check_tick' >> kprobe_events
  # echo 1 > events/kprobes/enable

So __rcu_irq_enter_check_tick() should not be kprobed, mark it as noinstr.

[1]
Insufficient stack space to handle exception!
Insufficient stack space to handle exception!
[...]
Kernel panic - not syncing: kernel stack overflow
CPU: 3 PID: 34 Comm: migration/3 Not tainted
6.1.0-rc5-00884-g84368d882b96 #2
Hardware name: linux,dummy-virt (DT)
Stopper: multi_cpu_stop+0x0/0x228 <- __stop_cpus.constprop.0+0xa4/0x100
Call trace:
 dump_backtrace+0xf8/0x108
 show_stack+0x20/0x48
 dump_stack_lvl+0x68/0x84
 dump_stack+0x1c/0x38
 panic+0x214/0x404
 add_taint+0x0/0xf0
 panic_bad_stack+0x144/0x160
 handle_bad_stack+0x38/0x58
 __bad_stack+0x78/0x7c
 el1h_64_sync_handler+0x4/0xe8
 __rcu_irq_enter_check_tick+0x0/0x1b8
 arm64_enter_el1_dbg.isra.0+0x14/0x20
 el1_dbg+0x2c/0x90
 el1h_64_sync_handler+0xcc/0xe8
 el1h_64_sync+0x64/0x68
 __rcu_irq_enter_check_tick+0x0/0x1b8
 arm64_enter_el1_dbg.isra.0+0x14/0x20
 el1_dbg+0x2c/0x90
 el1h_64_sync_handler+0xcc/0xe8
 el1h_64_sync+0x64/0x68
 __rcu_irq_enter_check_tick+0x0/0x1b8
 arm64_enter_el1_dbg.isra.0+0x14/0x20
 el1_dbg+0x2c/0x90
 el1h_64_sync_handler+0xcc/0xe8
 el1h_64_sync+0x64/0x68
 __rcu_irq_enter_check_tick+0x0/0x1b8
 arm64_enter_el1_dbg.isra.0+0x14/0x20
 el1_dbg+0x2c/0x90
 el1h_64_sync_handler+0xcc/0xe8
 el1h_64_sync+0x64/0x68
 __rcu_irq_enter_check_tick+0x0/0x1b8
 arm64_enter_el1_dbg.isra.0+0x14/0x20
 el1_dbg+0x2c/0x90
 el1h_64_sync_handler+0xcc/0xe8
 el1h_64_sync+0x64/0x68
 __rcu_irq_enter_check_tick+0x0/0x1b8
 [...]

Cc: stable@vger.kernel.org
Fixes: aaf2bc50df1f ("rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 93416afebd59..68230f02cfb7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -631,7 +631,7 @@ void rcu_irq_exit_check_preempt(void)
  * controlled environments, this function allows RCU to get what it
  * needs without creating otherwise useless interruptions.
  */
-void __rcu_irq_enter_check_tick(void)
+noinstr void __rcu_irq_enter_check_tick(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-- 
2.25.1

