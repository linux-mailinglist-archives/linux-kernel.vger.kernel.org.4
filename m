Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B924662063B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiKHBjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKHBjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:39:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E557186FF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:39:42 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5rPK0LYHzRp63;
        Tue,  8 Nov 2022 09:39:33 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 09:39:40 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 09:39:39 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Jan Kara <jack@suse.com>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] udf: fix NULL pointer dereference in udf_rename()
Date:   Tue, 8 Nov 2022 10:27:41 +0800
Message-ID: <20221108022741.492573-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported a NULL pointer dereference:

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
[...]
 Call trace:
  __memset+0x84/0x188 arch/arm64/lib/memset.S:98
  udf_delete_entry fs/udf/namei.c:577 [inline]
  udf_rename+0x47c/0x6d0 fs/udf/namei.c:1173
  vfs_rename+0x59c/0x7f8 fs/namei.c:4756
  do_renameat2+0x490/0x758 fs/namei.c:4907
  __do_sys_renameat2 fs/namei.c:4940 [inline]
[...]

Fix this by check return value of udf_find_entry() since ofi may be NULL
or error code.

Reported-by: syzbot+17fcf98a689ff64f669b@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 fs/udf/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index fb4c30e05245..e0267e72cebb 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1170,6 +1170,11 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 	/* The old fid may have moved - find it again */
 	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
+	if (IS_ERR_OR_NULL(ofi)) {
+		retval = PTR_ERR(ofi);
+		goto end_rename;
+	}
+
 	udf_delete_entry(old_dir, ofi, &ofibh, &ocfi);
 
 	if (new_inode) {
-- 
2.25.1

