Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BADD638C13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKYO0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYO0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:26:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842532AC46;
        Fri, 25 Nov 2022 06:26:32 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NJcbh0FcGzHwC8;
        Fri, 25 Nov 2022 22:25:52 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 25 Nov 2022 22:26:30 +0800
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 25 Nov
 2022 22:26:30 +0800
Subject: Re: [PATCH v14 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>
References: <20221123123823.27973-1-hejunhao3@huawei.com>
 <20221123123823.27973-2-hejunhao3@huawei.com>
 <9f5f66fa-0388-6a76-25c9-cacef0e7a4e2@arm.com>
 <0eb32726-2054-ee00-4b7a-d7a2f0121efd@huawei.com>
 <80cf9c73-4b9a-f2f7-f72d-de985c045f9c@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <lpieralisi@kernel.org>,
        <linuxarm@huawei.com>, <yangyicong@huawei.com>,
        <liuqi6124@gmail.com>, <f.fangjian@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <8e3b1957-33a7-83ed-6d62-1294cdb679e4@huawei.com>
Date:   Fri, 25 Nov 2022 22:26:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <80cf9c73-4b9a-f2f7-f72d-de985c045f9c@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/24 21:45, Suzuki K Poulose wrote:
> On 24/11/2022 13:33, hejunhao wrote:
>>
>> On 2022/11/23 22:03, Suzuki K Poulose wrote:
>>> On 23/11/2022 12:38, Junhao He wrote:
>>>> From: Qi Liu <liuqi115@huawei.com>
>>>>
>>>> Add driver for UltraSoc SMB(System Memory Buffer) device.
>>>> SMB provides a way to buffer messages from ETM, and store
>>>> these "CPU instructions trace" in system memory.
>>>> The SMB device is identifier as ACPI HID "HISI03A1". Device
>>>> system memory address resources are allocated using the _CRS
>>>> method and buffer modes is the circular buffer mode.
>>>>
>>>> SMB is developed by UltraSoc technology, which is acquired by
>>>> Siemens, and we still use "UltraSoc" to name driver.
>>>>
>>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>>>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>>>> Tested-by: JunHao He <hejunhao3@huawei.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/Kconfig        |  12 +
>>>>   drivers/hwtracing/coresight/Makefile       |   1 +
>>>>   drivers/hwtracing/coresight/ultrasoc-smb.c | 658 
>>>> +++++++++++++++++++++
>>>>   drivers/hwtracing/coresight/ultrasoc-smb.h | 129 ++++
>>>>   4 files changed, 800 insertions(+)
>>>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
>>>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
>>>>
>>>
>>>> +static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
>>>> +                 struct cs_buffers *buf,
>>>> +                 unsigned long head,
>>>> +                 unsigned long data_size)
>>>> +{
>>>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>>>> +    char **dst_pages = (char **)buf->data_pages;
>>>> +    unsigned long to_copy;
>>>> +    long pg_idx, pg_offset;
>>>> +
>>>> +    pg_idx = head >> PAGE_SHIFT;
>>>> +    pg_offset = head & (PAGE_SIZE - 1);
>>>> +
>>>> +    while (data_size) {
>>>> +        unsigned long pg_space = PAGE_SIZE - pg_offset;
>>>> +
>>>> +        /* Copy parts of trace data when read pointer wrap around */
>>>> +        if (sdb->rd_offset + pg_space > sdb->buf_size)
>>>> +            to_copy = sdb->buf_size - sdb->rd_offset;
>>>> +        else
>>>> +            to_copy = min(data_size, pg_space);
>>>> +
>>>> +        memcpy(dst_pages[pg_idx] + pg_offset,
>>>> +                  sdb->buf_base + sdb->rd_offset, to_copy);
>>>> +
>>>> +        pg_offset += to_copy;
>>>> +        if (pg_offset >= PAGE_SIZE) {
>>>> +            pg_offset = 0;
>>>> +            pg_idx++;
>>>> +            pg_idx %= buf->nr_pages;
>>>> +        }
>>>> +        data_size -= to_copy;
>>>> +        sdb->rd_offset += to_copy;
>>>> +        sdb->rd_offset %= sdb->buf_size;
>>>> +    }
>>>> +
>>>> +    sdb->data_size = 0;
>>>
>>>
>>> --8>-- cut here --<8--
>>>
>>>> +    writel(sdb->start_addr + sdb->rd_offset,
>>>> +        drvdata->base + SMB_LB_RD_ADDR_REG);
>>>> +
>>>> +    /*
>>>> +     * Data remained in link cannot be purged when SMB is full, so
>>>> +     * synchronize the read pointer to write pointer, to make sure
>>>> +     * these remained data won't influence next trace.
>>>> +     */
>>>> +    if (sdb->full) {
>>>> +        smb_purge_data(drvdata);
>>>> +        writel(readl(drvdata->base + SMB_LB_WR_ADDR_REG),
>>>> +               drvdata->base + SMB_LB_RD_ADDR_REG);
>>>> +    }
>>>
>>> --<8-- end here --8>--
>>>
>>> As pointed out in the last review, we must do this step
>>> everytime for perf mode irrespective of whether the buffer
>>> was "FULL" or not.
>>>
>>> i.e, the above block should simply be:
>>>
>>>     if (sdb->full)
>>>         smb_purge_data(drvdata);
>>>
>>>     /*
>>>      * The uncollected Data must be discarded for perf,
>>>      * as it cannot be clubbed with next schedule. We
>>>      * any way TRUNCATE the buffer in this case.
>>>      */
>>>     writel(readl(drvdata->base + SMB_LB_WR_ADDR_REG),
>>>         drvdata->base + SMB_LB_RD_ADDR_REG);
>>>
>>> Suzuki
>>
>> Hi Suzuki,
>>
>> We need to update SMB_LB_RD_ADDR_REG register first, then
>> check the "full" flag, whether the register needs to be
>> updated again.
>
> Why ? sdb->full is not updated after the write to RD_ADDR_REG.
>
Hi Suzuki,

Maybe using the code below is more appropriate.
i.e,

     writel(sdb->start_addr + sdb->rd_offset,
         drvdata->base + SMB_LB_RD_ADDR_REG);

     /*
      * The uncollected Data must be discarded for perf,
      * as it cannot be clubbed with next schedule. We
      * any way TRUNCATE the buffer in this case.
      */
     smb_update_data_size(drvdata);
     if (sdb->data_size)
         writel(readl(drvdata->base + SMB_LB_WR_ADDR_REG),
                 drvdata->base + SMB_LB_RD_ADDR_REG);

Best regards,
Junhao.

>>
>> If we don`t update the value of SMB_LB_RD_ADDR_REG register
>> or reset buffer state, the buffer state will still be "full".
>> The buffer has not free area,so the data will still remain
>> in link.
>
> My issue here is with potentially "leaving the trace from a previous
> session for the next session". i.e., at the end of a run, we must always
> make sure that the buffer is left empty (unlike the sysfs mode).
>
> e.g.,
>
> perf_session_x: RUN0: RD=0x0, WR=0x5000, HANDLE_SIZE=0x3000, full=false.
> At the end of the above routine we will have :
>     RD=0x3000, WR=0x5000,
>
> and if a different perf session comes in, say perf_session_y, it will 
> consume trace written by "x" at 0x3000-0x50000, right ?
>
> This is fine in the sysfs mode as we expect the entire sysfs mode
> to be owned by a single session and is left to the user to split it.
> But for perf mode we cannot do that and thus must make sure we don't
> leak trace from one session to antoher.
>
> Suzuki
>

In this cace:  RUN0: RD=0x0, WR=0x5000, HANDLE_SIZE=0x3000, full=false.
We will update the "rd_offset" in smb_update_buffer() function.
like this:

     ...
     if (data_size > handle->size) {
         sdb->rd_offset += data_size - handle->size;
         sdb->rd_offset %= sdb->buf_size;
         ...
         }
     ...


So the rd_offset will advance to 0x2000 first,
then we dump the latest trace data (0x2000 - 0x5000) from "buf_base + 
rd_offset".

Best regards,
Junhao.

>
>>
>> Thanks.
>> HeJunhao.
>>
>>> _______________________________________________
>>> CoreSight mailing list -- coresight@lists.linaro.org
>>> To unsubscribe send an email to coresight-leave@lists.linaro.org
>>>
>>> .
>>>
>>
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

