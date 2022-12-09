Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6918A64800C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiLIJVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLIJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:21:02 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2919E5802F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:21:02 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NT58S0rDHzmWXZ;
        Fri,  9 Dec 2022 17:20:08 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 9 Dec
 2022 17:20:49 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <jingyuwang_vip@163.com>,
        <legion@kernel.org>, <longman@redhat.com>
CC:     <akpm@linux-foundation.org>, <ebiederm@xmission.com>,
        <roman.gushchin@linux.dev>, <songmuchun@bytedance.com>,
        <yuzhe@nfschina.com>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH] ipc: fix memory leak in init_mqueue_fs()
Date:   Fri, 9 Dec 2022 17:29:29 +0800
Message-ID: <20221209092929.1978875-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setup_mq_sysctls() failed in init_mqueue_fs(), mqueue_inode_cachep
is not released. In order to fix this issue, the release path is reordered.

Fixes: dc55e35f9e81 ("ipc: Store mqueue sysctls in the ipc namespace")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 ipc/mqueue.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 467a194b8a2e..d09aa1c1e3e6 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1726,7 +1726,8 @@ static int __init init_mqueue_fs(void)
 
 	if (!setup_mq_sysctls(&init_ipc_ns)) {
 		pr_warn("sysctl registration failed\n");
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto out_kmem;
 	}
 
 	error = register_filesystem(&mqueue_fs_type);
@@ -1744,8 +1745,9 @@ static int __init init_mqueue_fs(void)
 out_filesystem:
 	unregister_filesystem(&mqueue_fs_type);
 out_sysctl:
-	kmem_cache_destroy(mqueue_inode_cachep);
 	retire_mq_sysctls(&init_ipc_ns);
+out_kmem:
+	kmem_cache_destroy(mqueue_inode_cachep);
 	return error;
 }
 
-- 
2.34.1

