Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A0D6121A7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJ2I7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJ2I7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:59:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E8D5D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 01:59:28 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MztYT2pgTzpVsR
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 16:55:57 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 16:59:26 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 29 Oct
 2022 16:59:25 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <tglx@linutronix.de>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] posix-timers: Prevent overflow for clock_nanosleep
Date:   Sat, 29 Oct 2022 16:58:24 +0800
Message-ID: <20221029085824.3275987-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN complains about signed-integer-overflow:
[  127.044171] ================================================================================
[  127.045183] UBSAN: signed-integer-overflow in ./include/linux/ktime.h:43:14
[  127.046043] -9223372037 * 1000000000 cannot be represented in type 'long long int'
[  127.046991] CPU: 5 PID: 218 Comm: a.out Not tainted 5.10.135 #20
[  127.047443] Hardware name: linux,dummy-virt (DT)
[  127.048290] Call trace:
[  127.049600]  dump_backtrace+0x0/0x258
[  127.050183]  show_stack+0x18/0x68
[  127.050507]  dump_stack+0xd8/0x134
[  127.050765]  ubsan_epilogue+0x10/0x58
[  127.051038]  handle_overflow+0xdc/0x108
[  127.051315]  __ubsan_handle_mul_overflow+0x14/0x20
[  127.051660]  posix_cpu_timer_set+0x2f8/0x370
[  127.052295]  do_cpu_nanosleep+0xc8/0x1e8
[  127.052659]  posix_cpu_nsleep_restart+0x48/0x70
[  127.053025]  __arm64_sys_restart_syscall+0x1c/0x28
[  127.053353]  el0_svc_common.constprop.4+0x68/0x188
[  127.053684]  do_el0_svc+0x24/0x90
[  127.053926]  el0_svc+0x20/0x30
[  127.054163]  el0_sync_handler+0x90/0xb8
[  127.054424]  el0_sync+0x160/0x180
[  127.054914] ================================================================================

This can be reproduced by the following code with UBSAN enabled:

	#include <unistd.h>
	#include <syscall.h>
	#include <sys/time.h>

	int main(int argc, char* argv[]) {
		struct timespec ts = {
			.tv_sec = 9223372036854775807,
			.tv_nsec = 0
		};
		syscall(__NR_clock_nanosleep, 2, 0, &ts, NULL);
	}

Compile and execute the following sequence, it makes syscall
clock_nanosleep restart.

	./a.out &
	kill -STOP [pid]
	kill -CONT [pid]

This happens because parameter 'exp' of cpu_timer_setexpires consists of
two parts: user input from clock_nanosleep() and cpu_clock_sample return
value, both of which are s64 types, so 'exp' may be greater than S64_MAX.
When cpu_timer_setexpires stores 'exp' in cpu_timer, it convert u64 to
ktime_t resulting in expires of cpu_timer may be negative.

Fix it by limiting the maximum value of 'exp'.

Cc: <stable@vger.kernel.org>
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 include/linux/posix-timers.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 2c6e99ca48af..54ef0aedea3e 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -103,6 +103,9 @@ static inline u64 cpu_timer_getexpires(struct cpu_timer *ctmr)
 
 static inline void cpu_timer_setexpires(struct cpu_timer *ctmr, u64 exp)
 {
+	if (unlikely(exp > KTIME_MAX))
+		exp = KTIME_MAX;
+
 	ctmr->node.expires = exp;
 }
 
-- 
2.25.1

