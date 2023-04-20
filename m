Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6146E8B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjDTHPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbjDTHPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:15:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B1A3A9B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:15:39 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q28656ZlHzsRPb;
        Thu, 20 Apr 2023 15:14:05 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 15:15:36 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <almaz.alexandrovich@paragon-software.com>
CC:     <weiyongjun1@huawei.com>, <xiexiuqi@huawei.com>,
        <ntfs3@lists.linux.dev>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/ntfs3: fix panic about slab-out-of-bounds caused by ntfs_list_ea()
Date:   Thu, 20 Apr 2023 15:46:22 +0800
Message-ID: <20230420074622.210011-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a BUG report about linux-6.1 from syzbot, but it still remains
within upstream:

BUG: KASAN: slab-out-of-bounds in ntfs_list_ea fs/ntfs3/xattr.c:191 [inline]
BUG: KASAN: slab-out-of-bounds in ntfs_listxattr+0x401/0x570 fs/ntfs3/xattr.c:710
Read of size 1 at addr ffff888021acaf3d by task syz-executor128/3632

Call Trace:
 kasan_report+0x139/0x170 mm/kasan/report.c:495
 ntfs_list_ea fs/ntfs3/xattr.c:191 [inline]
 ntfs_listxattr+0x401/0x570 fs/ntfs3/xattr.c:710
 vfs_listxattr fs/xattr.c:457 [inline]
 listxattr+0x293/0x2d0 fs/xattr.c:804
 path_listxattr fs/xattr.c:828 [inline]
 __do_sys_llistxattr fs/xattr.c:846 [inline]

Before derefering field members of `ea` in unpacked_ea_size(), we need to
check whether the EA_FULL struct is located in access validate range.

Similarly, when derefering `ea->name` field member, we need to check
whethe the ea->name is located in access validate range, too.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Reported-by: syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/ntfs3/xattr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index ff64302e87e5..27eb30453b9f 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -210,11 +210,15 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 	size = le32_to_cpu(info->size);
 
 	/* Enumerate all xattrs. */
-	for (ret = 0, off = 0; off < size; off += ea_size) {
+	for (ret = 0, off = 0; off + sizeof(struct EA_FULL) < size; off += ea_size) {
 		ea = Add2Ptr(ea_all, off);
 		ea_size = unpacked_ea_size(ea);
 
 		if (buffer) {
+			/* Check if we can use field ea->name */
+			if (off + ea_size > size)
+				break;
+
 			if (ret + ea->name_len + 1 > bytes_per_buffer) {
 				err = -ERANGE;
 				goto out;
-- 
2.25.1

