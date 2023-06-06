Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8C7241F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbjFFMWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjFFMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:22:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F93E7D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:22:18 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qb8h12yhdz1c0Lj;
        Tue,  6 Jun 2023 20:20:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 20:22:14 +0800
From:   Li Lingfeng <lilingfeng3@huawei.com>
To:     <dm-devel@redhat.com>
CC:     <agk@redhat.com>, <snitzer@kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>,
        <lilingfeng3@huawei.com>
Subject: [PATCH] dm thin: check fail_io before using data_sm
Date:   Tue, 6 Jun 2023 20:20:24 +0800
Message-ID: <20230606122024.1965040-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should check pmd->fail_io before using pmd->data_sm since pmd->data_sm
may be destroyed by other processes.

       P1(kworker)                             P2(message)
do_worker
 process_prepared
  process_prepared_discard_passdown_pt2
   dm_pool_dec_data_range
                                    pool_message
                                     commit
                                      dm_pool_commit_metadata
                                        ↓
                                       // commit failed
                                      metadata_operation_failed
                                       abort_transaction
                                        dm_pool_abort_metadata
                                         dm_block_manager_create
                                           ↓
                                          // create failed
                                         __destroy_persistent_data_objects
                                          dm_sm_destroy(pmd->data_sm)
                                            ↓
                                           // free data_sm
    dm_sm_dec_blocks
      ↓
     // try to access pmd->data_sm --> UAF

As shown above, if dm_pool_commit_metadata() and dm_block_manager_create()
fail in pool_message process, kworker may trigger UAF.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 drivers/md/dm-thin-metadata.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 9f5cb52c5763..b9461faa9f0d 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -1756,13 +1756,15 @@ int dm_thin_remove_range(struct dm_thin_device *td,
 
 int dm_pool_block_is_shared(struct dm_pool_metadata *pmd, dm_block_t b, bool *result)
 {
-	int r;
+	int r = -EINVAL;
 	uint32_t ref_count;
 
 	down_read(&pmd->root_lock);
-	r = dm_sm_get_count(pmd->data_sm, b, &ref_count);
-	if (!r)
-		*result = (ref_count > 1);
+	if (!pmd->fail_io) {
+		r = dm_sm_get_count(pmd->data_sm, b, &ref_count);
+		if (!r)
+			*result = (ref_count > 1);
+	}
 	up_read(&pmd->root_lock);
 
 	return r;
@@ -1770,10 +1772,11 @@ int dm_pool_block_is_shared(struct dm_pool_metadata *pmd, dm_block_t b, bool *re
 
 int dm_pool_inc_data_range(struct dm_pool_metadata *pmd, dm_block_t b, dm_block_t e)
 {
-	int r = 0;
+	int r = -EINVAL;
 
 	pmd_write_lock(pmd);
-	r = dm_sm_inc_blocks(pmd->data_sm, b, e);
+	if (!pmd->fail_io)
+		r = dm_sm_inc_blocks(pmd->data_sm, b, e);
 	pmd_write_unlock(pmd);
 
 	return r;
@@ -1781,10 +1784,11 @@ int dm_pool_inc_data_range(struct dm_pool_metadata *pmd, dm_block_t b, dm_block_
 
 int dm_pool_dec_data_range(struct dm_pool_metadata *pmd, dm_block_t b, dm_block_t e)
 {
-	int r = 0;
+	int r = -EINVAL;
 
 	pmd_write_lock(pmd);
-	r = dm_sm_dec_blocks(pmd->data_sm, b, e);
+	if (!pmd->fail_io)
+		r = dm_sm_dec_blocks(pmd->data_sm, b, e);
 	pmd_write_unlock(pmd);
 
 	return r;
-- 
2.31.1

