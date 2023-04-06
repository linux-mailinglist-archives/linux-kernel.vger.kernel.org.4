Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C36D8E08
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjDFDm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjDFDm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:42:56 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1584F7AAD;
        Wed,  5 Apr 2023 20:42:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PsS4m1SYCz4f3ppn;
        Thu,  6 Apr 2023 11:42:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CG4Py5kOHX_GA--.19144S3;
        Thu, 06 Apr 2023 11:42:49 +0800 (CST)
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
To:     Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
        jack@suse.cz, hch@infradead.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <42cfedca-f233-4d7e-f43b-4b5dd0c97e9e@huaweicloud.com>
Date:   Thu, 6 Apr 2023 11:42:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230322035926.1791317-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CG4Py5kOHX_GA--.19144S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF45ZFy5CF4fWw17uw4rZrb_yoW8tw18pF
        sxJF45tr9Fgr17ua4UZ3WxXa15Ja9rZryfGrW3G34Iywn8X3ZFkF92k3yDWF10grZ3KrWD
        WF15WayruF1fCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.7 required=5.0 tests=KHOP_HELO_FCRDNS,MAY_BE_FORGED,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens!

ÔÚ 2023/03/22 11:59, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
> set, and partition scan will be proceed again when blkdev_get_by_dev()
> is called. However, this will cause a problem that re-assemble partitioned
> raid device will creat partition for underlying disk.
> 
> Test procedure:
> 
> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> sgdisk -n 0:0:+100MiB /dev/md0
> blockdev --rereadpt /dev/sda
> blockdev --rereadpt /dev/sdb
> mdadm -S /dev/md0
> mdadm -A /dev/md0 /dev/sda /dev/sdb
> 
> Test result: underlying disk partition and raid partition can be
> observed at the same time
> 
> Note that this can still happen in come corner cases that
> GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
> device.
> 

Can you apply this patch?

Thanks,
Kuai
> Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/genhd.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 08bb1a9ec22c..a72e27d6779d 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -368,7 +368,6 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>   	if (disk->open_partitions)
>   		return -EBUSY;
>   
> -	set_bit(GD_NEED_PART_SCAN, &disk->state);
>   	/*
>   	 * If the device is opened exclusively by current thread already, it's
>   	 * safe to scan partitons, otherwise, use bd_prepare_to_claim() to
> @@ -381,12 +380,19 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>   			return ret;
>   	}
>   
> +	set_bit(GD_NEED_PART_SCAN, &disk->state);
>   	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL);
>   	if (IS_ERR(bdev))
>   		ret =  PTR_ERR(bdev);
>   	else
>   		blkdev_put(bdev, mode & ~FMODE_EXCL);
>   
> +	/*
> +	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
> +	 * and this will cause that re-assemble partitioned raid device will
> +	 * creat partition for underlying disk.
> +	 */
> +	clear_bit(GD_NEED_PART_SCAN, &disk->state);
>   	if (!(mode & FMODE_EXCL))
>   		bd_abort_claiming(disk->part0, disk_scan_partitions);
>   	return ret;
> 

