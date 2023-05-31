Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD2718690
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjEaPlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjEaPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:41:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181919D;
        Wed, 31 May 2023 08:41:13 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VEn1Si009755;
        Wed, 31 May 2023 15:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MhTlLlPXPB2hun/YA2U92J0IiaRh377ghLpoTRHa6uo=;
 b=k71HKymloQg/rg8FCKf6Hs92iY1db06zAKgJrb9NkcHoluAKlf1u2SHimCCiDPjkvNt3
 cxt/sNn+f4GHn7jCXXWzVr3nlOKeEOjYkHVCxqBcOAdW5wsag2ZZY0Ykj30mX+Njdns5
 W2pBCrH2uhPlp7jpoChnbo8MKdlAo86gXJ3Vl4XDyuAUiQIeDK3naijngiOapGDbZPCx
 v+daS3Jgh5OMWdOqkQV3TcRjYgbESFd/ZLZhGzwJvcUuzyCj1UrhP61NRHR4FVyKhS9W
 E1mZRDCALmZfqv2vI+MTyLbYFJPksxnUTzxi2LcCqUYsY0TRf0+1Nf31IYXGROz45pPA hQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx39d0xrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 15:40:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VFea2M020193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 15:40:36 GMT
Received: from [10.71.110.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 08:40:35 -0700
Message-ID: <157e8219-7af2-c7ed-6d99-3caa6fbc11ba@quicinc.com>
Date:   Wed, 31 May 2023 08:40:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 2/3] drm/msm/dpu: retrieve DSI DSC struct at
 atomic_check()
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1685464318-25031-1-git-send-email-quic_khsieh@quicinc.com>
 <1685464318-25031-3-git-send-email-quic_khsieh@quicinc.com>
 <dfa12c8b-ccec-261c-9c83-54536e17c02d@linaro.org>
Content-Language: en-US
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <dfa12c8b-ccec-261c-9c83-54536e17c02d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _UgxJ8hFXO64gsDUKEHxREvw_6jO6D_D
X-Proofpoint-ORIG-GUID: _UgxJ8hFXO64gsDUKEHxREvw_6jO6D_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310134
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>   +    if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
>
> INTF_DSI
>
>> +        struct drm_bridge *bridge;
>> +
>> +        if (!dpu_enc->dsc) {
>
> This condition is not correct. We should be updating the DSC even if 
> there is one.
>
>> +            bridge = drm_bridge_chain_get_first_bridge(drm_enc);
>> +            dpu_enc->dsc = msm_dsi_bridge_get_dsc_config(bridge);
>
> This approach will not work for the hot-pluggable outputs. The dpu_enc 
> is not a part of the state. It should not be touched before 
> atomic_commit actually commits changes.
where can drm_dsc_config be stored?
>
> Also, I don't think I like the API. It makes it impossible for the 
> driver to check that the bridge is the actually our DSI bridge or not.
> Once you add DP here, the code will explode.
>
> I think instead we should extend the drm_bridge API to be able to get 
> the DSC configuration from it directly. Additional care should be put 
> to design an assymetrical API. Theoretically a drm_bridge can be both 
> DSC source and DSC sink. Imagine a DSI-to-DP or DSI-to-HDMI bridge, 
> supporting DSC on the DSI side too.

Form my understanding, a bridge contains two interfaces.

Therefore I would think only one bridge for dsi-to-dp bridge? and this 
bridge should represent the bridge chip?

I am thinking adding an ops function, get_bridge_dsc() to struct 
drm_bridge_funcs to retrieve drm_dsc_config.

Do you have other suggestion?

>
