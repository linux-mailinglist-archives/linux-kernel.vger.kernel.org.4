Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB37102EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjEYCe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjEYCe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:34:26 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DD9E6;
        Wed, 24 May 2023 19:34:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QRWpL1Fb6z4f3jLT;
        Thu, 25 May 2023 10:14:34 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77KJxG5knxadKA--.51593S3;
        Thu, 25 May 2023 10:14:35 +0800 (CST)
Subject: Re: [PATCH -next] block: Fix the partition start may overflow in
 add_partition()
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230522070615.1485014-1-zhongjinghua@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <655707b8-f741-3ed0-b1ea-974b3ea496fb@huaweicloud.com>
Date:   Thu, 25 May 2023 10:14:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230522070615.1485014-1-zhongjinghua@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77KJxG5knxadKA--.51593S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4fGFy3Ww43GFyrCw1kGrg_yoW5Wryrpr
        Z8ta43GrWrKr13uw47J3Wxu34Fva12kF45tryxGr4rXrZ3C34UKa4jka4qvw1UJrW3Gry3
        uF4Ykry0kw4xAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/05/22 15:06, Zhong Jinghua Ð´µÀ:
> From: Zhong Jinghua <zhongjinghua@huawei.com>
> 
> In the block_ioctl, we can pass in the unsigned number 0x8000000000000000
> as an input parameter, like below:
> 
> block_ioctl
>    blkdev_ioctl
>      blkpg_ioctl
>        blkpg_do_ioctl
>          copy_from_user
>          bdev_add_partition
>            add_partition
>              p->start_sect = start; // start = 0x8000000000000000

start_sect is 0x8..... >> SECTOR_SHIFT.

> 
> Then, there was an warning when submit bio:
> 
> WARNING: CPU: 0 PID: 382 at fs/iomap/apply.c:54
> Call trace:
>   iomap_apply+0x644/0x6e0
>   __iomap_dio_rw+0x5cc/0xa24
>   iomap_dio_rw+0x4c/0xcc
>   ext4_dio_read_iter
>   ext4_file_read_iter
>   ext4_file_read_iter+0x318/0x39c
>   call_read_iter
>   lo_rw_aio.isra.0+0x748/0x75c
>   do_req_filebacked+0x2d4/0x370
>   loop_handle_cmd
>   loop_queue_work+0x94/0x23c
>   kthread_worker_fn+0x160/0x6bc
>   loop_kthread_worker_fn+0x3c/0x50
>   kthread+0x20c/0x25c
>   ret_from_fork+0x10/0x18
> 
> Stack:
> 
> submit_bio_noacct
>    submit_bio_checks
>      blk_partition_remap
>        bio->bi_iter.bi_sector += p->start_sect
>        // bio->bi_iter.bi_sector = 0xffc0000000000000 + 65408
> ..
> loop_queue_work
>   loop_handle_cmd
>    do_req_filebacked
>     pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset // pos < 0
>     lo_rw_aio
>       call_read_iter
>        ext4_dio_read_iter
>         __iomap_dio_rw
>          iomap_apply
>           ext4_iomap_begin
>             map.m_lblk = offset >> blkbits
>               ext4_set_iomap
>               iomap->offset = (u64) map->m_lblk << blkbits
>               // iomap->offset = 64512
>           WARN_ON(iomap.offset > pos) // iomap.offset = 64512 and pos < 0
> 
> This is unreasonable for start + length > disk->part0.nr_sects. There is
> already a similar check in blk_add_partition().
> Fix it by adding a check in bdev_add_partition().

The checking that you add is blkpg_do_ioctl().

> 
> Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> ---
>   block/ioctl.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9c5f637ff153..3223ea862523 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -33,9 +33,16 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>   	if (op == BLKPG_DEL_PARTITION)
>   		return bdev_del_partition(disk, p.pno);
>   
> +	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
> +		return -EINVAL;
> +
>   	start = p.start >> SECTOR_SHIFT;
>   	length = p.length >> SECTOR_SHIFT;
>   
> +	/* length may be equal to 0 after right shift */
> +	if (!length || start + length > get_capacity(bdev->bd_disk))
> +		return -EINVAL;
> +
>   	switch (op) {
>   	case BLKPG_ADD_PARTITION:
>   		/* check if partition is aligned to blocksize */
> 

The change itself looks good to me, feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

