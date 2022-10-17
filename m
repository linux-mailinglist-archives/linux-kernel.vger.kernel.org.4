Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F5460100B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJQNRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiJQNRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:17:09 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315804D25B;
        Mon, 17 Oct 2022 06:17:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Mrcsd3MTBz6R54R;
        Mon, 17 Oct 2022 21:14:45 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDnLS7PVU1j+NUFAA--.9367S3;
        Mon, 17 Oct 2022 21:17:05 +0800 (CST)
Subject: Re: [PATCH RFC] block: fix use after free for bd_holder_dir/slave_dir
To:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, gregkh@linuxfoundation.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai3@huawei.com >> yukuai (C)" <yukuai3@huawei.com>
References: <20221012125838.1608619-1-yukuai1@huaweicloud.com>
 <Y00LTH0yk3obS22m@infradead.org>
 <dadef634-9ec3-aa7b-f1c0-65a98a0fafb1@huaweicloud.com>
 <Y00+SsxI7IJ56im8@infradead.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <21375b39-234a-cffd-40db-f78fae3aee60@huaweicloud.com>
Date:   Mon, 17 Oct 2022 21:17:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y00+SsxI7IJ56im8@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnLS7PVU1j+NUFAA--.9367S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy8Kr17tF4UuF4fGw48Zwb_yoWkCFgE9a
        yxu39rCryvkw4ru3Zrtw1avasYkr15XrWUZFs7XFsFqFyqqasxAa1kCryxZr9xGa93CF15
        Cry5Wr9xurZ7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
        04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/10/17 19:36, Christoph Hellwig Ð´µÀ:
> On Mon, Oct 17, 2022 at 05:24:20PM +0800, Yu Kuai wrote:
>> I agree that this patch do make sense, however, it seems to me this
>> patch should fix the problem that kobject is leaked, not uaf... And I
>> verified that the problem can still be reporduced with this patch.
> 
> Can you share your reproducer?
> .
> 

Of course, I add some delay in kernel to make sure the problem is
reproduced 100%:

diff --git a/block/holder.c b/block/holder.c
index 5283bc804cc1..be8f4b4245f3 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -1,6 +1,7 @@
  // SPDX-License-Identifier: GPL-2.0-only
  #include <linux/blkdev.h>
  #include <linux/slab.h>
+#include <linux/delay.h>

  struct bd_holder_disk {
         struct list_head        list;
@@ -33,6 +34,8 @@ static int __link_disk_holder(struct block_device 
*bdev, struct gendisk *disk)
  {
         int ret;

+       printk("%s: delay 5s\n", __func__);
+       msleep(5000);
         ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
         if (ret)
                 return ret;

test cmd is very simple:

dmsetup create test1 --table "0 100000 linear /dev/sda 0" &
sleep 1
echo 1 > /sys/block/sda/device/delete

