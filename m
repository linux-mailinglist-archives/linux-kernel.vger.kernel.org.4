Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC0666874
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjALBdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjALBde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:33:34 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040F727186
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:33:32 -0800 (PST)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nsn4n71JbzqV7f;
        Thu, 12 Jan 2023 09:28:41 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 09:33:28 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <almaz.alexandrovich@paragon-software.com>,
        <kari.argillander@gmail.com>, <akpm@linux-foundation.org>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>,
        ZhangPeng <zhangpeng362@huawei.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH -next] fs/ntfs3: Fix potential NULL/IS_ERR bug in ntfs_lookup()
Date:   Thu, 12 Jan 2023 01:32:48 +0000
Message-ID: <20230112013248.2464556-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Dan Carpenter reported a Smatch static checker warning:

fs/ntfs3/namei.c:96 ntfs_lookup()
error: potential NULL/IS_ERR bug 'inode'
It will cause null-ptr-deref when dir_search_u() returns NULL if the
file is not found.
Fix this by replacing IS_ERR() with IS_ERR_OR_NULL() to add a check for
NULL.

Fixes: fb6b59b5a2d6 ("fs/ntfs3: Fix null-ptr-deref on inode->i_op in ntfs_lookup()")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 3db34d5c03dc..f23c2c26dd08 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -93,7 +93,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 	 * If the MFT record of ntfs inode is not a base record, inode->i_op can be NULL.
 	 * This causes null pointer dereference in d_splice_alias().
 	 */
-	if (!IS_ERR(inode) && inode->i_op == NULL) {
+	if (!IS_ERR_OR_NULL(inode) && inode->i_op == NULL) {
 		iput(inode);
 		inode = ERR_PTR(-EINVAL);
 	}
-- 
2.25.1

