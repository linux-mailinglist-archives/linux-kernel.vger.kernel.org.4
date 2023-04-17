Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C346E5005
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjDQSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDQSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:17:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AFDE48;
        Mon, 17 Apr 2023 11:17:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HGNaBM014517;
        Mon, 17 Apr 2023 18:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NPLaz7Gs9JU/HdCP8pfDzj93T4/4kvaYsuCnY3jZ1Rw=;
 b=ahLUJ1gqfNvozMO+xVHKLQeL/PNGalZ3/JjJh4USbwWkTLX6a5phErkwX1hQqHtTMIGx
 Iq8UwzqY/ScltDHibAoXzCNFpiXb0VxiuJCx90vZlvUdOaEPm/pUqvXk6bZxUcC11nQn
 odqjIRQff2dtOeMbFxI6nl9EPaX6rpTqaBjUuoISxhn+W3UWtwhNL4LFxfKCt+gFo9RA
 jR1ONbs32oT/G8E2qcXDrEoK+pHMDy8Obk1sx/TJ4wjRnVQ8VsVjOZbq97LRzKCFwUGc
 6ayUMP6HJ0bhyEv40IH0HQUN203OpSCzTgTaWCyz2eoRAvm4h/TN2QPq4VVdHD8cm8vc eA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q19kg07rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 18:17:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HIH8iY024844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 18:17:08 GMT
Received: from [10.110.100.39] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 11:17:07 -0700
Message-ID: <696170b9-1cd7-ecce-a318-aa5013855275@quicinc.com>
Date:   Mon, 17 Apr 2023 11:17:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional parameter
To:     Florian Fainelli <f.fainelli@gmail.com>, <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230417174401.19563-1-quic_nkela@quicinc.com>
 <20230417174401.19563-3-quic_nkela@quicinc.com>
 <02b34c80-f37e-deee-29cd-de7db902797d@gmail.com>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <02b34c80-f37e-deee-29cd-de7db902797d@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OBhycSJTA_slnzkhcCReKCRJ8qe4Axe3
X-Proofpoint-ORIG-GUID: OBhycSJTA_slnzkhcCReKCRJ8qe4Axe3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_12,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170162
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2023 11:01 AM, Florian Fainelli wrote:
> On 4/17/23 10:44, Nikunj Kela wrote:
>> This patch add support for passing shmem channel address as parameter
>> in smc/hvc call. This patch is useful when multiple scmi instances are
>> using same smc-id and firmware needs to distiguish among the instances.
>
> Typo: distinguish.
>
Will fix it.
> It really would have been a lot clearer and made a whole lot more 
> sense to encode a VM ID/channel number within some of the SMCCC 
> parameters, possibly as part of the function ID itself.
smc-id(func-id) is 32 bit long and the spec doesn't define any such 
provisions in it. Having said that, there are optional parameters as 
session-id and client-id(secureOS-id) that can be passed in w6/r6 and 
w7/r7 registers. If maintainers are OK to use dtb to pass them instead, 
I can rework the patches.
>
>>
>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/driver.c |  1 +
>>   drivers/firmware/arm_scmi/smc.c    | 25 ++++++++++++++++++++++++-
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/driver.c 
>> b/drivers/firmware/arm_scmi/driver.c
>> index e7d97b59963b..b5957cc12fee 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -2914,6 +2914,7 @@ static const struct of_device_id 
>> scmi_of_match[] = {
>>   #endif
>>   #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
>>       { .compatible = "arm,scmi-smc", .data = &scmi_smc_desc},
>> +    { .compatible = "arm,scmi-smc-param", .data = &scmi_smc_desc},
>>   #endif
>>   #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
>>       { .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
>> diff --git a/drivers/firmware/arm_scmi/smc.c 
>> b/drivers/firmware/arm_scmi/smc.c
>> index 93272e4bbd12..e28387346d33 100644
>> --- a/drivers/firmware/arm_scmi/smc.c
>> +++ b/drivers/firmware/arm_scmi/smc.c
>> @@ -20,6 +20,9 @@
>>     #include "common.h"
>>   +#define lower32(x)    ((u32)((x) & 0xffffffff))
>> +#define upper32(x)    ((u32)(((u64)(x) >> 32) & 0xffffffff))
>
> Cannot you use the existing lower_32_bits and upper_32_bits macros 
> from kernel.h here?
>
>> +
>>   /**
>>    * struct scmi_smc - Structure representing a SCMI smc transport
>>    *
>> @@ -30,6 +33,8 @@
>>    * @inflight: Atomic flag to protect access to Tx/Rx shared memory 
>> area.
>>    *          Used when operating in atomic mode.
>>    * @func_id: smc/hvc call function id
>> + * @is_smc64: smc/hvc calling convention type 64 vs 32
>> + * @param: physical address of the shmem channel
>>    */
>>     struct scmi_smc {
>> @@ -40,6 +45,8 @@ struct scmi_smc {
>>   #define INFLIGHT_NONE    MSG_TOKEN_MAX
>>       atomic_t inflight;
>>       u32 func_id;
>> +    bool is_smc64;
>> +    phys_addr_t param;
>>   };
>>     static irqreturn_t smc_msg_done_isr(int irq, void *data)
>> @@ -137,6 +144,8 @@ static int smc_chan_setup(struct scmi_chan_info 
>> *cinfo, struct device *dev,
>>       if (ret < 0)
>>           return ret;
>>   +    if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param"))
>> +        scmi_info->param = res.start;
>
> There is not even a check that this is going to be part of the 
> kernel's view of memory, that seems a bit brittle and possibly a 
> security hole, too. Your hypervisor presumably needs to have carved 
> out some amount of memory in order for the messages to be written 
> to/read from, and so would the VM kernel, so eventually we should have 
> a 'reserved-memory' entry of some sort, no?
>
>>       /*
>>        * If there is an interrupt named "a2p", then the service and
>>        * completion of a message is signaled by an interrupt rather 
>> than by
>> @@ -156,6 +165,7 @@ static int smc_chan_setup(struct scmi_chan_info 
>> *cinfo, struct device *dev,
>>       }
>>         scmi_info->func_id = func_id;
>> +    scmi_info->is_smc64 = ARM_SMCCC_IS_64(func_id);
>>       scmi_info->cinfo = cinfo;
>>       smc_channel_lock_init(scmi_info);
>>       cinfo->transport_info = scmi_info;
>> @@ -188,7 +198,20 @@ static int smc_send_message(struct 
>> scmi_chan_info *cinfo,
>>         shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
>>   -    arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, 
>> &res);
>> +#ifdef CONFIG_ARM64
>> +    /*
>> +     * if SMC32 convention is used, pass 64 bit address in
>> +     * two parameters
>> +     */
>> +    if (!scmi_info->is_smc64)
>
> There is no need for scmi_info to store is_smc64, just check the 
> func_id here and declare is_smc64 as a local variable to the function.
>
> Also, another way to approach this would be to encode the parameters 
> region in 4KB units such that event on a 32-bit system with LPAE you 
> are guaranteed to fit the region into a 32-bit unsigned long. AFAIR 
> virtualization and LPAE are indistinguishable on real CPUs?
>
>> + arm_smccc_1_1_invoke(scmi_info->func_id,
>> +                     lower32(scmi_info->param),
>> +                     upper32(scmi_info->param),
>> +                     0, 0, 0, 0, 0, &res);
>> +    else
>> +#endif
>> +        arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->param,
>> +                     0, 0, 0, 0, 0, 0, &res);
>>         /* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
>>       if (res.a0) {
>
