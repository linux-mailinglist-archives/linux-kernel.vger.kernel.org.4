Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16146C8BCB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjCYGfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjCYGfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:35:47 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE8413D44;
        Fri, 24 Mar 2023 23:35:45 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pk8Q9687gz17Nsr;
        Sat, 25 Mar 2023 14:32:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 25 Mar
 2023 14:35:43 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH] ext4: only update i_reserved_data_blocks on successful block allocation
Date:   Sat, 25 Mar 2023 14:34:43 +0800
Message-ID: <20230325063443.1839558-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our fault injection test, we create an ext4 file, migrate it to
non-extent based file, then punch a hole and finally trigger a WARN_ON
in the ext4_da_update_reserve_space():

EXT4-fs warning (device sda): ext4_da_update_reserve_space:369:
ino 14, used 11 with only 10 reserved data blocks

When writing back a non-extent based file, if we enable delalloc, the
number of reserved blocks will be subtracted from the number of blocks
mapped by ext4_ind_map_blocks(), and the extent status tree will be
updated. We update the extent status tree by first removing the old
extent_status and then inserting the new extent_status. If the block range
we remove happens to be in an extent, then we need to allocate another
extent_status with ext4_es_alloc_extent().

       use old    to remove   to add new
    |----------|------------|------------|
              old extent_status

The problem is that the allocation of a new extent_status failed due to a
fault injection, and __es_shrink() did not get free memory, resulting in
a return of -ENOMEM. Then do_writepages() retries after receiving -ENOMEM,
we map to the same extent again, and the number of reserved blocks is again
subtracted from the number of blocks in that extent. Since the blocks in
the same extent are subtracted twice, we end up triggering WARN_ON at
ext4_da_update_reserve_space() because used > ei->i_reserved_data_blocks.

To fix this, we update the number of reserved blocks for non-extents inodes
only when the reserved blocks are allocated successfully, rather than every
time the blocks are mapped successfully.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/indirect.c |  8 ++++++++
 fs/ext4/inode.c    | 10 ----------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index c68bebe7ff4b..9acab70ddf5e 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -651,6 +651,14 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	count = ar.len;
+
+	/*
+	 * Update reserved blocks/metadata blocks after successful block
+	 * allocation which had been deferred till now.
+	 */
+	if ((count > 0) && (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE))
+		ext4_da_update_reserve_space(inode, count, 1);
+
 got_it:
 	map->m_flags |= EXT4_MAP_MAPPED;
 	map->m_pblk = le32_to_cpu(chain[depth-1].key);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eaeec84ec1b0..21be018b6503 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -659,16 +659,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			 */
 			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
 		}
-
-		/*
-		 * Update reserved blocks/metadata blocks after successful
-		 * block allocation which had been deferred till now. We don't
-		 * support fallocate for non extent files. So we can update
-		 * reserve space here.
-		 */
-		if ((retval > 0) &&
-			(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE))
-			ext4_da_update_reserve_space(inode, retval, 1);
 	}
 
 	if (retval > 0) {
-- 
2.31.1

