Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587E867FD33
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 07:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjA2Gz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 01:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Gzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 01:55:55 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6DA2129F;
        Sat, 28 Jan 2023 22:55:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P4MXN1cFXz4f4NW7;
        Sun, 29 Jan 2023 14:55:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R90GNZj2XGDCQ--.27055S3;
        Sun, 29 Jan 2023 14:55:50 +0800 (CST)
Subject: Re: [PATCH-next v2 2/2] scsi: fix iscsi rescan fails to create block
 device
To:     Greg KH <gregkh@linuxfoundation.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Zhong Jinghua <zhongjinghua@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        emilne@redhat.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230128094146.205858-1-zhongjinghua@huawei.com>
 <20230128094146.205858-3-zhongjinghua@huawei.com>
 <Y9T8uQYEaGUZwpHO@kroah.com>
 <b4927ca9-7330-3f32-f68f-1a449473a0ce@huaweicloud.com>
 <Y9YWMQ4TuJfuXAzL@kroah.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c09ec3d3-9f6f-6bf6-8bb9-583c0c7c909d@huaweicloud.com>
Date:   Sun, 29 Jan 2023 14:55:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y9YWMQ4TuJfuXAzL@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R90GNZj2XGDCQ--.27055S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWUWr1rZryDCF4DJw4fKrg_yoW8Xr13pF
        WrXa1FkFWUJrWkKwn2qa17WFySq347KrZ8GrW7G340ga45Jr97tw1rJa9xZFyFyFWv93Wx
        Xr18XFs5ZrWvqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/01/29 14:46, Greg KH 写道:
> On Sun, Jan 29, 2023 at 09:13:55AM +0800, Yu Kuai wrote:
>> Hi, Greg
>>
>> 在 2023/01/28 18:45, Greg KH 写道:
>>>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>>>> index cac7c902cf70..a22109cdb8ef 100644
>>>> --- a/drivers/scsi/scsi_sysfs.c
>>>> +++ b/drivers/scsi/scsi_sysfs.c
>>>> @@ -1535,9 +1535,7 @@ static void __scsi_remove_target(struct scsi_target *starget)
>>>>    		if (sdev->channel != starget->channel ||
>>>>    		    sdev->id != starget->id)
>>>>    			continue;
>>>> -		if (sdev->sdev_state == SDEV_DEL ||
>>>> -		    sdev->sdev_state == SDEV_CANCEL ||
>>>> -		    !get_device(&sdev->sdev_gendev))
>>>> +		if (!get_device_unless_zero(&sdev->sdev_gendev))
>>>
>>> If sdev_gendev is 0 here, the object is gone and you are working with
>>> memory that is already freed so something is _VERY_ wrong.
>>
>> In fact, this patch will work:
>>
>> In __scsi_remove_target(), 'host_lock' is held to protect iterating
>> siblings, and object will wait for this lock in
>> scsi_device_dev_release() to remove siblings. Hence sdev will not be
>> freed untill the lock is released.
> 
> Then you got lucky, as that is not how a reference counted object should
> be working (i.e. the reference dropped to 0 and it still be kept alive.)
> 
> Please fix up the scsi logic here, don't abuse the reference count code.
> 

Thanks for the reply, I agree that we should fix this in scsi layer.

Kuai

