Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3112464D3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiLNXrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLNXrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:47:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9AF33C29;
        Wed, 14 Dec 2022 15:46:59 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BELv832017245;
        Wed, 14 Dec 2022 23:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b74lOJn7gvB3j3KsmREgTq5THccpsNFFgle1eDs0rcU=;
 b=gp1gnZk1zvCBgqaBNoBf6dGEYXxl2AivbDAZfGQnuefKGgHe0G9t2DNX6Q73L2ytkfh5
 tFyudr//Sap6h24bx/J2k6+gjsn3pdoOfFO6y5b59xLHA1eFKAQ4QHgZJmrU/dJwPoyc
 x4Kh+4f9RQEU/hNWrI58giYK7MkxrSXhU2BOaw+AoH+TrMUcg5gAG4BFF/G3lSPykcFr
 xyfQeXSXTSPpEumPA7xHWo+A23T34ulii5ZThXhD8PizciZOfOv/ZvNKTYWlIfhEw5xQ
 u2cvJ0TcXkiwTZvYckV7HvsrQRTw1fPy6jWE//uB5Q1ELBwZoHlc9smuztcbnzdjajY+ rg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rejn27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 23:46:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BENkqFA015423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 23:46:52 GMT
Received: from [10.111.161.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 14 Dec
 2022 15:46:48 -0800
Message-ID: <512f9f0d-a399-27fb-08d0-7311b73fd2a1@quicinc.com>
Date:   Wed, 14 Dec 2022 15:46:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dp: do not complete dp_aux_cmd_fifo_tx() if irq
 is not for aux transfer
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
CC:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1671052890-11627-1-git-send-email-quic_khsieh@quicinc.com>
 <CAD=FV=UTeCU7BcfPMXz8J-9uOp_7Fn9PFdtFMsu46x5wKa0RyQ@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAD=FV=UTeCU7BcfPMXz8J-9uOp_7Fn9PFdtFMsu46x5wKa0RyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TR4NceseZeGHunNInSsOOAhnXvFwVmVE
X-Proofpoint-GUID: TR4NceseZeGHunNInSsOOAhnXvFwVmVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_11,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212140195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug

On 12/14/2022 2:29 PM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Dec 14, 2022 at 1:21 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>>
>> There are 3 possible interrupt sources are handled by DP controller,
>> HPDstatus, Controller state changes and Aux read/write transaction.
>> At every irq, DP controller have to check isr status of every interrupt
>> sources and service the interrupt if its isr status bits shows interrupts
>> are pending. There is potential race condition may happen at current aux
>> isr handler implementation since it is always complete dp_aux_cmd_fifo_tx()
>> even irq is not for aux read or write transaction. This may cause aux read
>> transaction return premature if host aux data read is in the middle of
>> waiting for sink to complete transferring data to host while irq happen.
>> This will cause host's receiving buffer contains unexpected data. This
>> patch fixes this problem by checking aux isr and return immediately at
>> aux isr handler if there are no any isr status bits set.
>>
>> Follows are the signature at kernel logs when problem happen,
>> EDID has corrupt header
>> panel-simple-dp-aux aux-aea0000.edp: Couldn't identify panel via EDID
>> panel-simple-dp-aux aux-aea0000.edp: error -EIO: Couldn't detect panel nor find a fallback
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_aux.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
>> index d030a93..8f8b12a 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
>> @@ -423,6 +423,13 @@ void dp_aux_isr(struct drm_dp_aux *dp_aux)
>>
>>          isr = dp_catalog_aux_get_irq(aux->catalog);
>>
>> +       /*
>> +        * if this irq is not for aux transfer,
>> +        * then return immediately
>> +        */
> 
> Why do you need 4 lines for a comment that fits on one line?
Yes, we can fit this to one line.
> 
>> +       if (!isr)
>> +               return;
> 
> I can confirm that this works for me. I could reproduce the EDID
> problems in the past and I can't after this patch. ...so I could give
> a:
> 
> Tested-by: Douglas Anderson <dianders@chromium.org>
> 
> I'm not an expert on this part of the code, so feel free to ignore my
> other comments if everyone else thinks this patch is fine as-is, but
> to me something here feels a little fragile. It feels a little weird
> that we'll "complete" for _any_ interrupt that comes through now
> rather than relying on dp_aux_native_handler() / dp_aux_i2c_handler()
> to specifically identify interrupts that caused the end of the
> transfer. I guess that idea is that every possible interrupt we get
> causes the end of the transfer?
> 
> -Doug

So this turned out to be more tricky and was a good finding from kuogee.

In the bad EDID case, it was technically not bad EDID.

What was happening was, the VIDEO_READY interrupt was continuously 
firing. Ideally, this should fire only once but due to some error 
condition it kept firing. We dont exactly know why yet what was the 
error condition making it continuously fire.

In the DP ISR, the dp_aux_isr() gets called even if it was not an aux 
interrupt which fired (so the call flow in this case was 
dp_display_irq_handler (triggered for VIDEO_READY) ---> dp_aux_isr()
So we should certainly have some protection to return early from this 
routine if there was no aux interrupt which fired.

Which is what this fix is doing.

Its not completing any interrupt, its just returning early if no aux 
interrupt fired.

So based on the logs I have seen and given that its fixing this 
stability issue.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
