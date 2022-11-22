Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1493763385F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiKVJ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiKVJ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:27:25 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E549B7A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:27:20 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGf244WNfzqSbt;
        Tue, 22 Nov 2022 17:23:24 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:27:18 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 17:27:18 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>,
        <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: Fix memory leak if ntfs_read_mft failed
Date:   Tue, 22 Nov 2022 17:24:14 +0800
Message-ID: <20221122092414.231084-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Label ATTR_ROOT in ntfs_read_mft() sets is_root = true and
ni->ni_flags |= NI_FLAG_DIR, then next attr will goto label ATTR_ALLOC
and alloc ni->dir.alloc_run. However two states are not always
consistent and can make memory leak.

 1) attr_name in ATTR_ROOT does not fit the condition it will set
 is_root = true but NI_FLAG_DIR is not set.
 2) next attr_name in ATTR_ALLOC fits the condition and alloc
 ni->dir.alloc_run
 3) in cleanup function ni_clear(), when NI_FLAG_DIR is set, it frees
 ni->dir.alloc_run, otherwise it frees ni->file.run
 4) because NI_FLAG_DIR is not set in this case, ni->dir.alloc_run is
 leaked as kmemleak reported:

unreferenced object 0xffff888003bc5480 (size 64):
  backtrace:
    [<000000003d42e6b0>] __kmalloc_node+0x4e/0x1c0
    [<00000000d8e19b8a>] kvmalloc_node+0x39/0x1f0
    [<00000000fc3eb5b8>] run_add_entry+0x18a/0xa40 [ntfs3]
    [<0000000011c9f978>] run_unpack+0x75d/0x8e0 [ntfs3]
    [<00000000e7cf1819>] run_unpack_ex+0xbc/0x500 [ntfs3]
    [<00000000bbf0a43d>] ntfs_iget5+0xb25/0x2dd0 [ntfs3]
    [<00000000a6e50693>] ntfs_fill_super+0x218d/0x3580 [ntfs3]
    [<00000000b9170608>] get_tree_bdev+0x3fb/0x710
    [<000000004833798a>] vfs_get_tree+0x8e/0x280
    [<000000006e20b8e6>] path_mount+0xf3c/0x1930
    [<000000007bf15a5f>] do_mount+0xf3/0x110
    ...

Fix this by always setting is_root and NI_FLAG_DIR together.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 fs/ntfs3/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index d5a3afbbbfd8..b7f60624b044 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -247,7 +247,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			goto out;
 
 		root = Add2Ptr(attr, roff);
-		is_root = true;
 
 		if (attr->name_len != ARRAY_SIZE(I30_NAME) ||
 		    memcmp(attr_name(attr), I30_NAME, sizeof(I30_NAME)))
@@ -260,6 +259,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		if (!is_dir)
 			goto next_attr;
 
+		is_root = true;
 		ni->ni_flags |= NI_FLAG_DIR;
 
 		err = indx_init(&ni->dir, sbi, attr, INDEX_MUTEX_I30);
-- 
2.17.1

