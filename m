Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875A612F47
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 04:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJaDPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 23:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJaDPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 23:15:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1609589;
        Sun, 30 Oct 2022 20:15:10 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N0ytz71lCzHvV3;
        Mon, 31 Oct 2022 11:14:51 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 11:15:08 +0800
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 11:15:08 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>, <will@kernel.org>, <ming.lei@redhat.com>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH] blk-mq: Fix kmemleak in blk_mq_init_allocated_queue
Date:   Mon, 31 Oct 2022 03:12:42 +0000
Message-ID: <20221031031242.94107-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a kmemleak caused by modprobe null_blk.ko

unreferenced object 0xffff8881acb1f000 (size 1024):
  comm "modprobe", pid 836, jiffies 4294971190 (age 27.068s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 00 53 99 9e ff ff ff ff  .........S......
  backtrace:
    [<000000004a10c249>] kmalloc_node_trace+0x22/0x60
    [<00000000648f7950>] blk_mq_alloc_and_init_hctx+0x289/0x350
    [<00000000af06de0e>] blk_mq_realloc_hw_ctxs+0x2fe/0x3d0
    [<00000000e00c1872>] blk_mq_init_allocated_queue+0x48c/0x1440
    [<00000000d16b4e68>] __blk_mq_alloc_disk+0xc8/0x1c0
    [<00000000d10c98c3>] 0xffffffffc450d69d
    [<00000000b9299f48>] 0xffffffffc4538392
    [<0000000061c39ed6>] do_one_initcall+0xd0/0x4f0
    [<00000000b389383b>] do_init_module+0x1a4/0x680
    [<0000000087cf3542>] load_module+0x6249/0x7110
    [<00000000beba61b8>] __do_sys_finit_module+0x140/0x200
    [<00000000fdcfff51>] do_syscall_64+0x35/0x80
    [<000000003c0f1f71>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

That is because q->ma_ops is set to NULL before blk_release_queue is
called.

blk_mq_init_queue_data
  blk_mq_init_allocated_queue
    blk_mq_realloc_hw_ctxs
      for (i = 0; i < set->nr_hw_queues; i++) {
        old_hctx = xa_load(&q->hctx_table, i);
        if (!blk_mq_alloc_and_init_hctx(.., i, ..))		[1]
          if (!old_hctx)
	    break;

      xa_for_each_start(&q->hctx_table, j, hctx, j)
        blk_mq_exit_hctx(q, set, hctx, j); 			[2]

    if (!q->nr_hw_queues)					[3]
      goto err_hctxs;

  err_exit:
      q->mq_ops = NULL;			  			[4]

  blk_put_queue
    blk_release_queue
      if (queue_is_mq(q))					[5]
        blk_mq_release(q);

[1]: blk_mq_alloc_and_init_hctx failed at i != 0.
[2]: The hctxs allocated by [1] are moved to q->unused_hctx_list and
will be cleaned up in blk_mq_release.
[3]: q->nr_hw_queues is 0.
[4]: Set q->mq_ops to NULL.
[5]: queue_is_mq returns false due to [4]. And blk_mq_release
will not be called. The hctxs in q->unused_hctx_list are leaked.

To fix it, call blk_release_queue in exception path.

Fixes: 2f8f1336a48b ("blk-mq: always free hctx after request queue is freed")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 block/blk-mq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 33292c01875d..308b0ba71dba 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4188,9 +4188,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	return 0;
 
 err_hctxs:
-	xa_destroy(&q->hctx_table);
-	q->nr_hw_queues = 0;
-	blk_mq_sysfs_deinit(q);
+	blk_mq_release(q);
 err_poll:
 	blk_stat_free_callback(q->poll_cb);
 	q->poll_cb = NULL;
-- 
2.17.1

