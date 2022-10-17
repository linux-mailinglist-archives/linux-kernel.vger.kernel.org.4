Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6866004E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 03:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJQBqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 21:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJQBqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:46:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E959349A4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:46:04 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrKZs5HP7zHvss;
        Mon, 17 Oct 2022 09:45:57 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:46:02 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 09:46:02 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <jlbec@evilplan.org>, <hch@lst.de>, <chenzhongjin@huawei.com>
Subject: [PATCH] configfs: Fix possible memory leak in configfs_create_dir()
Date:   Mon, 17 Oct 2022 09:42:30 +0800
Message-ID: <20221017014230.119161-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak reported memory leaks in configfs_create_dir():

unreferenced object 0xffff888009f6af00 (size 192):
  comm "modprobe", pid 3777, jiffies 4295537735 (age 233.784s)
  backtrace:
    kmem_cache_alloc (mm/slub.c:3250 mm/slub.c:3256 mm/slub.c:3263 mm/slub.c:3273)
    new_fragment (./include/linux/slab.h:600 fs/configfs/dir.c:163)
    configfs_register_subsystem (fs/configfs/dir.c:1857)
    basic_write (drivers/hwtracing/stm/p_basic.c:14) stm_p_basic
    do_one_initcall (init/main.c:1296)
    do_init_module (kernel/module/main.c:2455)
    ...

unreferenced object 0xffff888003ba7180 (size 96):
  comm "modprobe", pid 3777, jiffies 4295537735 (age 233.784s)
  backtrace:
    kmem_cache_alloc (mm/slub.c:3250 mm/slub.c:3256 mm/slub.c:3263 mm/slub.c:3273)
    configfs_new_dirent (./include/linux/slab.h:723 fs/configfs/dir.c:194)
    configfs_make_dirent (fs/configfs/dir.c:248)
    configfs_create_dir (fs/configfs/dir.c:296)
    configfs_attach_group.isra.28 (fs/configfs/dir.c:816 fs/configfs/dir.c:852)
    configfs_register_subsystem (fs/configfs/dir.c:1881)
    basic_write (drivers/hwtracing/stm/p_basic.c:14) stm_p_basic
    do_one_initcall (init/main.c:1296)
    do_init_module (kernel/module/main.c:2455)
    ...

This is because the refcount is not correct in configfs_make_dirent().
For normal stage, the refcount is changing as:

configfs_register_subsystem()
  configfs_create_dir()
    configfs_make_dirent()
      configfs_new_dirent() # set s_count = 1
      dentry->d_fsdata = configfs_get(sd); # s_count = 2
...
configfs_unregister_subsystem()
  configfs_remove_dir()
    remove_dir()
      configfs_remove_dirent() # s_count = 1
    dput() ...
      *dentry_unlink_inode()*
        configfs_d_iput() # s_count = 0, release

However, if we failed in configfs_create():

configfs_register_subsystem()
  configfs_create_dir()
    configfs_make_dirent() # s_count = 2
    ...
    configfs_create() # fail
    ->out_remove:
    configfs_remove_dirent(dentry)
      configfs_put(sd) # s_count = 1
      return PTR_ERR(inode);

There is no inode in the error path, so the configfs_d_iput() is lost
and makes sd and fragment memory leaked.

To fix this, when we failed in configfs_create(), manually call
configfs_put(sd) to keep the refcount correct.

Fixes: 7063fbf22611 ("[PATCH] configfs: User-driven configuration filesystem")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 fs/configfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index d1f9d2632202..ec6519e1ca3b 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -316,6 +316,7 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
 	return 0;
 
 out_remove:
+	configfs_put(dentry->d_fsdata);
 	configfs_remove_dirent(dentry);
 	return PTR_ERR(inode);
 }
@@ -382,6 +383,7 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
 	return 0;
 
 out_remove:
+	configfs_put(dentry->d_fsdata);
 	configfs_remove_dirent(dentry);
 	return PTR_ERR(inode);
 }
-- 
2.17.1

