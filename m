Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED973E692
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjFZRfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjFZReh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:34:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E6E10CC;
        Mon, 26 Jun 2023 10:34:36 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QGtlo2004894;
        Mon, 26 Jun 2023 17:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EyU7g+/FdYKrk1DQaEP2iYnQoU8oezLZUpMJ66Ucu9Q=;
 b=hgixuRItsxPwEM2NXUJMoi/E8RbvrDf2EE1o+DRP9PvLFZDMZFEcCBbhFpCMaMQ1vhFO
 pS5t7ke/+aS+wRklFQR8hSlD9bMxCjgoQkOS31ccKqAPzSKgwTHK2ud5xs9c90L0Df+E
 VoEYD51LiEmHx8NnYHDTn5pWdinJZivqI+gZditAWRW01Cnmt2OXT+x1Xk6YuSQFlpfT
 VaHHCkCIr+czB/1CjqdeRHFtU3qM0iJCvLkqzu4ukn+/SF3x6A9Lt5EsgW2rE6VuosqB
 M6P6EYsHCiwvmGzvP0jrccFTSQXRwhX73YIYtf6C/61V/2VIz/mmHsMQG1vxtF3XxmgO 4w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rdrvd4r8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 17:34:21 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35QHYKeC004838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 17:34:20 GMT
Received: from [10.216.59.223] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 26 Jun
 2023 10:34:16 -0700
Message-ID: <696269e1-8b97-66ed-c9b0-ce1b8d637d24@quicinc.com>
Date:   Mon, 26 Jun 2023 23:04:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated ramoops
 memory regions
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Kees Cook <keescook@chromium.org>
CC:     John Stultz <jstultz@google.com>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        <kernel-team@android.com>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
References: <20230622005213.458236-1-isaacmanjarres@google.com>
 <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
 <202306212212.5E53607@keescook> <ZJSES98P+zzrhBI5@google.com>
 <3A2CFB4D-27D0-4FEB-93B4-2F888305DE5A@kernel.org>
 <a2c9417b-3a50-bea4-dd39-2f021c196fa1@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <a2c9417b-3a50-bea4-dd39-2f021c196fa1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mmjga9lZugHysgU3bcUR50qAwjUFXuLA
X-Proofpoint-GUID: Mmjga9lZugHysgU3bcUR50qAwjUFXuLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_14,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=822 suspectscore=0 phishscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260160
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2023 1:21 AM, Elliot Berman wrote:
> 
> 
> On 6/22/2023 10:58 AM, Kees Cook wrote:
>> On June 22, 2023 10:26:35 AM PDT, Isaac Manjarres 
>> <isaacmanjarres@google.com> wrote:
>>> On Wed, Jun 21, 2023 at 10:15:45PM -0700, Kees Cook wrote:
>>>> On Wed, Jun 21, 2023 at 09:47:26PM -0700, John Stultz wrote:
>>>>>> The reserved memory region for ramoops is assumed to be at a fixed
>>>>>> and known location when read from the devicetree. This is not 
>>>>>> desirable
>>>>>> in environments where it is preferred for the region to be 
>>>>>> dynamically
>>>>>> allocated early during boot (i.e. the memory region is defined with
>>>>>> the "alloc-ranges" property instead of the "reg" property).
>>>>>>
>>>>>
>>>>> Thanks for sending this out, Isaac!
>>>>>
>>>>> Apologies, I've forgotten much of the details around dt bindings here,
>>>>> so forgive my questions:
>>>>> If the memory is dynamically allocated from a specific range, is it
>>>>> guaranteed to be consistently the same address boot to boot?
>>>>>
>>>>>> Since ramoops regions are part of the reserved-memory devicetree
>>>>>> node, they exist in the reserved_mem array. This means that the
>>>>>> of_reserved_mem_lookup() function can be used to retrieve the
>>>>>> reserved_mem structure for the ramoops region, and that structure
>>>>>> contains the base and size of the region, even if it has been
>>>>>> dynamically allocated.
>>>>>
>>>>> I think this is answering my question above, but it's a little opaque,
>>>>> so I'm not sure.
>>>>
>>>> Yeah, I had exactly the same question: will this be the same
>>>> boot-to-boot?
>>>
>>> Hi Kees,
>>>
>>> Thank you for taking a look at this patch and for your review! When the
>>> alloc-ranges property is used to describe a memory region, the memory
>>> region will always be allocated within that range, but it's not
>>> guaranteed to be allocated at the same base address across reboots.
>>>
>>> I had proposed re-wording the end of the commit message in my response
>>> to John as follows:
>>>
>>> "...and that structure contains the address of the base of the region
>>> that was allocated at boot anywhere within the range specified by the
>>> "alloc-ranges" devicetree property."
>>>
>>> Does that clarify things better?
>>
>> I am probably misunderstanding something still, but it it varies from 
>> boot to boot, what utility is there for pstore if it changes? I.e. the 
>> things written during the last boot would then no longer accessible at 
>> the next boot? E.g.:
>>
>> Boot 1.
>> Get address Foo.
>> Crash, write to Foo.
>> Boot 2.
>> Get address Bar, different from Foo.
>> Nothing found at Bar, so nothing populated in pstorefs; crash report 
>> from Boot 1 unavailable.
>>
>> I feel like there is something I don't understand about the Foo/Bar 
>> addresses in my example.
>>
> 
> I believe this is being added to support the QCOM SoC minidump feature. 
> Mukesh has posted it on the mailing lists here:
> 
> https://lore.kernel.org/all/1683133352-10046-1-git-send-email-quic_mojha@quicinc.com/
> 
> https://lore.kernel.org/all/1683133352-10046-10-git-send-email-quic_mojha@quicinc.com/
> 
> Mukesh, could you comment whether this patch is wanted for us in the 
> version you have posted? It looks like maybe not based on the commit 
> text in patch #9.

No, this is no needed after patch #9 .

I have tried multiple attempt already to get this patch in

https://lore.kernel.org/lkml/1675330081-15029-2-git-send-email-quic_mojha@quicinc.com/

later tried the approach of patch #9 along with minidump series..


- Mukesh

> 
>   - Elliot
