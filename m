Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4396004FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 03:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJQB5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJQB5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:57:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00CB4151F;
        Sun, 16 Oct 2022 18:57:11 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrKkN4fmjzmV9f;
        Mon, 17 Oct 2022 09:52:28 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 09:57:08 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <djwong@kernel.org>, <dchinner@redhat.com>, <bfoster@redhat.com>
CC:     <lizetao1@huawei.com>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] xfs: Fix unreferenced object reported by kmemleak in xfs_sysfs_init()
Date:   Mon, 17 Oct 2022 11:00:29 +0800
Message-ID: <20221017030029.3876512-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
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

kmemleak reported a sequence of memory leaks, and one of them indicated we
failed to free a pointer:
  comm "mount", pid 19610, jiffies 4297086464 (age 60.635s)
    hex dump (first 8 bytes):
      73 64 61 00 81 88 ff ff                          sda.....
    backtrace:
      [<00000000d77f3e04>] kstrdup_const+0x46/0x70
      [<00000000e51fa804>] kobject_set_name_vargs+0x2f/0xb0
      [<00000000247cd595>] kobject_init_and_add+0xb0/0x120
      [<00000000f9139aaf>] xfs_mountfs+0x367/0xfc0
      [<00000000250d3caf>] xfs_fs_fill_super+0xa16/0xdc0
      [<000000008d873d38>] get_tree_bdev+0x256/0x390
      [<000000004881f3fa>] vfs_get_tree+0x41/0xf0
      [<000000008291ab52>] path_mount+0x9b3/0xdd0
      [<0000000022ba8f2d>] __x64_sys_mount+0x190/0x1d0

As mentioned in kobject_init_and_add() comment, if this function
returns an error, kobject_put() must be called to properly clean up
the memory associated with the object. Apparently, xfs_sysfs_init()
does not follow such a requirement. When kobject_init_and_add()
returns an error, the space of kobj->kobject.name alloced by
kstrdup_const() is unfree, which will cause the above stack.

Fix it by adding kobject_put() when kobject_init_and_add returns an
error.

Fixes: a31b1d3d89e4 ("xfs: add xfs_mount sysfs kobject")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/xfs/xfs_sysfs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
index 43585850f154..513095e353a5 100644
--- a/fs/xfs/xfs_sysfs.h
+++ b/fs/xfs/xfs_sysfs.h
@@ -33,10 +33,15 @@ xfs_sysfs_init(
 	const char		*name)
 {
 	struct kobject		*parent;
+	int err;
 
 	parent = parent_kobj ? &parent_kobj->kobject : NULL;
 	init_completion(&kobj->complete);
-	return kobject_init_and_add(&kobj->kobject, ktype, parent, "%s", name);
+	err = kobject_init_and_add(&kobj->kobject, ktype, parent, "%s", name);
+	if (err)
+		kobject_put(&kobj->kobject);
+
+	return err;
 }
 
 static inline void
-- 
2.31.1

