Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AF06350B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 07:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiKWGye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 01:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiKWGyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:54:31 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D602386A56;
        Tue, 22 Nov 2022 22:54:29 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHBgB2VRZzRpRY;
        Wed, 23 Nov 2022 14:53:58 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 14:54:28 +0800
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 14:54:27 +0800
Subject: Re: [PATCH v13 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>
References: <20221114090316.63157-1-hejunhao3@huawei.com>
 <20221114090316.63157-2-hejunhao3@huawei.com>
 <92291cb2-859c-a994-b05d-806def431376@arm.com>
 <c07e6417-7a37-3cf5-d3dd-b3ce7b3c20b1@huawei.com>
 <1c8da30c-d798-729d-c8e5-73a07f8b9f18@arm.com>
 <95024107-94d2-6114-4c50-b152c4da362b@huawei.com>
 <2f65e490-c264-9771-b120-e5ce76376170@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <lpieralisi@kernel.org>,
        <linuxarm@huawei.com>, <yangyicong@huawei.com>,
        <liuqi115@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <58f94eac-3b3f-f106-7a22-e33b6c3f8a25@huawei.com>
Date:   Wed, 23 Nov 2022 14:54:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <2f65e490-c264-9771-b120-e5ce76376170@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Hi Suzuki ,

On 2022/11/22 22:06, Suzuki K Poulose wrote:
> On 22/11/2022 13:23, hejunhao wrote:
>>
>> On 2022/11/21 18:47, Suzuki Kuruppassery Poulose wrote:
>>> On 18/11/2022 12:45, hejunhao wrote:
>>>> Hi Suzuki ,
>>>>
>>>>
>>>> On 2022/11/15 19:06, Suzuki K Poulose wrote:
>>>>> On 14/11/2022 09:03, Junhao He wrote:
>>>>>> From: Qi Liu <liuqi115@huawei.com>
>>>>>>
>>>
>>>>>> +static void smb_init_hw(struct smb_drv_data *drvdata)
>>>>>> +{
>>>>>> +    /* First disable SMB and clear the status of SMB buffer */
>>>>>> +    smb_reset_buffer_status(drvdata);
>>>>>> +    smb_disable_hw(drvdata);
>>>>>> +    smb_purge_data(drvdata);
>>>>>> +
>>>>>> +    writel(SMB_LB_CFG_LO_DEFAULT, drvdata->base + 
>>>>>> SMB_LB_CFG_LO_REG);
>>>>>> +    writel(SMB_LB_CFG_HI_DEFAULT, drvdata->base + 
>>>>>> SMB_LB_CFG_HI_REG);
>>>>>> +    writel(SMB_GLB_CFG_DEFAULT, drvdata->base + SMB_GLB_CFG_REG);
>>>>>> +    writel(SMB_GLB_INT_CFG, drvdata->base + SMB_GLB_INT_REG);
>>>>>> +    writel(SMB_LB_INT_CTRL_CFG, drvdata->base + 
>>>>>> SMB_LB_INT_CTRL_REG);
>>>>>
>>>>> Does this come with interrupt on overflow ? Do we not use this ?
>>>>>
>>>> When the buffer overflow, no interrupt will come.
>>>> Interrupt will upgrade SMB_LB_INT_STS_REG register status if start 
>>>> trace.
>>>> Thanks.
>>>>> Rest looks fine to me.
>>>
>>> What is the purpose of the "Interrupt" on the SMB ? It is not clear to
>>> me.
>> The SMB_LB_INT_CTRL_REG register control the validity of both real-time
>> events and interrupts. When logical buffer status changes causes to 
>> issue an
>> interrupt at the same time as it issues a real-time event.
>> Real-time events are used in SMB driver, which needs to get the 
>> buffer status.
>> Interrupts are used in debugger mode and cannot be registered in kernel.
>>   ..._BUF_NOTE_MASK control which events flags or interrupts are valid.
>
> Please add this to a comment in the code above the register write.
>
> Thanks
> Suzuki
>
Yes, thanks for the comment. I will do that.

Best regards,
Junhao.
>>
>> Thanks.
>>
>> Best regards,
>> Junhao.
>>
>>> Suzuki
>>>
>>> _______________________________________________
>>> CoreSight mailing list -- coresight@lists.linaro.org
>>> To unsubscribe send an email to coresight-leave@lists.linaro.org
>>
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

