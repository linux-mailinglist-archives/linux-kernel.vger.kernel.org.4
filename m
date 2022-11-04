Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719A9619589
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKDLmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDLmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:42:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D9A12760
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:42:35 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N3dtp0W38zpW70;
        Fri,  4 Nov 2022 19:38:58 +0800 (CST)
Received: from huawei.com (10.67.175.21) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 19:42:32 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <rpeterso@redhat.com>, <agruenba@redhat.com>,
        <teigland@redhat.com>, <swhiteho@redhat.com>
CC:     <lizetao1@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>, <cluster-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] gfs2: Fix memory leak in init_journal()
Date:   Fri, 4 Nov 2022 20:31:04 +0800
Message-ID: <20221104123104.628576-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.21]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a memory leak report by kmemleak:

  unreferenced object 0xffff8881786ff9a0 (size 192):
    comm "mount", pid 8881, jiffies 4301165942 (age 892.453s)
    hex dump (first 32 bytes):
      e0 ef 6f 78 81 88 ff ff 70 95 2a 04 81 88 ff ff  ..ox....p.*.....
      b0 f9 6f 78 81 88 ff ff b0 f9 6f 78 81 88 ff ff  ..ox......ox....
    backtrace:
      [<ffffffff8170ea67>] kmalloc_trace+0x27/0xa0
      [<ffffffffa0a15465>] init_inodes+0x495/0x2010 [gfs2]
      [<ffffffffa0a1bc27>] gfs2_fill_super+0x18c7/0x25b0 [gfs2]
      [<ffffffff818e1626>] get_tree_bdev+0x3e6/0x6e0
      [<ffffffffa0a13a34>] gfs2_get_tree+0x44/0x220 [gfs2]
      [<ffffffff818de91d>] vfs_get_tree+0x7d/0x230
      [<ffffffff81958073>] path_mount+0xd63/0x1760
      [<ffffffff81958b3a>] do_mount+0xca/0xe0
      [<ffffffff81958e1c>] __x64_sys_mount+0x12c/0x1a0
      [<ffffffff82f2e485>] do_syscall_64+0x35/0x80
      [<ffffffff8300006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

The root cause was traced to an error handling path in init_journal()
when gfs2_jindex_hold() fails. The GFS2 superblock will hold a list
of "gfs2_jdesc", and some of them are not freed in error handling path
"fail" when gfs2_jindex_hold() fails.

Fix it by freeing the memory of "gfs2_jdesc" allocated in the loop in
gfs2_jindex_hold() when an error occurs.

Fixes: b3b94faa5fe5 ("[GFS2] The core of GFS2")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/gfs2/ops_fstype.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c0cf1d2d0ef5..b55bee96619e 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -625,6 +625,9 @@ static int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
 		spin_unlock(&sdp->sd_jindex_spin);
 	}
 
+	if (error)
+		gfs2_jindex_free(sdp);
+
 	mutex_unlock(&sdp->sd_jindex_mutex);
 
 	return error;
-- 
2.25.1

