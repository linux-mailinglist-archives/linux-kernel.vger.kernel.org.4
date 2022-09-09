Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0452D5B3EB5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiIISRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiIISQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:16:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84910B011
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:16:58 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2898XvbQ025807;
        Fri, 9 Sep 2022 18:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tuPPrucYTqpGq1jfSQ7TV8M2XN0vfz8dVieMxM7ko4A=;
 b=UCmE0QGLk/CNeriQOsgAoEfCNTW5CRPoWW6ozH1zRCbS0KRNk0GVzi8v32iN+oqFTNRU
 +zcyfaC8qUmBufutOsho8jtKhXG6mJQ2/2XEUrnAEe/5qnXTneaGPLJ1IiuRgHOHfm0A
 z7yr2xfp1Es0aHZsY9WQXFULaPNkpnYDrXF3lQbmET4t6akjYvBIWTCdKVtoHkNmBKxv
 5GjG0Us83aO2nF+hZN5pOZwLBjgNoEDX2eGo7M+pCs+GtiqtII0i2Gi/j4+weUDdwyi/
 RU7DmOPPPXjztWgjZ1s+3IFOa47x1VXPIZ6UcqjQglA4aW88lsur6dAxNd1jziY2SqGT FA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfcpbxewm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 18:16:49 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 289HtK8u015807
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 17:55:20 GMT
Received: from [10.110.45.139] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 9 Sep 2022
 10:55:19 -0700
Message-ID: <05057e2a-1a85-69ba-ffcd-584d4090467a@quicinc.com>
Date:   Fri, 9 Sep 2022 10:55:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] KVM: arm64: Only set KVM_MODE_PROTECTED if
 is_hyp_mode_available()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>
References: <20220909144552.3000716-1-quic_eberman@quicinc.com>
 <Yxt3wmXYYbWraXrd@arm.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Yxt3wmXYYbWraXrd@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AP-y2F3XMGyeOnd-nJxqrgPW6E8z7YUm
X-Proofpoint-GUID: AP-y2F3XMGyeOnd-nJxqrgPW6E8z7YUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=685 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090065
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/2022 10:28 AM, Catalin Marinas wrote:
> On Fri, Sep 09, 2022 at 07:45:52AM -0700, Elliot Berman wrote:
>> Do not switch kvm_mode to KVM_MODE_PROTECTED if hypervisor mode is not
>> available. This prevents "Protected KVM" cpu capability being reported
>> when Linux is booting in EL1 and would not have KVM enabled.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   arch/arm64/kvm/arm.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 8fe73ee5fa84..861f4b388879 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -2272,7 +2272,9 @@ static int __init early_kvm_mode_cfg(char *arg)
>>   		return -EINVAL;
>>   
>>   	if (strcmp(arg, "protected") == 0) {
>> -		if (!is_kernel_in_hyp_mode())
>> +		if (!is_hyp_mode_available())
>> +			kvm_mode = KVM_MODE_DEFAULT;
> 
> I think kvm_mode is already KVM_MODE_DEFAULT at this point. You may want
> to print a warning instead.
> 

Does it make sense to print warning for kvm-arm.mode=nvhe as well?
