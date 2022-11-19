Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45297630B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKSDuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiKSDtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:49:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AF6C4969;
        Fri, 18 Nov 2022 19:47:21 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDfjB1GcJzmVw8;
        Sat, 19 Nov 2022 11:46:54 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 11:47:19 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 11:47:19 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <sfrench@samba.org>, <pc@cjr.nz>, <dhowells@redhat.com>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, <chenxiaosong2@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <yanaijie@huawei.com>
Subject: [PATCH] cifs: fix missing unlock in cifs_file_copychunk_range()
Date:   Sat, 19 Nov 2022 12:51:59 +0800
Message-ID: <20221119045159.1400244-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfstests generic/013 and generic/476 reported WARNING as follows:

  WARNING: lock held when returning to user space!
  6.1.0-rc5+ #4 Not tainted
  ------------------------------------------------
  fsstress/504233 is leaving the kernel with locks still held!
  2 locks held by fsstress/504233:
   #0: ffff888054c38850 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at:
                        lock_two_nondirectories+0xcf/0xf0
   #1: ffff8880b8fec750 (&sb->s_type->i_mutex_key#21/4){+.+.}-{3:3}, at:
                        lock_two_nondirectories+0xb7/0xf0

This will lead to deadlock and hungtask.

Fix this by releasing locks when failed to write out on a file range in
cifs_file_copychunk_range().

Fixes: 3e3761f1ec7d ("smb3: use filemap_write_and_wait_range instead of filemap_write_and_wait")
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/cifs/cifsfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index fe220686bba4..712a43161448 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1281,7 +1281,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	rc = filemap_write_and_wait_range(src_inode->i_mapping, off,
 					  off + len - 1);
 	if (rc)
-		goto out;
+		goto unlock;
 
 	/* should we flush first and last page first */
 	truncate_inode_pages(&target_inode->i_data, 0);
@@ -1297,6 +1297,8 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	 * that target is updated on the server
 	 */
 	CIFS_I(target_inode)->time = 0;
+
+unlock:
 	/* although unlocking in the reverse order from locking is not
 	 * strictly necessary here it is a little cleaner to be consistent
 	 */
-- 
2.31.1

