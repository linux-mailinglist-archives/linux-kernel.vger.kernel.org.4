Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA50A6EB1C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjDUSmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDUSmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:42:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B277C1728;
        Fri, 21 Apr 2023 11:42:13 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LBYTbb011343;
        Fri, 21 Apr 2023 18:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D+zxcmfcTVJSf2VwbasakLQRdVH5zKDovEgkZgH543E=;
 b=ERlKO4epj3mOPBXCw8MB8Sky51a4uvPPcm3BWVV2wsbu5WZsni+ZLwfMgHyDaJNEFjpo
 4p42SUaxVhReQY8SL4xUcRzxohnuzRZB90pjw3szw/ZT1a1OceHiH6VNKZW8uffxkC9e
 7hdb64+uTuNWt8M1pTAyM/CTuIWM5DUK0e5CtWVcu7szTXspOrllwQ2TC3jFPomPfkU+
 FJNrylk1Eeu4kl8AAht1gnG7/U3xjJfk4axcWbWG4mUZ0zquYb+6mq70/Hj8Lnbh2hUR
 E9gMQhaTvKP+eLsz6nf6GWq2mRI6ucPzc2aKZ6SFKy5CcfT5KY45AUhvs1C6ae2iRXQa ow== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3phdhc5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 18:42:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33LIg0Ps009769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 18:42:01 GMT
Received: from [10.110.74.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 21 Apr
 2023 11:41:59 -0700
Message-ID: <7579b02e-5b4d-72b7-4cef-e18f9fc86d7d@quicinc.com>
Date:   Fri, 21 Apr 2023 11:41:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dp: unregister audio driver during unbind
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <robdclark@gmail.com>, <sean@poorly.run>,
        <dmitry.baryshkov@linaro.org>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <lyude@redhat.com>
CC:     <javierm@redhat.com>, <tzimmermann@suse.de>,
        <quic_khsieh@quicinc.com>, <quic_bjorande@quicinc.com>,
        <johan+linaro@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230421145657.12186-1-srinivas.kandagatla@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230421145657.12186-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 45iFphmqevtGiCTObiY7FBrdu-TvvRs0
X-Proofpoint-ORIG-GUID: 45iFphmqevtGiCTObiY7FBrdu-TvvRs0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxlogscore=775 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210164
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2023 7:56 AM, Srinivas Kandagatla wrote:
> while binding the code always registers a audio driver, however there
> is no corresponding unregistration done in unbind. This leads to multiple
> redundant audio platform devices if dp_display_bind and dp_display_unbind
> happens multiple times during startup. On X13s platform this resulted in
> 6 to 9 audio codec device instead of just 3 codec devices for 3 dp ports.
> 
> Fix this by unregistering codecs on unbind.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Fixes: d13e36d7d222 ("drm/msm/dp: add audio support for Display Port on 
MSM")

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

(pls ignore the line break in the fixes tag, its a mail editor issue, I 
will apply the tag properly while applying to -fixes)
