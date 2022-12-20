Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E855651ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiLTGmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLTGmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:42:12 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95816633E;
        Mon, 19 Dec 2022 22:42:10 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nbn5j2SxqzRq0Y;
        Tue, 20 Dec 2022 14:40:57 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 14:42:06 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linux-modules@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] kallsyms: Fix sleeping function called from invalid context when CONFIG_KALLSYMS_SELFTEST=y
Date:   Tue, 20 Dec 2022 14:39:23 +0800
Message-ID: <20221220063923.1937-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[T58] BUG: sleeping function called from invalid context at kernel/kallsyms.c:305
[T58] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 58, name: kallsyms_test
[T58] preempt_count: 0, expected: 0
[T58] RCU nest depth: 0, expected: 0
[T58] no locks held by kallsyms_test/58.
[T58] irq event stamp: 18899904
[T58] hardirqs last enabled at (18899903): finish_task_switch.isra.0 (core.c:?)
[T58] hardirqs last disabled at (18899904): test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
[T58] softirqs last enabled at (18899886): __do_softirq (??:?)
[T58] softirqs last disabled at (18899879): ____do_softirq (irq.c:?)
[T58] CPU: 0 PID: 58 Comm: kallsyms_test Tainted: G T  6.1.0-next-20221215 #2
[T58] Hardware name: linux,dummy-virt (DT)
[T58] Call trace:
[T58] dump_backtrace (??:?)
[T58] show_stack (??:?)
[T58] dump_stack_lvl (??:?)
[T58] dump_stack (??:?)
[T58] __might_resched (??:?)
[T58] kallsyms_on_each_symbol (??:?)
[T58] test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
[T58] test_entry (kallsyms_selftest.c:?)
[T58] kthread (kthread.c:?)
[T58] ret_from_fork (??:?)
[T58] kallsyms_selftest: kallsyms_on_each_symbol() traverse all: 5744310840 ns
[T58] kallsyms_selftest: kallsyms_on_each_match_symbol() traverse all: 1164580 ns
[T58] kallsyms_selftest: finish

Functions kallsyms_on_each_symbol() and kallsyms_on_each_match_symbol()
call the user-registered hook function for each symbol that meets the
requirements. Because it is uncertain how long that hook function will
execute, they call cond_resched() to avoid consuming CPU resources for a
long time. However, irqs need to be disabled during the performance test
to ensure the accuracy of test data. Because the performance test hook is
very clear, very simple function, let's do not call cond_resched() when
CONFIG_KALLSYMS_SELFTEST=y.

Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/kallsyms.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 83f499182c9aa31..a49e344a686517b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -302,7 +302,8 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 		ret = fn(data, namebuf, NULL, kallsyms_sym_address(i));
 		if (ret != 0)
 			return ret;
-		cond_resched();
+		if (!IS_ENABLED(CONFIG_KALLSYMS_SELFTEST))
+			cond_resched();
 	}
 	return 0;
 }
@@ -319,7 +320,8 @@ int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
 
 	for (i = start; !ret && i <= end; i++) {
 		ret = fn(data, kallsyms_sym_address(get_symbol_seq(i)));
-		cond_resched();
+		if (!IS_ENABLED(CONFIG_KALLSYMS_SELFTEST))
+			cond_resched();
 	}
 
 	return ret;
-- 
2.25.1

