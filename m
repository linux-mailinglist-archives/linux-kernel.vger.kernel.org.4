Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8570B5DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjEVHGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjEVHF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:05:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0312684;
        Mon, 22 May 2023 00:02:48 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5AXIt006779;
        Mon, 22 May 2023 07:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GCyDNdBxjdpndBeVSnq6vZ/W/caszfgq1a9vcs1LanE=;
 b=Aq3OY9t46yVl7QmjW2wNyfPBI/2QXrzmX8guazUL6xrtl0JekQhG02u3sfpHXriKWcLq
 b4nXB5lM9CP96cMg6FWKgNTzLMcMO3mBAjOPcuYK6KW/3uRuDIqBvOfHNl+wbQg0ECh9
 q7kc/fFmV1d/f3gcLxkH+zDA89pvUSBivf2q7HbxDDyrEEp0fraatHKTbdv2ORVC8cgQ
 tWABFL8N5Att8cfPogF/R+Bbc2vqKVchkmAsXv0LNeSQYlH9d7A4OsqiqKcxek3ZXK1n
 xiyD4Qln3MTySvWP4x/AXTaLjeoU+q9C6914GXICErwbAteNoyvYPr/kjdE4lHFqzo82 WA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppypat1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 07:02:05 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34M725jC000399
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 07:02:05 GMT
Received: from [10.253.35.102] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 00:02:03 -0700
Message-ID: <113156cf-5770-c0c7-dea6-4ddca43b4438@quicinc.com>
Date:   Mon, 22 May 2023 15:01:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] bus: mhi: host: Skip MHI reset if device is in RDDM
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>,
        <stable@vger.kernel.org>
References: <1684390959-17836-1-git-send-email-quic_qianyu@quicinc.com>
 <20230519135129.GA4843@thinkpad>
Content-Language: en-US
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20230519135129.GA4843@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QO7Q7Uo9Yho1LYr5ylGld139xtzDmejz
X-Proofpoint-GUID: QO7Q7Uo9Yho1LYr5ylGld139xtzDmejz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220059
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/2023 9:51 PM, Manivannan Sadhasivam wrote:
> On Thu, May 18, 2023 at 02:22:39PM +0800, Qiang Yu wrote:
>> In RDDM EE, device can not process MHI reset issued by host. In case of MHI
>> power off, host is issuing MHI reset and polls for it to get cleared until
>> it times out. Since this timeout can not be avoided in case of RDDM, skip
>> the MHI reset in this scenarios.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: a6e2e3522f29 ("bus: mhi: core: Add support for PM state transitions")
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> ---
>> v1->v2: use ~75 columns in commit text, add Fixes tag
>> v2->v3: update Fixes tag
>> v3->v4: add review tag and CC stable
>>
>>   drivers/bus/mhi/host/pm.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
>> index 0834590..8a4362d 100644
>> --- a/drivers/bus/mhi/host/pm.c
>> +++ b/drivers/bus/mhi/host/pm.c
>> @@ -470,6 +470,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>>   
>>   	/* Trigger MHI RESET so that the device will not access host memory */
>>   	if (!MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
>> +		/* Skip MHI RESET if in RDDM state */
>> +		if (mhi_cntrl->rddm_image && mhi_get_exec_env(mhi_cntrl) == MHI_EE_RDDM)
> Do we really need to check for rddm_image? Wouldn't the EE check sufficient
> enough?
>
> In that case, the check can be moved to the prior if condition.
>
> - Mani

If rddm_image is NULL, that means this device does not support RDDM. In this case, it is unnecessary to access MMIO register.

>> +			goto skip_mhi_reset;
>> +
>>   		dev_dbg(dev, "Triggering MHI Reset in device\n");
>>   		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
>>   
>> @@ -495,6 +499,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>>   		}
>>   	}
>>   
>> +skip_mhi_reset:
>>   	dev_dbg(dev,
>>   		 "Waiting for all pending event ring processing to complete\n");
>>   	mhi_event = mhi_cntrl->mhi_event;
>> -- 
>> 2.7.4
>>
>>
