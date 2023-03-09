Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BEB6B18CF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCIBgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIBgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:36:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082F467031;
        Wed,  8 Mar 2023 17:36:09 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328N2I9m004069;
        Thu, 9 Mar 2023 01:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A5uXqcdle5bLVI4w3P2z/u3mEUjmhCGZT40Ofkc5+WU=;
 b=M5gi/8wzTlwE/K2/j6+x1uboXMWMWIlbnqUFqfLXMlvP+mU0RW31O19hNB6MFLyI4HbW
 X3L622nkNhMNJ6IVn5weCgcBh8JLB2ShaVOStCreFxQ10UY9awW/AUA2EErvIOLObx9j
 LbwW2fESW1V/G7iKKeqLR1dTj9CNjmidGVKjWs9XomCa/yti9Tc/UJiInWyNhCnn+UvL
 +FQISt3HiYcxP3aU44fZgt3e3X5iqpFlo5RzDvXT/tXeK4B3e5VFk3igRj4PX7/iRinq
 fqeXXgeYhVU32DNnCf+7mAio5bHfCsW0urB/lAN8UjoOHSK/949SZEIE4NokRIWtAMxd HA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fej3bd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 01:35:55 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3291ZsUm007753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 01:35:54 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 17:35:54 -0800
Message-ID: <690bbcfe-d6db-f6d1-acea-8ee5aa4ac606@quicinc.com>
Date:   Wed, 8 Mar 2023 17:35:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v1 4/4] ufs: mcq: Added ufshcd_mcq_abort()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
 <c7fcbb70f0e74d225c1a09f107ba1058270739be.1678247309.git.quic_nguyenb@quicinc.com>
 <85994527-d09d-f381-3dda-7cfb9ce98d4b@acm.org>
 <ec627f76-380b-bdfd-e736-1626d5bde0e4@quicinc.com>
 <e354dece-5dc8-9cdc-b822-59a1e0f3a9c3@acm.org>
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <e354dece-5dc8-9cdc-b822-59a1e0f3a9c3@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TLWj6MtvT77ZXkweNdiOWR_ZF8b4bJz-
X-Proofpoint-ORIG-GUID: TLWj6MtvT77ZXkweNdiOWR_ZF8b4bJz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=645 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090013
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/2023 3:25 PM, Bart Van Assche wrote:
> On 3/8/23 14:37, Bao D. Nguyen wrote:
>> On 3/8/2023 11:02 AM, Bart Van Assche wrote:
>>> On 3/7/23 20:01, Bao D. Nguyen wrote:
>>>> +    if (ufshcd_mcq_cqe_search(hba, hwq, tag)) {
>>>> +        dev_err(hba->dev, "%s: cmd found in cq. hwq=%d, tag=%d\n",
>>>> +                __func__, hwq->id, tag);
>>>> +        /*
>>>> +         * The command should not be 'stuck' in the CQ for such a 
>>>> long time.
>>>> +         * Is interrupt missing? Process the CQEs here. If the 
>>>> interrupt is
>>>> +         * invoked at a later time, the CQ will be empty because 
>>>> the CQEs
>>>> +         * are already processed here.
>>>> +         */
>>>> +        ufshcd_mcq_poll_cqe_lock(hba, hwq);
>>>> +        err = SUCCESS;
>>>> +        goto out;
>>>> +    }
>>>
>>> Please remove the above code and also the definition of the 
>>> ufshcd_mcq_cqe_search() function. The SCSI error handler submits an 
>>> abort to deal with command processing timeouts. 
>>> ufshcd_mcq_cqe_search() can only return true in case of a software 
>>> bug at the host side. Addressing such bugs is out of scope for the 
>>> SCSI error handler.
>>
>> This is an attempt to handle the error case similar to SDB mode where 
>> it prints "%s: cmd was completed, but without a notifying intr, tag = 
>> %d" in the ufshcd_abort() function.
>>
>> In this case the command has been completed by the hardware, but some 
>> reasons the software has not processed it. We have seen this print 
>> happened during debug sessions, so the error case does happen in SBL 
>> mode.
>>
>> Are you suggesting we should return error in this case without 
>> calling ufshcd_mcq_poll_cqe_lock()?
>
> What I am asking is to remove ufshcd_mcq_poll_cqe_lock() and all code 
> that depends on that function returning true. Although such code might 
> be useful for SoC debugging, helping with SoC debugging is out of 
> scope for Linux kernel drivers.
I will remove it. In that case, we don't need the first patch of this 
series, so I will remove the first patch as well. Thanks.
>
> Thanks,
>
> Bart.
>

