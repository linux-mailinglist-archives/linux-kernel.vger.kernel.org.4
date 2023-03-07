Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0AF6AD423
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCGBmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCGBma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:42:30 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97951715D;
        Mon,  6 Mar 2023 17:42:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PVyqf4MqGz4f3jJ8;
        Tue,  7 Mar 2023 09:42:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R96lgZkw5PkEQ--.64992S3;
        Tue, 07 Mar 2023 09:42:20 +0800 (CST)
Subject: Re: [syzbot] [block?] WARNING in blkdev_put (2)
To:     Julian Ruess <julianr@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        jack@suse.cz, hch@lst.de, Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <87lekfne28.fsf@oc8242746057.ibm.com>
 <f9649d501bc8c3444769418f6c26263555d9d3be.camel@linux.ibm.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <26079e08-857d-6216-0921-bdef369f3316@huaweicloud.com>
Date:   Tue, 7 Mar 2023 09:42:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f9649d501bc8c3444769418f6c26263555d9d3be.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R96lgZkw5PkEQ--.64992S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy3Aw48Wr4kWFy8AF1DKFg_yoW8uF4fpF
        Z3JFs0gF4DCr1xCay0qF1xuayrtan7Gr13XF13Aryrua9rC3s5Kr929395WrWjqrZ3Gws8
        Zr9rKryIqa4rA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/06 23:00, Julian Ruess 写道:
> On Thu, 2023-03-02 at 20:33 +0100, Alexander Egorenkov wrote:
>>
>> Hi,
>>
>> we are seeing a similar problem on s390x architecture when
>> partitioning
>> a NVMe disk on linux-next.
>>
>>
>>    [   70.403015]  nvme0n1: p1
>>    [   70.403197] ------------[ cut here ]------------
>>    [   70.403199] WARNING: CPU: 8 PID: 2452 at block/bdev.c:845
>> blkdev_put+0x280/0x298
> 
> ...
> 
>> The problem appeared about a week ago.
>>
>> Regards
>> Alex
> 
> Hi all,
> 
> I bisected this to:
> 
> commit e5cfefa97bccf956ea0bb6464c1f6c84fd7a8d9f
> Author: Yu Kuai <yukuai3@huawei.com>
> Date:   Fri Feb 17 10:22:00 2023 +0800
>                                                                                        
>      block: fix scan partition for exclusively open device again

Yes, thanks for the report, I figure out that I made a mistake here.

Following patch should fix this problem:

diff --git a/block/genhd.c b/block/genhd.c
index 3ee5577e1586..02d9cfb9e077 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -385,7 +385,7 @@ int disk_scan_partitions(struct gendisk *disk, 
fmode_t mode)
         if (IS_ERR(bdev))
                 ret =  PTR_ERR(bdev);
         else
-               blkdev_put(bdev, mode);
+               blkdev_put(bdev, mode & ~FMODE_EXCL);

Thanks,
Kuai
>                                                                                        
>      As explained in commit 36369f46e917 ("block: Do not reread
> partition table
>      on exclusively open device"), reread partition on the device that
> is
>      exclusively opened by someone else is problematic.
>                                                                                        
>      This patch will make sure partition scan will only be proceed if
> current
>      thread open the device exclusively, or the device is not opened
>      exclusively, and in the later case, other scanners and exclusive
> openers
>      will be blocked temporarily until partition scan is done.
>                                                                                        
>      Fixes: 10c70d95c0f2 ("block: remove the bd_openers checks in
> blk_drop_partitions")
>      Cc: <stable@vger.kernel.org>
>      Suggested-by: Jan Kara <jack@suse.cz>
>      Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>      Reviewed-by: Christoph Hellwig <hch@lst.de>
>      Link:
> https://lore.kernel.org/r/20230217022200.3092987-3-yukuai1@huaweicloud.com
>   
>      Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> 
> 
> Regards
> Julian
> 

