Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9791D74455A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjF3XmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjF3XmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:42:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057963C0B;
        Fri, 30 Jun 2023 16:42:22 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UNXIdx022615;
        Fri, 30 Jun 2023 23:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hft4E1gpvCyofLxOPJJzA7qnS+2omo4bn7L5eCF+mp8=;
 b=EgLb37mJpTQMsKkZVfJaKnz56ctDsbNiTYcIEz5lYsxLv5mZr1/7PWNgcrbvVCKjZ+lA
 eGCW8pSRCES+IUWNy5iBHHoiPoimQy727S3K5f/nvz93VdH4BorNCjKmzYA75g/VFNpZ
 LeMPBzMJS2loNREfwHYxiDu7ZH9ICYjYIMw3FfySdj+TwNmaG6WXPqPdEPvQ1fo1ur/z
 OWgylgfO0XlAJTCGv38E2GEoDEsG5KVtB8vQleikTTkHWZzsdNmdx3vz/0EbtXvvSP1X
 4yjtjgAeXilFGEcToKrsqLuUT1CtoJQkApLp6hbwZeN4fwyoRwC9mb/260ICDSMeJQOQ aw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhw70sjfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 23:41:59 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UNfwp3024189
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 23:41:58 GMT
Received: from [10.71.110.193] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 30 Jun
 2023 16:41:57 -0700
Message-ID: <7d7824a9-b57a-182d-ed04-883933ace702@quicinc.com>
Date:   Fri, 30 Jun 2023 16:41:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC v4 5/7] drm/msm/dpu: Add solid fill and pixel source
 properties
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     <quic_abhinavk@quicinc.com>, <ppaalanen@gmail.com>,
        <contact@emersion.fr>, <laurent.pinchart@ideasonboard.com>,
        <sebastian.wick@redhat.com>, <ville.syrjala@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <wayland-devel@lists.freedesktop.org>
References: <20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com>
 <20230404-solid-fill-v4-5-f4ec0caa742d@quicinc.com>
 <39ee5eac-1452-1c08-c24f-6c70c13ce804@linaro.org>
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <39ee5eac-1452-1c08-c24f-6c70c13ce804@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9BpfPWOkgs2U29cACyGlkmlvwqEevVMJ
X-Proofpoint-GUID: 9BpfPWOkgs2U29cACyGlkmlvwqEevVMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306300207
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 5:49 PM, Dmitry Baryshkov wrote:
> On 30/06/2023 03:25, Jessica Zhang wrote:
>> Add solid_fill and pixel_source properties to DPU plane
>>
>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> This should be the last commit.

Hi Dmitry,

Acked, will move this to the end.

Thanks,

Jessica Zhang

> Otherwise:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> index c2aaaded07ed..5f0984ce62b1 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> @@ -1429,6 +1429,8 @@ struct drm_plane *dpu_plane_init(struct 
>> drm_device *dev,
>>           DPU_ERROR("failed to install zpos property, rc = %d\n", ret);
>>       drm_plane_create_alpha_property(plane);
>> +    drm_plane_create_solid_fill_property(plane);
>> +    drm_plane_create_pixel_source_property(plane, 
>> BIT(DRM_PLANE_PIXEL_SOURCE_COLOR));
>>       drm_plane_create_blend_mode_property(plane,
>>               BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>>               BIT(DRM_MODE_BLEND_PREMULTI) |
>>
> 
> -- 
> With best wishes
> Dmitry
> 
