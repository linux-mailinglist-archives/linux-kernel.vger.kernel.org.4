Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782396497B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 02:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiLLBeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 20:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLBeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:34:13 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC124B1EB
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 17:34:11 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NVkfJ2Bq8zRpx0;
        Mon, 12 Dec 2022 09:33:12 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 09:34:09 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <almaz.alexandrovich@paragon-software.com>
CC:     <linux-kernel@vger.kernel.org>, <ntfs3@lists.linux.dev>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH] fs/ntfs3: Fix slab-out-of-bounds read in hdr_delete_de()
Date:   Mon, 12 Dec 2022 09:31:34 +0800
Message-ID: <20221212013134.2133231-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a BUG report from syzbot:

BUG: KASAN: slab-out-of-bounds in hdr_delete_de+0xe0/0x150 fs/ntfs3/index.c:806
Read of size 16842960 at addr ffff888079cc0600 by task syz-executor934/3631

Call Trace:
 memmove+0x25/0x60 mm/kasan/shadow.c:54
 hdr_delete_de+0xe0/0x150 fs/ntfs3/index.c:806
 indx_delete_entry+0x74f/0x3670 fs/ntfs3/index.c:2193
 ni_remove_name+0x27a/0x980 fs/ntfs3/frecord.c:2910
 ntfs_unlink_inode+0x3d4/0x720 fs/ntfs3/inode.c:1712
 ntfs_rename+0x41a/0xcb0 fs/ntfs3/namei.c:276

Before using the meta-data in struct INDEX_HDR, we need to
check index header valid or not. Otherwise, the corruptedi
(or malicious) fs image can cause out-of-bounds access which
could make kernel panic.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Reported-by: syzbot+9c2811fd56591639ff5f@syzkaller.appspotmail.com
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/ntfs3/fslog.c   | 2 +-
 fs/ntfs3/index.c   | 4 ++++
 fs/ntfs3/ntfs_fs.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 0d611a6c5511..0de2bbb42721 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2597,7 +2597,7 @@ static int read_next_log_rec(struct ntfs_log *log, struct lcb *lcb, u64 *lsn)
 	return find_log_rec(log, *lsn, lcb);
 }
 
-static inline bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes)
+bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes)
 {
 	__le16 mask;
 	u32 min_de, de_off, used, total;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 440328147e7e..6f5d8dd6659d 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -798,6 +798,10 @@ static inline struct NTFS_DE *hdr_delete_de(struct INDEX_HDR *hdr,
 	u32 off = PtrOffset(hdr, re);
 	int bytes = used - (off + esize);
 
+	/* check INDEX_HDR valid before using INDEX_HDR */
+	if (!check_index_header(hdr, le32_to_cpu(hdr->total)))
+		return NULL;
+
 	if (off >= used || esize < sizeof(struct NTFS_DE) ||
 	    bytes < sizeof(struct NTFS_DE))
 		return NULL;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2c791222c4e2..c5c022fef4e0 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -574,6 +574,7 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 bool ni_is_dirty(struct inode *inode);
 
 /* Globals from fslog.c */
+bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
 int log_replay(struct ntfs_inode *ni, bool *initialized);
 
 /* Globals from fsntfs.c */
-- 
2.25.1

