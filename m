Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94A95F458E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJDOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJDOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:34:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498314F3B5;
        Tue,  4 Oct 2022 07:34:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294EB9i6002780;
        Tue, 4 Oct 2022 14:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WfTJ1BN+M6nmsr8qs0O40lSy+N3imqFByhXaLIkXntM=;
 b=XLsxRQSKrsQ8FXmBC+z+Ls0lQB4gNSmSOV2UtUZOZtSdZXt0u0uzG/XgMxVmdcAYXxw+
 4NxfD0ZbalVATiS2Pq+abTtp3Q91kueELbBMeTW0SIYYDRIwWNFwhJy1+GBvC7yBSBGa
 dW7gX0ClbCee+qhd+F5W7hn9GFpuCZzOvW/7QcY2/3jUbTF5eBnxPp6FmAMypV984Ief
 C5hNeCaGJSG3sZpEUjB1DR1/DjzKttm6yFxpaKoSMLAaBbT6RFT1exlcHwLSL7czXmzL
 kGpKW5Uy/sQKzhUUbyoaJ5psHZxmwAMjqfBPFVq7Ip7i6CCo5oAKZkpNrv06snTwuCip bA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0m88gax5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 14:33:55 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 294EXsWm028981;
        Tue, 4 Oct 2022 14:33:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3jxemkke1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 14:33:54 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 294EXsPY028969;
        Tue, 4 Oct 2022 14:33:54 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 294EXsBs028962
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 14:33:54 +0000
Received: from [10.111.163.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 07:33:51 -0700
Message-ID: <7ded0eb3-ef99-1979-ffb6-c639288bd863@quicinc.com>
Date:   Tue, 4 Oct 2022 07:33:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH 1/5] drm/msm/dsi: Remove useless math in DSC
 calculation
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        <phone-devel@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Marek Vasut <marex@denx.de>, <freedreno@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        <linux-arm-msm@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Martin Botka <martin.botka@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>, <linux-kernel@vger.kernel.org>
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-2-marijn.suijten@somainline.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20221001190807.358691-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nrWLAZvh5E4vhZVpB4ewKLCUViSWfdlo
X-Proofpoint-ORIG-GUID: nrWLAZvh5E4vhZVpB4ewKLCUViSWfdlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040093
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 12:08 PM, Marijn Suijten wrote:
> Multiplying a value by 2 and adding 1 to it always results in a value
> that is uneven, and that 1 gets truncated immediately when performing
> integer division by 2 again.  There is no "rounding" possible here.
> 
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 8e4bc586c262..e05bae647431 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1864,12 +1864,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>   	data = 2048 * (dsc->rc_model_size - dsc->initial_offset + num_extra_mux_bits);
>   	dsc->slice_bpg_offset = DIV_ROUND_UP(data, groups_total);
>   
> -	/* bpp * 16 + 0.5 */
> -	data = dsc->bits_per_pixel * 16;
> -	data *= 2;
> -	data++;
> -	data /= 2;
> -	target_bpp_x16 = data;
> +	target_bpp_x16 = dsc->bits_per_pixel * 16;
>   
Since this patch is titled, "remove useless math", even the 
target_bpp_x16 math looks redundant to me,

first we do

target_bpp_x16 = dsc->bits_per_pixel * 16;

then in the next line we do

data = (dsc->initial_xmit_delay * target_bpp_x16) / 16;

the *16 and /16 will cancel out here.

Instead we can just do

data = (dsc->initial_xmit_delay * dsc->drm->bits_per_pixel) ?

>   	data = (dsc->initial_xmit_delay * target_bpp_x16) / 16;
>   	final_value =  dsc->rc_model_size - data + num_extra_mux_bits;
