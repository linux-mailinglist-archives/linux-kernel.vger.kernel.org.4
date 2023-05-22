Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710ED70B5EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjEVHJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjEVHJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:09:13 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D2B1;
        Mon, 22 May 2023 00:07:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QPpS11mRNz4f3vf4;
        Mon, 22 May 2023 15:07:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgAXvuvAFGtkMeRtJw--.38846S4;
        Mon, 22 May 2023 15:07:46 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next] block: Fix the partition start may overflow in add_partition()
Date:   Mon, 22 May 2023 15:06:15 +0800
Message-Id: <20230522070615.1485014-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXvuvAFGtkMeRtJw--.38846S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1xKryfCrWruFyktrWUArb_yoW5JF17pr
        s8t3W3GrWrKw15uw47JF1xu3y0kanFkF45XrWIgrs5urs7C348Ka4jkayjvw1UJryrZFWf
        ZF4j9rykKw17AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

In the block_ioctl, we can pass in the unsigned number 0x8000000000000000
as an input parameter, like below:

block_ioctl
  blkdev_ioctl
    blkpg_ioctl
      blkpg_do_ioctl
        copy_from_user
        bdev_add_partition
          add_partition
            p->start_sect = start; // start = 0x8000000000000000

Then, there was an warning when submit bio:

WARNING: CPU: 0 PID: 382 at fs/iomap/apply.c:54
Call trace:
 iomap_apply+0x644/0x6e0
 __iomap_dio_rw+0x5cc/0xa24
 iomap_dio_rw+0x4c/0xcc
 ext4_dio_read_iter
 ext4_file_read_iter
 ext4_file_read_iter+0x318/0x39c
 call_read_iter
 lo_rw_aio.isra.0+0x748/0x75c
 do_req_filebacked+0x2d4/0x370
 loop_handle_cmd
 loop_queue_work+0x94/0x23c
 kthread_worker_fn+0x160/0x6bc
 loop_kthread_worker_fn+0x3c/0x50
 kthread+0x20c/0x25c
 ret_from_fork+0x10/0x18

Stack:

submit_bio_noacct
  submit_bio_checks
    blk_partition_remap
      bio->bi_iter.bi_sector += p->start_sect
      // bio->bi_iter.bi_sector = 0xffc0000000000000 + 65408
..
loop_queue_work
 loop_handle_cmd
  do_req_filebacked
   pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset // pos < 0
   lo_rw_aio
     call_read_iter
      ext4_dio_read_iter
       __iomap_dio_rw
        iomap_apply
         ext4_iomap_begin
           map.m_lblk = offset >> blkbits
             ext4_set_iomap
             iomap->offset = (u64) map->m_lblk << blkbits
             // iomap->offset = 64512
         WARN_ON(iomap.offset > pos) // iomap.offset = 64512 and pos < 0

This is unreasonable for start + length > disk->part0.nr_sects. There is
already a similar check in blk_add_partition().
Fix it by adding a check in bdev_add_partition().

Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
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

