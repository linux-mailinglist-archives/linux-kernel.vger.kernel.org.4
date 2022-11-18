Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC962EF94
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbiKRIdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbiKRIcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:32:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35528BE9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:32:49 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND9154WhVzqSWS;
        Fri, 18 Nov 2022 16:28:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:32:47 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 18 Nov
 2022 16:32:47 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <longman@redhat.com>, <boqun.feng@gmail.com>, <bvanassche@acm.org>
Subject: [PATCH] locking/lockdep: fix null-ptr-deref in check_prev_add()
Date:   Fri, 18 Nov 2022 16:31:02 +0800
Message-ID: <20221118083102.4011977-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a null-ptr-deref report as following:

general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 0 PID: 500 Comm: systemd-udevd Tainted: G        W          6.1.0-rc5-00144-gabd8ea84ca72-dirty #1320
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:check_prevs_add+0x2f8/0x2780
Call Trace:
 <TASK>
 __lock_acquire+0x2ae8/0x3d60
 lock_acquire+0x195/0x4e0
 fs_reclaim_acquire+0x119/0x160
 kmem_cache_alloc_node+0x47/0x310
 __alloc_skb+0x205/0x2d0
 devlink_compat_running_version+0x10b/0x6a0
 dev_ethtool+0x285/0x380
 dev_ioctl+0x16c/0xff0
 sock_do_ioctl+0x1ae/0x220
 sock_ioctl+0x55f/0x600
 __x64_sys_ioctl+0x156/0x1d0
 do_syscall_64+0x37/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

If in use bit of lock_class is not set, hlock_class() returns NULL,
it causes null-ptr-deref while using it in check_prev_add(). Fix this
by adding null pointer check for it.

Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
Reported-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/locking/lockdep.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e3375bc40dad..f0a28f9ed426 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3063,10 +3063,13 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	       struct held_lock *next, u16 distance,
 	       struct lock_trace **const trace)
 {
+	struct lock_class *prev_class = hlock_class(prev);
+	struct lock_class *next_class = hlock_class(next);
 	struct lock_list *entry;
 	enum bfs_result ret;
 
-	if (!hlock_class(prev)->key || !hlock_class(next)->key) {
+	if ((prev_class && !prev_class->key) ||
+	    (next_class && !next_class->key)) {
 		/*
 		 * The warning statements below may trigger a use-after-free
 		 * of the class name. It is better to trigger a use-after free
-- 
2.25.1

