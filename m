Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BDF647150
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLHOHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLHOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:07:16 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B3F018
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:07:14 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NSbV36Xm6zJpCN;
        Thu,  8 Dec 2022 22:03:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 8 Dec
 2022 22:07:11 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <snitzer@redhat.com>, <agk@redhat.com>, <snitzer@kernel.org>,
        <Martin.Wilck@suse.com>, <thornber@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yi.zhang@huawei.com>, <dm-devel@redhat.com>
Subject: [dm-devel][PATCH -next] dm thin: Use last transaction's pmd->root when commit failed
Date:   Thu, 8 Dec 2022 22:28:02 +0800
Message-ID: <20221208142802.1479048-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we found a softlock up problem in dm thin pool looking up btree
caused by corrupted metadata:
 Kernel panic - not syncing: softlockup: hung tasks
 CPU: 7 PID: 2669225 Comm: kworker/u16:3
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 Workqueue: dm-thin do_worker [dm_thin_pool]
 Call Trace:
   <IRQ>
   dump_stack+0x9c/0xd3
   panic+0x35d/0x6b9
   watchdog_timer_fn.cold+0x16/0x25
   __run_hrtimer+0xa2/0x2d0
   </IRQ>
   RIP: 0010:__relink_lru+0x102/0x220 [dm_bufio]
   __bufio_new+0x11f/0x4f0 [dm_bufio]
   new_read+0xa3/0x1e0 [dm_bufio]
   dm_bm_read_lock+0x33/0xd0 [dm_persistent_data]
   ro_step+0x63/0x100 [dm_persistent_data]
   btree_lookup_raw.constprop.0+0x44/0x220 [dm_persistent_data]
   dm_btree_lookup+0x16f/0x210 [dm_persistent_data]
   dm_thin_find_block+0x12c/0x210 [dm_thin_pool]
   __process_bio_read_only+0xc5/0x400 [dm_thin_pool]
   process_thin_deferred_bios+0x1a4/0x4a0 [dm_thin_pool]
   process_one_work+0x3c5/0x730

Following process may generate a broken btree mixed with fresh and stale
nodes, which could let dm thin trapped into an infinite loop while looking
up data block:
 Transaction 1: pmd->root = A, A->B->C   // One path in btree
                pmd->root = X, X->Y->Z   // Copy-up
 Transaction 2: X,Z is updated on disk, Y is written failed.
                // Commit failed, dm thin becomes read-only.
                process_bio_read_only
		 dm_thin_find_block
		  __find_block
		   dm_btree_lookup(pmd->root)
The pmd->root points to a broken btree, Y may contain stale node pointing
to any block, for example X, which lets dm thin trapped into a dead loop
while looking up Z.

Fix it by setting pmd->root in __open_metadata(), so that dm thin will use
last transaction's pmd->root if commit failed.

Fetch a reproducer in [Link].

Linke: https://bugzilla.kernel.org/show_bug.cgi?id=216790
Fixes: 991d9fa02da0 ("dm: add thin provisioning target")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/md/dm-thin-metadata.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 1a62226ac34e..26c42ee183ed 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -724,6 +724,15 @@ static int __open_metadata(struct dm_pool_metadata *pmd)
 		goto bad_cleanup_data_sm;
 	}
 
+	/*
+	 * For pool metadata opening process, root setting is redundant
+	 * because it will be set again in __begin_transaction(). But dm
+	 * pool aborting process really needs to get last transaction's
+	 * root in case accessing broken btree.
+	 */
+	pmd->root = le64_to_cpu(disk_super->data_mapping_root);
+	pmd->details_root = le64_to_cpu(disk_super->device_details_root);
+
 	__setup_btree_details(pmd);
 	dm_bm_unlock(sblock);
 
-- 
2.31.1

