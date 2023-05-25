Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E57771062A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbjEYHWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjEYHWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:22:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D02D9C;
        Thu, 25 May 2023 00:22:19 -0700 (PDT)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QRfX85ZDNzqTPF;
        Thu, 25 May 2023 15:17:44 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 15:22:15 +0800
From:   Zhong Jinghua <zhongjinghua@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhongjinghua@huawei.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH -next v2] block: Fix the partition start may overflow in add_partition()
Date:   Thu, 25 May 2023 15:20:41 +0800
Message-ID: <20230525072041.3701176-1-zhongjinghua@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the blkdev_ioctl, we can pass in the unsigned number 0x8000000000000000
as an input parameter, like below:

blkdev_ioctl
  blkpg_ioctl
    blkpg_do_ioctl
      start = p.start >> SECTOR_SHIFT; // start = 0x8000000000000000 >> 9
       bdev_add_partition
         add_partition
           p->start_sect = start; // start = 0xffc0000000000000

Then, there was an warning when submit bio:

submit_bio_noacct
  submit_bio_checks
    blk_partition_remap
      bio->bi_iter.bi_sector += p->start_sect
      // bio->bi_iter.bi_sector = 0xffc0000000000000 + 0xfc00
..
loop_process_work
 loop_handle_cmd
  do_req_filebacked
   pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset
   // pos is 0xffc000000000fc00 << 9
   lo_rw_aio
     call_read_iter
      ext4_dio_read_iter
	ext4_dio_read_iter
          iomap_dio_rw
            __iomap_dio_rw
	      iomap_iter
		ext4_iomap_begin
		  map.m_lblk = offset >> blkbits // (u32) map.m_lblk is 0xfc00
		  ext4_set_iomap
		    iomap->offset = (u64) map->m_lblk << blkbits
		    // iomap->offset = 0xfc00
		iomap_iter_done
		  WARN_ON_ONCE(iter->iomap.offset > iter->pos);
		  // iomap.offset = 0xfc00 and iter->pos < 0

This is unreasonable for start + length > disk->part0.nr_sects. There is
already a similar check in blk_add_partition().
Fix it by adding a check in blkpg_do_ioctl().

Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 v2: Modify the io stack in commit message.
 block/ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 9c5f637ff153..3223ea862523 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -33,9 +33,16 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(disk, p.pno);
 
+	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
+		return -EINVAL;
+
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
 
+	/* length may be equal to 0 after right shift */
+	if (!length || start + length > get_capacity(bdev->bd_disk))
+		return -EINVAL;
+
 	switch (op) {
 	case BLKPG_ADD_PARTITION:
 		/* check if partition is aligned to blocksize */
-- 
2.31.1

