Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D826CF0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjC2RQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjC2RQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:16:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94977126;
        Wed, 29 Mar 2023 10:16:16 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TH9PMQ002570;
        Wed, 29 Mar 2023 17:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WQsg8jYGYlS5jR6si9qHdD85lJZwt9IDNgaN2IZ7IrM=;
 b=RZShClF2ep127YRedE//sd/nrcCpcgob5bGDU/P25+wqgAwq0SPWAs8WDDe+EyLjejYp
 jHPu2V3WGY/BvsKnxxvuk8u7Q/SsbuTlX58HHqCQ9Yv8fCkIOSm+OF95TFcc1KP8Tj8D
 aW62llXIINVwLylCw1Q7cN2g1UfgU7z9HrXruNDoWZ/t9hkU6hi9rNCtPwhjUFTtBjuM
 uapFOwO6mUEoFAM6zjFbEqlwN8QD5GTPeU1azyaw8aAJjovenVg/SdeFeevvBJB40dnS
 jHdAbSFW+ysGBTNW5atCTU/SjDd+UxcQkvxHzsajS4CJRRedJTHy0zPh24y/K3OksG4V sw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pmq1v8g33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:16:12 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32THGBTB029070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:16:11 GMT
Received: from [10.216.23.227] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 29 Mar
 2023 10:16:07 -0700
Message-ID: <b2e16887-bc35-c933-2107-6e8faa439770@quicinc.com>
Date:   Wed, 29 Mar 2023 22:45:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4] venus: Enable sufficient sequence change support for
 sc7180 and fix for Decoder STOP command issue.
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC:     <quic_dikshita@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <20230323130153.8229-1-quic_vboma@quicinc.com>
 <c611c390-2cf3-2abe-82aa-67538b823d62@linaro.org>
 <9f5bce7e-2b8a-0b71-3a80-0b4f86d9f908@quicinc.com>
 <E98548DB-5085-4036-9F6C-DC22A604A0C2@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <E98548DB-5085-4036-9F6C-DC22A604A0C2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NoIfbNaPMCKyW2bdaBKpz2BbE5yelsdc
X-Proofpoint-ORIG-GUID: NoIfbNaPMCKyW2bdaBKpz2BbE5yelsdc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_10,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290135
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2023 7:06 PM, Dmitry Baryshkov wrote:
> 29 марта 2023 г. 10:48:23 GMT+03:00, Vikash Garodia <quic_vgarodia@quicinc.com> пишет:
>> On 3/29/2023 3:49 AM, Dmitry Baryshkov wrote:
>>> On 23/03/2023 15:01, Viswanath Boma wrote:
>>>> For VP9 bitstreams, there could be a change in resolution at interframe,
>>>> for driver to get notified of such resolution change,
>>>> enable the property in video firmware.
>>>> Also, EOS handling is now made same in video firmware across all V6 SOCs,
>>>> hence above a certain firmware version, the driver handling is
>>>> made generic for all V6s
>>> Having "Do abc. Also do defgh." is a clear sign that this patch should be split into two.
>> I agree, it could have split into patches. The patch introduces way to store venus firmware
>>
>> version and take some decision for various version. For ex. here STOP handling and enabling
>>
>> DRC event for specific firmware revision and onwards. Since both the handling was primarily
>>
>> dependent of firmware version, and since the handlings were smaller, it was combined as single
>>
>> patch. Let me know, if you have any further review comments, else, will raise a new version with
>>
>> 2 patches probably.
> Thanks!
>
>>>> Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
>>>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>>>> Tested-by: Nathan Hebert <nhebert@chromium.org>
>>>> ---
>>>> Since v3 : Addressed comments to rectify email address.
>>>>
>>>>    drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
>>>>    drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
>>>>    drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
>>>>    drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
>>>>    drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
>>>>    5 files changed, 41 insertions(+), 3 deletions(-)
>>>>
> (Skipped)
>
>
>
>>>> @@ -671,6 +671,16 @@ static int vdec_set_properties(struct venus_inst *inst)
>>>>                return ret;
>>>>        }
>>>>    +    /* Enabling sufficient sequence change support for VP9 */
>>>> +    if (of_device_is_compatible(inst->core->dev->of_node, "qcom,sc7180-venus")) {
>>> Let me repeat my question from v3:
>>>
>>> Is it really specific just to sc7180 or will it be applicable to any
>>> other platform using venus-5.4 firmware?
>> The HFI "HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT" is implemented
>>
>> only for sc7180. Calling this for any other venus-5.4 would error out the session with error as
>>
>> unsupported property from firmware.
>
> How can we be sure that other platforms do not end up using sc7180 firmware? Or that sc7180 didn't end up using some other firmware?
>
> I see generic  qcom/venus-5.4/venus.mbn in Linux firmware. It's version is VIDEO.VE.5.4-00053-PROD-1. It can be used with any unfused device which uses firmware 5.4

Driver defines resources for every platforms and there it specifies the 
firmware to be used for that platform. For ex, for sc7180, the firmware 
is specified at [1].

The various firmware supported by different platforms are also available 
in linux firmware.

[1] 
https://elixir.bootlin.com/linux/v6.3-rc4/source/drivers/media/platform/qcom/venus/core.c#L765 


>>>> +        if (is_fw_rev_or_newer(inst->core, 5, 4, 51)) {
>>>> +            ptype = HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
>>>> +            ret = hfi_session_set_property(inst, ptype, &en);
>>>> +            if (ret)
>>>> +                return ret;
>>>> +        }
>>>> +    }
>>>> +
>>>>        ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
>>>>        conceal = ctr->conceal_color & 0xffff;
>>>>        conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;
