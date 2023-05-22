Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3180070CD82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjEVWIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEVWIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:08:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD57A9E;
        Mon, 22 May 2023 15:08:44 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLxHbS030842;
        Mon, 22 May 2023 22:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dprGoRvd60sAloN3JzaU3vUHUhDpUIgBUgbjLzM3+aQ=;
 b=faiMEQo77pJ1m9jZE+Ty9hEaZ0y81Ita0SK8aSEseCD2Sk31wz2H9s02Ic9icUc3LWsk
 WF/M08c/rDHlYY7XkGsoynwYDxspXCPDDku+JmHabFSJBWAtEADSyO9m4xt93C4In4RD
 7rLANmJURkfLSIwUK3Bt29t7PkdAiCtbtfo3CtZnR1Ym6ayXmQQtHenGv81J19pzHExM
 VtUCNpzgpPhQ3ONurfuJ1ZwKM9uVzGlB+KZpUkJzpLPm4YxwYs/pZscF1BTohm6fsMAy
 NEiE+t51JY7oi4ylLqFQDgqOZ5pPT1Hf6dquoFIkYdu94TlBrYlsE3Ur4a4pIJ2Uu40t rw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr8qr938s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 22:08:37 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34MM8aMp024402
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 22:08:36 GMT
Received: from [10.71.110.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 15:08:36 -0700
Message-ID: <3935b919-58ee-e8c6-826f-7ebdff980524@quicinc.com>
Date:   Mon, 22 May 2023 15:08:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Freedreno] [PATCH v4 1/5] msm/drm/dsi: Round up DSC hdisplay
 calculation
Content-Language: en-US
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     <freedreno@lists.freedesktop.org>, Sean Paul <sean@poorly.run>,
        "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Clark" <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>
References: <20230405-add-dsc-support-v4-0-15daf84f8dcb@quicinc.com>
 <20230405-add-dsc-support-v4-1-15daf84f8dcb@quicinc.com>
 <eo7chb7m4cowvb53hnebi3bjtotm7x5ea5iv6ulmmfkr2hdt32@2nkoa5rco3qb>
 <a93c3c36-f262-b89d-8452-98120cffb491@quicinc.com>
In-Reply-To: <a93c3c36-f262-b89d-8452-98120cffb491@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wtEPy21QFtILttYMHmvhq0LpeqaJvZuy
X-Proofpoint-ORIG-GUID: wtEPy21QFtILttYMHmvhq0LpeqaJvZuy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220187
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 2:45 PM, Jessica Zhang wrote:
> 
> 
> On 5/22/2023 1:44 PM, Marijn Suijten wrote:
>> On 2023-05-22 13:30:20, Jessica Zhang wrote:
>>> Currently, when compression is enabled, hdisplay is reduced via integer
>>> division. This causes issues for modes where the original hdisplay is
>>> not a multiple of 3.
>>>
>>> To fix this, use DIV_ROUND_UP to divide hdisplay.
>>>
>>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> Suggested-by: Marijn Suijten <marijn.suijten@somainline.org>
>>
>> Nit: probably these should go in the opposite order.  And if they're
>> all supposed to be chronological, I think it is:
>>
>>      Suggested-by:
>>      Fixes:
>>      Signed-off-by:
>>      Reviewed-by:
>>
>> But unsure if that's a hard requirement, or even correct at all.
> 
> Hi Marijn,
> 
> I don't see any explicit documentation on the order of R-b tags. FWIW, I 
> see in the git log that S-o-b always goes at the bottom of the commit 
> message.
> 
> I would prefer the S-o-b to always be at the bottom (as it helps me 
> avoid duplicate S-o-b's when doing `git commit -s`), though I can flip 
> the order of the R-b and suggested-by tags.

Correction -- I can reorder the tags so that it's:

Suggested-by:
Fixes:
Reviewed-by:
Signed-off-by:

Thanks,

Jessica Zhang

> 
> Thanks,
> 
> Jessica Zhang
> 
>>
>> - Marijn
>>
>>> Fixes: 08802f515c3cf ("drm/msm/dsi: Add support for DSC configuration")
>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c 
>>> b/drivers/gpu/drm/msm/dsi/dsi_host.c
>>> index 9223d7ec5a73..18d38b90eb28 100644
>>> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
>>> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
>>> @@ -952,7 +952,7 @@ static void dsi_timing_setup(struct msm_dsi_host 
>>> *msm_host, bool is_bonded_dsi)
>>>            * pulse width same
>>>            */
>>>           h_total -= hdisplay;
>>> -        hdisplay = msm_dsc_get_bytes_per_line(msm_host->dsc) / 3;
>>> +        hdisplay = 
>>> DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);
>>>           h_total += hdisplay;
>>>           ha_end = ha_start + hdisplay;
>>>       }
>>>
>>> -- 
>>> 2.40.1
>>>
