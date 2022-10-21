Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354F8607BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJUQG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiJUQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:06:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CC8209F80;
        Fri, 21 Oct 2022 09:06:18 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L8rYue008650;
        Fri, 21 Oct 2022 16:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=R8emWiLBFPkOphvZD7XQZDyKcPgVRPFkVJwpvC3ik0w=;
 b=Mb3McpJsM0kCnDdicPBol6ZL9QyCqdi9UeLUL660+CvUku0N6M+Lp/P/d+QBavd2fkJd
 UgQhPpEvqqfZbWUpPhZXJ/qVcpt7fhvemmm+xpw0mJAsoQlvKgtZrsTqsyjEWQt6o13U
 IHBM8f0RkDf1uSPLhawilz1jK4nNHj+6iowJrDla+BO7Y3+v5kT2zCgHzzsoj8AFhGVl
 KUlcDDZOi8YxNa3zP28F9Zug5qtD7CeZLZ8Hn2yk5mP6Tx+7aGpsu603PNvEMon72BIi
 gVGYhGGbcvyePpyWuul01AojORpZLwhkzzWVWqNfnRopfUCJAoc+LlgliJ1ZqEpVRYG1 lg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kbnqt29b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 16:06:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29LG60J1019984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 16:06:00 GMT
Received: from [10.111.175.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 21 Oct
 2022 09:05:56 -0700
Message-ID: <139426b9-0e5b-e4c3-27c6-584ab48517c2@quicinc.com>
Date:   Fri, 21 Oct 2022 09:05:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 00/10] drm/msm: probe deferral fixes
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
CC:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <YymCll02tRIMb+9Z@hovoldconsulting.com>
 <Y1I77HYeOkx1fz1E@hovoldconsulting.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <Y1I77HYeOkx1fz1E@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gls1jzuKGH2PD6_I00PqYRbhQlT3-yDP
X-Proofpoint-ORIG-GUID: Gls1jzuKGH2PD6_I00PqYRbhQlT3-yDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan

On 10/20/2022 11:27 PM, Johan Hovold wrote:
> On Tue, Sep 20, 2022 at 11:06:30AM +0200, Johan Hovold wrote:
>> On Tue, Sep 13, 2022 at 10:53:10AM +0200, Johan Hovold wrote:
>>> The MSM DRM driver is currently broken in multiple ways with respect to
>>> probe deferral. Not only does the driver currently fail to probe again
>>> after a late deferral, but due to a related use-after-free bug this also
>>> triggers NULL-pointer dereferences.
>>>
>>> These bugs are not new but have become critical with the release of
>>> 5.19 where probe is deferred in case the aux-bus EP panel driver has not
>>> yet been loaded.
>>>
>>> The underlying problem is lifetime issues due to careless use of
>>> device-managed resources.
>>
>> Any chance of getting this merged for 6.1?
> 
> Is anyone picking these up as fixes for 6.1-rc as we discussed?
> 
> Johan

All of these except the last two ( as discussed ) have landed in the 
-fixes tree

https://gitlab.freedesktop.org/drm/msm/-/commit/6808abdb33bf90330e70a687d29f038507e06ebb

Thanks

Abhinav

>   
>>> Changes in v2
>>>   - use a custom devres action instead of amending the AUX bus interface
>>>     (Doug)
>>>   - split sanity check fixes and cleanups per bridge type (Dmitry)
>>>   - add another Fixes tag for the missing bridge counter reset (Dmitry)
>>>
>>>
>>> Johan Hovold (10):
>>>    drm/msm: fix use-after-free on probe deferral
>>>    drm/msm/dp: fix memory corruption with too many bridges
>>>    drm/msm/dsi: fix memory corruption with too many bridges
>>>    drm/msm/hdmi: fix memory corruption with too many bridges
>>>    drm/msm/dp: fix IRQ lifetime
>>>    drm/msm/dp: fix aux-bus EP lifetime
>>>    drm/msm/dp: fix bridge lifetime
>>>    drm/msm/hdmi: fix IRQ lifetime
>>>    drm/msm/dp: drop modeset sanity checks
>>>    drm/msm/dsi: drop modeset sanity checks
>>>
>>>   drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++++++++++++-------
>>>   drivers/gpu/drm/msm/dp/dp_parser.c  |  6 +++---
>>>   drivers/gpu/drm/msm/dp/dp_parser.h  |  5 +++--
>>>   drivers/gpu/drm/msm/dsi/dsi.c       |  9 +++++----
>>>   drivers/gpu/drm/msm/hdmi/hdmi.c     |  7 ++++++-
>>>   drivers/gpu/drm/msm/msm_drv.c       |  1 +
>>>   6 files changed, 37 insertions(+), 17 deletions(-)
