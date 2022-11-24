Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F48637529
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiKXJ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXJ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:29:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0B94E43A;
        Thu, 24 Nov 2022 01:29:13 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHt3C2SP1zmW5j;
        Thu, 24 Nov 2022 17:28:39 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 17:29:06 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 17:29:06 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <syzbot+a4055c78774bbf3498bb@syzkaller.appspotmail.com>,
        <linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>, <miklos@szeredi.hu>
Subject: [PATCH] ovl: Fix use inode directly in rcu-walk mode
Date:   Thu, 24 Nov 2022 17:26:02 +0800
Message-ID: <20221124092602.259809-1-chenzhongjin@huawei.com>
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

syzkaller reported a null-ptr-deref error:
https://syzkaller.appspot.com/bug?id=bb281e89381b9ed55728c274447a575e69a96c35

ovl_dentry_revalidate_common() can be called in rcu-walk mode.
As document said, "in rcu-walk mode, d_parent and d_inode should not be
used without care". Check inode here to protect access under rcu-walk
mode.

Fixes: bccece1ead36 ("ovl: allow remote upper")
Reported-by: syzbot+a4055c78774bbf3498bb@syzkaller.appspotmail.com
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 fs/overlayfs/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a29a8afe9b26..d61ab192dfd9 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -139,11 +139,19 @@ static int ovl_dentry_revalidate_common(struct dentry *dentry,
 					unsigned int flags, bool weak)
 {
 	struct ovl_entry *oe = dentry->d_fsdata;
+	struct inode *inode;
 	struct dentry *upper;
 	unsigned int i;
 	int ret = 1;
 
-	upper = ovl_dentry_upper(dentry);
+	if (flags & LOOKUP_RCU) {
+		inode = d_inode_rcu(dentry);
+		if (!inode)
+			return -ECHILD;
+		upper = ovl_upperdentry_dereference(OVL_I(inode));
+	} else
+		upper = ovl_dentry_upper(dentry);
+
 	if (upper)
 		ret = ovl_revalidate_real(upper, flags, weak);
 
-- 
2.17.1

