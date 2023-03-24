Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C456C7F19
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjCXNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCXNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:50:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F011ABFA;
        Fri, 24 Mar 2023 06:50:18 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OCeBHm028430;
        Fri, 24 Mar 2023 13:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JdVVWHZ69BaDiZ+0gfVAZs2x+E32SkohOmw9pXDXoGk=;
 b=fvr2yaNH5nbmkKZloZvXrH1DkJJmfJgqJfWsTTdFzJT1iD5fISUPziR5RTexE+QSQaXs
 Z5ERk1BVTaNhMKjx4kFzv3cMzTcqd6WIbHbWSA8RFS4x6842c7TWwhyq41XN9oAPzcDb
 hlNeh4IogQqOZiz/4chZzcQrp3miUKVWaEPetHU3+7vMjtkZGRS4Lg00iKzw10Ewj5L6
 1JAA4eRM5W6zAL7ZCZkZ2QnrAPyg0M07e925G8Kevi+7aaW9bXWtSNuV1WEDdtB24BCX
 YyULnuuU98MeIP0gRGydJq2iXnxlKoNDRrzrc/HAtj8de+Vs8h+pjZX81zvP9+JJQ2O5 6g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgy60a0qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 13:50:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32ODo3E3020342
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 13:50:03 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 24 Mar
 2023 06:50:02 -0700
Message-ID: <11ea2552-27e1-3665-869c-4594de1782a5@quicinc.com>
Date:   Fri, 24 Mar 2023 07:50:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: host: Range check CHDBOFF and ERDBOFF
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1679066059-8399-1-git-send-email-quic_jhugo@quicinc.com>
 <20230324103452.GC4259@thinkpad>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230324103452.GC4259@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vHeHX3xCtvbLGlCpiO9ew32pexnjDQOK
X-Proofpoint-GUID: vHeHX3xCtvbLGlCpiO9ew32pexnjDQOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_08,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303240112
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/2023 4:34 AM, Manivannan Sadhasivam wrote:
> On Fri, Mar 17, 2023 at 09:14:19AM -0600, Jeffrey Hugo wrote:
>> If the value read from the CHDBOFF and ERDBOFF registers is outside the
>> range of the MHI register space then an invalid address might be computed
>> which later causes a kernel panic.  Range check the read value to prevent
>> a crash due to bad data from the device.
>>
>> Fixes: 6cd330ae76ff ("bus: mhi: core: Add support for ringing channel/event ring doorbells")
> 
> Please CC stable list.

The stable folks have been automatically picking up everything with a 
fixes tag for years.  CCing the stable list does not seem to do anything 
unless the patch needs specific backporting adjustments.

Do you still want an explicit CC?

> 
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
>> ---
>>   drivers/bus/mhi/host/init.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index 3d779ee..ae8ebcfb 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -516,6 +516,12 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>   		return -EIO;
>>   	}
>>   
>> +	if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
>> +		dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
>> +			val, mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB));
>> +		return -EINVAL;
> 
> Isn't -ERANGE a better errno here and also in other places of the driver?

I suppose that could work.  This was modeled after the existing BHI (eg 
BHIOFF) range checks.  You want those updated in the same change or a 
separate one?

> Thanks,
> Mani
> 
>> +	}
>> +
>>   	/* Setup wake db */
>>   	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
>>   	mhi_cntrl->wake_set = false;
>> @@ -532,6 +538,12 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>   		return -EIO;
>>   	}
>>   
>> +	if (val >= mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings)) {
>> +		dev_err(dev, "ERDB offset: 0x%x is out of range: 0x%zx\n",
>> +			val, mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings));
>> +		return -EINVAL;
>> +	}
>> +
>>   	/* Setup event db address for each ev_ring */
>>   	mhi_event = mhi_cntrl->mhi_event;
>>   	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
>> -- 
>> 2.7.4
>>
>>
> 

