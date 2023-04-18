Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70326E6A91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjDRRHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjDRRHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:07:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3107EFA;
        Tue, 18 Apr 2023 10:07:32 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6rTIG010692;
        Tue, 18 Apr 2023 17:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PNvIebMKg0s6WLeOM4MrOoRQKx0Az7eGDCsVUpNExw4=;
 b=nCJh/Lfkn9VFSeDJj2flIYMMZzbWlJFeki1VGmYoqBGbJDK0bMvZFwym32apw30uDe+T
 SfUSFjapG3yJTQAKCpTdnohVNMth82PeBFEV7duDM/mIRTBefUf2Krbgmof5zzrEzUrD
 SQSulhPp2DrNyO9qKcqAy6L0MLNoSgnrplOqkmv/EobKv8hIoTXtrXiOeOvaQQclQnTl
 7v4+W0CptnMGpqV4WxrLd0yABFvq6TsMNKhX/Tbm5mlLsNPGGGtMn2eF5y9zzds6dek4
 3aa6h0OZ+T8tz6BZJX1dCv1zMWjGtPbMDn0bIkX0G8+dDMy6Hzj9sLsU7u/UDePNEvfU mg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1nr5hj9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:07:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33IH7JgJ009939
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:07:19 GMT
Received: from [10.110.100.39] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 18 Apr
 2023 10:07:18 -0700
Message-ID: <12846dc1-38b6-892a-3189-25db866fa38e@quicinc.com>
Date:   Tue, 18 Apr 2023 10:07:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional parameter
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230417174401.19563-1-quic_nkela@quicinc.com>
 <20230417174401.19563-3-quic_nkela@quicinc.com>
 <02b34c80-f37e-deee-29cd-de7db902797d@gmail.com>
 <20230418095846.4lkncoa4beeih2hj@bogus>
 <d05b26ff-1c49-69eb-7146-8f7cef7e1ddb@quicinc.com>
 <40e91346-19d7-c0b4-7fcc-d5a2081fe8dd@gmail.com>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <40e91346-19d7-c0b4-7fcc-d5a2081fe8dd@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fjR5bTmHqKjnDAWCnrKSETB_i2QVL_vA
X-Proofpoint-ORIG-GUID: fjR5bTmHqKjnDAWCnrKSETB_i2QVL_vA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_12,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180143
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2023 9:33 AM, Florian Fainelli wrote:
> On 4/18/23 07:20, Nikunj Kela wrote:
>>
>> On 4/18/2023 2:58 AM, Sudeep Holla wrote:
>>> On Mon, Apr 17, 2023 at 11:01:13AM -0700, Florian Fainelli wrote:
>>>> On 4/17/23 10:44, Nikunj Kela wrote:
>>>>> This patch add support for passing shmem channel address as parameter
>>>>> in smc/hvc call. This patch is useful when multiple scmi instances 
>>>>> are
>>>>> using same smc-id and firmware needs to distiguish among the 
>>>>> instances.
>>>> Typo: distinguish.
>>>>
>>>> It really would have been a lot clearer and made a whole lot more 
>>>> sense to
>>>> encode a VM ID/channel number within some of the SMCCC parameters, 
>>>> possibly
>>>> as part of the function ID itself.
>>>>
>>> Yes I was about to suggest this but then remembered one main reason 
>>> I have
>>> been given in the past against that:
>>> If the system launches high number of VMs then that means loads of FID
>>> needs to be reserved for SCMI and the hypervisor needs to support it.
>>> Basically it is not scalable which I agree but not sure if such large
>>> number of VMs are used in reality with SCMI. But I agree with the 
>>> technical
>>> reasoning.
>>>
>>> The other reason why I preferred the shmem address itself instead of 
>>> some
>>> custom VM ID/channel number is that it can easily becomes vendor 
>>> specific
>>> for no real good reason and then we need to add support for each such
>>> different parameters. Nikunj suggested getting them from DT which I 
>>> really
>>> don't like if the sole reason is just to identify the channel. We don't
>>> have standard SCMI SMC/HVC but allowing such deviations with params 
>>> from
>>> DT will just explode with various combinations for silly/no reason.
>>>
>> Would you be ok to pass the smc/hvc parameters via kernel parameters 
>> in commandline? If so, I can implement that. I just wanted to keep 
>> everything in one place hence suggested using DTB node.
>
> Command line arguments seem a bit unnecessary here and it would force 
> you to invent a scheme to control per SCMI device/instance parameters.
>
Agreed!
>>
>>> [...]
>>>
>>>>> @@ -137,6 +144,8 @@ static int smc_chan_setup(struct 
>>>>> scmi_chan_info *cinfo, struct device *dev,
>>>>>        if (ret < 0)
>>>>>            return ret;
>>>>> +    if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param"))
>>>>> +        scmi_info->param = res.start;
>>>> There is not even a check that this is going to be part of the 
>>>> kernel's view
>>>> of memory, that seems a bit brittle and possibly a security hole, 
>>>> too. Your
>>>> hypervisor presumably needs to have carved out some amount of 
>>>> memory in
>>>> order for the messages to be written to/read from, and so would the VM
>>>> kernel, so eventually we should have a 'reserved-memory' entry of 
>>>> some sort,
>>>> no?
>>>>
>>> Not disagreeing here. Just checking if my understanding is correct 
>>> or not.
>>> IIUC, we need reserved-memory if it is part of the memory presented 
>>> to the
>>> OS right ? You don't need that if it is dedicated memory like part 
>>> of SRAM
>>> or something similar.
>> We are not using reserved-memory node. Instead using sram-mmio to 
>> carve out shmem for scmi instances.
>
> OK, that works too.
>
>>>>>        /*
>>>>>         * If there is an interrupt named "a2p", then the service and
>>>>>         * completion of a message is signaled by an interrupt 
>>>>> rather than by
>>>>> @@ -156,6 +165,7 @@ static int smc_chan_setup(struct 
>>>>> scmi_chan_info *cinfo, struct device *dev,
>>>>>        }
>>>>>        scmi_info->func_id = func_id;
>>>>> +    scmi_info->is_smc64 = ARM_SMCCC_IS_64(func_id);
>>>>>        scmi_info->cinfo = cinfo;
>>>>>        smc_channel_lock_init(scmi_info);
>>>>>        cinfo->transport_info = scmi_info;
>>>>> @@ -188,7 +198,20 @@ static int smc_send_message(struct 
>>>>> scmi_chan_info *cinfo,
>>>>>        shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
>>>>> -    arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, 
>>>>> &res);
>>>>> +#ifdef CONFIG_ARM64
>>>>> +    /*
>>>>> +     * if SMC32 convention is used, pass 64 bit address in
>>>>> +     * two parameters
>>>>> +     */
>>>>> +    if (!scmi_info->is_smc64)
>>>> There is no need for scmi_info to store is_smc64, just check the 
>>>> func_id
>>>> here and declare is_smc64 as a local variable to the function.
>>>>
>>> +1
>> ACK!
>>>> Also, another way to approach this would be to encode the 
>>>> parameters region
>>>> in 4KB units such that event on a 32-bit system with LPAE you are 
>>>> guaranteed
>>>> to fit the region into a 32-bit unsigned long. AFAIR virtualization 
>>>> and LPAE
>>>> are indistinguishable on real CPUs?
>>>>
>>> Agree with the idea. But can a single 4kB be used for multiple shmem 
>>> across
>>> VMs ? IIUC the hypervisor can deal with that, so I prefer it if it 
>>> is possible
>>> practically.
>> We have multiple VMs and each VM has multiple instances. We will have 
>> quite a few domains and I am not sure if single page will suffice.
>
> I did not make myself clear enough, you can encode an offset into the 
> shared memory area, and however big that shared memory area will be, 
> that offset can be in a 4KB size. So for instance if you have your 
> MMIO SRAM at 0x8000_0000, the first VM can use 0x8000_0ffff, the 
> second VM can use 0x8000_1000 to 0x8000_1fff and so on and so forth.
>
> Even if you need more than 4KB per VM, you can put that information 
> into the two additional parameters you pass through the SMC/HVC call.

Okay. I will float another version, first parameter of smc/hvc call will 
be pfn and second the offset!

