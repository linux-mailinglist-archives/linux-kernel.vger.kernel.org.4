Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E2E64156C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 10:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiLCJsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 04:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLCJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 04:48:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA842AD2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:48:26 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NPQ304YqhzmVxm;
        Sat,  3 Dec 2022 17:47:40 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 17:48:25 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>, <xiang@kernel.org>, <chao@kernel.org>,
        <huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>
Subject: [PATCH] erofs: Fix pcluster become inline when m_pa is zero
Date:   Sat, 3 Dec 2022 17:45:27 +0800
Message-ID: <20221203094527.129869-1-chenzhongjin@huawei.com>
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

syzkaller reported a memleak:
https://syzkaller.appspot.com/bug?id=62f37ff612f0021641eda5b17f056f1668aa9aed

unreferenced object 0xffff88811009c7f8 (size 136):
  ...
  backtrace:
    [<ffffffff821db19b>] z_erofs_do_read_page+0x99b/0x1740
    [<ffffffff821dee9e>] z_erofs_readahead+0x24e/0x580
    [<ffffffff814bc0d6>] read_pages+0x86/0x3d0
    ...

syzkaller constructed a case: in z_erofs_register_pcluster(),
ztailpacking = false and map->m_pa = zero. This makes pcl->obj.index
become zero although pcl is not an inline pcluster.

Then following path adds refcount for grp, but the it won't be put
because pcl is inline, which makes pcl not released when shrink.

z_erofs_readahead()
  z_erofs_do_read_page() # for another page
    z_erofs_collector_begin()
      erofs_find_workgroup()
        erofs_workgroup_get()

To fix this, add an attribute in z_erofs_pcluster to mark the inline
state which not depends on index of grp.

Fixes: cecf864d3d76 ("erofs: support inline data decompression")
Reported-by: syzbot+6f8cd9a0155b366d227f@syzkaller.appspotmail.com
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 fs/erofs/zdata.c | 2 +-
 fs/erofs/zdata.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index b792d424d774..fef2624d19e3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -517,7 +517,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	DBG_BUGON(!mutex_trylock(&pcl->lock));
 
 	if (ztailpacking) {
-		pcl->obj.index = 0;	/* which indicates ztailpacking */
+		pcl->is_inline = true;  /* which indicates ztailpacking */
 		pcl->pageofs_in = erofs_blkoff(map->m_pa);
 		pcl->tailpacking_size = map->m_plen;
 	} else {
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index d98c95212985..35051ad27521 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -78,6 +78,9 @@ struct z_erofs_pcluster {
 		unsigned short tailpacking_size;
 	};
 
+	/* I:  whether it is inline or not */
+	bool is_inline;
+
 	/* I: compression algorithm format */
 	unsigned char algorithmformat;
 
@@ -115,7 +118,7 @@ struct z_erofs_decompressqueue {
 
 static inline bool z_erofs_is_inline_pcluster(struct z_erofs_pcluster *pcl)
 {
-	return !pcl->obj.index;
+	return pcl->is_inline;
 }
 
 static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
-- 
2.17.1

