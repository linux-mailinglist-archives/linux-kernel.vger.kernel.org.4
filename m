Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D741467C0F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjAYXiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjAYXi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:38:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE8D5E523;
        Wed, 25 Jan 2023 15:37:40 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PN0PR6005302;
        Wed, 25 Jan 2023 23:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c5UJxOnflZySzbbBz8EKXb+/eyQTtUxmdH7N8Iq+fus=;
 b=pDS50iWaGTbMDaTEK6+ty+4JHjjFKTLHGlDneUX4+8F4qJNXKFtBZ7eWnEqm0HPorwpt
 ERABIZbayeQqafs2KXnPZLVByJ+LscE9Op192NuNqZWat4s3jwmFSA/SQQ7KZ+gowVOZ
 Ov+8dlZ/KJ7msfUAIwqsqI2IOEKYlYI+QmM8lGAXWX7l3CyAPEgdsom0ZsI85dEANjww
 NjdIZVM8kvntMXRgTqsTEpIGPfMWGsvC9sLsnsEsOgxWHfR7+7UOe6c1GkWD9l3Sw8li
 Pcvqw5lLYf8AYYoLAoXwLIxDOZtk4ChmxEAeAzVWrU8a+QgDC7gs+Duwa8NAJOcmzPQP tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nbdny81tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 23:37:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PNb0xn009214
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 23:37:00 GMT
Received: from [10.110.102.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 15:36:59 -0800
Message-ID: <b17cf047-b478-0333-8eae-e2fc8b752106@quicinc.com>
Date:   Wed, 25 Jan 2023 15:36:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] drm/msm/dp: Return IRQ_NONE for unhandled interrupts
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230119145248.1.I90ffed3ddd21e818ae534f820cb4d6d8638859ab@changeid>
 <20230119145248.2.I2d7aec2fadb9c237cd0090a47d6a8ba2054bf0f8@changeid>
 <f08b04b2-3fdd-38f5-6402-16c57a3322d2@quicinc.com>
 <CAD=FV=WHH5=NZPWSyu6P0HVMpSJK_53=S6PgyjJZCKz8-dE1rg@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAD=FV=WHH5=NZPWSyu6P0HVMpSJK_53=S6PgyjJZCKz8-dE1rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rlQzeDX-4UwAv1tqNpWGmcbNmBkgBL6f
X-Proofpoint-GUID: rlQzeDX-4UwAv1tqNpWGmcbNmBkgBL6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 mlxlogscore=642 phishscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250210
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2023 10:21 AM, Doug Anderson wrote:
> Hi,
>
> On Wed, Jan 25, 2023 at 9:22 AM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>>> -void dp_ctrl_isr(struct dp_ctrl *dp_ctrl)
>>> +irqreturn_t dp_ctrl_isr(struct dp_ctrl *dp_ctrl)
>>>    {
>>>        struct dp_ctrl_private *ctrl;
>>>        u32 isr;
>>> +     irqreturn_t ret = IRQ_NONE;
>>>
>>>        if (!dp_ctrl)
>>> -             return;
>>> +             return IRQ_NONE;
>>>
>>>        ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
>>>
>>>        isr = dp_catalog_ctrl_get_interrupt(ctrl->catalog);
>> can you add (!isr) check and return IRQ_NONE here to be consistent with
>> dp_aux_isr()?
> I could, though it doesn't really buy us a whole lot in this case and
> just adds an extra test that's not needed. Here it should be easy for
> someone reading the function to see that if "isr == 0" that neither of
> the two "if" statements below will fire and we'll return "IRQ_NONE"
> anyway.
>
> ...that actually made me go back and wonder whether we still needed
> the "if" test in dp_aux_isr() or if it too was also redundant. It
> turns out that it's not! The previous patch made dp_aux_irq() detect
> unexpected interrupts. Thus the "if (!isr)" test earlier is important
> because otherwise we'd end up WARNing "Unexpected interrupt:
> 0x00000000" which would be confusing.
>
> So unless you or others feel strongly that I should add the redundant
> test here, I'd rather keep it off. Let me know.
>
> -Doug
ack
