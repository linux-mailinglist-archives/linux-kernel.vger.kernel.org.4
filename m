Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EC1644CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLFT7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLFT7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:59:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65E40444;
        Tue,  6 Dec 2022 11:59:07 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6JQX4T009973;
        Tue, 6 Dec 2022 19:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/qoa6QkTRVtzY7PQwUYrr7Mo3VfK02MILbYzCqvXZuY=;
 b=FlIwAlGSPy6+EpNeBXX/ONOXvQCdM5nxLDd+AHymLjmbcijWeXc0VelIrOWayUMzwve/
 67DJvgNzU1TvfvtCs8GoarnngS7QmFoqhYwN0Ko+rnwgl1nrf/WcJFqHkc/knzUVK/fq
 UNJn6tJuc2PJSQEL1Yi9MBOXxl2FGOC20r6/23VrVWvqz6l0qViL4fW6ltYqs1K+SOIp
 dzbGId0YDC2M1Z9M0M8Qb7+pZudDv2I5lFVZ+TRTvFph2+xC0FKAofvfpo1/UfhlHTtP
 771tVvu/kwTAwSxYh37bl15g+AAFk8j2HYvWLpVlVStf5HYeAlBduGDMJzoRgPRMUZu6 2g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m9wa2tj3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 19:58:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B6Jwg2A003806
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 19:58:42 GMT
Received: from [10.216.31.39] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 11:58:35 -0800
Message-ID: <a174f4a8-42a6-c861-f08a-91fb497a5f43@quicinc.com>
Date:   Wed, 7 Dec 2022 01:28:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Freedreno] [PATCH v7 0/6] clk/qcom: Support gdsc collapse
 polling using 'reset' interface
Content-Language: en-US
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-clk@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Sean Paul" <sean@poorly.run>, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        <krzysztof.kozlowski@linaro.org>, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>
References: <1664960824-20951-1-git-send-email-quic_akhilpo@quicinc.com>
 <20221201225705.46r2m35ketvzipox@builder.lan>
 <a0544298-f463-4994-1cf4-9e290f85bf37@quicinc.com>
In-Reply-To: <a0544298-f463-4994-1cf4-9e290f85bf37@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GFOILXgwYLeNOI7SR9e4VLJ4UKh9T2dr
X-Proofpoint-ORIG-GUID: GFOILXgwYLeNOI7SR9e4VLJ4UKh9T2dr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_11,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060167
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/2022 12:30 PM, Akhil P Oommen wrote:
> On 12/2/2022 4:27 AM, Bjorn Andersson wrote:
>> On Wed, Oct 05, 2022 at 02:36:58PM +0530, Akhil P Oommen wrote:
>> @Ulf, Akhil has a power-domain for a piece of hardware which may be
>> voted active by multiple different subsystems (co-processors/execution
>> contexts) in the system.
>>
>> As such, during the powering down sequence we don't wait for the
>> power-domain to turn off. But in the event of an error, the recovery
>> mechanism relies on waiting for the hardware to settle in a powered off
>> state.
>>
>> The proposal here is to use the reset framework to wait for this state
>> to be reached, before continuing with the recovery mechanism in the
>> client driver.
>>
>> Given our other discussions on quirky behavior, do you have any
>> input/suggestions on this?
Ulf,

Gentle ping! Could you please share your feedback?

-Akhil.
>>
>>> Some clients like adreno gpu driver would like to ensure that its gdsc
>>> is collapsed at hardware during a gpu reset sequence. This is because it
>>> has a votable gdsc which could be ON due to a vote from another subsystem
>>> like tz, hyp etc or due to an internal hardware signal. To allow
>>> this, gpucc driver can expose an interface to the client driver using
>>> reset framework. Using this the client driver can trigger a polling within
>>> the gdsc driver.
>> @Akhil, this description is fairly generic. As we've reached the state
>> where the hardware has settled and we return to the client, what
>> prevents it from being powered up again?
>>
>> Or is it simply a question of it hitting the powered-off state, not
>> necessarily staying there?
> Correct. It doesn't need to stay there. The intention is to hit the powered-off state at least once to clear all the internal hw states (basically a hw reset).
>
> -Akhil.
>> Regards,
>> Bjorn
>>
>>> This series is rebased on top of qcom/linux:for-next branch.
>>>
>>> Related discussion: https://patchwork.freedesktop.org/patch/493144/
>>>
>>> Changes in v7:
>>> - Update commit message (Bjorn)
>>> - Rebased on top of qcom/linux:for-next branch.
>>>
>>> Changes in v6:
>>> - No code changes in this version. Just captured the Acked-by tags
>>>
>>> Changes in v5:
>>> - Nit: Remove a duplicate blank line (Krzysztof)
>>>
>>> Changes in v4:
>>> - Update gpu dt-binding schema
>>> - Typo fix in commit text
>>>
>>> Changes in v3:
>>> - Use pointer to const for "struct qcom_reset_ops" in qcom_reset_map (Krzysztof)
>>>
>>> Changes in v2:
>>> - Return error when a particular custom reset op is not implemented. (Dmitry)
>>>
>>> Akhil P Oommen (6):
>>>   dt-bindings: clk: qcom: Support gpu cx gdsc reset
>>>   clk: qcom: Allow custom reset ops
>>>   clk: qcom: gdsc: Add a reset op to poll gdsc collapse
>>>   clk: qcom: gpucc-sc7280: Add cx collapse reset support
>>>   dt-bindings: drm/msm/gpu: Add optional resets
>>>   arm64: dts: qcom: sc7280: Add Reset support for gpu
>>>
>>>  .../devicetree/bindings/display/msm/gpu.yaml       |  6 +++++
>>>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |  3 +++
>>>  drivers/clk/qcom/gdsc.c                            | 23 ++++++++++++++----
>>>  drivers/clk/qcom/gdsc.h                            |  7 ++++++
>>>  drivers/clk/qcom/gpucc-sc7280.c                    | 10 ++++++++
>>>  drivers/clk/qcom/reset.c                           | 27 +++++++++++++++++++++-
>>>  drivers/clk/qcom/reset.h                           |  8 +++++++
>>>  include/dt-bindings/clock/qcom,gpucc-sc7280.h      |  3 +++
>>>  8 files changed, 82 insertions(+), 5 deletions(-)
>>>
>>> -- 
>>> 2.7.4
>>>

