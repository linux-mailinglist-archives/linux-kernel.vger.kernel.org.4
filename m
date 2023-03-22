Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76DD6C3FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCVB0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVB0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:26:16 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C66830289;
        Tue, 21 Mar 2023 18:26:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ph9m12s6sz4f3wYK;
        Wed, 22 Mar 2023 09:26:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBnFCIvWRpkXohdFQ--.57798S3;
        Wed, 22 Mar 2023 09:26:08 +0800 (CST)
Subject: Re: [PATCH -next 0/2] block: fix scan partition for exclusively open
 device again
To:     Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hare@suse.de, hch@infradead.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230217022200.3092987-1-yukuai1@huaweicloud.com>
 <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dc7d28bf-35ca-7cde-ffdf-9490177dfdb9@huaweicloud.com>
Date:   Wed, 22 Mar 2023 09:26:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBnFCIvWRpkXohdFQ--.57798S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr43tr1fCw18ZF13tF4rGrg_yoW8Xw1xpF
        Z7XFs8Xr4DCw17Ca4UJ3Z7G3W5J3s7ZrWrGr13WryIka98Wr1YgFWkt39xXa92qrZ0kr1q
        9r1kJrWxZFyfCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/21 19:43, Ming Lei 写道:
> On Fri, Feb 17, 2023 at 10:21:58AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Changes from RFC:
>>   - remove the patch to factor out GD_NEED_PART_SCAN
>>
>> Yu Kuai (2):
>>    block: Revert "block: Do not reread partition table on exclusively
>>      open device"
>>    block: fix scan partition for exclusively open device again
> 
> Hi Yu kuai,
> 
> Looks the original issue starts to re-appear now with the two patches:
> 
> https://lore.kernel.org/linux-block/20221130135344.2ul4cyfstfs3znxg@quack3/
> 
> And underlying disk partition and raid partition can be observed at the
> same time.
> 
> Can you take a look?
Yes, thanks for the report. I realize that sda1 adn sdb1 is created
while raid open sda and sdb excl, and I think this problem should exist
before this patchset.

And I verify this with following test:

1) mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
2) sgdisk -n 0:0:+100MiB /dev/md0
3) mdadm -S /dev/md0
# scan partitions of sda
4) blockdev --rereadpt /dev/sda

Then sda1 is created.

I'm not sure how to fix this yet😂

Thanks,
Kuai
> 
> Follows the script, which isn't 100% triggered, but still easy.
> 
> #create level 1 with 2 devices, meta 1.0
> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
> 
> #create partition 0, start from 0 sector, size 100MiB
> sgdisk -n 0:0:+100MiB /dev/md0
> 
> #observe partitions
> cat /proc/partitions
> 
> #stop the array
> mdadm -S /dev/md0
> 
> #re-assemble
> mdadm -A /dev/md0 /dev/sda /dev/sdb
> cat /proc/partitions
> 
> 
> Thanks,
> Ming
> 
> .
> 

