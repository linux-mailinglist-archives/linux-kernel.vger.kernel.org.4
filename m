Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC285F096C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiI3LDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiI3LCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:02:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7398965649
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:40:16 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mf67P13xPzWh56;
        Fri, 30 Sep 2022 18:35:13 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:39:22 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:39:21 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <devel@lists.orangefs.org>
CC:     <hubcap@omnibond.com>, <martin@omnibond.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next] orangefs: Remove unused variable 'i'
Date:   Fri, 30 Sep 2022 18:35:31 +0800
Message-ID: <20220930103531.41726-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by Clang [-Wunused-but-set-variable]

'commit 3e9dfc6e1e8b ("orangefs: move do_readv_writev to direct_IO")'
This commit added the variable 'i' in orangefs_direct_IO().
However this 'i' was never used by other code except iterates itself.

It seems that it's some undeleted debug code. Remove it for code clean.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 fs/orangefs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 7a8c0c6e698d..eaa35a966115 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -530,7 +530,6 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 	size_t count = iov_iter_count(iter);
 	ssize_t total_count = 0;
 	ssize_t ret = -EINVAL;
-	int i = 0;
 
 	gossip_debug(GOSSIP_FILE_DEBUG,
 		"%s-BEGIN(%pU): count(%d) after estimate_max_iovecs.\n",
@@ -556,7 +555,6 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 	while (iov_iter_count(iter)) {
 		size_t each_count = iov_iter_count(iter);
 		size_t amt_complete;
-		i++;
 
 		/* how much to transfer in this loop iteration */
 		if (each_count > orangefs_bufmap_size_query())
-- 
2.17.1

