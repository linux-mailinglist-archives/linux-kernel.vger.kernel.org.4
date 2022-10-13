Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3BE5FDDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiJMQDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJMQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:03:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD8105370;
        Thu, 13 Oct 2022 09:03:03 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DETIJW002993;
        Thu, 13 Oct 2022 16:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7GCxck1F76oNu/zOawhZchbhsyoZ314kO7NzDUJIlZA=;
 b=gp+p4Cnw6EMx4jwqorcfDni2xbk+nd/B+2/PI2ZDflExITS8kXOixnr3CRFzJxvV/pPq
 66QcEiGEVjvOhHitDx0mjQ5j6IgSNdPxHlRvv8OTHNN24873StSp8FkfP/aGgypGRhd2
 3Kg24xM99cpukdscKWEeH+wQ4AAizp8RXzUxeOeN1U4FXWfstzNNMjgM7a8GBGweGX6x
 J1iVthCdSacVipZBYeetq35BLuRZmCpIG8E+0G8ASFqM16VIuiee4qEucta6Ts4Q0+Ss
 tFiQ2blJia1F5GZWeiPuA8s6upa8bt/3bswENgkIXTckCST9b7IZ+vGIFm1oviyw/clB rA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k643h3397-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 16:02:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29DG2o3L012012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 16:02:50 GMT
Received: from [10.38.241.12] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 09:02:46 -0700
Message-ID: <32af4444-9c88-eb0f-eda7-24fa0418aff6@quicinc.com>
Date:   Thu, 13 Oct 2022 09:02:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH v3 06/10] drm/msm/dsi: Migrate to
 drm_dsc_compute_rc_parameters()
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     <phone-devel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@gmail.com>,
        <linux-arm-msm@vger.kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <freedreno@lists.freedesktop.org>, Sean Paul <sean@poorly.run>,
        <linux-kernel@vger.kernel.org>
References: <20221009184824.457416-1-marijn.suijten@somainline.org>
 <20221009185058.460688-1-marijn.suijten@somainline.org>
 <5c178d7e-5022-f5e5-791d-d3800114b42b@quicinc.com>
 <20221013093646.c65mbjc6oekd7gha@SoMainline.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20221013093646.c65mbjc6oekd7gha@SoMainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ugdfzT4CmzreMjEF5Ak7NdJbjnZLkbxn
X-Proofpoint-ORIG-GUID: ugdfzT4CmzreMjEF5Ak7NdJbjnZLkbxn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130092
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2022 2:36 AM, Marijn Suijten wrote:
> On 2022-10-12 16:03:06, Abhinav Kumar wrote:
>>
>>
>> On 10/9/2022 11:50 AM, Marijn Suijten wrote:
>>> As per the FIXME this code is entirely duplicate with what is already
>>> provided inside drm_dsc_compute_rc_parameters(), and it is yet unknown
>>> why this comment was put in place instead of resolved from the get-go.
>>> Not only does it save on duplication, it would have also spared certain
>>> issues.
>>>
>>> For example, this code from downstream assumed dsc->bits_per_pixel to
>>> contain an integer value, whereas the upstream drm_dsc_config struct has
>>> it with 4 fractional bits.  drm_dsc_compute_rc_parameters() already
>>> accounts for this feat, and the sole remaining use of
>>> dsc->bits_per_pixel inside dsi_populate_dsc_params() will be addressed
>>> in a separate patch.
>>>
>>
>> This is a nice cleanup! Thanks for doing this. I would actually like to
>> move towards the drm_dsc_compute_rc_parameters() API.
>>
>> But I would like to hold back this change till Vinod clarifies because
>> Vinod had mentioned that with drm_dsc_compute_rc_parameters() he was
>> seeing a mismatch in the computation of two values.
>>
>> slice_bpg_offset and the final_offset.
> 
> Unsurprisingly so because final_offset, and slice_bpg_offset through
> initial_offset depend directly on bits_per_pixel.  The main takeaway of
> this series is that Vinod was interpreting this field as integer instead
> of containing 4 fractional bits.  If he updates his the panel driver [1]
> to set bits_per_pixel = 8 << 4 instead of just 8 to account for this,
> the values should check out once again.
> 
> [1]: https://git.linaro.org/people/vinod.koul/kernel.git/commit/?h=topic/pixel3_5.18-rc1&id=1d7d98ad564f1ec69e7525e07418918d90f247a1
> 
> Once Vinod (or someone else in the posession of a Pixel 3) confirms
> this, I can respin this series and more explicitly explain why the FIXME
> was put in place, instead of being resolved outright?
> 
> - Marijn

Makes perfect sense to me.

Will just wait for Vinod's tested-by.

> 
>>
>> The difference between the upstream drm_dsc_compute_rc_parameters() and
>> dsi_populate_dsc_params() causing this was not clear to me from his
>> explanation earlier.
>>
>> So this was left as a to-do item.
>>
>> I would like this to be re-tested on pixel3 and check if this works for
>> vinod. If not, i think its the right time to debug why and not delay
>> this more.
>>
>> Thanks
>>
>> Abhinav
