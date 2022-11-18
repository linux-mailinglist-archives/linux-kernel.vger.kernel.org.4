Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE8A62EDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbiKRGg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbiKRGgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:36:15 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7199A5EC;
        Thu, 17 Nov 2022 22:36:13 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ND6VX11zzz15MZw;
        Fri, 18 Nov 2022 14:35:48 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 14:36:12 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 14:36:11 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-nilfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>, <konishi.ryusuke@gmail.com>,
        <akpm@linux-foundation.org>
Subject: [PATCH] nilfs2: Fix nilfs_sufile_mark_dirty() not set segment usage as dirty
Date:   Fri, 18 Nov 2022 14:33:04 +0800
Message-ID: <20221118063304.140187-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nilfs_sufile_mark_dirty(), the buffer and inode are set dirty, but
nilfs_segment_usage is not set dirty, which makes it can be found by
nilfs_sufile_alloc() because it checks nilfs_segment_usage_clean(su).

This will cause the problem reported by syzkaller:
https://syzkaller.appspot.com/bug?id=c7c4748e11ffcc367cef04f76e02e931833cbd24

It's because the case starts with segbuf1.segnum = 3, nextnum = 4, and
nilfs_sufile_alloc() not called to allocate a new segment.

The first time nilfs_segctor_extend_segments() allocated segment
segbuf2.segnum = segbuf1.nextnum = 4, then nilfs_sufile_alloc() found
nextnextnum = 4 segment because its su is not set dirty.
So segbuf2.nextnum = 4, which causes next segbuf3.segnum = 4.

sb_getblk() will get same bh for segbuf2 and segbuf3, and this bh is
added to both buffer lists of two segbuf.
It makes the list head of second list linked to the first one. When
iterating the first one, it will access and deref the head of second,
which causes NULL pointer dereference.

Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
Reported-by: syzbot+77e4f0...@syzkaller.appspotmail.com
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 fs/nilfs2/sufile.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 77ff8e95421f..2962f9071490 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -495,12 +495,18 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
 int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 {
 	struct buffer_head *bh;
+	void *kaddr;
+	struct nilfs_segment_usage *su;
 	int ret;
 
 	ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
 	if (!ret) {
 		mark_buffer_dirty(bh);
 		nilfs_mdt_mark_dirty(sufile);
+		kaddr = kmap_atomic(bh->b_page);
+		su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+		nilfs_segment_usage_set_dirty(su);
+		kunmap_atomic(kaddr);
 		brelse(bh);
 	}
 	return ret;
-- 
2.17.1

