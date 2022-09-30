Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB55F0971
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiI3LEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiI3LDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:03:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE03415FC5D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 03:41:14 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mf68T5Nz1zWh9J;
        Fri, 30 Sep 2022 18:36:09 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:40:18 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 18:40:18 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-afs@lists.infradead.org>
CC:     <dhowells@redhat.com>, <marc.dionne@auristor.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next] afs: Remove unused loop code 'nr_servers'
Date:   Fri, 30 Sep 2022 18:36:28 +0800
Message-ID: <20220930103628.59511-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
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

Reported by Clang [-Wunused-but-set-variable]

'commit 45df8462730d ("afs: Fix server list handling")'
This commit deleted all the logic about searching records in servers,
but the loop to count 'nr_servers' was not dropped together.

Since these code should have been part of deleted code, and also there
is no other code referencing them, remove them for code cleaning.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 fs/afs/volume.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index f4937029dcd7..29d483c80281 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -70,11 +70,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 {
 	struct afs_server_list *slist;
 	struct afs_volume *volume;
-	int ret = -ENOMEM, nr_servers = 0, i;
-
-	for (i = 0; i < vldb->nr_servers; i++)
-		if (vldb->fs_mask[i] & type_mask)
-			nr_servers++;
+	int ret = -ENOMEM;
 
 	volume = kzalloc(sizeof(struct afs_volume), GFP_KERNEL);
 	if (!volume)
-- 
2.17.1

