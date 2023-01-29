Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9967FC0E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 02:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjA2BPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 20:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjA2BN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 20:13:59 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E70F22DD6;
        Sat, 28 Jan 2023 17:13:56 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P4Cxq28T3z4f3nYx;
        Sun, 29 Jan 2023 09:13:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiBPyNVjsNp1CQ--.6849S3;
        Sun, 29 Jan 2023 09:13:53 +0800 (CST)
Subject: Re: [PATCH-next v2 2/2] scsi: fix iscsi rescan fails to create block
 device
To:     Greg KH <gregkh@linuxfoundation.org>,
        Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de,
        bvanassche@acm.org, emilne@redhat.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
 <20230128094146.205858-3-zhongjinghua@huawei.com>
 <Y9T8uQYEaGUZwpHO@kroah.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b4927ca9-7330-3f32-f68f-1a449473a0ce@huaweicloud.com>
Date:   Sun, 29 Jan 2023 09:13:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y9T8uQYEaGUZwpHO@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiBPyNVjsNp1CQ--.6849S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW3WFWxZFy7WFyktrWxCrg_yoWDuFb_ur
        WjyFZ7ur18Xw4rtayrAF1rZrWYqFnaqryxWF1Fqr1vvry7Xr4qqrW29Fy5ZrWDCwsayF15
        Jr4UC3y3Krs5ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg

ÔÚ 2023/01/28 18:45, Greg KH Ð´µÀ:
>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>> index cac7c902cf70..a22109cdb8ef 100644
>> --- a/drivers/scsi/scsi_sysfs.c
>> +++ b/drivers/scsi/scsi_sysfs.c
>> @@ -1535,9 +1535,7 @@ static void __scsi_remove_target(struct scsi_target *starget)
>>   		if (sdev->channel != starget->channel ||
>>   		    sdev->id != starget->id)
>>   			continue;
>> -		if (sdev->sdev_state == SDEV_DEL ||
>> -		    sdev->sdev_state == SDEV_CANCEL ||
>> -		    !get_device(&sdev->sdev_gendev))
>> +		if (!get_device_unless_zero(&sdev->sdev_gendev))
> 
> If sdev_gendev is 0 here, the object is gone and you are working with
> memory that is already freed so something is _VERY_ wrong.

In fact, this patch will work:

In __scsi_remove_target(), 'host_lock' is held to protect iterating
siblings, and object will wait for this lock in
scsi_device_dev_release() to remove siblings. Hence sdev will not be
freed untill the lock is released.

Thanks,
Kuai
> 
> This isn't ok, sorry.
> 
> greg k-h
> .
> 

