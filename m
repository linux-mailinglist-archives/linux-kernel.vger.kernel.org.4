Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2196006C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJQGeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJQGeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:34:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B27457241
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 23:34:18 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrRt60Tl0z1P7qM;
        Mon, 17 Oct 2022 14:29:34 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 14:34:07 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <brauner@kernel.org>, <akpm@linux-foundation.org>,
        <tglx@linutronix.de>, <ebiederm@xmission.com>, <luto@kernel.org>,
        <bigeasy@linutronix.de>, <Liam.Howlett@Oracle.com>,
        <fenghua.yu@intel.com>, <peterz@infradead.org>,
        <viro@zeniv.linux.org.uk>, <jannh@google.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] copy_process(): fix a memleak in copy_process()
Date:   Mon, 17 Oct 2022 14:34:06 +0800
Message-ID: <20221017063406.604188-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CLONE_PIDFD is set in clone_flags, pidfile will hold the reference
count of pid by getpid(pid), In the error path bad_fork_put_pidfd, the
reference of pid needs to be released, otherwise there will be a
memleak issue, fix it.

unreferenced object 0xffff888164aed400 (size 224):
  comm "sh", pid 75274, jiffies 4295717290 (age 2955.536s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
    ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000bcb9eebb>] kmem_cache_alloc+0x16a/0x7f0
    [<00000000340cf9ad>] alloc_pid+0xc5/0xce0
    [<000000002387362c>] copy_process+0x29ef/0x6c90
    [<00000000bf7d7efc>] kernel_clone+0xd9/0xc70
    [<0000000047b1a04f>] __do_sys_clone+0xe1/0x120
    [<0000000000f1aa25>] __x64_sys_clone+0xc3/0x150
    [<00000000250a19f1>] do_syscall_64+0x5c/0x90
    [<000000007e0ac417>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..8706c06be8af 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2499,6 +2499,7 @@ static __latent_entropy struct task_struct *copy_process(
 	cgroup_cancel_fork(p, args);
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
+		put_pid(pid);
 		fput(pidfile);
 		put_unused_fd(pidfd);
 	}
-- 
2.25.1

