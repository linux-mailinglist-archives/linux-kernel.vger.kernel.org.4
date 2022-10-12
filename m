Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BDF5FCE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJLWyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJLWyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:54:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB211C252;
        Wed, 12 Oct 2022 15:54:05 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CMqmfL003734;
        Wed, 12 Oct 2022 22:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xiYh95aAw9TpCzIEjCXj5v0+/oJAQonhZN9a1qdCNMY=;
 b=oFq80MMf6zbnus1YlGxg3JZ1LT+X4OAnjl1joXi9q4MXu1A872BdDVQjcSP12khvLlJ0
 xcVfs3OOCBamljNHPtJrv/NVUZh8ZYpE0riFGScRfG+yijVAZZXcwUQ/xABDC3ejpIjd
 1i+AsBAMRoOfLrMANkTXTTceB1YOCjbSx5JltLlV31O0CV8f6vuewSO8s2Dl6/l9OAqq
 0ERUG872WUFWHjGXxeJDgs13A4MwxqG3G4pFxQyqCq64j88cVOy+D1+XX1VD1SuMg/I0
 DGx8rRoDYq9wgcw/SRXYy4PCqRer5KK5MBA2Vxrn6Vj+VIlG8LWo9D01ZBXDIp0rbWIy UQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5xtf15jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:53:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29CMrptU003344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 22:53:51 GMT
Received: from [10.38.241.12] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 15:53:48 -0700
Message-ID: <2af896bc-96c1-2138-c419-7cf9df7fe33c@quicinc.com>
Date:   Wed, 12 Oct 2022 15:53:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 05/10] drm/msm/dsi: Appropriately set
 dsc->mux_word_size based on bpc
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        <phone-devel@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20221009184824.457416-1-marijn.suijten@somainline.org>
 <20221009184824.457416-6-marijn.suijten@somainline.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20221009184824.457416-6-marijn.suijten@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ncXyES5thCtWa0H0RPk6NYnuHYSKFgxK
X-Proofpoint-ORIG-GUID: ncXyES5thCtWa0H0RPk6NYnuHYSKFgxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120142
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/2022 11:48 AM, Marijn Suijten wrote:
> This field is currently unread but will come into effect when duplicated
> code below is migrated to call drm_dsc_compute_rc_parameters(), which
> uses the bpc-dependent value of the local variable mux_words_size in
> much the same way.
> 
> The hardcoded constant seems to be a remnant from the `/* bpc 8 */`
> comment right above, indicating that this group of field assignments is
> applicable to bpc = 8 exclusively and should probably bail out on
> different bpc values, until constants for other bpc values are added (or
> the current ones are confirmed to be correct across multiple bpc's).
> 

Yes, this seems to hard-code it to 8bpc/10bpc. So your code-change is fine.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index f42794cdd4c1..83cde4d62b68 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1808,6 +1808,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>   	if (dsc->bits_per_component == 12)
>   		mux_words_size = 64;
>   
> +	dsc->mux_word_size = mux_words_size;
>   	dsc->initial_xmit_delay = 512;
>   	dsc->initial_scale_value = 32;
>   	dsc->first_line_bpg_offset = 12;
> @@ -1818,7 +1819,6 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>   	dsc->flatness_max_qp = 12;
>   	dsc->rc_quant_incr_limit0 = 11;
>   	dsc->rc_quant_incr_limit1 = 11;
> -	dsc->mux_word_size = DSC_MUX_WORD_SIZE_8_10_BPC;
>   
>   	/* FIXME: need to call drm_dsc_compute_rc_parameters() so that rest of
>   	 * params are calculated
