Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C263972A213
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjFISXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjFISXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:23:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F6B1730;
        Fri,  9 Jun 2023 11:23:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359FqxYu003464;
        Fri, 9 Jun 2023 18:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xZAwHAYdiTHICYvfdxFuK+h4NxTCnlISN12IpXG6Fug=;
 b=UHBqy/E9IkxqoT8OB0UOGj1ZWnAXq+E1h4dxaKEGTuai6hIt1i+BixS6PI9jD+5uJUJK
 nxcmVIQAOnRXjazMiK8aEq8TD71ffYOc5Pv52fKiY3Lo1Sd+nhodUhnHdCoA+WQe8+WM
 nSGpY/zmlqMhhrB2ejEPbJ5DE9nD1dPCROVZ2RACEVksnXTl4Aq4WSPjShZVd0a6ZW0K
 hAoJwnCd/gUhgJTtCojQkyNS5NLywBVpUIMTcCD3fpM7ZTQKZnJT4y4XnSFrWcpfCiPW
 /qIhzeK1WdNve9kqff+ti4DBVzvVHCpDb5zHb+82T7J72ajAEouo+gTEWramFT3ygWNh 4A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3w7dsj45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 18:22:47 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359IMZRC003104
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 18:22:35 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 11:22:35 -0700
Message-ID: <0416ee79-ac07-aefc-d83b-bc21894312ab@quicinc.com>
Date:   Fri, 9 Jun 2023 11:22:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v13 22/24] virt: gunyah: Add irqfd interface
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-23-quic_eberman@quicinc.com>
 <1c386f4e-e2dd-eb79-9117-9b19877f2ccc@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <1c386f4e-e2dd-eb79-9117-9b19877f2ccc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: woGnfPQzRI2anPREFMhlFBTuvfUVFi7P
X-Proofpoint-ORIG-GUID: woGnfPQzRI2anPREFMhlFBTuvfUVFi7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_13,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 mlxlogscore=917
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090153
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2023 12:50 PM, Alex Elder wrote:
> On 5/9/23 3:47 PM, Elliot Berman wrote:
>> Enable support for creating irqfds which can raise an interrupt on a
>> Gunyah virtual machine. irqfds are exposed to userspace as a Gunyah VM
>> function with the name "irqfd". If the VM devicetree is not configured
>> to create a doorbell with the corresponding label, userspace will still
>> be able to assert the eventfd but no interrupt will be raised on the
>> guest.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> I have a minor suggestion.  I think I'd like to look at this
> again, so:
> 
> Acked-by: Alex Elder <elder@linaro.org>
> 
>> ---
>>   Documentation/virt/gunyah/vm-manager.rst |   2 +-
>>   drivers/virt/gunyah/Kconfig              |   9 ++
>>   drivers/virt/gunyah/Makefile             |   1 +
>>   drivers/virt/gunyah/gunyah_irqfd.c       | 180 +++++++++++++++++++++++
>>   include/uapi/linux/gunyah.h              |  35 +++++
>>   5 files changed, 226 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c
>>
> 
> . . .
> 
>> @@ -99,6 +102,38 @@ struct gh_fn_vcpu_arg {
>>       __u32 id;
>>   };
>> +/**
>> + * enum gh_irqfd_flags - flags for use in gh_fn_irqfd_arg
>> + * @GH_IRQFD_FLAGS_LEVEL: make the interrupt operate like a level 
>> triggered
>> + *                        interrupt on guest side. Triggering IRQFD 
>> before
>> + *                        guest handles the interrupt causes 
>> interrupt to
>> + *                        stay asserted.
>> + */
>> +enum gh_irqfd_flags {
>> +    GH_IRQFD_FLAGS_LEVEL        = 1UL << 0,
> 
>      BIT(0),            /* ? */
> 

The BIT macro isn't a standard C macro and isn't defined by Linux, so it 
causes compile errors at least for me when I use it in userspace.

>> +};
>> +
>> +/**
>> + * struct gh_fn_irqfd_arg - Arguments to create an irqfd function.
>> + *
>> + * Create this function with &GH_VM_ADD_FUNCTION using type 
>> &GH_FN_IRQFD.
>> + *
>> + * Allows setting an eventfd to directly trigger a guest interrupt.
>> + * irqfd.fd specifies the file descriptor to use as the eventfd.
>> + * irqfd.label corresponds to the doorbell label used in the guest 
>> VM's devicetree.
>> + *
>> + * @fd: an eventfd which when written to will raise a doorbell
>> + * @label: Label of the doorbell created on the guest VM
>> + * @flags: see &enum gh_irqfd_flags
>> + * @padding: padding bytes
>> + */
>> +struct gh_fn_irqfd_arg {
>> +    __u32 fd;
>> +    __u32 label;
>> +    __u32 flags;
>> +    __u32 padding;
>> +};
>> +
>>   /**
>>    * struct gh_fn_desc - Arguments to create a VM function
>>    * @type: Type of the function. See &enum gh_fn_type.
> 
