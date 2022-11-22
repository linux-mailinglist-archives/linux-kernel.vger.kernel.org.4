Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B9E633E83
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiKVOIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiKVOIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:08:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0EDC67106;
        Tue, 22 Nov 2022 06:06:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78BE91FB;
        Tue, 22 Nov 2022 06:06:33 -0800 (PST)
Received: from [10.57.36.169] (unknown [10.57.36.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3ED13F73D;
        Tue, 22 Nov 2022 06:06:24 -0800 (PST)
Message-ID: <2f65e490-c264-9771-b120-e5ce76376170@arm.com>
Date:   Tue, 22 Nov 2022 14:06:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v13 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     hejunhao <hejunhao3@huawei.com>, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, john.garry@huawei.com
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        lpieralisi@kernel.org, linuxarm@huawei.com, yangyicong@huawei.com,
        liuqi115@huawei.com, f.fangjian@huawei.com,
        prime.zeng@hisilicon.com
References: <20221114090316.63157-1-hejunhao3@huawei.com>
 <20221114090316.63157-2-hejunhao3@huawei.com>
 <92291cb2-859c-a994-b05d-806def431376@arm.com>
 <c07e6417-7a37-3cf5-d3dd-b3ce7b3c20b1@huawei.com>
 <1c8da30c-d798-729d-c8e5-73a07f8b9f18@arm.com>
 <95024107-94d2-6114-4c50-b152c4da362b@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <95024107-94d2-6114-4c50-b152c4da362b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 13:23, hejunhao wrote:
> 
> On 2022/11/21 18:47, Suzuki Kuruppassery Poulose wrote:
>> On 18/11/2022 12:45, hejunhao wrote:
>>> Hi Suzuki ,
>>>
>>>
>>> On 2022/11/15 19:06, Suzuki K Poulose wrote:
>>>> On 14/11/2022 09:03, Junhao He wrote:
>>>>> From: Qi Liu <liuqi115@huawei.com>
>>>>>
>>
>>>>> +static void smb_init_hw(struct smb_drv_data *drvdata)
>>>>> +{
>>>>> +    /* First disable SMB and clear the status of SMB buffer */
>>>>> +    smb_reset_buffer_status(drvdata);
>>>>> +    smb_disable_hw(drvdata);
>>>>> +    smb_purge_data(drvdata);
>>>>> +
>>>>> +    writel(SMB_LB_CFG_LO_DEFAULT, drvdata->base + SMB_LB_CFG_LO_REG);
>>>>> +    writel(SMB_LB_CFG_HI_DEFAULT, drvdata->base + SMB_LB_CFG_HI_REG);
>>>>> +    writel(SMB_GLB_CFG_DEFAULT, drvdata->base + SMB_GLB_CFG_REG);
>>>>> +    writel(SMB_GLB_INT_CFG, drvdata->base + SMB_GLB_INT_REG);
>>>>> +    writel(SMB_LB_INT_CTRL_CFG, drvdata->base + SMB_LB_INT_CTRL_REG);
>>>>
>>>> Does this come with interrupt on overflow ? Do we not use this ?
>>>>
>>> When the buffer overflow, no interrupt will come.
>>> Interrupt will upgrade SMB_LB_INT_STS_REG register status if start 
>>> trace.
>>> Thanks.
>>>> Rest looks fine to me.
>>
>> What is the purpose of the "Interrupt" on the SMB ? It is not clear to
>> me.
> The SMB_LB_INT_CTRL_REG register control the validity of both real-time
> events and interrupts. When logical buffer status changes causes to 
> issue an
> interrupt at the same time as it issues a real-time event.
> Real-time events are used in SMB driver, which needs to get the buffer 
> status.
> Interrupts are used in debugger mode and cannot be registered in kernel.
>   ..._BUF_NOTE_MASK control which events flags or interrupts are valid.

Please add this to a comment in the code above the register write.

Thanks
Suzuki

> 
> Thanks.
> 
> Best regards,
> Junhao.
> 
>> Suzuki
>>
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org
> 

