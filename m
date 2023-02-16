Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B981699B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBPRZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjBPRZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:25:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902E02A149;
        Thu, 16 Feb 2023 09:25:00 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GDV6AU011765;
        Thu, 16 Feb 2023 17:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Owu4kKEVZG2ZOvUONe24jGcyp2Oqr3f4CtmNiGV/rtE=;
 b=eRziNPAHlxkvN6EYvQm4FFE/WuU9rOZAf0ZGwb/iJZcaVj6XrRQnqaKnvECmuqm22EbI
 lP8PigIVcyK0r8LpBBOwFdOAdlLDYV+AvUon4rVbXnyzVoE0Win4hvrRzViMlSldBgh+
 PbLVAPKo5yKnwlo0NCM6VjJezMvI4fVVLyKcj3poQaYL/ZJGjxqFqVmYt3JDpl0O0jg9
 IjzBifyk93l6l/jYmKler6CRgmsoi2YmkxoOrlW1J5BOLGbMos5PtMB+SrnjZfypOdB2
 HHogu6ZqYf85cMLlMC+ajEDroihoNUcCyAdYRfDk2tlNc8Ti9ulbDIr2KUSWAtn+jRml sQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrwcs481d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:24:48 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GHOl3M014778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:24:47 GMT
Received: from [10.110.95.168] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 09:24:46 -0800
Message-ID: <94992117-2cab-71e6-f38c-bded109171d2@quicinc.com>
Date:   Thu, 16 Feb 2023 09:24:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212417.3315422-1-quic_eberman@quicinc.com>
 <Y+3PXRdbVFz/ErxW@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y+3PXRdbVFz/ErxW@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jxja4lDOlj973SIyiXrrOef7lSsK6Wjo
X-Proofpoint-ORIG-GUID: jxja4lDOlj973SIyiXrrOef7lSsK6Wjo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_14,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160151
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/2023 10:38 PM, Greg Kroah-Hartman wrote:
> On Tue, Feb 14, 2023 at 01:24:16PM -0800, Elliot Berman wrote:
>>
>> When launching a virtual machine, Gunyah userspace allocates memory for
>> the guest and informs Gunyah about these memory regions through
>> SET_USER_MEMORY_REGION ioctl.
> 
> It also frees memory, see below.  Why not document that?
> 

I can mention in commit text, too.

>> +	case GH_VM_SET_USER_MEM_REGION: {
>> +		struct gh_userspace_memory_region region;
>> +
>> +		if (copy_from_user(&region, argp, sizeof(region)))
>> +			return -EFAULT;
>> +
>> +		/* All other flag bits are reserved for future use */
>> +		if (region.flags & ~(GH_MEM_ALLOW_READ | GH_MEM_ALLOW_WRITE | GH_MEM_ALLOW_EXEC |
>> +			GH_MEM_LENT))
>> +			return -EINVAL;
> 
> Nice, thanks for validating that.
> 
> 
>> +
>> +
> 
> Nit, 2 blank lines are not needed :(
> 
> 
>> +		if (region.memory_size)
>> +			r = gh_vm_mem_alloc(ghvm, &region);
>> +		else
>> +			r = gh_vm_mem_free(ghvm, region.label);
> 
> So if you set the size to 0 it is freed?  Wouldn't a separate ioctl make
> more sense?  Where is this logic documented to userspace? >

We're following KVM convention here. The logic is documented in patch 17/26.

Thanks,
Elliot
