Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A234747B73
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 04:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGECQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 22:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGECQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 22:16:19 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D3C10E3;
        Tue,  4 Jul 2023 19:16:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QwjvK3NStz4f4NLj;
        Wed,  5 Jul 2023 10:16:13 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7Ns0qRkT0jtNA--.50894S3;
        Wed, 05 Jul 2023 10:16:14 +0800 (CST)
Subject: Re: [PATCH] scsi/sg: don't grab scsi host module reference
To:     Benjamin Block <bblock@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, hch@lst.de, chaitanyak@nvidia.com,
        shinichiro.kawasaki@wdc.com, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, axboe@kernel.dk,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
 <87lefv622n.fsf@linux.ibm.com> <20230704185110.GA10217@t480-pf1aa2c2>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <522b297a-7890-bf2d-fa08-2f0a20c848c7@huaweicloud.com>
Date:   Wed, 5 Jul 2023 10:16:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230704185110.GA10217@t480-pf1aa2c2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7Ns0qRkT0jtNA--.50894S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw48Zr4xKFWrXryrZF4kCrg_yoW7Jw1UpF
        W29anrCrWkAr17G347Wr1kJF15trZ7Zr1UGFy5G3s09ryUC34xKrn7G395Z3WUCw4xA3WY
        9F1DKF9FvryDJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/07/05 2:51, Benjamin Block 写道:
> On Tue, Jul 04, 2023 at 07:04:00PM +0200, Marc Hartmayer wrote:
>> On Thu, Jun 22, 2023 at 12:01 AM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
>>> index 2433eeef042a..dcb73787c29d 100644
>>> --- a/drivers/scsi/sg.c
>>> +++ b/drivers/scsi/sg.c
>>> @@ -1497,7 +1497,7 @@ sg_add_device(struct device *cl_dev)
>>>   	int error;
>>>   	unsigned long iflags;
>>>   
>>> -	error = scsi_device_get(scsidp);
>>> +	error = blk_get_queue(scsidp->request_queue);
>>>   	if (error)
>>>   		return error;
>>>   
> 
> Might be interesting as well. Marc showed me a `dmesg` snipped earlier
> from when the bind fails:
> 
>    [   15.441817] scsi host2: scsi_eh_2: sleeping
>    [   15.441899] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
>    [   15.441907] scsi host2: scsi_debug: version 0191 [20210520]
>                     dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
>    [   15.442078] scsi host2: scsi_scan_host_selected: <4294967295:4294967295:18446744073709551615>
>    [   15.442267] scsi 2:0:0:0: scsi scan: INQUIRY pass 1 length 36
>    [   15.442286] scsi 2:0:0:0: scsi scan: INQUIRY successful with code 0x0
>    [   15.442296] scsi 2:0:0:0: scsi scan: INQUIRY pass 2 length 96
>    [   15.442308] scsi 2:0:0:0: scsi scan: INQUIRY successful with code 0x0
>    [   15.442317] scsi 2:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
>    [   15.442554] scsi 2:0:0:0: Power-on or device reset occurred
>    [   15.442560] scsi 2:0:0:0: tag#50 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>    [   15.442565] scsi 2:0:0:0: tag#50 CDB: Report supported operation codes a3 0c 01 88 00 00 00 00 00 14 00 00
>    [   15.442569] scsi 2:0:0:0: tag#50 Sense Key : Unit Attention [current]
>    [   15.442573] scsi 2:0:0:0: tag#50 Add. Sense: Power on occurred
> 
> The bind should happend around here somewhere I think.
> 
>    [   15.472680] sd 2:0:0:0: scsi scan: Sending REPORT LUNS to (try 0)
>    [   15.472703] sd 2:0:0:0: scsi scan: REPORT LUNS successful (try 0) result 0x0
>    [   15.472706] sd 2:0:0:0: scsi scan: REPORT LUN scan
>    [   15.472709] sd 2:0:0:0: scsi scan: device exists on 2:0:0:0
>    [   15.492874] sd 2:0:0:0: [sdi] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
>    [   15.502853] sd 2:0:0:0: [sdi] Write Protect is off
>    [   15.502856] sd 2:0:0:0: [sdi] Mode Sense: 73 00 10 08
>    [   15.522819] sd 2:0:0:0: [sdi] Write cache: enabled, read cache: enabled, supports DPO and FUA
>    [   15.552773] sd 2:0:0:0: [sdi] Preferred minimum I/O size 512 bytes
>    [   15.552776] sd 2:0:0:0: [sdi] Optimal transfer size 524288 bytes
>    [   15.575373] sd 2:0:0:0: [sdi] tag#62 Done: SUCCESS Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>    [   15.575377] sd 2:0:0:0: [sdi] tag#62 CDB: Inquiry 12 01 b9 00 04 00
>    [   15.575380] sd 2:0:0:0: [sdi] tag#62 Sense Key : Illegal Request [current]
>    [   15.575383] sd 2:0:0:0: [sdi] tag#62 Add. Sense: Invalid field in cdb
>    [   15.645749] sd 2:0:0:0: [sdi] Attached SCSI disk
> 
> But we don't even see the `sg_alloc: dev=...` message that is logged in
> `sg_alloc()`. And between the change above and the call to `sg_alloc()`,
> there is only the character device allocation; and if that failed, it
> would print an error. So either the bind is never even tried, or the new
> `blk_get_queue()` fails to get a reference.
>      Which is odd, since the only way that would happen is, if the queue
> was marked dying; but we see that the stack is using it for LUN probing
> in `sd`.

Yes, if scsi_device_get() works fine, but blk_get_queue() has problems,
it seems to me that sg_add_device() can be called with scsi_device queue
mark dying? This is odd, but I'm not sure if it's the case.

Thanks,
Kuai
> 
>> This change (bisected) triggers a regression in our KVM on s390x CI. The
>> symptom is that a “scsi_debug device” does not bind to the scsi_generic
>> driver. On s390x you can reproduce the problem as follows (I have not
>> tested on x86):
>>
>> With this patch applied:
>>
>> $ sudo modprobe scsi_debug
> 
> One more thing maybe worth mentioning: in the kernel configuration we
> use in the CI we have `sg` built-in. I guess most have it built as
> module.
> 
>> $ # Get the 'scsi_host,channel,target_number,LUN' tuple for the scsi_debug device
>> $ lsscsi |grep scsi_debug |awk '{ print $1 }'
>> [0:0:0:0]
>> $ sudo stat /sys/bus/scsi/devices/0:0:0:0/scsi_generic
>> stat: cannot statx '/sys/bus/scsi/devices/0:0:0:0/scsi_generic': No such file or directory
>>
>>
>> Patch reverted:
>>
>> $ sudo modprobe scsi_debug
>> $ lsscsi |grep scsi_debug |awk '{ print $1 }'
>> [0:0:0:0]
>> $ sudo stat /sys/bus/scsi/devices/0:0:0:0/scsi_generic
>>    File: /sys/bus/scsi/devices/0:0:0:0/scsi_generic
>>    Size: 0         	Blocks: 0          IO Block: 4096   directory
>> Device: 0,20	Inode: 12155       Links: 3
>> …
> 
> That's all I got from looking at it earlier, so far.
> 

