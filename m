Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83685648136
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLIK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLIK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:59:24 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611D5447B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:59:22 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NT7Kz0RGQzJqMN;
        Fri,  9 Dec 2022 18:58:31 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 9 Dec
 2022 18:59:20 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <haibinzhang@tencent.com>, <hewenliang4@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] arm64: fix a concurrency issue in emulation_proc_handler()
Date:   Fri, 9 Dec 2022 18:55:56 +0800
Message-ID: <20221209105556.47621-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In emulation_proc_handler(), read and write operations are performed on
insn->current_mode. In the concurrency scenario, mutex only protects
writing insn->current_mode, and not protects the read. Suppose there are
two concurrent tasks, task1 updates insn->current_mode to INSN_EMULATE
in the critical section, the prev_mode of task2 is still the old data
INSN_UNDEF of insn->current_mode. As a result, two tasks call
update_insn_emulation_mode twice with prev_mode = INSN_UNDEF and
current_mode = INSN_EMULATE, then call register_emulation_hooks twice,
resulting in a list_add double problem.

Call trace:
 __list_add_valid+0xd8/0xe4
 register_undef_hook+0x94/0x13c
 update_insn_emulation_mode+0xd0/0x12c
 emulation_proc_handler+0xd8/0xf4
 proc_sys_call_handler+0x140/0x250
 proc_sys_write+0x1c/0x2c
 new_sync_write+0xec/0x18c
 vfs_write+0x214/0x2ac
 ksys_write+0x70/0xfc
 __arm64_sys_write+0x24/0x30
 el0_svc_common.constprop.0+0x7c/0x1bc
 do_el0_svc+0x2c/0x94
 el0_svc+0x20/0x30
 el0_sync_handler+0xb0/0xb4
 el0_sync+0x160/0x180

Fixes: af483947d472 ("arm64: fix oops in concurrently setting insn_emulation sysctls")
Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index fb0e7c7b2e20..d33e5d9e6990 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -208,10 +208,12 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
 				  loff_t *ppos)
 {
 	int ret = 0;
-	struct insn_emulation *insn = container_of(table->data, struct insn_emulation, current_mode);
-	enum insn_emulation_mode prev_mode = insn->current_mode;
+	struct insn_emulation *insn;
+	enum insn_emulation_mode prev_mode;
 
 	mutex_lock(&insn_emulation_mutex);
+	insn = container_of(table->data, struct insn_emulation, current_mode);
+	prev_mode = insn->current_mode;
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
 	if (ret || !write || prev_mode == insn->current_mode)
-- 
2.25.1

