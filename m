Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A392D5BE9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiITPQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiITPPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:15:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC28060535;
        Tue, 20 Sep 2022 08:15:48 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MX4lD0zS9zmVjB;
        Tue, 20 Sep 2022 23:11:52 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:46 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:46 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <jolsa@kernel.org>, <guoren@kernel.org>, <nsaenzju@redhat.com>,
        <frederic@kernel.org>, <changbin.du@intel.com>,
        <vincent.chen@sifive.com>, <ardb@kernel.org>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <keescook@chromium.org>, <catalin.marinas@arm.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next 4/7] riscv: syscall: Don't clobber s0 when syscall
Date:   Tue, 20 Sep 2022 23:11:59 +0800
Message-ID: <20220920151202.180057-5-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920151202.180057-1-chenzhongjin@huawei.com>
References: <20220920151202.180057-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall uses s0 to load address of sys_call_table.

Since now we uses s0 to save pt_regs for unwinding, clobber
s0 can make unwinder treat s0 as pt_regs address. Use s1 for
this job.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/riscv/kernel/entry.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index ecb15c7430b4..a3b14a649782 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -205,33 +205,33 @@ handle_syscall:
 check_syscall_nr:
 	/* Check to make sure we don't jump to a bogus syscall number. */
 	li t0, __NR_syscalls
-	la s0, sys_ni_syscall
+	la s1, sys_ni_syscall
 	/*
 	 * Syscall number held in a7.
 	 * If syscall number is above allowed value, redirect to ni_syscall.
 	 */
 	bgeu a7, t0, 3f
 #ifdef CONFIG_COMPAT
-	REG_L s0, PT_STATUS(sp)
-	srli s0, s0, SR_UXL_SHIFT
-	andi s0, s0, (SR_UXL >> SR_UXL_SHIFT)
+	REG_L s1, PT_STATUS(sp)
+	srli s1, s1, SR_UXL_SHIFT
+	andi s1, s1, (SR_UXL >> SR_UXL_SHIFT)
 	li t0, (SR_UXL_32 >> SR_UXL_SHIFT)
-	sub t0, s0, t0
+	sub t0, s1, t0
 	bnez t0, 1f
 
 	/* Call compat_syscall */
-	la s0, compat_sys_call_table
+	la s1, compat_sys_call_table
 	j 2f
 1:
 #endif
 	/* Call syscall */
-	la s0, sys_call_table
+	la s1, sys_call_table
 2:
 	slli t0, a7, RISCV_LGPTR
-	add s0, s0, t0
-	REG_L s0, 0(s0)
+	add s1, s1, t0
+	REG_L s1, 0(s1)
 3:
-	jalr s0
+	jalr s1
 
 ret_from_syscall:
 	/* Set user a0 to kernel a0 */
-- 
2.17.1

